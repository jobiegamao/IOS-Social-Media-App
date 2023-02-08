//
//  CustomCircleImageView.swift
//  socialmedia_swift
//
//  Created by may on 2/8/23.
//

import UIKit

class CustomCircleImageView: UIImageView {

	convenience init(height: Double) {
		self.init()
		self.translatesAutoresizingMaskIntoConstraints = false
		self.clipsToBounds = true
		self.layer.masksToBounds = true
		self.backgroundColor = .lightGray
		self.tintColor = .gray
		self.isUserInteractionEnabled = true
		self.layer.cornerRadius = height / 2
		self.contentMode = .scaleAspectFill
		
		NSLayoutConstraint.activate([
			self.widthAnchor.constraint(equalToConstant: height),
			self.heightAnchor.constraint(equalToConstant: height),
		])
	}
}
