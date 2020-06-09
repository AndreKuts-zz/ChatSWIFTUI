//
//  ChatModel.swift
//  ChatTestTask
//
//  Created by Kuts, Andrey on 6/8/20.
//  Copyright © 2020 Kuts, Andrey. All rights reserved.
//

import Foundation

class ChatModel {

	lazy var service: MessageServiceProtocol = MessageService()
	lazy var messagePublisher = service.loadMessage()
}
