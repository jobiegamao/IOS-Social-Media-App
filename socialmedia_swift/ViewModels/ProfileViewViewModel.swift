//
//  ProfileVIewViewModel.swift
//  socialmedia_swift
//
//  Created by may on 2/13/23.
//

import Foundation
import Combine
import FirebaseAuth

final class ProfileViewViewModel: ObservableObject {
	
	@Published var user: UserAccount?
	@Published var error: Error?
	
	private var subscriptions: Set<AnyCancellable> = []
	
	func retreiveUser() {
		guard let id = Auth.auth().currentUser?.uid else {return}
		DatabaseManager.shared.collectionUsers(retreive: id)
			.sink { [weak self] result in
				if case .failure(let error) = result {
					self?.error = error
				}
			} receiveValue: { [weak self] user in
				self?.user = user
			}
			.store(in: &subscriptions)

	}
}
