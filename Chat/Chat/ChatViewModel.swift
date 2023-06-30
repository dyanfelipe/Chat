//
//  ChatViewModel.swift
//  Chat
//
//  Created by Dyan on 6/28/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ChatViewModel: ObservableObject {
    
    @Published var messages: [Message] = []
    
    @Published var text = String()
    
    var myName = String()
    var myPhoto = String()
    var limit = 20
    var inserting = false
    var newCount = 0
    
    func onAppear(contact: Contact){
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
            .start(after: [self.messages.last?.timestamp ?? 999999999999999])
            .limit(to: limit)
            .addSnapshotListener{ querySnapshot, err in
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
                            if self.inserting{
                                self.messages.insert(message, at: 0)
                            } else {
                                self.messages.append(message)
                            }
                        }
                    }
                    self.inserting = false
                }
                self.newCount = self.messages.count
            }
    }
    
    
    func sendMessage(contact: Contact)  {
        let text = self.text.trimmingCharacters(in: .whitespacesAndNewlines)
        inserting = true
        newCount += newCount
        self.text = ""
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
                        "lastMessage": self.text
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
                        "lastMessage": self.text
                    ])
            }
    }
}
