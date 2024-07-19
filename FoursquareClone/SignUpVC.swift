//
//  ViewController.swift
//  FoursquareClone
//
//  Created by Sabri Çetin on 15.06.2024.
//

import UIKit
import Parse


class SignUpVC: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
       
        
    }
    
    //Kullanıcı Giriş Fonksiyonu

    @IBAction func signİnClicked(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != "" {
            
            PFUser.logInWithUsername(inBackground: usernameText.text!, password: passwordText.text!) { user, error in
                if  error != nil {
                    self.makeAlert(titleİnput: "ERROR", massageİnput: error?.localizedDescription ?? "Error")
                    
                } else {
                    // Segue
                  
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
        }
            
        
        else {
            makeAlert(titleİnput: "ERROR", massageİnput: "Username / Password ??? ") }
        
    }
    
    //Kullanıcı Kayıt Fonksiyonu

    @IBAction func signUpClicked(_ sender: Any) {
        
        
        if usernameText.text != "" && passwordText.text != "" {

            let user = PFUser()
            user.username = usernameText.text!
            user.password = passwordText.text!
            
            user.signUpInBackground { (success, error) in
                if error != nil {
                    self.makeAlert(titleİnput: "Error", massageİnput: error?.localizedDescription ?? "Error !!!")
                }
                else {
                    //Segue
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                 }
            }
        } else {
            makeAlert(titleİnput: "Error", massageİnput: "Username / Password ??? ")
        }
    }
    
    //Uyarı Mesaj Fonksiyonu
    
    func makeAlert(titleİnput: String , massageİnput:String) {
        let alert = UIAlertController(title: titleİnput, message: massageİnput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
   






