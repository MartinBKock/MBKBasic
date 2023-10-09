//
//  File.swift
//  
//
//  Created by Martin Kock on 28/09/2023.
//

import Foundation

public extension String {
    // MARK: - Public properties
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
  
    
  
    
    var urlQueryAllowed: String {
        self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    var capitalizedSentence: String {
        let firstLetter = prefix(1).capitalized
        let remainingLetters = dropFirst().lowercased()
        return firstLetter + remainingLetters
    }

    // MARK: - Public functions
    func containsLetters() -> Bool {
        self.contains { $0.isLetter }
    }
    
    func containsNumbers() -> Bool {
        self.contains { $0.isNumber }
    }
    
    func containsSymbols() -> Bool {
        self.contains { $0.isSymbol }
    }

    func onlyContainsLetters() -> Bool {
        contains { !$0.isLetter }
    }
    
    func onlyContainsNumbers() -> Bool {
        contains { !$0.isNumber }
    }
    
    func onlyContainsSymbols() -> Bool {
        contains { !$0.isSymbol }
    }
    
    func isEmptyOrWhitespace() -> Bool {
        // Check empty string
        if self.isEmpty {
            return true
        }
        // Trim and check empty string
        return (self.trimmingCharacters(in: .whitespaces) == "")
    }
    
    func range(ofText text: String) -> NSRange {
        let fullText = self
        let range = (fullText as NSString).range(of: text)
        return range
    }
    
 
    
    func asDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {}
        }
        return nil
    }
    
    static func json(from dict: [String: Any]) -> String? {
        if let theJSONData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
            return String(data: theJSONData, encoding: .utf8)
        }
        return nil
    }
}
