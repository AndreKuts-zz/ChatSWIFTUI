//
//  MessageLengthAdapter.swift
//  ChatTestTask
//
//  Created by Kuts, Andrey on 6/10/20.
//  Copyright © 2020 Kuts, Andrey. All rights reserved.
//

import Foundation

struct MessageLengthAdapter {

	static private let maxMessageLength = 550

	static func adaptToLenght(texts: [String]) -> [String] {
		var result: [String] = []
		texts.forEach { text in
			let correctText = text.trimmingCharacters(in: .whitespacesAndNewlines)
			if correctText.count <= maxMessageLength {
				result.append(correctText)
			} else {
				let sentences = correctText.components(separatedBy: ".").filter { !$0.isEmpty }
				if sentences.count == 1 {
					let words = correctText.components(separatedBy: " ")
					let split = words.split()
					let left = split.left.joined(separator: " ")
					let right = split.right.joined(separator: " ")
					let arrayWithCorrectLenght = adaptToLenght(texts: [left, right])
					result.append(contentsOf: arrayWithCorrectLenght)
				} else {
					let split = sentences.split()
					let left = split.left.joined(separator: " ")
					let right = split.right.joined(separator: " ")
					let arrayWithCorrectLenght = adaptToLenght(texts: [left, right])
					result.append(contentsOf: arrayWithCorrectLenght)
				}
			}
		}

		return result
	}
}

extension Array {
	func split() -> (left: [Element], right: [Element]) {
		let half = count / 2
		let leftSplit = self[0 ..< half]
		let rightSplit = self[half ..< count]
		return (left: Array(leftSplit), right: Array(rightSplit))
	}
}
