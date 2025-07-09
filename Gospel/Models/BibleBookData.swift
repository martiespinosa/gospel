//
//  BibleBookData.swift
//  Gospel
//
//  Created by Martí Espinosa Farran on 18/6/25.
//

import Foundation

struct BibleBookData: Codable {
    let name: String
    let spanish_name: String
    let verses: [BibleVerse]
}