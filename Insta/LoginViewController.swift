//
//  LoginViewController.swift
//  Insta
//
//  Created by jsood on 5/25/18.
//  Copyright © 2018 Jigyasaa Sood. All rights reserved.
//

import UIKit
import Parse
import Pastel

class LoginViewController: UIViewController {

    
    @IBOutlet weak var instaLogoImageView: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pastelView = PastelView(frame: view.bounds)
        
        // Custom Direction
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        
        
        
        // Custom Duration
        pastelView.animationDuration = 3.0
        
        // Custom Color
        pastelView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
                              UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
                              UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
                              UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)])
        
        pastelView.startAnimation()
        view.insertSubview(pastelView, at: 0)
        //titleView.setGradientBackground(colorOne: UIColor.purple , colorTwo: UIColor.black)
        //gifView.loadGif(name: "instagram-gradient-3")

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTapSignUp(_ sender: Any) {
        // initialize a user object
        let newUser = PFUser()
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // set user properties
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                appDelegate.registerUser()
                // manually segue to logged in view
            }
        }
        
    }
    
    @IBAction func onTapLogin(_ sender: Any) {
            let username = usernameField.text ?? ""
            let password = passwordField.text ?? ""
        
        if(usernameField.text?.isEmpty == true || passwordField.text?.isEmpty == true || (usernameField.text?.isEmpty == true && passwordField.text?.isEmpty == true)){
            print("incorrect login credentials, try again")
            let alertController = UIAlertController(title: "Empty Field(s)", message: "Please enter your username and password" , preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {(action) in}
            alertController.addAction(cancelAction)
            let OKAction = UIAlertAction(title: "OK", style: .default){ (action) in }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true)
        }
        else{
            PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
                if let error = error {
                    print("User log in failed: \(error.localizedDescription)")
                    print("incorrect login credentials, try again")
                    let alertController = UIAlertController(title: "Incorrect Login", message: "Please enter your correct username and password" , preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {(action) in}
                    alertController.addAction(cancelAction)
                    let OKAction = UIAlertAction(title: "OK", style: .default){ (action) in }
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true)
                    //self.dismiss(animated: true, completion: nil)
                    
                } else{
                    print("User logged in successfully")
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                    // display view controller that needs to shown after successful login
                }
            }
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
