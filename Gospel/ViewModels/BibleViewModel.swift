//
//  BibleViewModel.swift
//  Gospel
//
//  Created by Martí Espinosa Farran on 18/6/25.
//

import Foundation
import Observation

@Observable
class BibleViewModel {
    var searchResults: [BibleVerse] = []
    var isLoading = false
    
    private let dataService: BibleDataServiceProtocol
    
    init(dataService: BibleDataServiceProtocol = BibleDataService.shared) {
        self.dataService = dataService
    }
    
    func getVerses(for bookName: String, chapter: Int? = nil, verse: Int? = nil) -> [BibleVerse] {
        guard let bookData = dataService.loadBook(bookName) else {
            return []
        }
        
        var filteredVerses = bookData.verses
        
        if let chapter = chapter {
            filteredVerses = filteredVerses.filter { $0.chapter == chapter }
        }
        
        if let verse = verse {
            filteredVerses = filteredVerses.filter { $0.verse == verse }
        }
        
        return filteredVerses
    }
    
    func searchVerses(query: String) {
        isLoading = true
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            var allResults: [BibleVerse] = []
            
            // Search in all books
            for book in BibleBook.allCases {
                if let bookData = self.dataService.loadBook(book.rawValue) {
                    let results = bookData.verses.filter { verse in
                        verse.text.localizedCaseInsensitiveContains(query)
                    }
                    allResults.append(contentsOf: results)
                }
            }
            
            DispatchQueue.main.async {
                self.searchResults = allResults
                self.isLoading = false
            }
        }
    }
    
    func preloadBooks(_ bookNames: [String]) {
        dataService.preloadBooks(bookNames)
    }
    
    func clearCache() {
        dataService.clearCache()
    }
}