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

}
