//
//  CustomCircleImageView.swift
//  socialmedia_swift
//
//  Created by may on 2/8/23.
//

import UIKit

class CustomCircleImageView: UIImageView {

	
	init(frame: CGRect, size: Double = 50) {
		super.init(frame: frame)
		translatesAutoresizingMaskIntoConstraints = false
		layer.cornerRadius = size / 2
		clipsToBounds = true
		layer.masksToBounds = true
		backgroundColor = .lightGray
		tintColor = .gray
		isUserInteractionEnabled = true
		contentMode = .scaleAspectFill
		layer.borderWidth = 2
		NSLayoutConstraint.activate([
			self.widthAnchor.constraint(equalToConstant: size),
			self.heightAnchor.constraint(equalToConstant: size),
		])
		
	}
	
	override func layoutSubviews() {
		layer.borderColor = UIColor.systemBackground.cgColor
		
	}
	
	required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
	}
	
	
	
}
