//
//  RegistractionViewController.swift
//  LoginPage
//
//  Created by R82 on 28/12/22.
//

import UIKit
import Alamofire
import FMDB

class RegistractionViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var conformPasswordTextField: UITextField!
    @IBOutlet weak var registrationButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func registrationButtonTapped(_ sender: UIButton) {
    
            if usernameTextField.text == " " || passwordTextField.text == " "
            {
                displayAlert(message: "Enter userName and password")
            }
            else if usernameTextField.text?.count ?? 0 < 5 || passwordTextField.text? .count ?? 0 < 6
            {
                displayAlert(message: "Enter Valid userName and Password")
            }
            
            if usernameTextField.text == ""
            {
                displayAlert(message: "Enter userName")
            }
            else if passwordTextField.text == " "
            {
                displayAlert(message: "Enter password")
            }
            else if passwordTextField.text?.count ?? 0 < 6
            {
                displayAlert(message: "Enter password")
            }
            else if usernameTextField.text?.count ?? 0 < 5
            {
                
                displayAlert(message: "Enter userName")
            }
        else if passwordTextField.text != conformPasswordTextField.text {
            displayAlert(message: "Password must be same")
        }
//
//        let query = "insert into emp (userName, phoneNumber, password, conformPassword) values ('\(usernameTextField.text ?? "")','\(phoneNumberTextField.text ?? "")','\(passwordTextField.text ?? "")','\(conformPasswordTextField.text ?? "")');"
//        print(query)
//        let databaseObject = FMDatabase(path: AppDelegate.databasePath)
//        if databaseObject.open() {
//            let result = databaseObject.executeUpdate(query, withArgumentsIn: [])
//            if result == true {
//                usernameTextField.text = ""
//                phoneNumberTextField.text = ""
//                passwordTextField.text = ""
//                conformPasswordTextField.text = ""
//            } else {
//                usernameTextField.text = ""
//                phoneNumberTextField.text = ""
//                passwordTextField.text = ""
//                conformPasswordTextField.text = ""
//            }
//        }
        
        
            var parameters: Parameters = [ "email": usernameTextField.text ?? "","password": passwordTextField.text ?? ""]
            AF.request("https://reqres.in/api/user", method: .post, parameters: parameters).responseData { response in
                debugPrint("response \(response)")
                if response.response?.statusCode == 200{
                    guard let apidata = response.data else{return}
                    do{
                        let registrationDetails = try JSONDecoder().decode(Registration.self, from: apidata)
                        print(registrationDetails)

                    }catch{
                        print("Prasing error")
                    }
                }else{
                    print("there is some problem")
                }

            }

            .resume()


    
        
        
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let afterRegistrationViewController: AfterRegistrationViewController = storyboard?.instantiateViewController(withIdentifier: "AfterRegistrationViewController")as! AfterRegistrationViewController
            self.navigationController?.pushViewController(afterRegistrationViewController, animated: true)
        
            
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
        
        @IBAction func loginButtonTapped(_ sender: UIButton) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController: LoginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")as! LoginViewController
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    




struct Registration: Decodable {
    var email: String
    var password: String
}
