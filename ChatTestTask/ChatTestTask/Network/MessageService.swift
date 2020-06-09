//
//  MessageService.swift
//  ChatTestTask
//
//  Created by Kuts, Andrey on 6/7/20.
//  Copyright © 2020 Kuts, Andrey. All rights reserved.
//

import Foundation
import Combine

enum DefaultError: Error {
	case `default`
}

protocol MessageServiceProtocol: AnyObject {
	func loadMessage() -> AnyPublisher<MessageList, Error>?
}

class MessageService: MessageServiceProtocol, Decoder {

	let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()

	private lazy var session = URLSession.shared
	private let request: URLRequest

	init() {
		self.request = URLRequest(url: URL(string: "https://mail.google.com/")!)
	}

	func loadMessage() -> AnyPublisher<MessageList, Error>? {

//		return session.dataTaskPublisher(for: request)
//			.mapError { _ in DefaultError.default }
//			.map { $0.data }
//			.decode(type: MessageList.self, decoder: decoder)
//			.eraseToAnyPublisher()

		let bundl = Bundle.main
        let fileName = "MessagesList"
        let fileType = "json"

		if let path = bundl.path(forResource: fileName, ofType: fileType),
			let url = URL(fileURLWithPath: path) as? URL,
			let data = try? Data(contentsOf: url)  {

			return decode(data)
		}

		return nil
	}
}
