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
    
    @State var textSize: CGSize = .zero
    
    @Namespace var bottomID
    
    var body: some View {
        VStack{
            ScrollViewReader { value in
                ScrollView(showsIndicators: false) {
                    Color.clear.frame(height: 0).id(bottomID)
                    LazyVStack {
                        ForEach(viewModel.messages, id: \.self) { message in
                            MessageRow(message: message)
                                .scaleEffect(x: 1, y:-1, anchor: .center)
                                .onAppear {
                                    if message == viewModel.messages.last && viewModel.messages.count >= viewModel.limit {
                                        viewModel.onAppear(contact: contact)
                                        print("LazyVStack -> \(message)")
                                    }
                                }
                        }
                        .onChange(of: viewModel.newCount) { newValue in
                            print("count is \(newValue)")
                            if newValue > viewModel.messages.count {
                                withAnimation {
                                    value.scrollTo(bottomID)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    
                }
                .gesture(DragGesture().onChanged({_ in
                    UIApplication.shared.endEditing()
                }))
                .rotationEffect(Angle(degrees: 180))
                .scaleEffect(x: -1, y: 1, anchor: .center)
            }
            
            Spacer()
            
            HStack {
                ZStack {
                    TextEditor(text: $viewModel.text)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(24)
                        .overlay (
                            RoundedRectangle(cornerRadius: 24)
                                .strokeBorder(Color(UIColor.separator), style: StrokeStyle(lineWidth: 1))
                        )
                        .frame(maxHeight: (textSize.height + 38) > 100 ? 100 : textSize.height + 38)
                    
                    Text(viewModel.text)
                        .opacity(0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(ViewGeometry())
                        .lineLimit(4)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 21)
                        .onPreferenceChange(ViewSizeKey.self) { size in
                            print("textSize is \(size)")
                            textSize = size
                        }
                    
                }
                
                Button {
                    viewModel.sendMessage(contact: contact)
                } label: {
                    Text("Send")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Color("GreenColor"))
                        .foregroundColor(Color.white)
                        .cornerRadius(24)
                }
                .disabled(viewModel.text.isEmpty)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
        }
        .navigationTitle(contact.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            viewModel.onAppear(contact: contact)
        }
    }
}

struct ViewGeometry: View {
    var body: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: ViewSizeKey.self, value: geometry.size)
        }
    }
}

struct ViewSizeKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        print("new value is \(value)")
        value = nextValue()
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
                .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(message.isMe ? Color(white: 0.95) : Color("GreenLightColor"))
                )
                .frame(maxWidth: 260, alignment: message.isMe ?  .trailing : .leading )
        }
        .padding(.horizontal, 2)
        .frame(maxWidth: .infinity, alignment: message.isMe ? .trailing : .leading)
    }
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatView(contact: Contact(uuid: UUID().uuidString, name: "Chat VIEW", profileUrl: ""))
        }
        
    }
}
