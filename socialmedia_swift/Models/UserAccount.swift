//
//  User.swift
//  socialmedia_swift
//
//  Created by may on 2/7/23.
//

import Foundation
import Firebase

struct UserAccount: Codable {
	let id: String
	var displayName: String = ""
	var username: String = ""
	var followersCount: Double = 0
	var followingCount: Double = 0
	var createdOn: Date = Date()
	var bio: String = ""
	var avatarPath: String = ""
	var isUserOnboarded: Bool = false
	
	init(from user: User) {
		self.id = user.uid
	}
}
