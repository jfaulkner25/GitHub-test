//
//  PMSViewController.swift
//  Pirelli
//
//  Created by James Faulkner on 11/01/2018.
//  Copyright © 2018 The Hungry Gorilla. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI

class PMSViewController: UIViewController, FUIAuthDelegate {

    // MARK: - UI Elements
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        if self.usernameField.text == "" || self.passwordField.text == "" {
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            FIRAuth.auth()?.signIn(withEmail: self.usernameField.text!, password: self.passwordField.text!) { (user, error) in
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    //Go to the HomeViewController if the login is sucessful
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func registerButton(_ sender: Any) {
        if usernameField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        } else {
            FIRAuth.auth()?.createUser(withEmail: usernameField.text!, password: passwordField.text!, completion: { (user, error) in
                
                if error == nil {
                    print("You have succesfully signed up")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    self.present(vc!, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        }
    }
    
    
    // MARK: - Firebase
    let ref = FIRDatabase.database().reference(withPath: "pirelli-users")
    
    func setupFirebase() {
        let authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        return
    }
    
    
    // MARK: - Runtime
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        setupFirebase()
    }
    
    // MARK: - Navigation
    func configureNavigationBar() {
        navigationBar.setValue(true, forKey: "hidesShadow") // Hides the line shadow
        let shadow = hexStringToUIColor(hex: "000000")
        navigationBar.layer.shadowColor = shadow.cgColor
        navigationBar.layer.shadowOpacity = 0.25
        navigationBar.layer.shadowRadius = 2
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        navigationBar.topItem?.title = "LOGIN"
        navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Gotham Book", size: 15)!]
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Color
    let backgroundColor = "#1E1F24"
    let pirelliYellow = "rgba(254, 209, 0, 1)"
    let pirelliClear = "rgba(254, 209, 0, 0)"
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    


}
