//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by Viktor Golubenkov on 02.10.2020.
//

import Foundation

class Emoji: Codable {
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    init(symbol: String, name: String, description: String, usage: String) {
        self.symbol = symbol
        self.name = name
        self.description = description
        self.usage = usage
    }
    
    // MARK: - "Storage":
    // creating a path/file for local repository
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("emojis").appendingPathExtension("plist")
    
    // function for encoding an existing or new emoji
    static func saveToFile(emojis: [Emoji]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedEmojis = try? propertyListEncoder.encode(emojis)
        
        try? encodedEmojis?.write(to: archiveURL, options: .noFileProtection)
    }
    
    // function for decoding an existing emoji
    static func loadFromFile() -> [Emoji]? {
        guard let retrievedData = try? Data(contentsOf: archiveURL) else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<Emoji>.self, from: retrievedData)
    }
    
    // function for loading sample of emojis if "local storage" is empty
    static func loadSampleEmojis() -> [Emoji] {
       return [
    Emoji(symbol: "😀", name: "Grinning Face", description: "A typical smiley face.", usage: "happiness"),
    Emoji(symbol: "😕", name: "Confused Face", description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
    Emoji(symbol: "😍", name: "Heart Eyes", description: "A smiley face with hearts for eyes.", usage: "love of something; attractive"),
    Emoji(symbol: "👮", name: "Police Officer", description: "A police officer wearing a blue cap with a gold badge.", usage: "person of authority"),
    Emoji(symbol: "🐢", name: "Turtle", description: "A cute turtle.", usage: "Something slow"),
    Emoji(symbol: "🐘", name: "Elephant", description: "A gray elephant.", usage: "good memory"),
    Emoji(symbol: "🍝", name: "Spaghetti", description: "A plate of spaghetti.", usage: "spaghetti"),
    Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
    Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"),
    Emoji(symbol: "📚", name: "Stack of Books", description: "Three colored books stacked on each other.", usage: "homework, studying"),
    Emoji(symbol: "💔", name: "Broken Heart", description: "A red, broken heart.", usage: "extreme sadness"),
    Emoji(symbol: "💤", name: "Snore", description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
    Emoji(symbol: "🏁", name: "Checkered Flag", description: "A black-and-white checkered flag.", usage: "completion"),
    Emoji(symbol: "💩", name: "A Smiling Poo", description: "Poo with eyes and mouth", usage: "problem:)")
        ]
    }
    
    
}
