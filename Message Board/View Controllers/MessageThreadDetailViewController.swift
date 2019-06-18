//
//  MessageThreadDetailViewController.swift
//  Message Board
//
//  Created by Michael Redig on 6/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit
import MessageKit

class MessageThreadDetailViewController: MessagesViewController {
	var messageThread: MessageThread?
	var messageThreadController: MessageThreadController?

	override func viewDidLoad() {
		super.viewDidLoad()

		messagesCollectionView.messagesDataSource = self
		messagesCollectionView.messagesLayoutDelegate = self
		messagesCollectionView.messagesDisplayDelegate = self
	}
}

extension MessageThreadDetailViewController: MessagesDataSource {
	func currentSender() -> SenderType {
		return Sender(senderId: "I AM LORDE YAYAYA", displayName: "Pizza")
	}

	func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
		guard let message = messageThread?.messages[indexPath.item] else { fatalError("No message for \(indexPath.item)") }
		return message
	}

	func numberOfItems(inSection section: Int, in messagesCollectionView: MessagesCollectionView) -> Int {
		return messageThread?.messages.count ?? 0
	}

	func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
		return 1
	}
}

extension MessageThreadDetailViewController: MessagesLayoutDelegate {
	
}

extension MessageThreadDetailViewController: MessagesDisplayDelegate {
	
}


