//
//  ContentView.swift
//  Chat
//
//  Created by Dyan on 6/27/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        if viewModel.isLogged{
            MessagesView()
        }else {
            SignInView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
