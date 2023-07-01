//
//  ChatRepository.swift
//  Chat
//
//  Created by Dyan on 6/30/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ChatRepository {
    
    var myName = String()
    var myPhoto = String()
    var newCount = 0
    
    func fetchChat(limit: Int, contact: Contact, lastMessage: Message?, completion: @escaping (Message) -> Void) {
        let fromId = Auth.auth().currentUser!.uid
        
        Firestore.firestore().collection("users")
            .document(fromId)
            .getDocument { snapshot, err in
                if let err = err {
                    print("Error: fetching documents \(err)")
                    return
                }
                
                if let document = snapshot?.data() {
                    self.myName = document["name"] as! String
                    self.myPhoto = document["profileUrl"] as! String
                }
            }
        
        Firestore.firestore().collection("conversations")
            .document(fromId)
            .collection(contact.uuid)
            .order(by: "timestamp", descending: true)
            .start(after: [lastMessage?.timestamp ?? 999999999999999])
            .limit(to: limit)
            .addSnapshotListener { querySnapshot, err in
                if let err = err {
                    print("Error: fetching documents \(err)")
                    return
                }
                
                if let changes = querySnapshot?.documentChanges {
                    for doc in changes {
                        if  doc.type == .added {
                            let document = doc.document
                            print("Document is: \(document.documentID) \(document.data())")
                            
                            let message = Message(uuid: document.documentID,
                                                  text: document.data()["text"] as! String,
                                                  isMe: fromId == document.data()["fromId"] as! String,
                                                  timestamp: document.data()["timestamp"] as! UInt
                            )
                            completion(message)
                        }
                    }
                }
            }
    }
    
    
    func sendMessage(text: String,contact: Contact)  {
        let fromId = Auth.auth().currentUser!.uid
        let timestamp = Date().timeIntervalSince1970
        
        Firestore.firestore().collection("conversations")
            .document(fromId)
            .collection(contact.uuid)
            .addDocument(data: [
                "text": text,
                "fromId": fromId,
                "toId": contact.uuid,
                "timestamp": UInt(timestamp)
            ]) { err in
                if err != nil {
                    print("ERROR: \(err!.localizedDescription)")
                    return
                }
                
                Firestore.firestore().collection("last-messages")
                    .document(fromId)
                    .collection("contacts")
                    .document(contact.uuid)
                    .setData([
                        "uid": contact.uuid,
                        "username": contact.name,
                        "photoUrl": contact.profileUrl,
                        "timestamp": UInt(timestamp),
                        "lastMessage": text
                    ])
            }
        
        Firestore.firestore().collection("conversations")
            .document(contact.uuid)
            .collection(fromId)
            .addDocument(data: [
                "text": text,
                "fromId": fromId,
                "toId": contact.uuid,
                "timestamp": UInt(timestamp)
            ]) { err in
                if err != nil {
                    print("ERROR: \(err!.localizedDescription)")
                    return
                }
                
                Firestore.firestore().collection("last-messages")
                    .document(fromId)
                    .collection("contacts")
                    .document(contact.uuid)
                    .setData([
                        "uid": contact.uuid,
                        "username": self.myName,
                        "photoUrl": self.myPhoto,
                        "timestamp": UInt(timestamp),
                        "lastMessage": text
                    ])
            }
    }
    
}
