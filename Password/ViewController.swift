//
//  ViewController.swift
//  Password
//
//  Created by Hyejeong Park on 2022/11/10.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var passwordInput: UITextField!
  
  @IBOutlet weak var levelView: UIView!
  
  @IBOutlet weak var descriptionLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func passwordValidator(password: String) -> Int {
    var (alphabetCount, numCount, symbolCount) = (0, 0, 0)
    
    password.unicodeScalars.forEach { char in
      if CharacterSet.lowercaseLetters.contains(char) ||
          CharacterSet.uppercaseLetters.contains(char)  { alphabetCount += 1 }
      else if CharacterSet.decimalDigits.contains(char) { numCount += 1 }
      else if CharacterSet(charactersIn: "~!@#$%^&*").contains(char) { symbolCount += 1 }
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

