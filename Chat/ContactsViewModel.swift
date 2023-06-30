//
//  ContactsViewModel.swift
//  Chat
//
//  Created by Dyan on 6/27/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ContactsViewModel: ObservableObject {
    @Published var contacts: [Contact] = []
    @Published var isLoading = false
     var isLoaded = false
    func getContacts() {
        if isLoaded { return }
        isLoading = true
        Firestore.firestore().collection("users")
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("error list users \(error)")
                    self.isLoading = false
                    return
                }
                
                for document in querySnapshot!.documents{
                    print("ID \(document.documentID) \(document.data())")
                    if Auth.auth().currentUser?.uid != document.documentID {                    
                        self.contacts.append(Contact(uuid: document.documentID, name: document.data()["name"] as! String, profileUrl: document.data()["profileUrl"] as! String))
                    }
                }
                self.isLoaded = true
                self.isLoading = false
            }
    }
}
