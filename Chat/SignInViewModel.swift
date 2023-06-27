//
//  SignInViewModel.swift
//  Chat
//
//  Created by Dyan on 6/27/23.
//

import Foundation
import FirebaseAuth

class SignInViewModel: ObservableObject{
    @Published var email = String()
    @Published var password = String()
    @Published var alertText = String()
    
    @Published var isLoading = Bool()
    @Published var formInvalid = Bool()

    
    func signIn(){
        isLoading = true
        print("email: \(email), password: \(password)")
        Auth.auth().signIn(withEmail: email, password: password){ result, err in
            guard let user = result?.user, err == nil else {
                self.formInvalid = true
                self.alertText = err!.localizedDescription
                self.isLoading = false
                return
            }
            self.isLoading = false
            print("user created: \(user.metadata)")
        }
    }
}
