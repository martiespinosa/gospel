//
//  BookCardView.swift
//  Gospel
//
//  Created by Martí Espinosa Farran on 18/6/25.
//

import SwiftUI

struct BookCardView: View {
    let book: Book
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(BibleBook(rawValue: book.name)?.color.secondary ?? Color.gray.secondary)
            
            VStack(alignment: .leading, spacing: 8) {
                Spacer()
                
                Text(book.name)
                    .font(.headline)
            }
            .padding()
            .frame(height: 90, alignment: .bottom)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    BookCardView(book: BibleBook.allBooks.first!)
}
