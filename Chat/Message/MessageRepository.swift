//
//  MessageRepository.swift
//  Chat
//
//  Created by Dyan on 6/30/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class MessageRepository {
    
    func getContacts(completion: @escaping ([Contact]) -> Void) {
        let fromId = Auth.auth().currentUser!.uid
        var contacts: [Contact] = []
        
        Firestore.firestore().collection("last-messages")
            .document(fromId)
            .collection("contacts")
            .addSnapshotListener { snapshot, error in
                if let changes = snapshot?.documentChanges {
                    for doc in changes {
                        if doc.type == .added {
                            let document = doc.document
                            contacts.append(Contact(uuid: document.documentID,
                                                         name: document.data()["username"] as! String,
                                                         profileUrl:  document.data()["photoUrl"] as! String,
                                                         lastMessage:  document.data()["lastMessage"] as! String,
                                                         timestamp:  document.data()["timestamp"] as! UInt
                                                        ))
                            
                        }
                    }
                }
                completion(contacts)
            }
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
}
