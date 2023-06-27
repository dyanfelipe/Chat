//
//  SignUpViewModel.swift
//  Chat
//
//  Created by Dyan on 6/27/23.
//

import Foundation
import FirebaseAuth

class SignUpViewModel: ObservableObject{
    var email = String()
    var name = String()
    var password = String()
    
    @Published var formInvalid: Bool = false
    @Published var isLoading: Bool = false
    var alertText = String()
    
    func signUp(){
        isLoading = true
        print("email: \(email), name: \(name) password: \(password)")
        Auth.auth().createUser(withEmail: email, password: password){ result, err in
            guard let user = result?.user, err == nil else {
                self.formInvalid = true
                self.alertText = err!.localizedDescription
                self.isLoading = false
                return
            }
            self.isLoading = false
            print("user created: \(user.uid)")
        }
    }
}
