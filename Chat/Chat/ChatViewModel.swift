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
    var inserting = false
    var limit = 20
    var newCount = 0
    
    private let repo: ChatRepository

    init(repo: ChatRepository) {
        self.repo = repo
    }
    
    func onAppear(contact: Contact){
        repo.fetchChat(limit: limit,contact: contact, lastMessage: self.messages.last) { message in
            
            if self.inserting || message.timestamp > self.messages.last?.timestamp ?? 0 {
                self.messages.insert(message, at: 0)
            } else {
                self.messages.append(message)
            }
            self.inserting = false
            self.newCount = self.messages.count
        }
    }
    
    
    func sendMessage(contact: Contact)  {
        let text = self.text.trimmingCharacters(in: .whitespacesAndNewlines)
        self.inserting = true
        newCount += newCount
        self.text = ""
        
        repo.sendMessage(text: text, contact: contact)
    }
}
