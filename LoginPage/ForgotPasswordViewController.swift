//
//  ForgotPasswordViewController.swift
//  LoginPage
//
//  Created by R82 on 29/12/22.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var conformPasswordTextField: UITextField!
    @IBOutlet weak var resetPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
          setup()
    }
    
    func setup() {
        
    
    if newPasswordTextField.text != conformPasswordTextField.text {
        displayAlert(message: "Password must be same")
    }
        
    }
    @IBAction func resetPasswordButtonTapped(_ sender: UIButton) {
        
    }
    
    func displayAlert(message: String){
        let alert: UIAlertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okButton: UIAlertAction = UIAlertAction(title: "ok", style: .default) {
            button in
            print("oky Button tapped")
        }
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}

