//
//  ChatViewModel.swift
//  ChatTestTask
//
//  Created by Kuts, Andrey on 6/8/20.
//  Copyright © 2020 Kuts, Andrey. All rights reserved.
//

import AVFoundation
import Foundation
import Combine

class ChatViewModel: NSObject, ObservableObject, Identifiable {

	@Published var dataSource: [ChatBubbleViewModel] = []

	private let model: ChatModel
	private var disposables = Set<AnyCancellable>()
	private var queue = Queue()
	private let rate: Float = 0.4

	private lazy var synthesizer = AVSpeechSynthesizer()
	private lazy var voice = AVSpeechSynthesisVoice(language: "en-US")

	init(model: ChatModel) {
		self.model = model
		super.init()

		synthesizer.delegate = self
		loadNextItem()
	}
}

private extension ChatViewModel {

	func loadNextItem() {
		model.messagePublisher?
			.subscribe(on: RunLoop.main)
			.map({ MessageLengthAdapter.adaptToLenght(texts: ($0.messages.map { $0.line })) })
			.sink(receiveCompletion: { _ in
			}, receiveValue: { [weak self] list in
				list.forEach {
					self?.queue.enqueue(element: $0)
				}
				self?.showNextMessageFromQueue()
			})
			.store(in: &disposables)
	}

	func voiceReadText(_ text: String) {
		let utterance = AVSpeechUtterance(string: text)
		utterance.voice = voice
		utterance.rate = rate
		DispatchQueue.main.async {
			self.synthesizer.speak(utterance)
		}
	}

	func showNextMessageFromQueue() {
		if let nextMessage = queue.dequeue() {
			dataSource.insert(ChatBubbleViewModel(text: nextMessage), at: 0)
			DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
				self.voiceReadText(nextMessage)
			}
		}
	}
}

extension ChatViewModel: AVSpeechSynthesizerDelegate {
	func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
		showNextMessageFromQueue()
	}
}
