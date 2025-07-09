//
//  Book.swift
//  Gospel
//
//  Created by Martí Espinosa Farran on 18/6/25.
//

import Foundation
import SwiftUI

struct Book: Identifiable, Codable, Hashable {
    var id: String { name }
    let name: String
    let chapterCount: Int
    let versesPerChapter: [Int]
    let description: String
}

enum BibleBook: String, CaseIterable, Codable {
    case genesis = "Genesis"
    case exodus = "Exodus"
    case leviticus = "Leviticus"
    case numbers = "Numbers"
    case deuteronomy = "Deuteronomy"
    case joshua = "Joshua"
    case judges = "Judges"
    case ruth = "Ruth"
    case firstSamuel = "1 Samuel"
    case secondSamuel = "2 Samuel"
    case firstKings = "1 Kings"
    case secondKings = "2 Kings"
    case firstChronicles = "1 Chronicles"
    case secondChronicles = "2 Chronicles"
    case ezra = "Ezra"
    case nehemiah = "Nehemiah"
    case esther = "Esther"
    case job = "Job"
    case psalms = "Psalms"
    case proverbs = "Proverbs"
    case ecclesiastes = "Ecclesiastes"
    case songOfSolomon = "Song of Solomon"
    case isaiah = "Isaiah"
    case jeremiah = "Jeremiah"
    case lamentations = "Lamentations"
    case ezekiel = "Ezekiel"
    case daniel = "Daniel"
    case hosea = "Hosea"
    case joel = "Joel"
    case amos = "Amos"
    case obadiah = "Obadiah"
    case jonah = "Jonah"
    case micah = "Micah"
    case nahum = "Nahum"
    case habakkuk = "Habakkuk"
    case zephaniah = "Zephaniah"
    case haggai = "Haggai"
    case zechariah = "Zechariah"
    case malachi = "Malachi"
    case matthew = "Matthew"
    case mark = "Mark"
    case luke = "Luke"
    case john = "John"
    case acts = "Acts"
    case romans = "Romans"
    case firstCorinthians = "1 Corinthians"
    case secondCorinthians = "2 Corinthians"
    case galatians = "Galatians"
    case ephesians = "Ephesians"
    case philippians = "Philippians"
    case colossians = "Colossians"
    case firstThessalonians = "1 Thessalonians"
    case secondThessalonians = "2 Thessalonians"
    case firstTimothy = "1 Timothy"
    case secondTimothy = "2 Timothy"
    case titus = "Titus"
    case philemon = "Philemon"
    case hebrews = "Hebrews"
    case james = "James"
    case firstPeter = "1 Peter"
    case secondPeter = "2 Peter"
    case firstJohn = "1 John"
    case secondJohn = "2 John"
    case thirdJohn = "3 John"
    case jude = "Jude"
    case revelation = "Revelation"
}

