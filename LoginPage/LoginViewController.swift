//
//  ViewController.swift
//  LoginPage
//
//  Created by R82 on 27/12/22.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    
    var arrUser: [UserDetails] = []
    @IBOutlet weak var userNameOrPhoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var DontHaveAnAccountLabel: UILabel!
    @IBOutlet weak var registrationButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    
    @IBAction func loginButtonTapped(_ sender: Any) {
    
    
        if userNameOrPhoneNumberTextField.text == " " || passwordTextField.text == " "
        {
            displayAlert(message: "Enter userName and password")
        }
        else if userNameOrPhoneNumberTextField.text?.count ?? 0 < 5 || passwordTextField.text? .count ?? 0 < 6
        {
            displayAlert(message: "Enter Valid userName and Password")
        }
        
        if userNameOrPhoneNumberTextField.text == ""
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
        else if userNameOrPhoneNumberTextField.text?.count ?? 0 < 5
        {
            
            displayAlert(message: "Enter userName")
        }
        

            var parameters: Parameters = [ "name": userNameOrPhoneNumberTextField.text ?? "","job": passwordTextField.text ?? ""]
            AF.request("https://reqres.in/api/login", method: .post, parameters: parameters).responseData { response in
                debugPrint("response \(response)")
                if response.response?.statusCode == 201{
                    guard let apidata = response.data else{return}
                    do{
                        let loginDetails = try JSONDecoder().decode(LoginDetails.self, from: apidata)
                        print(loginDetails)

                    }catch{
                        print("Prasing error")
                    }
                }else{
                    print("there is some problem")
                }

            }

            .resume()

            
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let afterLoginViewController: AfterLoginViewController = storyBoard.instantiateViewController(withIdentifier: "AfterLoginViewController")as! AfterLoginViewController
            navigationController?.pushViewController(afterLoginViewController, animated: true)

        }
        

    
        
        

    struct LoginDetails: Decodable{
       
        var name: String
        var job: String
        var id: String
        var createdAt: String
    }
    
    
    struct LoginApiToken: Decodable{
        var token: String
    }

        
    
   
    
    
    
    
    @IBAction func registrationButtonTapped(_ sender: UIButton) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
     let registractionViewController: RegistractionViewController = storyBoard.instantiateViewController(withIdentifier: "RegistractionViewController")as! RegistractionViewController
        navigationController?.pushViewController(registractionViewController, animated: true)
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.layer.masksToBounds = true
    }
    @IBAction func forgetPasswordButtonTapped(_ sender: UIButton) {
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
     let forgotPasswordViewController: ForgotPasswordViewController = storyBoard.instantiateViewController(withIdentifier: "ForgotPasswordViewController")as! ForgotPasswordViewController
        navigationController?.pushViewController(forgotPasswordViewController, animated: true)
    
    }
    
}
extension LoginViewController: UITextViewDelegate
{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        switch textField.tag
        {
        case 0: return true
        case 1: return true
        default: return true
                    
    }
        switch textField.tag {
        case 1: return false
        default: return true
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(textField.tag)
    }
    
    func textFieldShouldEditing(_ textField: UITextField) -> Bool {
        return true
    }
        
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField.tag == 0 {
            passwordTextField.becomeFirstResponder()
        }
        print(textField.text ?? "")
    }
    
}

struct UserDetails: Decodable {

    var id: Int
    var email: String
    var firstName: String
    var lastName: String
    var avatar: String

}


