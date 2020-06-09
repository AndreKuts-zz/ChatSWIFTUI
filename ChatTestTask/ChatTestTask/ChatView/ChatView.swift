//
//  ChatView.swift
//  ChatTestTask
//
//  Created by Kuts, Andrey on 6/8/20.
//  Copyright © 2020 Kuts, Andrey. All rights reserved.
//

import SwiftUI

struct ChatView: View {

	@ObservedObject var viewModel: ChatViewModel

	init(viewModel: ChatViewModel) {

		self.viewModel = viewModel

		UITableView.appearance().tableFooterView = UIView()
		UITableView.appearance().separatorStyle = .none
		UITableView.appearance().backgroundColor = .clear
		UITableViewCell.appearance().backgroundColor = .clear
	}

    var body: some View {
		ZStack(alignment: .top) {
			Color.background.edgesIgnoringSafeArea(.top)
			Spacer().frame(height: 70)
			List { ForEach(viewModel.dataSource, content: ChatBubbleView.init(viewModel:)) }
				.scaleEffect(x: 1, y: -1, anchor: .center)
				.navigationBarTitle("Chat", displayMode: .inline)
			
		}
	}
}

struct ChatView_Previews: PreviewProvider {

	private static let model = ChatModel()
	private static let viewModel = ChatViewModel(model: model)

    static var previews: some View {
        ChatView(viewModel: viewModel)
    }
}
