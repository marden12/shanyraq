//
//  AuthService.swift
//  Shanyraq
//
//  Created by Dayana Marden on 05.05.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import ProgressHUD


struct AuthenticationService {
    
    var databaseRef: DatabaseReference! {
        return Database.database().reference()
    }
    
    var storageRef: StorageReference! {
        return Storage.storage().reference()
    }
    
    
    // 4 - We sign in the User
    func signIn(_ email: String, password: String, vs: UIViewController){
        if email == "" || password == "" {
            ProgressHUD.showError("Check your email or password,please")
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    ProgressHUD.showSuccess("You have successfully logged in")
                    (UIApplication.shared.delegate as? AppDelegate)?.loadMainPages()
                } else {
                    ProgressHUD.showError("Check your email or password,please")
                }
            }
        }
    }
    
    // 1 - We create firstly a New User
    func signUp(username:String, email: String, password: String,vc: UIViewController){
        if email == "" || password == "" {
            ProgressHUD.showError("Check your email or password,please")
        } else {
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    ProgressHUD.showSuccess("You have successfully logged in")
                    self.saveInfo(user, username: username, email: email,password:password)
                    (UIApplication.shared.delegate as? AppDelegate)?.loadMainPages()
                }else {
                    print("BADLY")
                    ProgressHUD.showError("Check your email,name or password,please")
                }
            })
        }
    }
    
    func resetPassword(_ email: String){
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            if error == nil {
                DispatchQueue.main.async(execute: {
                    print("error")
                })
            }else {
                print("error")
            }
        })
        
    }
    
    // 2 - We set the User Info
    //username:String,email: String,password:String
    func saveInfo(_ user:User!,username:String,email: String,password:String){
        let userRef = databaseRef.child("userData").child(user.uid)
        userRef.setValue(["username": username, "email" :  email,"userpassword" : password])
        //        let scoresRef = Database.database().reference(withPath: "userData")
        //        scoresRef.keepSynced(true)
        //        let userInfo = ["email": user.email!]
        //
        //        let userRef = databaseRef.child("userData").child(user.uid)
        //
        //        userRef.setValue(userInfo)
        
        
    }
    
    func logout(){
        ProgressHUD.show("Waiting", interaction: false)
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                ProgressHUD.showSuccess("You have successfully log out")
                print("LOGOUT SUCCESS")
                (UIApplication.shared.delegate as? AppDelegate)?.loadLoginPages()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    //    func updateUser(username:String,email: String,password:String){
    //        let user = ["username": username,
    //                    "email" : email,
    //                    "password" : password
    //        ]
    //        databaseRef.child(username).setValue(user)
    //        }
    
    
    //  func updateEmailAction(useremail: String) {
    //        let currentUser = Auth.auth().currentUser
    //        currentUser?.updateEmail(to: useremail) { error in
    //            if let error = error {
    //                print(error)
    //            } else {
    //                print("CHANGED")
    //                let uid = Auth.auth().currentUser!
    //                let thisUserRef = self.databaseRef.child("users")
    //                let thisUserEmailRef = thisUserRef.child("email")
    //                thisUserEmailRef.setValue(useremail)
    //            }
    //        }
    //    }
}
