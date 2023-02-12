//
//  StorageManager.swift
//  socialmedia_swift
//
//  Created by may on 2/9/23.
//  StorageManager is a class that provides functionality for uploading and downloading images from Firebase Storage.

import Foundation
import Combine
import FirebaseStorageCombineSwift
import FirebaseStorage

enum FireStorageError: Error {
	case invalidImageID
}

final class StorageManager{
	static let shared = StorageManager()
	
	let storage = Storage.storage()
	
	// method returns a download URL for a given image ID,
	func getDownloadURL(for id: String?) -> AnyPublisher<URL, Error>{
		guard let id = id else {
			return Fail(error: FireStorageError.invalidImageID)
				.eraseToAnyPublisher()
			}
		
		return storage
			.reference(withPath: id)
			.downloadURL()
			.eraseToAnyPublisher()
			
	}
	
	// method uploads an image with given metadata and a random ID to Firebase Storage.
	func uploadProfilePhoto(with randomID: String, image: Data, metadata: StorageMetadata) -> AnyPublisher<StorageMetadata, Error> {
		storage
			.reference()
			.child("images/\(randomID).jpg")
			.putData(image, metadata: metadata)
			.print()
			.eraseToAnyPublisher()
	}
}


/* NOTES
 
 uploadProfilePhoto()
	The uploadProfilePhoto method first creates a reference to a Firebase Storage location using the child method of the Storage object. The location is specified using the string "images/(randomID).jpg". This means that the uploaded image will be stored in the "images" folder of Firebase Storage and will have the file name randomID.jpg.
 
	After creating the reference, the method calls the putData method on the reference to upload the image data to Firebase Storage, along with the specified metadata. The putData method returns a StorageUploadTask object, which is an instance of a Combine publisher that emits the metadata of the uploaded file.
 
	//when calling the function
	To handle the metadata, the method uses the flatMap operator to flatten the StorageUploadTask publisher into a single AnyPublisher<URL, Error> publisher. The flatMap operator is used to transform the StorageUploadTask into a Publisher that emits the download URL of the uploaded file, which can then be retrieved using the getDownloadURL method of the StorageManager.
 */