extension BibleBook {
    static let spanishToEnglishMapping: [String: String] = [
        "Génesis": "Genesis",
        "Éxodo": "Exodus",
        "Levítico": "Leviticus",
        "Números": "Numbers",
        "Deuteronomio": "Deuteronomy",
        "Josué": "Joshua",
        "Jueces": "Judges",
        "Rut": "Ruth",
        "1 Samuel": "1 Samuel",
        "2 Samuel": "2 Samuel",
        "1 Reyes": "1 Kings",
        "2 Reyes": "2 Kings",
        "1 Crónicas": "1 Chronicles",
        "2 Crónicas": "2 Chronicles",
        "Esdras": "Ezra",
        "Nehemías": "Nehemiah",
        "Ester": "Esther",
        "Job": "Job",
        "Salmos": "Psalms",
        "Proverbios": "Proverbs",
        "Eclesiastés": "Ecclesiastes",
        "Canción de canciones": "Song of Solomon",
        "Isaías": "Isaiah",
        "Jeremías": "Jeremiah",
        "Lamentaciones": "Lamentations",
        "Ezequiel": "Ezekiel",
        "Daniel": "Daniel",
        "Oseas": "Hosea",
        "Joel": "Joel",
        "Amós": "Amos",
        "Abdías": "Obadiah",
        "Jonás": "Jonah",
        "Miqueas": "Micah",
        "Nahúm": "Nahum",
        "Habacuc": "Habakkuk",
        "Sofonías": "Zephaniah",
        "Hageo": "Haggai",
        "Zacarías": "Zechariah",
        "Malaquías": "Malachi",
        "Mateo": "Matthew",
        "Marcos": "Mark",
        "Lucas": "Luke",
        "Juan": "John",
        "Hechos": "Acts",
        "Romanos": "Romans",
        "1 Corintios": "1 Corinthians",
        "2 Corintios": "2 Corinthians",
        "Gálatas": "Galatians",
        "Efesios": "Ephesians",
        "Filipenses": "Philippians",
        "Colosenses": "Colossians",
        "1 Tesalonicenses": "1 Thessalonians",
        "2 Tesalonicenses": "2 Thessalonians",
        "1 Timoteo": "1 Timothy",
        "2 Timoteo": "2 Timothy",
        "Tito": "Titus",
        "Filemón": "Philemon",
        "Hebreos": "Hebrews",
        "Santiago": "James",
        "1 Pedro": "1 Peter",
        "2 Pedro": "2 Peter",
        "1 Juan": "1 John",
        "2 Juan": "2 John",
        "3 Juan": "3 John",
        "Judas": "Jude",
        "Revelación": "Revelation"
    ]
    
