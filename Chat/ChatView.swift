//
//  ChatView.swift
//  Chat
//
//  Created by Dyan on 6/28/23.
//

import SwiftUI

struct ChatView: View {
    let contact: Contact
    @StateObject var viewModel = ChatViewModel()
    
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.messages, id: \.self){ message in
                    MessageRow(message: message)
                }
            }
            
            Spacer()
            
            HStack {
                TextField("Enter a mensagem", text: $viewModel.text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(24)
                    .overlay (
                        RoundedRectangle(cornerRadius: 24)
                            .strokeBorder(Color(UIColor.separator), style: StrokeStyle(lineWidth: 1))
                    )
                Button {
                    viewModel.sendMessage(contact: contact)
                } label: {
                    Text("Send")
                        .padding()
                        .background(Color("GreenColor"))
                        .foregroundColor(Color.white)
                        .cornerRadius(24)
                }
                .disabled(viewModel.text.isEmpty)
            }
            .padding(.vertical, 10)
            .padding(.vertical, 16)
        }
        .navigationTitle(contact.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            viewModel.onAppear(contact: contact)
        }
    }
}

struct MessageRow: View {
    let message: Message
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(message.text)
                .padding(.vertical, 5)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 10)
                .background(Color(white: 0.95))
                .frame(maxWidth: 260, alignment: message.isMe ? .leading : .trailing)
        }
        .frame(maxWidth: .infinity, alignment: message.isMe ? .leading : .trailing)
    }
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatView(contact: Contact(uuid: UUID().uuidString, name: "Chat VIEW", profileUrl: ""))
        }
        
    }
}
