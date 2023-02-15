//
//  CustomButton.swift
//  socialmedia_swift
//
//  Created by may on 2/8/23.
//

import UIKit

class CustomOvalButton: UIButton {
	
	
	init(frame: CGRect, primaryAction: UIAction?, title: String?, height: Double = 50.0 ) {
		super.init(frame: frame)
		translatesAutoresizingMaskIntoConstraints = false
		layer.cornerRadius = height / 2
		heightAnchor.constraint(equalToConstant: height).isActive = true
		
		backgroundColor = UIColor(named: "AccentColorBlue")
		
		if let title = title{
			setTitle(title, for: .normal)
			titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
		}
		
		setTitleColor(UIColor.init(white: 1, alpha: 0.3), for: .disabled)
		setTitleColor(.white, for: .normal)
		tintColor = .white
		
		isEnabled = false
	}
	
	required init?(coder: NSCoder) {
		fatalError()
	}
}
