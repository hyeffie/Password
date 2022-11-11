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
  
  @IBOutlet weak var recommandedPasswordLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func validatePassword(_ sender: Any) {
    updatePasswordLevel()
  }
  
  @IBAction func inputDidChanged(_ sender: Any) {
    updatePasswordLevel()
  }
  
  @IBAction func generatePassword(_ sender: Any) {
    recommandedPasswordLabel.text = Password.generateVeryStrongPassword()
  }
  
  private func updatePasswordLevel() {
    guard let input = passwordInput.text else { return }
    let trimmedInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
    
    let password = Password(words: trimmedInput)
    levelView.backgroundColor = password.level.color
    descriptionLabel.text = password.level.description
  }
  
}

