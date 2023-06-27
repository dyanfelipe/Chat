//
//  SignUpViewModel.swift
//  Chat
//
//  Created by Dyan on 6/27/23.
//

import Foundation

class SignUpViewModel: ObservableObject{
    var email = String()
    var name = String()
    var password = String()
    
    func signUp(){
        print("email: \(email), name: \(name) password: \(password)")
    }
}
