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
    var limit = 20
    var newCount = 0
    
    private let repo: ChatRepository

    init(repo: ChatRepository) {
        self.repo = repo
    }
    
    func onAppear(contact: Contact){
        repo.fetchChat(limit: limit,contact: contact, lastMessage: self.messages.last) { messages, newCount in
            self.messages.append(contentsOf: messages)
            self.newCount = newCount
        }
    }
    
    
    func sendMessage(contact: Contact)  {
        let text = self.text.trimmingCharacters(in: .whitespacesAndNewlines)
        newCount += newCount
        self.text = ""
        
        repo.sendMessage(inserting: true,text: text, contact: contact)
    }
}
