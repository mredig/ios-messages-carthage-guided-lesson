//
//  Sender+UserDefaults.swift
//  Message Board
//
//  Created by Michael Redig on 6/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import MessageKit

struct Sender: SenderType {
	var senderId: String
	var displayName: String
}

extension Sender: Codable {
	static func setDefault(sender: Sender) {
		let encoder = PropertyListEncoder()
		do {
			let data = try encoder.encode(sender)
			UserDefaults.standard.set(data, forKey: "DefaultSender")
		} catch {
			NSLog("Error saving default sender: \(error)")
		}
	}

	static func defaultSender() -> Sender? {
		guard let data = UserDefaults.standard.data(forKey: "DefaultSender") else { return nil }

		let decoder = PropertyListDecoder()
		return try? decoder.decode(Sender.self, from: data)
	}
}
