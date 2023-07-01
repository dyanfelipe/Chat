//
//  ContactsViewModel.swift
//  Chat
//
//  Created by Dyan on 6/27/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ContactViewModel: ObservableObject {
    @Published var contacts: [Contact] = []
    @Published var isLoading = false
     var isLoaded = false
    
    private let repo: ContactRepository
    
    init(repo: ContactRepository) {
        self.repo = repo
    }
    
    func getContacts() {
        if isLoaded { return }
        isLoading = true
        
        repo.getContacts { contacts in
            self.contacts.append(contentsOf: contacts)
            self.isLoading = false
        }
    }
}
