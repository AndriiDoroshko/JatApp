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
        setupStyle()
        setupObserving()
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
    
    func setupStyle() {
        usernameTextField.placeholder = "User email"
        passwordTextField.placeholder = "Password"
        
        logInButton.isEnabled = false
        logInButton.setTitle("Login is Disabled", for: .disabled)
        passwordTextField.isSecureTextEntry = true
    }
    
    func setupObserving() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: UITapGestureRecognizer
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        view.endEditing(true)
    }
    
    @IBAction func validator(_ sender: UITextField) {
        if (usernameTextField.text?.asEmail() != nil) && (passwordTextField.text?.asPassword() != nil) {
            logInButton.isEnabled = true
            logInButton.setTitle("Log In", for: .normal)
        } else {
            logInButton.isEnabled = false
            logInButton.setTitle("Login is Disabled", for: .disabled)
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        let nextResponder = textField.superview?.viewWithTag(nextTag)
        
        if nextResponder != nil {
            nextResponder?.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
