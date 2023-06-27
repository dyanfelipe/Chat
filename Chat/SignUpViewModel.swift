//
//  SignUpViewModel.swift
//  Chat
//
//  Created by Dyan on 6/27/23.
//

import Foundation
import FirebaseAuth
import SwiftUI
import FirebaseStorage

class SignUpViewModel: ObservableObject{
    var email = String()
    var name = String()
    var password = String()
    
    @Published var image = UIImage()
    @Published var formInvalid: Bool = false
    @Published var isLoading: Bool = false
    var alertText = String()
    
    func signUp(){
        
        print("email: \(email), name: \(name) password: \(password)")
        
        if image.size.width <= 0 {
            formInvalid = true
            alertText = "Selecione uma foto."
            return
        }
        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password){ result, err in
            guard let user = result?.user, err == nil else {
                self.formInvalid = true
                self.alertText = err!.localizedDescription
                self.isLoading = false
                return
            }
            self.isLoading = false
            print("user created: \(user.uid)")
            
            self.uploadPhoto()
        }
    }
    
    private func uploadPhoto() {
        let filename = UUID().uuidString
        
        guard let data = image.jpegData(compressionQuality: 0.2) else { return }
        
        let newMetadata = StorageMetadata()
        newMetadata.contentType = "image/jpeg"
        
        let ref = Storage.storage().reference(withPath: "/images/\(filename).jpg")
        
        ref.putData(data, metadata: newMetadata) { metadata, err in
            ref.downloadURL(completion: { url, err in
                self.isLoading = false
            })
        }
    }
}
