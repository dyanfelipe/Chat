//
//  SignUpViewModel.swift
//  Chat
//
//  Created by Dyan on 6/27/23.
//

import SwiftUI

class SignUpViewModel: ObservableObject{
    @Published var email = String()
    @Published var name = String()
    @Published var password = String()
    @Published var image = UIImage()
    @Published var formInvalid: Bool = false
    @Published var isLoading: Bool = false
    var alertText = String()

    private let repo: SignUpRepository
    
    init(repo: SignUpRepository) {
        self.repo = repo
    }
    
    func signUp(){
        if image.size.width <= 0 {
            formInvalid = true
            alertText = "Selecione uma foto."
            return
        }
        isLoading = true
        repo.signUp(withEmail: email, password: password, image: image, name: name) { err in
            if let err = err {
                self.formInvalid = true
                self.alertText = err
            }
            self.isLoading = false
        }
    }
}
