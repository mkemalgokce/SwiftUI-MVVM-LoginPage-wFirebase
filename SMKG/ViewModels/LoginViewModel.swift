//
//  LoginViewModel.swift
//  LoginPage
//
//  Created by Mustafa Kemal Gökçe on 30.07.2021.
//

import Foundation
import FirebaseAuth
import SwiftUI
final class LoginViewModel: ObservableObject {
    
    let auth = Auth.auth()
    @Published var signedIn = false
    @Published var isAlert = false
    @Published var alertMsg: String = ""
    @Published var isLoading = false
    
    @AppStorage("loginStatus") var status = false
    func createUser(mail: String, pass: String, verificationPass: String){
        
        if mail == "" || pass == "" {
            alertMsg = "Please fill the contents properly!"
            isAlert.toggle()
            return
        }
        if pass != verificationPass{
            self.alertMsg = "Passwords are not same!"
            self.isAlert.toggle()
            return
        }

            self.isLoading.toggle()

        self.auth.createUser(withEmail: mail, password: pass) { result, err in

                self.isLoading.toggle()

            guard result != nil, err == nil else {
                self.alertMsg = err?.localizedDescription ?? "Error"
                self.isAlert.toggle()
                return
            }
            result?.user.sendEmailVerification { err in
                if err != nil{
                    self.alertMsg = err?.localizedDescription ?? "Error"
                    self.isAlert.toggle()
                    return
                }
                self.alertMsg = "Email verification has been sent."
                self.isAlert.toggle()
            }
            
        }
    }
    func signIn(mail: String, pass: String){
        

            self.isLoading.toggle()

        self.auth.signIn(withEmail: mail, password: pass) { result, err in

                self.isLoading.toggle()
            guard result != nil, err == nil else{
                self.alertMsg = err?.localizedDescription ?? "Error"
                self.isAlert.toggle()
                return
            }
            let user = Auth.auth().currentUser
            if !user!.isEmailVerified {
                self.alertMsg = "Please verify your mail adress !"
                self.isAlert.toggle()
                try! Auth.auth().signOut()
                return
            }

                self.status = true

        }
    }
    func resetPassword(mail: String){

            self.isLoading.toggle()

        self.auth.sendPasswordReset(withEmail: mail) { err in

                self.isLoading.toggle()

            if err != nil{
                self.alertMsg = err?.localizedDescription ?? "Error"
                self.isAlert.toggle()
                return
            }else{
                self.alertMsg = "Password reset link has been sent!"
                self.isAlert.toggle()
            }
            
        }
    }
    func logOut(){
        try! self.auth.signOut()

            self.status = false

    }
}
