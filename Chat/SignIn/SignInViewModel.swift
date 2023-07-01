//
//  SignInViewModel.swift
//  Chat
//
//  Created by Dyan on 6/27/23.
//

import Foundation

class SignInViewModel: ObservableObject{
    @Published var email = String()
    @Published var password = String()
    @Published var alertText = String()
    @Published var isLoading = Bool()
    @Published var formInvalid = Bool()
    
    private let repo: SignInRepository
    
    init(repo: SignInRepository) {
        self.repo = repo
    }
    
    func signIn(){
        isLoading = true
        repo.signIn(withEmail: email, password: password) { err in
            if let err = err {
                self.formInvalid = true
                self.alertText = err
                self.isLoading = false
            }
            self.isLoading = false
        }
    }
}
