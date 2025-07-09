//
//  ContentView.swift
//  Gospel
//
//  Created by Martí Espinosa Farran on 18/6/25.
//

import SwiftUI

struct ContentView: View {
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    @State private var selectedTab = 0
    @State private var navigationPath = NavigationPath()
    @AppStorage("currentBook") private var currentBook = "Genesis"
    @AppStorage("currentChapter") private var currentChapter = 1
    @AppStorage("currentVerse") private var currentVerse = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Biblia", systemImage: "book", value: 0) {
                NavigationStack(path: $navigationPath) {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 12) {
                            ForEach(BibleBook.allBooks) { book in
                                NavigationLink(value: book) {
                                    BookCardView(book: book)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding()
                    }
                    .navigationTitle("Bible")
                    .navigationDestination(for: Book.self) { book in
                        BookView(book: book, currentBook: $currentBook, currentChapter: $currentChapter, currentVerse: $currentVerse)
                    }
                }
            }
            
            Tab("Favoritos", systemImage: "heart", value: 1) {
                FavoritesView(currentBook: $currentBook, currentChapter: $currentChapter, currentVerse: $currentVerse)
            }
            
            Tab("Musica", systemImage: "music.note", value: 2) {
                Text("Musica")
            }
            
            Tab("Buscar", systemImage: "magnifyingglass", value: 3, role: .search) {
                SearchView()
            }
        }
        .myTabBarMinimizeBehavior()
        .myTabViewBottomAccessory(navigationPath: $navigationPath, selectedTab: $selectedTab, currentBook: currentBook, currentChapter: currentChapter, currentVerse: currentVerse)
    }
}

#Preview {
    ContentView()
}

extension View {
    @ViewBuilder
    func myTabBarMinimizeBehavior() -> some View {
        if #available(iOS 26.0, *) { self.tabBarMinimizeBehavior(.onScrollDown) } else { self }
    }
}

extension View {
    @ViewBuilder
    func myTabViewBottomAccessory(navigationPath: Binding<NavigationPath>, selectedTab: Binding<Int>, currentBook: String, currentChapter: Int, currentVerse: Int) -> some View {
        if #available(iOS 26.0, *) { self.tabViewBottomAccessory{
            ContinueReadingView(navigationPath: navigationPath, selectedTab: selectedTab, currentBook: currentBook, currentChapter: currentChapter, currentVerse: currentVerse)
        } } else { self }
    }
}
