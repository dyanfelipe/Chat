//
//  SignInViewModel.swift
//  Chat
//
//  Created by Dyan on 6/27/23.
//

import Foundation
class SignInViewModel: ObservableObject{
    var email = String()
    var password = String()
    
    func signIn(){
        print("email: \(email) password: \(password)")
    }
}
