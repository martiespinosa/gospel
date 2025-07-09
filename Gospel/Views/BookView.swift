//
//  BookView.swift
//  Gospel
//
//  Created by Martí Espinosa Farran on 18/6/25.
//

import SwiftUI

struct BookView: View {
    let book: Book
    @State private var verses: [BibleVerse] = []
    @State private var isLoading = true
    @State private var showAsVerses = false
    @State private var showVerseNumbers = false
    @Binding var currentBook: String
    @Binding var currentChapter: Int
    @Binding var currentVerse: Int
    @State private var favoritesManager = FavoritesViewModel.shared
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(BibleBook.allBooks.first(where: { $0.name == book.name })?.description ?? "")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
                
                if isLoading {
                    ProgressView("Cargando texto...")
                        .frame(maxWidth: .infinity)
                        .padding()
                } else if verses.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "book.closed")
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)
                        Text("No hay texto disponible para \(book.name)")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                } else {
                    if showAsVerses {
                        // Vista por versículos separados
                        LazyVStack(alignment: .leading, spacing: 16) {
                            ForEach(verses, id: \.id) { verse in
                                BibleVerseView(verse: verse, currentBook: $currentBook, currentChapter: $currentChapter, currentVerse: $currentVerse)
                            }
                        }
                        .padding(.horizontal)
                    } else {
                        // Vista de lectura continua
                        ContinuousTextView(verses: verses, showVerseNumbers: showVerseNumbers, currentBook: $currentBook, currentChapter: $currentChapter, currentVerse: $currentVerse)
                    }
                }
            }
        }
        .background {
            LinearGradient(
                colors: [BibleBook(rawValue: book.name)?.color ?? .gray, .clear],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
        .scrollBounceBehavior(.basedOnSize)
        .navigationTitle("\(book.name)")
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                // Toggle para números de versículo (solo en vista continua)
                if !showAsVerses {
                    Button {
                        showVerseNumbers.toggle()
                    } label: {
                        Image(systemName: showVerseNumbers ? "textformat.123" : "textformat")
                            .foregroundStyle(.primary)
                    }
                }
                
                // Toggle entre vista continua y versículos
                Button {
                    showAsVerses.toggle()
                } label: {
                    Image(systemName: showAsVerses ? "text.alignleft" : "list.bullet")
                        .foregroundStyle(.primary)
                }
            }
        }
        .task {
            await loadVerses()
        }
        .onAppear {
            updateCurrentPosition()
        }
    }
    
    private func loadVerses() async {
        isLoading = true
        
        // Try to load from JSON files first
        let loadedVerses = BibleDataService.shared.loadBook(book.name)?.verses ?? []
        
        await MainActor.run {
            if loadedVerses.isEmpty {
                // If no JSON data, create sample verses for demonstration
                verses = createSampleVerses(for: book.name)
            } else {
                verses = loadedVerses
            }
            isLoading = false
            updateCurrentPosition()
        }
    }
    
    private func updateCurrentPosition() {
        if !verses.isEmpty {
            let firstVerse = verses.first!
            currentBook = book.name
            currentChapter = firstVerse.chapter
            currentVerse = firstVerse.verse
        }
    }
    
    private func createSampleVerses(for bookName: String) -> [BibleVerse] {
        switch bookName {
        case "Genesis":
            return [
                BibleVerse(book_name: "Génesis", book: 1, chapter: 1, verse: 1, text: "EN el principio crió Dios los cielos y la tierra."),
                BibleVerse(book_name: "Génesis", book: 1, chapter: 1, verse: 2, text: "Y la tierra estaba desordenada y vacía, y las tinieblas estaban sobre la haz del abismo, y el Espíritu de Dios se movía sobre la haz de las aguas."),
                BibleVerse(book_name: "Génesis", book: 1, chapter: 1, verse: 3, text: "Y dijo Dios: Sea la luz: y fué la luz."),
                BibleVerse(book_name: "Génesis", book: 1, chapter: 1, verse: 4, text: "Y vió Dios que la luz era buena: y apartó Dios la luz de las tinieblas."),
                BibleVerse(book_name: "Génesis", book: 1, chapter: 1, verse: 5, text: "Y llamó Dios á la luz Día, y á las tinieblas llamó Noche: y fué la tarde y la mañana un día.")
            ]
        case "Matthew":
            return [
                BibleVerse(book_name: "Mateo", book: 40, chapter: 1, verse: 1, text: "LIBRO de la generación de Jesucristo, hijo de David, hijo de Abraham."),
                BibleVerse(book_name: "Mateo", book: 40, chapter: 1, verse: 2, text: "Abraham engendró á Isaac: é Isaac engendró á Jacob: y Jacob engendró á Judas y á sus hermanos:"),
                BibleVerse(book_name: "Mateo", book: 40, chapter: 1, verse: 3, text: "Y Judas engendró de Thamar á Phares y á Zara: y Phares engendró á Esrom: y Esrom engendró á Aram:")
            ]
        case "John":
            return [
                BibleVerse(book_name: "Juan", book: 43, chapter: 1, verse: 1, text: "EN el principio era el Verbo, y el Verbo era con Dios, y el Verbo era Dios."),
                BibleVerse(book_name: "Juan", book: 43, chapter: 1, verse: 2, text: "Este era en el principio con Dios."),
                BibleVerse(book_name: "Juan", book: 43, chapter: 1, verse: 3, text: "Todas las cosas por él fueron hechas; y sin él nada de lo que es hecho, fué hecho."),
                BibleVerse(book_name: "Juan", book: 43, chapter: 3, verse: 16, text: "Porque de tal manera amó Dios al mundo, que ha dado á su Hijo unigénito, para que todo aquel que en él cree, no se pierda, mas tenga vida eterna.")
            ]
        default:
            return [
                BibleVerse(book_name: bookName, book: 1, chapter: 1, verse: 1, text: "Contenido de ejemplo para \(bookName). Para ver el texto completo, añade los archivos JSON correspondientes al proyecto."),
                BibleVerse(book_name: bookName, book: 1, chapter: 1, verse: 2, text: "Este es un versículo de demostración para mostrar cómo funcionaría la aplicación con datos reales.")
            ]
        }
    }
}

