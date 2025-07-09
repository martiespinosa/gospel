//
//  FavoritesView.swift
//  Gospel
//
//  Created by Martí Espinosa Farran on 9/7/25.
//

import SwiftUI

struct FavoritesView: View {
    @State private var favoritesManager = FavoritesViewModel.shared
    @Binding var currentBook: String
    @Binding var currentChapter: Int
    @Binding var currentVerse: Int
    
    var body: some View {
        NavigationStack {
            if favoritesManager.favoriteVerses.isEmpty {
                ContentUnavailableView {
                    Label("No Favorites", systemImage: "heart")
                } description: {
                    Text("Tap the heart icon on verses to add them to your favorites")
                }
            } else {
                List {
                    ForEach(favoritesManager.favoriteVerses, id: \.id) { verse in
                        FavoriteVerseRow(verse: verse, currentBook: $currentBook, currentChapter: $currentChapter, currentVerse: $currentVerse)
                    }
                    .onDelete(perform: deleteFavorites)
                }
                .animation(.default, value: favoritesManager.favoriteVerses)
            }
        }
        .navigationTitle("Favorites")
        .toolbar {
            if !favoritesManager.favoriteVerses.isEmpty {
                EditButton()
            }
        }
    }
    
    private func deleteFavorites(at offsets: IndexSet) {
        for index in offsets {
            let verse = favoritesManager.favoriteVerses[index]
            favoritesManager.toggleFavorite(verse)
        }
    }
}

struct FavoriteVerseRow: View {
    let verse: BibleVerse
    @Binding var currentBook: String
    @Binding var currentChapter: Int
    @Binding var currentVerse: Int
    @State private var favoritesManager = FavoritesViewModel.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(verse.book_name) \(verse.chapter):\(verse.verse)")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Button {
                    withAnimation {
                        favoritesManager.toggleFavorite(verse)
                    }
                } label: {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.accent)
                }
                .buttonStyle(.plain)
            }
            
            Text(verse.text)
                .font(.body)
                .lineLimit(nil)
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
        .onTapGesture {
            // Actualizar posición actual cuando se toca el favorito
            if let englishName = BibleBook.spanishToEnglishMapping[verse.book_name] {
                currentBook = englishName
            } else {
                currentBook = verse.book_name
            }
            currentChapter = verse.chapter
            currentVerse = verse.verse
        }
    }
}

#Preview {
    FavoritesView(currentBook: .constant("Genesis"), currentChapter: .constant(1), currentVerse: .constant(1))
}
