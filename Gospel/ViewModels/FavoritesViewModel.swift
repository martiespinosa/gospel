//
//  FavoritesViewModel.swift
//  Gospel
//
//  Created by Martí Espinosa Farran on 9/7/25.
//

import Foundation
import Observation

@Observable
class FavoritesViewModel {
    var favoriteVerses: [BibleVerse] = []
    
    static let shared = FavoritesViewModel()
    
    private let userDefaults = UserDefaults.standard
    private let favoritesKey = "FavoriteVerses"
    
    private init() {
        loadFavorites()
    }
    
    func isFavorite(_ verse: BibleVerse) -> Bool {
        return favoriteVerses.contains { $0.id == verse.id }
    }
    
    func toggleFavorite(_ verse: BibleVerse) {
        if let index = favoriteVerses.firstIndex(where: { $0.id == verse.id }) {
            favoriteVerses.remove(at: index)
        } else {
            favoriteVerses.append(verse)
        }
        saveFavorites()
    }
    
    private func saveFavorites() {
        do {
            let data = try JSONEncoder().encode(favoriteVerses)
            userDefaults.set(data, forKey: favoritesKey)
        } catch {
            print("Error saving favorites: \(error)")
        }
    }
    
    private func loadFavorites() {
        guard let data = userDefaults.data(forKey: favoritesKey) else { return }
        
        do {
            favoriteVerses = try JSONDecoder().decode([BibleVerse].self, from: data)
        } catch {
            print("Error loading favorites: \(error)")
        }
    }
}