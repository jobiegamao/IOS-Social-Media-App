//
//  AuthManager.swift
//  socialmedia_swift
//
//  Created by may on 2/6/23.
//

import Foundation
import Firebase
import FirebaseAuthCombineSwift
import Combine

class AuthManager {
	
	static let shared = AuthManager()
	
	func registerUser(with email: String, password: String) -> AnyPublisher<User, Error> {
		
		return Auth.auth().createUser(withEmail: email, password: password)
			.map(\.user)
			.eraseToAnyPublisher()
	}
	
	func loginUser(with email: String, password: String) -> AnyPublisher<User, Error> {
		return Auth.auth().signIn(withEmail: email, password: password)
			.map(\.user)
			.eraseToAnyPublisher()
	}
}



// NOTES:
//          .map(\.user) is a shorthand for
//			.map { result in
//				return result.user
//			}
