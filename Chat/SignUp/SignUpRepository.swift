//
//  SignUpRepository.swift
//  Chat
//
//  Created by Dyan on 6/30/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class SignUpRepository {
    
    func signUp(withEmail email: String, password: String, image: UIImage, name: String,completion: @escaping (String?)-> Void){
        Auth.auth().createUser(withEmail: email, password: password){ result, err in
            guard let _ = result?.user, err == nil else {
                completion(err!.localizedDescription)
                return
            }
            self.uploadPhoto(image: image, name: name){ err in
                if let err = err {
                    completion(err)
                }
            }
        }
    }
    
    private func uploadPhoto(image: UIImage, name: String, completion: @escaping (String?) -> Void) {
        let filename = UUID().uuidString
        
        guard let data = image.jpegData(compressionQuality: 0.2) else { return }
        
        let newMetadata = StorageMetadata()
        newMetadata.contentType = "image/jpeg"
        
        let ref = Storage.storage().reference(withPath: "/images/\(filename).jpg")
        
        ref.putData(data, metadata: newMetadata) { metadata, err in
            ref.downloadURL(completion: { url, err in
                guard let url = url else { return }
                self.createdUser(photoUrl: url, name: name, completion: completion)
            })
        }
    }
    
    private func createdUser(photoUrl: URL, name: String, completion: @escaping (String?) -> Void){
        let id = Auth.auth().currentUser!.uid
        Firestore.firestore().collection("users")
            .document(id)
            .setData([
                "name" : name,
                "uuid": Auth.auth().currentUser!.uid,
                "profileUrl": photoUrl.absoluteString
            ]) { err in
                if let err = err {
                    completion(err.localizedDescription)
                }
            }
    }
}
