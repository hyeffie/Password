//
//  ViewController.swift
//  Password
//
//  Created by Hyejeong Park on 2022/11/10.
//

import UIKit

class ViewController: UIViewController {
  
  let essentialChars = ["abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
                        "0123456789",
                        "~!@#$%^&*"]
  let specialCharSet = CharacterSet(charactersIn: "~!@#$%^&*")
  
  @IBOutlet weak var passwordInput: UITextField!
  
  @IBOutlet weak var levelView: UIView!
  
  @IBOutlet weak var descriptionLabel: UILabel!
  
  @IBOutlet weak var recommandedPasswordLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func validatePassword(_ sender: Any) {
    checkPasswordLevel()
  }
  
  @IBAction func inputDidChanged(_ sender: Any) {
    checkPasswordLevel()
  }
  
  @IBAction func generateVeryStrongPassword(_ sender: Any) {
    var result = ""
    essentialChars.forEach { result += String($0.randomElement()!) }
    result += String(essentialChars.reduce("", { $0 + $1 })
      .shuffled().prefix(6))
    recommandedPasswordLabel.text = String(result.shuffled())
  }
  
  func checkPasswordLevel() {
    guard let inputText = passwordInput.text else { return }
    let password = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
    guard password.count >= 0 else { return }
    
    let level = passwordValidator(password: password)
    switch level {
    case 1:
      levelView.backgroundColor = .red
      descriptionLabel.text = "아주 약한 암호"
    case 2:
      levelView.backgroundColor = .orange
      descriptionLabel.text = "약한 암호"
    case 3:
      levelView.backgroundColor = .yellow
      descriptionLabel.text = "보통 암호"
    case 4:
      levelView.backgroundColor = .blue
      descriptionLabel.text = "강한 암호"
    case 5:
      levelView.backgroundColor = .green
      descriptionLabel.text = "아주 강한 암호"
    default:
      break
    }
  }
  
  func passwordValidator(password: String) -> Int {
    var (alphabetCount, numCount, symbolCount) = (0, 0, 0)
    
    password.unicodeScalars.forEach { char in
      if CharacterSet.lowercaseLetters.contains(char) ||
          CharacterSet.uppercaseLetters.contains(char)  { alphabetCount += 1 }
      else if CharacterSet.decimalDigits.contains(char) { numCount += 1 }
      else if specialCharSet.contains(char) { symbolCount += 1 }
    }
    
    if password.count < 8 {
      if password.count == numCount { return 1 }
      else if password.count == alphabetCount { return 2 }
    } else {
      if alphabetCount >= 1 && numCount >= 1 {
        if symbolCount >= 1 { return 5 }
        else { return 4 }
      }
    }
    
    return 3
  }
}
