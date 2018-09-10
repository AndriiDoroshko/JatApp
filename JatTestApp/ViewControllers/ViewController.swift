//
//  ViewController.swift
//  JatTestApp
//
//  Created by Andrey Doroshko on 9/5/18.
//  Copyright © 2018 Andrey Doroshko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.placeholder = "User email"
        passwordTextField.placeholder = "Password"
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }

    @IBAction func logInPressed(_ sender: Any) {
        guard let email = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        let data = ["email": email,
                    "password": password]
        AutService().logIn(with: data) { logInModel, response, error in
            if logInModel != nil {
                let resultViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "result") as? ResultViewController
                if resultViewController != nil {
                    DispatchQueue.main.async {
                        self.navigationController?.pushViewController(resultViewController!, animated: true)
                    }
                }
            }
        }
    }
    
    func isValidEmail(testStr:String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let restId = textField.restorationIdentifier else { return }
        switch restId {
        case "Email":
            if isValidEmail(testStr: textField.text) && !(passwordTextField.text?.isEmpty)! {
                logInButton.isEnabled = true
            } else {
                logInButton.isEnabled = false
            }
        case "Password":
                logInButton.isEnabled = false
        default:
            return
        }
    }
//    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let restId = textField.restorationIdentifier else { return false }
//        switch restId {
//        case "email":
//            return true
//        case "password":
//            let strippedString = "*"
//            
//            if let replaceStart = textField.position(from: textField.beginningOfDocument, offset: range.location),
//                let replaceEnd = textField.position(from: replaceStart, offset: range.length),
//                let textRange = textField.textRange(from: replaceStart, to: replaceEnd) {
//                
//                textField.replace(textRange, withText: strippedString)
//            }
//        default:
//            return false
//        }
//        return false
//    }
}
