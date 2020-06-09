//
//  Message.swift
//  ChatTestTask
//
//  Created by Kuts, Andrey on 6/7/20.
//  Copyright © 2020 Kuts, Andrey. All rights reserved.
//

import SwiftUI

class ChatBubbleViewModel: ObservableObject, Identifiable {

	var text: String = ""

	@Published var isShow: Bool = false

	init(text: String) {
		self.text = text

		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			self.isShow = true
		}
	}
}
