//
//  statusBarView.swift
//  socialmedia_swift
//
//  Created by may on 2/11/23.
//

import UIKit

class StatusBarView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .systemBackground
		layer.opacity = 0
	}
	
	required init?(coder: NSCoder) {
		fatalError()
	}

}
