//
//  File.swift
//  
//
//  Created by Martin Kock on 28/09/2023.
//

import Foundation

extension String {
    // char count + 5
    public func setCharCount() -> String {
        
        return "5"
    }
}

extension Int {
      var durationInMinSecFromMicrosondsIntToString: String {
            return String(format:"%d:%02d", self / 1000 / 60, self % 60)
      }
      
      var durationInMinFromMicrosecondsIntToString: String {
            let duration = String(format:"%d", self / 1000 / 60)
            return "\(duration) min"
      }
      
      var epochToCurrentDateWithDaysSince: String {
            let date = Date(timeIntervalSince1970: TimeInterval(self))
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            dateFormatter.dateFormat = "d. MMMM yyyy"
            
            let calendar = Calendar.current
            let currentDate = Date()
            
            if calendar.isDate(date, inSameDayAs: currentDate) {
                  return "idag"
            } else if let daysAgo = calendar.dateComponents([.day], from: date, to: currentDate).day, daysAgo < 7 && daysAgo > 1 {
                  let stringEnd = "dag siden"
                  return "\(daysAgo) \(stringEnd)"
            } else if let daysAgo = calendar.dateComponents([.day], from: date, to: currentDate).day, daysAgo == 1 {
                  let stringEnd = "dage siden"
                  return "\(daysAgo) \(stringEnd)"
            }
            else {
                  return dateFormatter.string(from: date)
            }
      }
      
      func checkIfEpochIsOlderThanSevenDays() -> Bool{
            let date = Date(timeIntervalSince1970: TimeInterval(self))
            let calendar = Calendar.current
            let currentDate = Date()
            
            if let daysAgo = calendar.dateComponents([.day], from: date, to: currentDate).day, daysAgo < 7 {
                  return false
            } else {
                  return true
            }
      }
    
}


