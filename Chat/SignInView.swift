//
//  ContentView.swift
//  Chat
//
//  Created by Dyan on 6/26/23.
//

import SwiftUI

struct SignInView: View {
    @StateObject var viewModel = SignInViewModel()
    var body: some View {
        VStack {
            Image("chat_logo")
                .resizable()
                .scaledToFit()
                .padding()
            
            TextField("Enter your email", text: $viewModel.email)
                .padding()
                .border(Color(UIColor.separator))
            SecureField("Enter your email", text: $viewModel.password)
                .padding()
                .border(Color(UIColor.separator))
            
            Button {
                viewModel.signIn()
            } label: {
                Text("Enter")
            }
            
            Divider()
            
            Button {
                
            } label: {
                Text("I don't have an account? click here")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
