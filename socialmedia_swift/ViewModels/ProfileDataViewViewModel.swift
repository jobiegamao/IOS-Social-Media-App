//
//  ProfileDataViewViewModel.swift
//  socialmedia_swift
//
//  Created by may on 2/7/23.
//

import Foundation

final class ProfileDataViewViewModel: ObservableObject {
	
	@Published var displayName: String?
	@Published var username: String?
	@Published var bio: String?
	@Published var avatarPath: String?
	
}
