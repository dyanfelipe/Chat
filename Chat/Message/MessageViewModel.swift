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
    private var handleEnabled = true
    
    init(repo: MessageRepository) {
        self.repo = repo
    }
    
    func getContacts() {
        repo.getContacts { contacts in
            if self.handleEnabled {
                self.contacts = contacts
            }
        }
    }

    func handleEnabled(enabled: Bool)  {
        self.handleEnabled = enabled
    }
    
    func logout() {
        repo.logout()
    }
    
}
