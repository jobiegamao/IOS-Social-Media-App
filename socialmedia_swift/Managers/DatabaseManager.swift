//
//  DatabaseManager.swift
//  socialmedia_swift
//
//  Created by may on 2/7/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestoreCombineSwift
import Combine

class DatabaseManager {
	
	static let shared = DatabaseManager()
	
	let db = Firestore.firestore()
	
	//collection of users == users table
	let usersPath: String = "users"
	
	func collectionUsers(add user: User) -> AnyPublisher<Bool, Error> {
		let userAccount = UserAccount(from: user)
		
		return db.collection(usersPath).document(userAccount.id).setData(from: userAccount)
			.map{ _ in true }
			.eraseToAnyPublisher()
	}
	
	func collectionUsers(retreive id: String) -> AnyPublisher<UserAccount, Error>{
		db.collection(usersPath).document(id).getDocument()
			.tryMap{ try $0.data(as: UserAccount.self) }
			.eraseToAnyPublisher()
	}
	
	func collectionUsers(for id: String, update fields: [String: Any]) -> AnyPublisher<Bool, Error>{
		db.collection(usersPath).document(id).updateData(fields)
			.map { _ in true }
			.eraseToAnyPublisher()
	}
	
}


/*
 NOTES:
 
 // the database
 let db = Firestore.firestore()
 
 func collectionUsers(add user: User) -> AnyPublisher<Bool, Error>
	- is called when we want to add a user in the collection {table} in our firebase database
	- -> AnyPublisher<Bool, Error>, this func after will return a boolean when success or error when fail, thus after the return statement of rewriting the db, we use .map to follow the pattern of returning the bool.
	- .eraseToAnyPublisher() is needed when we use AnyPublisher from the Combine Library
 
 let userAccount = UserAccount(from: user)
	- when saving data, it must be in a form of a codable struct thus beforehand, we created the struct codable as our model for users account.
 
 db.collection(usersPath).document(userAccount.id).setData(from: userAccount)
	- usersPath == name of table/collection
	- .document(UNIQUE ID)
	- .setData(STRUCT DATA TO PUT)
 
*/
