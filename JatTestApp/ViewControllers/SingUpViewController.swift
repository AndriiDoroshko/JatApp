//
//  SingUpViewController.swift
//  JatTestApp
//
//  Created by Andrey Doroshko on 9/5/18.
//  Copyright © 2018 Andrey Doroshko. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repassworTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI(){
        nameTextField.placeholder = "Enter your name"
        emailTextField.placeholder = "Enter your email"
        passwordTextField.placeholder = "Enter password"
        repassworTextField.placeholder = "Re-enter password"
    }
    

    @IBAction func createAccountPressed(_ sender: Any) {
        AutService().createAccount(with: ["name": nameTextField.text!,
                                          "email": emailTextField.text!,
                                          "password": passwordTextField.text!],
                                   completion: { model, responce, error in
            
                                    
        })
    }
}
