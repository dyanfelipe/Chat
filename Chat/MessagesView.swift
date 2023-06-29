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
                if viewModel.isLoading {
                    ProgressView()
                }
                
                List(viewModel.contacts, id: \.self){ contact in
                    NavigationLink {
                        ChatView(contact: contact)
                    } label: {
                        ContactMessageRow(contact: contact)
                    }
                }
            }
            .onAppear{
                viewModel.getContacts()
            }
            .navigationTitle("Messagens")
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

struct ContactMessageRow: View{
    var contact: Contact
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: contact.profileUrl)) { image in
                image.resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                Text(contact.name)
                if let msg = contact.lastMessage {
                    Text(msg)
                }
            }
            Spacer()
            
        }
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
