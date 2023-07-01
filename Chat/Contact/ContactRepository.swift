//
//  ContactRepository.swift
//  Chat
//
//  Created by Dyan on 6/30/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ContactRepository {
    func getContacts(completion: @escaping ([Contact]) -> Void) {
        var contacts:[Contact] = []
        Firestore.firestore().collection("users")
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("error list users \(error)")
                    return
                }
                
                for document in querySnapshot!.documents {
                    if Auth.auth().currentUser?.uid != document.documentID {
                        contacts.append(Contact(uuid: document.documentID,
                                                name: document.data()["name"] as! String,
                                                profileUrl: document.data()["profileUrl"] as! String))
                    }
                }
                completion(contacts)
            }
    }
}
