//
//  Message.swift
//  Chat
//
//  Created by Dyan on 6/28/23.
//

import Foundation


struct Message: Hashable {
    let uuid: String
    let text: String
    let isMe: Bool
}
