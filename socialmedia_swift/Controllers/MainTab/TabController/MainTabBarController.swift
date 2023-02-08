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
	
	private lazy var tabs: [UINavigationController] = tabs_root.map{ vc in
		return UINavigationController(rootViewController: vc)
	}
	
	private let tabImage = [
		"house",
		"magnifyingglass",
		"bell",
		"envelope"
	]
	private let tabImage_selected = [
		"house.fill",
		"",
		"bell.fill",
		"envelope.fill"
	]
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tabBarController?.tabBar.backgroundColor = .clear
		tabBarController?.tabBar.isTranslucent = true
		
		for (index, tab) in tabs.enumerated() {
			tab.tabBarItem.image = UIImage(systemName: tabImage[index])
			if(tabImage_selected[index] != ""){
				tab.tabBarItem.selectedImage = UIImage(systemName: tabImage_selected[index])
			}
			
		}
		
		setViewControllers(tabs, animated: true)
		
	
		
	}


}

