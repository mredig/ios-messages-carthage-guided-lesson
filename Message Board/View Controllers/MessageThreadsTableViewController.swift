//
//  MessageThreadsTableViewController.swift
//  Message Board
//
//  Created by Spencer Curtis on 8/7/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {


	// MARK: - Properties

	let messageThreadController = MessageThreadController()

	@IBOutlet weak var threadTitleTextField: UITextField!

	override func viewDidLoad() {
		if let defaultUser = Sender.defaultSender() {
			messageThreadController.currentUser = defaultUser
		} else {
			presentUsernameSubmissionsAlert()

		}
	}

	private func presentUsernameSubmissionsAlert() {
		let alert = UIAlertController(title: "Enter a username:", message: "WHO ARE YOU?!", preferredStyle: .alert)
		var userTextField: UITextField!
		alert.addTextField { (textField) in
			textField.placeholder = "I'm Mr. Meeseeks! Look at me!"
			userTextField = textField
		}
		let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
			guard let username = userTextField.text else { return }
			let sender = Sender(senderId: UUID().uuidString, displayName: username)
			Sender.setDefault(sender: sender)
			self.messageThreadController.currentUser = Sender.defaultSender()
		}
		alert.addAction(submitAction)
		present(alert, animated: true)
	}

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        messageThreadController.fetchMessageThreads {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func createThread(_ sender: Any) {
        threadTitleTextField.resignFirstResponder()
        
        guard let threadTitle = threadTitleTextField.text else { return }
        
        threadTitleTextField.text = ""
        
        messageThreadController.createMessageThread(with: threadTitle) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThreadController.messageThreads.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageThreadCell", for: indexPath)
        
        cell.textLabel?.text = messageThreadController.messageThreads[indexPath.row].title

        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewMessageThread" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? MessageThreadDetailViewController else { return }
            
            destinationVC.messageThreadController = messageThreadController
            destinationVC.messageThread = messageThreadController.messageThreads[indexPath.row]
        }
    }

}
