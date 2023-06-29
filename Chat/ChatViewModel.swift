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
    
    
    func onAppear(toId: String){
        let fromId = Auth.auth().currentUser!.uid
        
        Firestore.firestore().collection("conversations")
            .document(fromId)
            .collection(toId)
            .order(by: "timestamp", descending: false)
            .addSnapshotListener{ querySnapshot, err in
                if let err = err {
                    print("Error: fetching documents \(err)")
                    return
                }
                
                if let changes = querySnapshot?.documentChanges {
                    for doc in changes {
                        let document = doc.document
                        print("Document is: \(document.documentID) \(document.data())")
                        
                        let message = Message(uuid: document.documentID, text: document.data()["text"] as! String, isMe: fromId == document.data()["fromId"] as! String)
                        
                        self.messages.append(message)
                    }
                }
            }
    }
    
    
    func sendMessage(toId: String)  {
        let fromId = Auth.auth().currentUser!.uid
        let timestamp = Date().timeIntervalSince1970
        
        Firestore.firestore().collection("conversations")
            .document(fromId)
            .collection(toId)
            .addDocument(data: [
                "text": text,
                "fromId": fromId,
                "toId": toId,
                "timestamp": UInt(timestamp)
            ]) { err in
                if err != nil {
                    print("ERROR: \(err!.localizedDescription)")
                    return
                }
            }
        
        Firestore.firestore().collection("conversations")
            .document(toId)
            .collection(fromId)
            .addDocument(data: [
                "text": text,
                "fromId": fromId,
                "toId": toId,
                "timestamp": UInt(timestamp)
            ]) { err in
                if err != nil {
                    print("ERROR: \(err!.localizedDescription)")
                    return
                }
            }
    }
}
