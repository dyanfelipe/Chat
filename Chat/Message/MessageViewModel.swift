//
//  MessagesViewModel.swift
//  Chat
//
//  Created by Dyan on 6/27/23.
//

import Foundation

class MessageViewModel: ObservableObject {
    @Published var isLoading = Bool()
    @Published var contacts: [Contact] = []
    private let repo: MessageRepository
    
    init(repo: MessageRepository) {
        self.repo = repo
    }
    
    func getContacts() {
        repo.getContacts { contacts in
            self.contacts.removeAll()
            self.contacts = contacts
        }
    }

    func logout() {
        repo.logout()
    }
    
}
