//
//  Password.swift
//  Password
//
//  Created by Hyejeong Park on 2022/11/11.
//

import UIKit

struct Password {
  
  enum Level {
    case one, two, three, four, five
    case notDetermined
    
    var description: String {
      switch self {
      case .one: return "아주 약한 암호"
      case .two: return "약한 암호"
      case .three: return "보통 암호"
      case .four: return "강한 암호"
      case .five: return "아주 강한 암호"
      case .notDetermined: return "암호 수준"
      }
    }
    
    var color: UIColor {
      switch self {
      case .one: return .red
      case .two: return .orange
      case .three: return .yellow
      case .four: return .blue
      case .five: return .green
      case .notDetermined: return .gray
      }
    }
  }
  
  static let essentialChars = ["abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
                               "0123456789",
                               "~!@#$%^&*"]

  static let specialCharSet = CharacterSet(charactersIn: "~!@#$%^&*")
  
  var words: String
  
  var level: Level {
    if words.isEmpty { return .notDetermined }
    
    var (alphabetCount, numCount, symbolCount) = (0, 0, 0)
    self.words.unicodeScalars.forEach { char in
      if CharacterSet.lowercaseLetters.contains(char) ||
          CharacterSet.uppercaseLetters.contains(char)  { alphabetCount += 1 }
      else if CharacterSet.decimalDigits.contains(char) { numCount += 1 }
      else if CharacterSet(charactersIn: "~!@#$%^&*").contains(char) { symbolCount += 1 }
    }
    
    if self.words.count < 8 {
      if self.words.count == numCount { return .one }
      else if self.words.count == alphabetCount { return .two }
    } else {
      if alphabetCount >= 1 && numCount >= 1 {
        return symbolCount >= 1 ? .five : .four
      }
    }
    return .three
  }
  
  static func generateVeryStrongPassword() -> String {
    var result = ""
    essentialChars.forEach { result += String($0.randomElement()!) }
    result += String(essentialChars.reduce("", { $0 + $1 })
      .shuffled().prefix(6))
    return String(result.shuffled())
  }
}
