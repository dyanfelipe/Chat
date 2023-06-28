//
//  ContactsViewModel.swift
//  Chat
//
//  Created by Dyan on 6/27/23.
//

import Foundation
import FirebaseFirestore

class ContactsViewModel: ObservableObject {
    @Published var contacts: [Contact] = []
    
    func getContacts() {
        Firestore.firestore().collection("users")
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("error list users \(error)")
                    return
                }
                
                for document in querySnapshot!.documents{
                    print("ID \(document.documentID) \(document.data())")
                    self.contacts.append(Contact(uuid: document.documentID, name: document.data()["name"] as! String, profileUrl: document.data()["profileUrl"] as! String))
                }
            }
    }
}
