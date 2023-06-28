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
        NavigationView {
            VStack {
                Image("chat_logo")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                TextField("Enter your email", text: $viewModel.email)
                    .textFieldWhiteSeparator()
                    .padding(.bottom)
                SecureField("password", text: $viewModel.password)
                    .textFieldWhiteSeparator()
                    .padding(.bottom, 8)
                   
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }
                
                Button {
                    viewModel.signIn()
                } label: {
                    Text("Enter")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("GreenColor"))
                        .foregroundColor(.white)
                        .cornerRadius(16)
                }
                .alert(isPresented: $viewModel.formInvalid) {
                    Alert(title: Text(viewModel.alertText))
                }
                
                Divider()
                    .padding()
                
                NavigationLink(destination: SignUpView()) {
                    Text("I don't have an account? click here")
                        .foregroundColor(.black)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 32)
            .background(Color.init(red: 240 / 255, green: 231 / 255, blue: 210 / 255))
            .navigationTitle("SignIn")
            .navigationBarHidden(true)
        }
    }
}

struct TextFieldWhiteSeparator: ViewModifier {
    func body(content: Content) -> some View {
        content
            .autocapitalization(.none)
            .disableAutocorrection(false)
            .padding()
            .background(.white)
            .cornerRadius(8.0)
            .overlay(
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(Color(UIColor.separator), style: StrokeStyle(lineWidth: 1.0))
            )
        }
}

extension View {
    func textFieldWhiteSeparator() -> some View {
        modifier(TextFieldWhiteSeparator())
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