struct ContinuousTextView: View {
    let verses: [BibleVerse]
    let showVerseNumbers: Bool
    @Binding var currentBook: String
    @Binding var currentChapter: Int
    @Binding var currentVerse: Int
    
    private var groupedVerses: [Int: [BibleVerse]] {
        Dictionary(grouping: verses) { $0.chapter }
    }
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 24) {
            ForEach(groupedVerses.keys.sorted(), id: \.self) { chapterNumber in
                VStack(alignment: .leading, spacing: 12) {
                    // Título del capítulo
                    Text("Capítulo \(chapterNumber)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .fontDesign(.serif)
                        .padding(.top, chapterNumber == 1 ? 0 : 16)
                    
                    // Texto continuo del capítulo
                    let chapterVerses = groupedVerses[chapterNumber]?.sorted { $0.verse < $1.verse } ?? []
                    
                    Text(buildChapterText(verses: chapterVerses))
                        .font(.body)
                        .fontDesign(.serif)
                        .lineSpacing(8)
                        .multilineTextAlignment(.leading)
                        .onTapGesture {
                            if let firstVerse = chapterVerses.first {
                                currentBook = firstVerse.book_name
                                currentChapter = firstVerse.chapter
                                currentVerse = firstVerse.verse
                            }
                        }
                }
            }
        }
        .padding(.horizontal)
    }
    
    private func buildChapterText(verses: [BibleVerse]) -> AttributedString {
        var result = AttributedString()
        
        for (index, verse) in verses.enumerated() {
            // Número del versículo (solo si está activado)
            if showVerseNumbers {
                var verseNumber = AttributedString("\(verse.verse)")
                verseNumber.font = .caption
                verseNumber.foregroundColor = .secondary
                result += verseNumber
                result += AttributedString(" ")
            }
            
            // Texto del versículo
            var verseText = AttributedString(verse.text)
            verseText.font = .body
            result += verseText
            
            // Añadir espacio entre versículos
            if index < verses.count - 1 {
                result += AttributedString(" ")
            }
        }
        
        return result
    }
}

struct BibleVerseView: View {
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
                    favoritesManager.toggleFavorite(verse)
                } label: {
                    Image(systemName: favoritesManager.isFavorite(verse) ? "heart.fill" : "heart")
                        .foregroundStyle(favoritesManager.isFavorite(verse) ? .accent : .secondary)
                }
            }
            
            Text(verse.text)
                .font(.body)
                .lineLimit(nil)
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onTapGesture {
            currentBook = verse.book_name
            currentChapter = verse.chapter
            currentVerse = verse.verse
        }
    }
}

#Preview {
    @Previewable @State var currentBook = "Genesis"
    @Previewable @State var currentChapter = 1
    @Previewable @State var currentVerse = 1
    
    NavigationStack {
        BookView(book: BibleBook.allBooks.first!, currentBook: $currentBook, currentChapter: $currentChapter, currentVerse: $currentVerse)
    }
}
