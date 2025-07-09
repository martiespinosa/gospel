import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var searchResults: [BibleVerse] = []
    @State private var isSearching = false
    @State private var searchScope: SearchScope = .all
    
    enum SearchScope: String, CaseIterable {
        case all = "Todo"
        case reference = "Referencia"
        case text = "Texto"
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if searchText.isEmpty {
                    // Estado inicial - sugerencias
                    SearchSuggestionsView()
                } else if isSearching {
                    // Buscando
                    ProgressView("Buscando...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if searchResults.isEmpty {
                    // Sin resultados
                    SearchEmptyView(searchText: searchText)
                } else {
                    // Resultados
                    SearchResultsView(results: searchResults)
                }
            }
            .navigationTitle("Buscar")
            .searchable(text: $searchText, prompt: "Buscar versículos o referencias...")
            .searchScopes($searchScope) {
                ForEach(SearchScope.allCases, id: \.self) { scope in
                    Text(scope.rawValue)
                }
            }
            .onChange(of: searchText) { _, newValue in
                performSearch(newValue)
            }
            .onChange(of: searchScope) { _, _ in
                if !searchText.isEmpty {
                    performSearch(searchText)
                }
            }
        }
    }
    
    private func performSearch(_ query: String) {
        guard !query.isEmpty else {
            searchResults = []
            return
        }
        
        isSearching = true
        
        Task {
            let results = await searchVerses(query: query, scope: searchScope)
            
            await MainActor.run {
                searchResults = results
                isSearching = false
            }
        }
    }
    
    private func searchVerses(query: String, scope: SearchScope) async -> [BibleVerse] {
        // Lista de libros más comunes para buscar primero
        let popularBooks = ["Genesis", "Matthew", "John", "Romans", "Psalms", "Proverbs"]
        let allBooks = ["Genesis", "Exodus", "Leviticus", "Numbers", "Deuteronomy", "Joshua", "Judges", "Ruth", "1 Samuel", "2 Samuel", "1 Kings", "2 Kings", "1 Chronicles", "2 Chronicles", "Ezra", "Nehemiah", "Esther", "Job", "Psalms", "Proverbs", "Ecclesiastes", "Song of Solomon", "Isaiah", "Jeremiah", "Lamentations", "Ezekiel", "Daniel", "Hosea", "Joel", "Amos", "Obadiah", "Jonah", "Micah", "Nahum", "Habakkuk", "Zephaniah", "Haggai", "Zechariah", "Malachi", "Matthew", "Mark", "Luke", "John", "Acts", "Romans", "1 Corinthians", "2 Corinthians", "Galatians", "Ephesians", "Philippians", "Colossians", "1 Thessalonians", "2 Thessalonians", "1 Timothy", "2 Timothy", "Titus", "Philemon", "Hebrews", "James", "1 Peter", "2 Peter", "1 John", "2 John", "3 John", "Jude", "Revelation"]
        
        // Buscar en libros populares primero, luego en todos
        let searchOrder = popularBooks + allBooks.filter { !popularBooks.contains($0) }
        
        return await MainActor.run {
            var allResults: [BibleVerse] = []
            
            for bookName in searchOrder {
                if let bookData = BibleDataService.shared.loadBook(bookName) {
                    let bookResults = self.searchInBook(bookData.verses, query: query, scope: scope)
                    allResults.append(contentsOf: bookResults)
                    
                    // Limitar resultados para mejor rendimiento
                    if allResults.count >= 100 {
                        break
                    }
                }
            }
            
            return Array(allResults.prefix(50)) // Máximo 50 resultados
        }
    }
    
    private func searchInBook(_ verses: [BibleVerse], query: String, scope: SearchScope) -> [BibleVerse] {
        
        switch scope {
        case .all:
            return verses.filter { verse in
                verse.text.localizedCaseInsensitiveContains(query) ||
                verse.book_name.localizedCaseInsensitiveContains(query) ||
                "\(verse.chapter):\(verse.verse)".contains(query)
            }
        case .reference:
            return verses.filter { verse in
                verse.book_name.localizedCaseInsensitiveContains(query) ||
                "\(verse.chapter):\(verse.verse)".contains(query) ||
                "\(verse.chapter)".contains(query)
            }
        case .text:
            return verses.filter { verse in
                verse.text.localizedCaseInsensitiveContains(query)
            }
        }
    }
}

struct SearchSuggestionsView: View {
    let suggestions = [
        "Juan 3:16", "Salmos 23", "Romanos 8:28", "Génesis 1:1", 
        "amor", "esperanza", "fe", "salvación", "paz", "gracia"
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Búsquedas populares")
                        .font(.headline)
                        .foregroundStyle(.primary)
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 8) {
                        ForEach(suggestions, id: \.self) { suggestion in
                            SearchSuggestionChip(text: suggestion)
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Ejemplos de búsqueda")
                        .font(.headline)
                        .foregroundStyle(.primary)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        SearchExampleRow(example: "Juan 3:16", description: "Buscar versículo específico")
                        SearchExampleRow(example: "Salmos 23", description: "Buscar capítulo completo")
                        SearchExampleRow(example: "amor", description: "Buscar por palabra en el texto")
                        SearchExampleRow(example: "Génesis", description: "Buscar por libro")
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct SearchSuggestionChip: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.subheadline)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct SearchExampleRow: View {
    let example: String
    let description: String
    
    var body: some View {
        HStack {
            Text(example)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(.blue)
            
            Text("—")
                .foregroundStyle(.secondary)
            
            Text(description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Spacer()
        }
    }
}

struct SearchEmptyView: View {
    let searchText: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 48))
                .foregroundStyle(.secondary)
            
            Text("Sin resultados")
                .font(.title2)
                .fontWeight(.medium)
            
            Text("No se encontraron resultados para \"\(searchText)\"")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            
            Text("Intenta buscar por:")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.top)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("• Libro (ej: Génesis)")
                Text("• Referencia (ej: Juan 3:16)")
                Text("• Palabra del texto (ej: amor)")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SearchResultsView: View {
    let results: [BibleVerse]
    
    var body: some View {
        List {
            Section {
                ForEach(results, id: \.id) { verse in
                    SearchResultRow(verse: verse)
                }
            } header: {
                Text("\(results.count) resultado\(results.count == 1 ? "" : "s")")
            }
        }
        .listStyle(.insetGrouped)
    }
}

struct SearchResultRow: View {
    let verse: BibleVerse
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(verse.book_name) \(verse.chapter):\(verse.verse)")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.blue)
                
                Spacer()
            }
            
            Text(verse.text)
                .font(.body)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    SearchView()
}