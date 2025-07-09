#!/usr/bin/env python3
import json
import os

def split_bible():
    # Load the full Bible JSON
    with open('Gospel/BibleData/rv_1909.json', 'r', encoding='utf-8') as f:
        bible_data = json.load(f)
    
    verses = bible_data['verses']
    
    # Create output directory
    os.makedirs('Gospel/BibleData/Books', exist_ok=True)
    
    # Group verses by book
    books = {}
    for verse in verses:
        book_name = verse['book_name']
        if book_name not in books:
            books[book_name] = []
        books[book_name].append(verse)
    
    # Create mapping of Spanish to English names
    spanish_to_english = {
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
        "Cantares": "Song of Solomon",
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
        "Apocalipsis": "Revelation"
    }
    
    # Save each book as separate JSON file
    for spanish_name, verses_list in books.items():
        english_name = spanish_to_english.get(spanish_name, spanish_name)
        
        book_data = {
            "name": english_name,
            "spanish_name": spanish_name,
            "verses": verses_list
        }
        
        filename = f"Gospel/BibleData/Books/{english_name}.json"
        with open(filename, 'w', encoding='utf-8') as f:
            json.dump(book_data, f, ensure_ascii=False, indent=2)
        
        print(f"✅ Created {filename} with {len(verses_list)} verses")
    
    print(f"\n🎉 Split complete! Created {len(books)} book files")

if __name__ == "__main__":
    split_bible()