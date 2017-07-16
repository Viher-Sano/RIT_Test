//
//  LoginViewController.swift
//  RIT_Test
//
//  Created by Alexander Ruduk on 13.07.17.
//  Copyright © 2017 Alexander Ruduk. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKCoreKit
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var loginButtonFB: UIButton!
    @IBOutlet weak var loginViewFB: UIView!
    @IBOutlet weak var loginButtonGoogle: UIButton!
    @IBOutlet weak var loginViewGoogle: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButtonFB.addTarget(self, action: #selector(self.loginButtonFBCliced), for: .touchUpInside)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(googleLoginSuccess), name: Constant.googleLoginNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Constant.googleLoginNotification, object: nil);
    }
    
    func presentTabViewControler() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarVC = sb.instantiateViewController(withIdentifier: "MainTabBarVC") as? UITabBarController {
            let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = tabBarVC
        }
    }
    
    //MARK: - Action
    
    func loginButtonFBCliced() {
        let loginManager = LoginManager()
        loginManager.logIn([.publicProfile], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(grantedPermissions: _, declinedPermissions: _, token: _):
                print("Login success!...")
                self.loginButtonFB.isEnabled = false
                self.loginViewFB.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                if (GIDSignIn.sharedInstance().hasAuthInKeychain()) {
                    self.presentTabViewControler()
                }
            }
        }
    }
    
    @IBAction func loginButtonGoogleAction(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    //MARK: - Notification
    
    func googleLoginSuccess() {
        print("GoogleLoginSuccessNotification")
        
        loginButtonGoogle.isEnabled = false
        loginViewGoogle.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        if(FBSDKAccessToken.current() != nil){
            self.presentTabViewControler()
        }
    }
}

