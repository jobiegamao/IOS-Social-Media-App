//
//  AuthViewViewModel.swift
//  socialmedia_swift
//
//  Created by may on 2/6/23.
//

import Foundation
import Firebase
import Combine

// final -> prevents the class from being inherited
// ObservableObject -> A type of object with a publisher that emits before the object has changed so that when important changes happen the view will reload.
// @Published -> @Published property wrapper is added to any properties inside an observed object that should cause views to update when they change.


final class AuthViewViewModel: ObservableObject {
	
	@Published var email: String?
	@Published var password: String?
	@Published var isAuthenticationValid: Bool = false
	@Published var user: User?
	@Published var error: Error?
	
	private var subscriptions: Set<AnyCancellable> = []
	
	func validateForm(){
		guard let email = email, let password = password else { return }
		isAuthenticationValid = isValidEmail(email) && isValidPassword(password: password)
		
	}
	
	func isValidEmail(_ email: String) -> Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

		let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
		return emailPred.evaluate(with: email)
	}
	
	func isValidPassword(password: String) -> Bool {
		let valid: Bool
		
		if password.count >= 8 {
			valid = true
		} else {
			valid = false
		}
		
		return valid
	}
	
	func createUser(){
		guard let email = email, let password = password else { return }
		AuthManager.shared.registerUser(with: email, password: password)
			.sink { [weak self] result in //error
				if case .failure(let error) = result {
					self?.error = error
				}
					
			} receiveValue: { [weak self] user in //
				self?.user = user
			}
			.store(in: &subscriptions)
	}
	
	func loginUser(){
		guard let email = email, let password = password else { return }
		AuthManager.shared.loginUser(with: email, password: password)
			.sink { [weak self] result in //error
				if case .failure(let error) = result {
					self?.error = error
				}
			} receiveValue: { [weak self] user in //
				self?.user = user
			}
			.store(in: &subscriptions)
	}
}
