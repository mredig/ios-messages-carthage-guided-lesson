//
//  MessageThreadDetailViewController.swift
//  Message Board
//
//  Created by Michael Redig on 6/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit
import MessageKit
import InputBarAccessoryView

class MessageThreadDetailViewController: MessagesViewController {
	var messageThread: MessageThread?
	var messageThreadController: MessageThreadController?

	override func viewDidLoad() {
		super.viewDidLoad()

		messageInputBar.delegate = self
		messagesCollectionView.messagesDataSource = self
		messagesCollectionView.messagesLayoutDelegate = self
		messagesCollectionView.messagesDisplayDelegate = self
	}
}

extension MessageThreadDetailViewController: MessagesDataSource {
	func currentSender() -> SenderType {
		return messageThreadController?.currentUser ?? Sender(senderId: "I AM LORDE YAYAYA", displayName: "Pizza")
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

extension MessageThreadDetailViewController: InputBarAccessoryViewDelegate {
	func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
		guard let messageThread = messageThread, let sender = messageThreadController?.currentUser else { return }
		messageThreadController?.createMessage(in: messageThread, withText: text, sender: sender, completion: {
			DispatchQueue.main.async {
				self.messagesCollectionView.reloadData()
				inputBar.inputTextView.text = ""
			}
		})
	}
}
