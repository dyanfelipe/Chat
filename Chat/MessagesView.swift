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
        Button {
            viewModel.logout()
        } label: {
            Text("Logout")
        }

    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
