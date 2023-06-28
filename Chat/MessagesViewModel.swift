//
//  MessagesViewModel.swift
//  Chat
//
//  Created by Dyan on 6/27/23.
//

import Foundation
import FirebaseAuth

class MessagesViewModel: ObservableObject {
    
    func logout() {
        try? Auth.auth().signOut()
    }
    
}
