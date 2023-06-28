//
//  MessagesView.swift
//  Chat
//
//  Created by Dyan on 6/27/23.
//

import SwiftUI

struct MessagesView: View {
    @StateObject var viewModel = MessagesViewModel()
    var body: some View {
        NavigationView {
            VStack{
                Text("Logout")
            }
            .toolbar {
                ToolbarItem(id: "contacts", placement: ToolbarItemPlacement.navigationBarTrailing, showsByDefault: true) {
                    NavigationLink("Contacts", destination: ContactsView())
                }
                
                ToolbarItem(id: "logout", placement: ToolbarItemPlacement.navigationBarTrailing, showsByDefault: true) {
                    Button("Logout") {
                        viewModel.logout()
                    }
                    
                }
            }
        }
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
