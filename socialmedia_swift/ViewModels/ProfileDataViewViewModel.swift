//
//  ProfileDataViewViewModel.swift
//  socialmedia_swift
//
//  Created by may on 2/7/23.
//

import Foundation
import UIKit
import Combine
import Firebase
import FirebaseAuth
import FirebaseStorage

final class ProfileDataViewViewModel: ObservableObject {
	
	@Published var displayName: String?
	@Published var username: String?
	@Published var bio: String?
	@Published var avatarPath: String?
	@Published var imageData: UIImage?
	@Published var isFormValid: Bool = false
	@Published var isOnboardingDone: Bool = false
	@Published var error: String = ""
	
	private var subscriptions: Set<AnyCancellable> = []
	
	func validateForm(){
		guard let displayName = displayName,
			  displayName.count > 2,
			  let username = username,
			  username.count > 3,
			  let bio = bio,
			  bio.count > 1,
			  imageData != nil
		else {
			isFormValid = false
			return
		}
		
		isFormValid = true
		
					
	}
	
	//  method uploads the imageData property to Firebase Storage using the StorageManager class and saves the download URL of the uploaded image to the url property.
	func uploadAvatar(){
		
		let randomID = UUID().uuidString
		guard let imageData = imageData?.jpegData(compressionQuality: 0.5) else { return }
		let metadata = StorageMetadata()
		metadata.contentType = "image/jpeg"
		
		StorageManager.shared.uploadProfilePhoto(with: randomID, image: imageData, metadata: metadata)
			.flatMap({ metadata in
				StorageManager.shared.getDownloadURL(for: metadata.path)
			})
			.sink { [weak self] result in
				switch result{
					case .failure(let error):
						self?.error = error.localizedDescription
						
					case .finished:
						self?.updateUserData()
				}
			} receiveValue: { [weak self] url in
				self?.avatarPath = url.absoluteString
			}
			.store(in: &subscriptions)

	}
	
	private func updateUserData(){
		guard let id = Auth.auth().currentUser?.uid,
			  let displayName,
			  let username,
			  let bio,
			  let avatarPath else {return}
		
		let updateFields: [String: Any] = [
			"displayName": displayName,
			"username": username,
			"bio": bio,
			"avatarPath": avatarPath,
			"isUserOnboarded": true
			
		]
		
		DatabaseManager.shared.collectionUsers(for: id, update: updateFields)
			.sink { [weak self] result in
				if case .failure(let error) = result {
					self?.error = error.localizedDescription
				}
			} receiveValue: { [weak self] boolResult in
				self?.isOnboardingDone = boolResult
			}
			.store(in: &subscriptions)

		
	}
	
}


/* NOTES
 uploadAvatar()
	.flatmap()
		the uploadAvatar returns a StorageUploadTask publisher cuz of putData(..), thus before doing anything, we use flatmap operator to flatten the StorageUploadTask publisher into a single AnyPublisher<URL, Error> publisher. The flatMap operator is used to transform the StorageUploadTask into a Publisher that emits the download URL of the uploaded file, which can then be retrieved using the getDownloadURL method of the StorageManager.
	.sink()
		The sink operator is used to subscribe to the AnyPublisher<URL, Error> publisher, which will emit the download URL of the uploaded file or an error if one occurs. The receiveValue closure is called whenever a value is emitted by the publisher. In this case, the closure sets the url property of the ProfileDataViewViewModel object to the download URL of the uploaded image.
	.store()
		store method is used to store the subscription in the subscriptions set, which is a property of the ProfileDataViewViewModel object. This ensures that the subscription is retained and will not be deallocated as long as the ProfileDataViewViewModel object exists.
 
 */
