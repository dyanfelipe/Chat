//
//  SignInRepository.swift
//  Chat
//
//  Created by Dyan on 6/30/23.
//

import Foundation
import FirebaseAuth

class SignInRepository {
    func signIn(withEmail email: String, password: String, completion: @escaping (String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password){ result, err in
            guard let _ = result?.user, err == nil else {
                completion(err!.localizedDescription)
                return
            }
            completion(nil)
        }
    }
}
