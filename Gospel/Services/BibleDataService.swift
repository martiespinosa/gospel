//
//  BibleDataService.swift
//  Gospel
//
//  Created by Martí Espinosa Farran on 18/6/25.
//

import Foundation

protocol BibleDataServiceProtocol {
    func loadBook(_ bookName: String) -> BibleBookData?
    func preloadBooks(_ bookNames: [String])
    func clearCache()
}

class BibleDataService: BibleDataServiceProtocol {
    static let shared = BibleDataService()
    
    private init() {}
    
    private var loadedBooks: [String: BibleBookData] = [:]
    
    func loadBook(_ bookName: String) -> BibleBookData? {
        if let cachedBook = loadedBooks[bookName] {
            return cachedBook
        }
        
        var url: URL?
        
        let possiblePaths = [
            "BibleData/Books",
            "Books", 
            nil
        ]
        
        for path in possiblePaths {
            if let foundURL = Bundle.main.url(forResource: bookName, withExtension: "json", subdirectory: path) {
                url = foundURL
                print("✅ Found \(bookName).json at path: \(path ?? "root")")
                break
            }
        }
        
        guard let finalURL = url else {
            print("❌ Could not find \(bookName).json in bundle")
            print("📍 Searching in bundle for JSON files...")
            if let allJSONs = Bundle.main.urls(forResourcesWithExtension: "json", subdirectory: nil) {
                print("Found \(allJSONs.count) JSON files:")
                for jsonURL in allJSONs.prefix(5) {
                    print("   - \(jsonURL.lastPathComponent)")
                }
            }
            return nil
        }
        
        do {
            let data = try Data(contentsOf: finalURL)
            let bookData = try JSONDecoder().decode(BibleBookData.self, from: data)
            
            loadedBooks[bookName] = bookData
            
            print("✅ Loaded \(bookName) with \(bookData.verses.count) verses")
            return bookData
        } catch {
            print("❌ Error loading \(bookName): \(error)")
            return nil
        }
    }
    
    func preloadBooks(_ bookNames: [String]) {
        for bookName in bookNames {
            _ = loadBook(bookName)
        }
    }
    
    func clearCache() {
        loadedBooks.removeAll()
    }
}