//
//  ContinueReadingView.swift
//  Gospel
//
//  Created by Martí Espinosa Farran on 9/7/25.
//

import SwiftUI

struct ContinueReadingView: View {
    @Binding var navigationPath: NavigationPath
    @Binding var selectedTab: Int
    let currentBook: String
    let currentChapter: Int
    let currentVerse: Int
    
    var body: some View {
        Button {
            selectedTab = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let book = BibleBook.allBooks.first(where: { $0.name == currentBook }) {
                    navigationPath = NavigationPath()
                    navigationPath.append(book)
                }
            }
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(currentBook) \(currentChapter):\(currentVerse)".uppercased())
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                    
                    Text(getVerseText())
                        .lineLimit(2)
                }
                .font(.caption)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .buttonStyle(.plain)
    }
    
    private func getVerseText() -> String {
        let verses = BibleDataService.shared.loadBook(currentBook)?.verses.filter { $0.chapter == currentChapter && $0.verse == currentVerse } ?? []
        
        if let verse = verses.first {
            let text = verse.text
            // Truncar a una línea aproximada (unos 80 caracteres) y añadir puntos suspensivos
            if text.count > 80 {
                let truncated = String(text.prefix(80))
                // Buscar el último espacio para no cortar palabras
                if let lastSpace = truncated.lastIndex(of: " ") {
                    return String(truncated[..<lastSpace]) + "..."
                } else {
                    return truncated + "..."
                }
            } else {
                return text
            }
        } else {
            return "Tap to continue reading \(currentBook)..."
        }
    }
}

#Preview {
    ContinueReadingView(navigationPath: .constant(NavigationPath()), selectedTab: .constant(0), currentBook: "Genesis", currentChapter: 1, currentVerse: 1)
}
