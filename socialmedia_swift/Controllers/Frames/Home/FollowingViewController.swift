//
//  FollowingTableViewController.swift
//  socialmedia_swift
//
//  Created by may on 2/11/23.
//

import UIKit

class FollowingViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Following"
		view.backgroundColor = .brown
		let label = UILabel(frame: CGRect(x: 50, y: 200, width: 100, height: 50))
		label.text = "Hello"
		view.addSubview(label)
	}
}