    static let allBooks: [Book] = [
        Book(name: "Genesis", chapterCount: 50, versesPerChapter: [
            31, 25, 24, 26, 32, 22, 24, 22, 29, 32,
            32, 20, 18, 24, 21, 16, 27, 33, 38, 18,
            34, 24, 20, 67, 34, 35, 46, 22, 35, 43,
            55, 32, 20, 31, 29, 43, 36, 30, 23, 23,
            57, 38, 34, 34, 28, 34, 31, 22, 33, 26
        ], description: "Relata la creación del mundo, los patriarcas y los inicios del pueblo de Israel."),
        Book(name: "Exodus", chapterCount: 40, versesPerChapter: [
            22, 25, 22, 31, 23, 30, 25, 32, 35, 29,
            10, 51, 22, 31, 27, 36, 16, 27, 25, 26,
            36, 31, 33, 18, 40, 37, 21, 43, 46, 38,
            18, 35, 23, 35, 35, 38, 29, 31, 43, 38
        ], description: "Narra la liberación de Israel de Egipto y la entrega de la Ley en el Sinaí."),
        Book(name: "Leviticus", chapterCount: 27, versesPerChapter: [
            17, 16, 17, 35, 19, 30, 38, 36, 24, 20,
            47, 8, 59, 57, 33, 34, 16, 30, 37, 27,
            24, 33, 44, 23, 55, 46, 34
        ], description: "Contiene leyes y regulaciones para la vida religiosa y moral de Israel."),
        Book(name: "Numbers", chapterCount: 36, versesPerChapter: [
            54, 34, 51, 49, 31, 27, 89, 26, 23, 36,
            35, 16, 33, 45, 41, 50, 13, 32, 22, 29,
            35, 41, 30, 25, 18, 65, 23, 31, 39, 17,
            54, 42, 56, 29, 34, 13
        ], description: "Describe el censo y las peregrinaciones del pueblo de Israel en el desierto."),
        Book(name: "Deuteronomy", chapterCount: 34, versesPerChapter: [
            46, 37, 29, 49, 33, 25, 26, 20, 29, 22,
            32, 32, 18, 29, 23, 22, 20, 22, 21, 20,
            23, 30, 25, 22, 19, 19, 26, 68, 29, 20,
            30, 52, 29, 12
        ], description: "Reitera la Ley y prepara a Israel para entrar en la Tierra Prometida."),
        Book(name: "Joshua", chapterCount: 24, versesPerChapter: [
            18, 24, 17, 24, 15, 27, 26, 35, 27, 43,
            23, 24, 33, 15, 63, 10, 18, 28, 51, 9,
            45, 34, 16, 33
        ], description: "Relata la conquista y distribución de la Tierra Prometida bajo Josué."),
        Book(name: "Judges", chapterCount: 21, versesPerChapter: [
            36, 23, 31, 24, 31, 40, 25, 35, 57, 18,
            40, 15, 25, 20, 20, 31, 13, 31, 30, 48,
            25
        ], description: "Cuenta la historia de Israel durante el período de los jueces y sus ciclos de pecado y redención."),
        Book(name: "Ruth", chapterCount: 4, versesPerChapter: [
            22, 23, 18, 22
        ], description: "Historia de lealtad y redención en tiempos de los jueces, antepasada de David."),
        Book(name: "1 Samuel", chapterCount: 31, versesPerChapter: [
            28, 36, 21, 22, 12, 21, 17, 22, 27, 27,
            15, 25, 23, 52, 35, 23, 58, 30, 24, 42,
            15, 23, 29, 22, 44, 25, 12, 25, 11, 31,
            13
        ], description: "Relata el establecimiento de la monarquía en Israel y la vida de Samuel y Saúl."),
        Book(name: "2 Samuel", chapterCount: 24, versesPerChapter: [
            27, 32, 39, 12, 25, 23, 29, 18, 13, 19,
            27, 31, 39, 33, 37, 23, 29, 33, 43, 26,
            22, 51, 39, 25
        ], description: "Describe el reinado del rey David y la consolidación del reino."),
        Book(name: "1 Kings", chapterCount: 22, versesPerChapter: [
            53, 46, 28, 34, 18, 38, 51, 66, 28, 29,
            43, 33, 34, 31, 34, 34, 24, 46, 21, 43,
            29, 54
        ], description: "Narra la historia de los reyes de Israel y Judá hasta la división del reino."),
        Book(name: "2 Kings", chapterCount: 25, versesPerChapter: [
            18, 25, 27, 44, 27, 33, 20, 29, 37, 36,
            21, 21, 25, 29, 38, 20, 41, 37, 37, 21,
            26, 20, 37, 20, 30
        ], description: "Continúa la historia de los reyes y la caída de Israel y Judá."),
        Book(name: "1 Chronicles", chapterCount: 29, versesPerChapter: [
            54, 55, 24, 43, 26, 81, 40, 40, 44, 14,
            47, 40, 14, 17, 29, 43, 27, 17, 19, 8,
            30, 19, 32, 31, 31, 32, 34, 21, 30
        ], description: "Recopilación genealógica y la historia del reinado de David."),
        Book(name: "2 Chronicles", chapterCount: 36, versesPerChapter: [
            17, 18, 17, 22, 14, 42, 22, 18, 31, 19,
            23, 16, 22, 15, 19, 14, 19, 34, 11, 37,
            20, 12, 21, 27, 28, 23, 9, 27, 36, 27,
            21, 33, 25, 33, 27, 23
        ], description: "Relata la historia de Judá desde Salomón hasta el exilio babilónico."),
        Book(name: "Ezra", chapterCount: 10, versesPerChapter: [
            11, 70, 13, 24, 17, 22, 28, 36, 15, 44
        ], description: "Describe el regreso de los exiliados y la reconstrucción del templo."),
        Book(name: "Nehemiah", chapterCount: 13, versesPerChapter: [
            11, 20, 32, 23, 19, 19, 73, 18, 38, 39,
            36, 47, 31
        ], description: "Narra la reconstrucción de los muros de Jerusalén y reformas religiosas."),
        Book(name: "Esther", chapterCount: 10, versesPerChapter: [
            22, 23, 15, 17, 14, 14, 10, 17, 32, 3
        ], description: "Historia de la salvación del pueblo judío en Persia mediante la reina Esther."),
        Book(name: "Job", chapterCount: 42, versesPerChapter: [
            22, 13, 26, 21, 27, 30, 21, 22, 35, 22,
            20, 25, 28, 22, 35, 22, 16, 21, 29, 29,
            34, 30, 17, 25, 6, 14, 23, 28, 25, 31,
            40, 22, 33, 37, 16, 33, 24, 41, 30, 24,
            34, 17
        ], description: "Explora el sufrimiento, la fe y la justicia divina a través de la vida de Job."),
        Book(name: "Psalms", chapterCount: 150, versesPerChapter: [
            6, 12, 8, 8, 12, 10, 17, 9, 20, 18,
            7, 8, 6, 7, 5, 11, 15, 50, 14, 9,
            13, 31, 6, 10, 22, 12, 14, 9, 11, 12,
            24, 11, 22, 22, 28, 12, 40, 22, 13, 17,
            13, 11, 5, 26, 17, 11, 9, 14, 20, 23,
            19, 9, 6, 7, 23, 13, 11, 11, 17, 12,
            8, 12, 11, 10, 13, 20, 7, 35, 36, 5,
            24, 20, 28, 23, 10, 12, 20, 72, 13, 19,
            16, 8, 18, 12, 13, 17, 7, 18, 52, 17,
            16, 15, 5, 23, 11, 13, 12, 9, 9, 5,
            8, 28, 22, 35, 45, 48, 43, 13, 31, 7,
            10, 10, 9, 8, 18, 19, 2, 29, 176, 7,
            8, 9, 4, 8, 5, 6, 5, 6, 8, 8,
            3, 18, 3, 3, 21, 26, 9, 8, 24, 13,
            10, 7, 12, 15, 21, 10, 20, 14, 9, 6
        ], description: "Colección de himnos y oraciones que expresan adoración y confianza en Dios."),
        Book(name: "Proverbs", chapterCount: 31, versesPerChapter: [
            33, 22, 35, 27, 23, 35, 27, 36, 18, 32,
            31, 28, 25, 35, 33, 33, 28, 24, 29, 30,
            31, 29, 35, 34, 28, 28, 27, 28, 27, 33,
            31
        ], description: "Recopilación de sabiduría práctica para la vida diaria y moral."),
        Book(name: "Ecclesiastes", chapterCount: 12, versesPerChapter: [
            18, 26, 22, 16, 20, 12, 29, 17, 18, 20,
            10, 14
        ], description: "Reflexiones sobre el sentido de la vida y la vanidad de las cosas terrenales."),
        Book(name: "Song of Solomon", chapterCount: 8, versesPerChapter: [
            17, 17, 11, 16, 16, 12, 14, 14
        ], description: "Poema que celebra el amor y la belleza entre esposos."),
        Book(name: "Isaiah", chapterCount: 66, versesPerChapter: [
            31, 22, 26, 6, 30, 13, 25, 22, 21, 34,
            16, 6, 22, 32, 9, 14, 14, 7, 25, 6,
            17, 25, 18, 23, 12, 21, 13, 29, 24, 33,
            9, 20, 24, 17, 10, 22, 38, 22, 8, 31,
            29, 25, 28, 28, 25, 13, 15, 22, 26, 11,
            23, 15, 12, 17, 13, 12, 21, 14, 21, 22,
            11, 12, 19, 12, 25, 24
        ], description: "Profecías sobre juicio, esperanza y la venida del Mesías."),
        Book(name: "Jeremiah", chapterCount: 52, versesPerChapter: [
            19, 37, 25, 31, 31, 30, 34, 22, 26, 25,
            23, 17, 27, 22, 21, 21, 27, 23, 15, 18,
            14, 30, 40, 10, 38, 24, 22, 17, 32, 24,
            40, 44, 26, 22, 19, 32, 21, 28, 18, 16,
            18, 22, 13, 30, 5, 28, 7, 47, 39, 46,
            64, 34
        ], description: "Profecías de advertencia y consuelo durante la caída de Judá."),
        Book(name: "Lamentations", chapterCount: 5, versesPerChapter: [
            22, 22, 66, 22, 22
        ], description: "Poemas que expresan el dolor por la destrucción de Jerusalén."),
        Book(name: "Ezekiel", chapterCount: 48, versesPerChapter: [
            28, 10, 27, 17, 17, 14, 27, 18, 11, 22,
            25, 28, 23, 23, 8, 63, 24, 32, 14, 49,
            32, 31, 49, 27, 17, 21, 36, 26, 21, 26,
            18, 32, 33, 31, 15, 38, 28, 23, 29, 49,
            26, 20, 27, 31, 25, 24, 23, 35
        ], description: "Visiones y mensajes de juicio y restauración para Israel."),
        Book(name: "Daniel", chapterCount: 12, versesPerChapter: [
            21, 49, 30, 37, 31, 28, 28, 27, 27, 21,
            45, 13
        ], description: "Relatos y profecías sobre la soberanía de Dios en tiempos de exilio."),
        Book(name: "Hosea", chapterCount: 14, versesPerChapter: [
            11, 23, 5, 19, 15, 11, 16, 14, 17, 15,
            12, 14, 16, 9
        ], description: "Profecías que usan el matrimonio como metáfora del amor fiel de Dios."),
        Book(name: "Joel", chapterCount: 3, versesPerChapter: [
            20, 32, 21
        ], description: "Llamado al arrepentimiento y promesas de restauración futura."),
        Book(name: "Amos", chapterCount: 9, versesPerChapter: [
            15, 16, 15, 13, 27, 14, 17, 14, 15
        ], description: "Denuncia la injusticia social y llama al arrepentimiento."),
        Book(name: "Obadiah", chapterCount: 1, versesPerChapter: [
            21
        ], description: "Profecía contra Edom por su arrogancia y violencia contra Israel."),
        Book(name: "Jonah", chapterCount: 4, versesPerChapter: [
            17, 10, 10, 11
        ], description: "Historia de la misericordia de Dios hacia Nínive y la obediencia de Jonás."),
        Book(name: "Micah", chapterCount: 7, versesPerChapter: [
            16, 13, 12, 13, 15, 16, 20
        ], description: "Profecías de juicio y esperanza, incluyendo la venida del Mesías."),
        Book(name: "Nahum", chapterCount: 3, versesPerChapter: [
            15, 13, 19
        ], description: "Profecía sobre la caída de Nínive como juicio divino."),
        Book(name: "Habakkuk", chapterCount: 3, versesPerChapter: [
            17, 20, 19
        ], description: "Diálogo sobre el problema del mal y la justicia de Dios."),
        Book(name: "Zephaniah", chapterCount: 3, versesPerChapter: [
            18, 15, 20
        ], description: "Advertencias del día del juicio y promesas de restauración."),
        Book(name: "Haggai", chapterCount: 2, versesPerChapter: [
            15, 23
        ], description: "Exhortación a reconstruir el templo y renovar la fe."),
        Book(name: "Zechariah", chapterCount: 14, versesPerChapter: [
            21, 13, 10, 14, 11, 15, 14, 23, 17, 12,
            17, 14, 9, 21
        ], description: "Visiones proféticas que animan a la restauración y anuncian al Mesías."),
        Book(name: "Malachi", chapterCount: 4, versesPerChapter: [
            14, 17, 18, 6
        ], description: "Llamado a la fidelidad y anuncio de la venida de un mensajero."),
        Book(name: "Matthew", chapterCount: 28, versesPerChapter: [
            25, 23, 17, 25, 48, 34, 29, 34, 38, 42,
            30, 50, 58, 36, 39, 28, 27, 35, 30, 34,
            46, 46, 39, 51, 46, 75, 66, 20
        ], description: "Relato de la vida, enseñanzas, muerte y resurrección de Jesús."),
        Book(name: "Mark", chapterCount: 16, versesPerChapter: [
            45, 28, 35, 41, 43, 56, 37, 38, 50, 52,
            33, 44, 37, 72, 47, 20
        ], description: "Narración breve y dinámica del ministerio de Jesús como Siervo."),
        Book(name: "Luke", chapterCount: 24, versesPerChapter: [
            80, 52, 38, 44, 39, 49, 50, 56, 62, 42,
            54, 59, 35, 35, 32, 31, 37, 43, 48, 47,
            38, 71, 56, 53
        ], description: "Historia detallada de la vida y obra de Jesús con énfasis en la compasión."),
        Book(name: "John", chapterCount: 21, versesPerChapter: [
            51, 25, 36, 54, 47, 71, 53, 59, 41, 42,
            57, 50, 38, 31, 27, 33, 26, 40, 42, 31,
            25
        ], description: "Presenta a Jesús como el Hijo de Dios y Salvador del mundo."),
        Book(name: "Acts", chapterCount: 28, versesPerChapter: [
            26, 47, 26, 37, 42, 15, 60, 40, 43, 48,
            30, 25, 52, 28, 41, 40, 34, 28, 41, 38,
            40, 30, 35, 27, 27, 32, 44, 31
        ], description: "Relata la expansión de la iglesia primitiva y la obra del Espíritu Santo."),
        Book(name: "Romans", chapterCount: 16, versesPerChapter: [
            32, 29, 31, 25, 21, 23, 25, 39, 33, 21,
            36, 21, 14, 23, 33, 27
        ], description: "Exposición teológica de la salvación por fe en Cristo."),
        Book(name: "1 Corinthians", chapterCount: 16, versesPerChapter: [
            31, 16, 23, 21, 13, 20, 40, 13, 27, 33,
            34, 31, 13, 40, 58, 24
        ], description: "Instrucciones para corregir problemas y promover la unidad en la iglesia."),
        Book(name: "2 Corinthians", chapterCount: 13, versesPerChapter: [
            24, 17, 18, 18, 21, 18, 16, 24, 15, 18,
            33, 21, 14
        ], description: "Defensa del ministerio apostólico y exhortación a la reconciliación."),
        Book(name: "Galatians", chapterCount: 6, versesPerChapter: [
            24, 21, 29, 31, 26, 18
        ], description: "Afirma la libertad en Cristo y la justificación por la fe."),
        Book(name: "Ephesians", chapterCount: 6, versesPerChapter: [
            23, 22, 21, 32, 33, 24
        ], description: "Enseña sobre la iglesia como cuerpo de Cristo y la vida cristiana."),
        Book(name: "Philippians", chapterCount: 4, versesPerChapter: [
            30, 30, 21, 23
        ], description: "Carta de alegría y exhortación a vivir en humildad y unidad."),
        Book(name: "Colossians", chapterCount: 4, versesPerChapter: [
            29, 23, 25, 18
        ], description: "Afirma la supremacía de Cristo y advierte contra falsas enseñanzas."),
        Book(name: "1 Thessalonians", chapterCount: 5, versesPerChapter: [
            10, 20, 13, 18, 28
        ], description: "Aliento y enseñanza sobre la segunda venida de Cristo."),
        Book(name: "2 Thessalonians", chapterCount: 3, versesPerChapter: [
            12, 17, 18
        ], description: "Corrección de malentendidos sobre el día del Señor."),
        Book(name: "1 Timothy", chapterCount: 6, versesPerChapter: [
            20, 15, 16, 16, 25, 21
        ], description: "Instrucciones para la organización y liderazgo en la iglesia."),
        Book(name: "2 Timothy", chapterCount: 4, versesPerChapter: [
            18, 26, 17, 22
        ], description: "Últimas exhortaciones y fidelidad en el ministerio."),
        Book(name: "Titus", chapterCount: 3, versesPerChapter: [
            16, 15, 15
        ], description: "Consejos para la enseñanza y conducta cristiana en la iglesia."),
        Book(name: "Philemon", chapterCount: 1, versesPerChapter: [
            25
        ], description: "Petición para perdonar y recibir a un esclavo convertido."),
        Book(name: "Hebrews", chapterCount: 13, versesPerChapter: [
            14, 18, 19, 16, 14, 20, 28, 13, 28, 39,
            40, 29, 25
        ], description: "Muestra la superioridad de Cristo y la nueva alianza."),
        Book(name: "James", chapterCount: 5, versesPerChapter: [
            27, 26, 18, 17, 20
        ], description: "Enseñanzas prácticas sobre la fe y las obras."),
        Book(name: "1 Peter", chapterCount: 5, versesPerChapter: [
            25, 25, 22, 19, 14
        ], description: "Exhortación a la perseverancia y santidad en medio del sufrimiento."),
        Book(name: "2 Peter", chapterCount: 3, versesPerChapter: [
            21, 22, 18
        ], description: "Advertencias contra falsos maestros y afirmación de la esperanza."),
        Book(name: "1 John", chapterCount: 5, versesPerChapter: [
            10, 29, 24, 21, 21
        ], description: "Enseña sobre el amor, la verdad y la fe en Jesús."),
        Book(name: "2 John", chapterCount: 1, versesPerChapter: [
            13
        ], description: "Advertencia contra los engañadores y llamado al amor."),
        Book(name: "3 John", chapterCount: 1, versesPerChapter: [
            14
        ], description: "Aliento a la hospitalidad y fidelidad en la verdad."),
        Book(name: "Jude", chapterCount: 1, versesPerChapter: [
            25
        ], description: "Advertencia contra falsos maestros y exhortación a la fe."),
        Book(name: "Revelation", chapterCount: 22, versesPerChapter: [
            20, 29, 22, 11, 14, 17, 17, 13, 21, 11,
            19, 17, 18, 20, 8, 21, 18, 24, 21, 15,
            27, 21
        ], description: "Visiones apocalípticas sobre el triunfo final de Dios y la nueva creación.")
    ]
}

