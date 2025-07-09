//
//  BibleVerse.swift
//  Gospel
//
//  Created by Martí Espinosa Farran on 18/6/25.
//

import Foundation

struct BibleVerse: Codable, Identifiable, Equatable {
    var id: String { "\(book_name) \(chapter):\(verse)" }
    let book_name: String
    let book: Int
    let chapter: Int
    let verse: Int
    let text: String
    
    static let mock = BibleVerse(
        book_name: "John",
        book: 43,
        chapter: 3,
        verse: 16,
        text: "Porque de tal manera amó Dios al mundo, que ha dado a su Hijo unigénito, para que todo aquel que en él cree, no se pierda, mas tenga vida eterna."
    )
}