//
//  ViewController.swift
//  twitterclone_swift
//
//  Created by may on 1/31/23.
//

import UIKit

class MainTabBarController: UITabBarController {
	private var tabs_root: [UIViewController] = [
		HomeViewController(),
		SearchViewController(),
		MessagesViewController(),
		NotificationsViewController()
	]
	
	private var tabs: [UINavigationController] = []
	
	private let tabImage = [
		"house",
		"magnifyingglass",
		"bell",
		"envelope"
	]
	private let tabImage_selected = [
		"house.fill",
		"magnifyingglass",
		"bell.fill",
		"envelope.fill"
	]
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tabs = tabs_root.map{ root in
			UINavigationController(rootViewController: root)
		}
		
		for (index, tab) in tabs.enumerated() {
			tab.tabBarItem.image = UIImage(systemName: tabImage[index])
			tab.tabBarItem.selectedImage = UIImage(systemName: tabImage_selected[index])
		}
		
		setViewControllers(tabs, animated: true)
		
	
		
	}


}

