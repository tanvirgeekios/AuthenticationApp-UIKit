//
//  LoginTableViewController.swift
//  AuthenticationApp
//
//  Created by MD Tanvir Alam on 27/4/21.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class LoginTableViewController: UITableViewController, LoginButtonDelegate, GIDSignInDelegate {
    
    @IBOutlet weak var btnFacebook: FBLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        facebookLogin()
        googleLogin()
        
    }
    //MARK:- Functions
    func facebookLogin(){
        if let token = AccessToken.current,
                !token.isExpired {
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: token, version: nil, httpMethod: .get)
            request.start { (connection, result, error) in
                print("\(result ?? "No Result")")
            }
        }else{
            btnFacebook.permissions = ["public_profile", "email"]
            btnFacebook.delegate = self
        }
    }
    
    func googleLogin(){
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        
        if ((GIDSignIn.sharedInstance()?.hasPreviousSignIn()) != nil){
            GIDSignIn.sharedInstance()?.restorePreviousSignIn()
            print("already login")
        }
    }
    
    //MARK:- FacebookDelegate
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: token, version: nil, httpMethod: .get)
        request.start { (connection, result, error) in
            print("\(result ?? "No Result")")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logout")
    }
    //MARK:- GoogleLoginDelegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("\(user.profile.email ?? "No email")")
    }
    
    //MARK:- TableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height
    }
    //MARK:- Actions
    @IBAction func googleBTNTapped(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signIn()
    }
}
