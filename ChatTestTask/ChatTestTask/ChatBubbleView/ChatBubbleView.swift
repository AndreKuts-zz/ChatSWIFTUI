//
//  ChatBubbleView.swift
//  ChatTestTask
//
//  Created by Kuts, Andrey on 6/7/20.
//  Copyright © 2020 Kuts, Andrey. All rights reserved.
//

import SwiftUI
import Combine

struct ChatBubbleView: View {

	@ObservedObject var viewModel: ChatBubbleViewModel

	var body: some View {
		HStack(alignment: .bottom, spacing: 0) {
			BubblText
				.opacity(viewModel.isShow ? 1 : 0)
				.offset(x: 0, y: viewModel.isShow ? 0 : 100)
			Spacer()
		}
		.padding(.leading, 25)
		.animation(.linear(duration: viewModel.isShow ? 0.5 : 0))
		.listRowInsets(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
		.scaleEffect(x: 1, y: -1, anchor: .center)
	}

	private var BubblText: some View {
		HStack(alignment: .bottom) {
			Text(viewModel.text)
				.padding(10)
				.padding(.leading, 10)
				.foregroundColor( .black)
				.multilineTextAlignment(.leading)
				.background(chatBubble)
		}
	}

	private var chatBubble: some View {
		HStack {
			VStack {
				Spacer()
				chatBubbleTriange(width: 13, height: 22)
					.padding(.trailing, -12)
					.shadow(color: Color.gray.opacity(0.2), radius: 2, x: -4, y: 0)
			}
			.zIndex(10)
			RoundedRectangle(cornerRadius: 6)
				.foregroundColor(.white)
				.shadow(color: Color.gray.opacity(0.5), radius: 4, x: 1, y: 1)
		}
	}

	init(viewModel: ChatBubbleViewModel) {
		self.viewModel = viewModel
	}

	private func chatBubbleTriange(width: CGFloat, height: CGFloat) -> some View {
		Path { path in
			path.move(to: CGPoint(x: 0, y: height * 1))
			path.addLine(to: CGPoint(x: width, y: height))
			path.addLine(to: CGPoint(x: width, y: 1))
			path.closeSubpath()
		}
		.fill(Color.white)
		.clipped()
		.frame(width: width, height: height)
	}
}

struct ChatBubbleView_Previews: PreviewProvider {
    static var previews: some View {
		ChatBubbleView(viewModel: ChatBubbleViewModel(text: "testTEXT"))
    }
}