extension BibleBook {
    var color: Color {
        switch self {
        case .genesis: return .brown
        case .exodus: return .orange
        case .leviticus: return .red
        case .numbers: return .yellow
        case .deuteronomy: return .mint
        case .joshua: return .indigo
        case .judges: return .gray
        case .ruth: return .pink
        case .firstSamuel: return .teal
        case .secondSamuel: return .teal
        case .firstKings: return .blue
        case .secondKings: return .blue
        case .firstChronicles: return .cyan
        case .secondChronicles: return .cyan
        case .ezra: return .purple
        case .nehemiah: return .purple
        case .esther: return .pink
        case .job: return .gray
        case .psalms: return .blue
        case .proverbs: return .orange
        case .ecclesiastes: return .brown
        case .songOfSolomon: return .pink
        case .isaiah: return .mint
        case .jeremiah: return .red
        case .lamentations: return .gray
        case .ezekiel: return .indigo
        case .daniel: return .blue
        case .hosea: return .mint
        case .joel: return .green
        case .amos: return .brown
        case .obadiah: return .gray
        case .jonah: return .teal
        case .micah: return .orange
        case .nahum: return .red
        case .habakkuk: return .gray
        case .zephaniah: return .yellow
        case .haggai: return .purple
        case .zechariah: return .blue
        case .malachi: return .indigo
        case .matthew: return .blue
        case .mark: return .red
        case .luke: return .green
        case .john: return .teal
        case .acts: return .cyan
        case .romans: return .indigo
        case .firstCorinthians: return .purple
        case .secondCorinthians: return .purple
        case .galatians: return .pink
        case .ephesians: return .mint
        case .philippians: return .yellow
        case .colossians: return .blue
        case .firstThessalonians: return .teal
        case .secondThessalonians: return .teal
        case .firstTimothy: return .orange
        case .secondTimothy: return .orange
        case .titus: return .cyan
        case .philemon: return .gray
        case .hebrews: return .red
        case .james: return .blue
        case .firstPeter: return .green
        case .secondPeter: return .green
        case .firstJohn: return .pink
        case .secondJohn: return .pink
        case .thirdJohn: return .pink
        case .jude: return .red
        case .revelation: return .brown
        }
    }
}