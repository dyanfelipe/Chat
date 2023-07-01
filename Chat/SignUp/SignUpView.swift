//
//  SignUpView.swift
//  Chat
//
//  Created by Dyan on 6/27/23.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel = SignUpViewModel(repo: SignUpRepository())
    @State var isShowPhotoLibrary: Bool = false
    var body: some View {
        VStack {
            Button {
                isShowPhotoLibrary = true
            } label: {
                if viewModel.image.size.width > 0 {
                    Image(uiImage: viewModel.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 130, height: 130)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color("GreenColor"), lineWidth: 4))
                        .shadow(radius: 7)
                } else {
                    Text("Photo")
                        .frame(width: 130, height: 130)
                        .padding()
                        .background(Color("GreenColor"))
                        .foregroundColor(.white)
                        .cornerRadius(100)
                }
            }
            .padding(.bottom, 32)
            .sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker(selectedImage: $viewModel.image)
            }

            TextField("Enter your name", text: $viewModel.name)
                .textFieldWhiteSeparator()
                .padding(.bottom)
            TextField("Enter your email", text: $viewModel.email)
                .textFieldWhiteSeparator()
                .padding(.bottom)
            SecureField("Enter your password", text: $viewModel.password)
                .textFieldWhiteSeparator()
                .padding(.bottom, 8)
               
            if viewModel.isLoading{
                ProgressView()
                    .padding()
            }
            
            Button {
                viewModel.signUp()
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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 32)
        .background(Color.init(red: 240 / 255, green: 231 / 255, blue: 210 / 255))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
