//
//  CustomButton.swift
//  socialmedia_swift
//
//  Created by may on 2/8/23.
//

import UIKit

class CustomOvalButton: UIButton {
	
	convenience init(title: String, height: Double = 50.0) {
		self.init()
		self.translatesAutoresizingMaskIntoConstraints = false
		self.setTitle(title, for: .normal)
		self.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
		self.backgroundColor = UIColor(named: "AccentColorBlue")
		self.tintColor = .white
		self.layer.cornerRadius = height / 2
		self.heightAnchor.constraint(equalToConstant: height).isActive = true
		
		self.isEnabled = false
		self.setTitleColor(UIColor.init(white: 1, alpha: 0.3), for: .disabled)
		self.setTitleColor(.white, for: .normal)
	}
}
