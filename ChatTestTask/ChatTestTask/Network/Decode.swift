//
//  Decode.swift
//  ChatTestTask
//
//  Created by Kuts, Andrey on 6/7/20.
//  Copyright © 2020 Kuts, Andrey. All rights reserved.
//

import Foundation
import Combine

protocol Decoder {

	var decoder: JSONDecoder  { get }

	func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, Error>
}

extension Decoder {

	func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, Error> {
		return Just(data)
			.decode(type: T.self, decoder: decoder)
			.eraseToAnyPublisher()
	}
}
