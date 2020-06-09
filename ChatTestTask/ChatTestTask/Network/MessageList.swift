//
//  MessageList.swift
//  ChatTestTask
//
//  Created by Kuts, Andrey on 6/7/20.
//  Copyright © 2020 Kuts, Andrey. All rights reserved.
//

import Foundation

// MARK: - MessageList
struct MessageList: Codable {
    let messages: [Message]
}

// MARK: - Message
struct Message: Codable {
    let line: String
}
