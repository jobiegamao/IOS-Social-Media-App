/*
 ////
 ////  HomeTabBarController.swift
 ////  socialmedia_swift
 ////
 ////  Created by may on 2/11/23.
 ////
 //
 //import UIKit
 //
 //class HomeTabBarController: UITabBarController, UITabBarControllerDelegate {
 //
 //	private let indicatorLine = UIView()
 //	private let forYouVC = ForYouViewController()
 //	private let followingVC = FollowingViewController()
 //
 //	override func viewDidLoad() {
 //
 //		super.viewDidLoad()
 //
 //		setupTabBar()
 //
 //		forYouVC.tabBarItem = UITabBarItem(title: "For You", image: nil, tag: 0)
 //		followingVC.tabBarItem = UITabBarItem(title: "Following", image: nil, tag: 1)
 //		viewControllers = [forYouVC, followingVC]
 //
 //
 //		tabBar.items?.forEach({
 //			$0.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -15)
 //			$0.setTitleTextAttributes([
 //				NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold),
 //			], for: .normal)
 //		})
 //
 //		// Add the indicator line as a subview
 //		indicatorLine.backgroundColor = .systemBlue
 //		self.tabBar.addSubview(indicatorLine)
 //		updateLinePosition()
 //
 //		configureConstraints()
 //
 //	}
 //
 //	private func setupTabBar(){
 //		tabBar.backgroundColor = .clear
 //		tabBar.isTranslucent = true
 //		tabBar.backgroundImage = UIImage()
 //		tabBar.tintColor = .label
 //		tabBar.barTintColor = .clear
 //
 //		// Set the delegate
 //		self.delegate = self
 //	}
 //
 //
 //	private func configureConstraints(){
 //		// Place the tab bar on top
 //
 //
 ////		for VC in self.viewControllers! {
 //////			view.addSubview(VC.view)
 ////			VC.view.translatesAutoresizingMaskIntoConstraints = false
 ////			VC.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: tabBarHeight).isActive = true
 ////			VC.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
 ////			VC.view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
 ////			VC.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
 ////		}
 //
 //
 //	}
 //
 //	private func updateLinePosition(){
 //		// Find the selected item
 //	   guard let selectedItem = self.selectedViewController?.tabBarItem else { return }
 //	   let items = self.tabBar.items!
 //
 //	   // Find the UILabel for the selected item
 //		let selectedIndex = items.firstIndex(of: selectedItem)!
 //		guard let label = self.tabBar.subviews[selectedIndex + 1].subviews.first as? UILabel else { return }
 //
 //		//hard code ;<
 //		let prevbar = tabBar.subviews[selectedIndex]
 //		let x = selectedIndex == 0 ? label.frame.minX : tabBar.convert(prevbar.frame, to: self.view).maxX + label.frame.minX
 //
 //	   // Calculate the frame of the indicator line
 //		let frame = CGRect(x: x, y: self.tabBar.frame.height - 3, width: label.frame.width + 3, height: 2)
 //
 //		UIView.animate(withDuration: 0.5, delay: 0) { [weak self] in
 //			self?.indicatorLine.frame = frame
 //
 //		}
 //
 //	}
 //
 //	override func viewDidLayoutSubviews() {
 //		super.viewDidLayoutSubviews()
 //
 //		setupTabBar()
 //		updateLinePosition()
 //
 //		setupChildConstraints()
 //	}
 //
 //	func setupChildConstraints(){
 //		guard let vc = selectedViewController?.view else { return }
 //		vc.translatesAutoresizingMaskIntoConstraints = false
 //		vc.topAnchor.constraint(equalTo: tabBar.bottomAnchor).isActive = true
 //	}
 //
 //	func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
 //		// Update the position and width of the indicator line
 //		self.view.setNeedsLayout()
 //		// Set the selected view controller to the corresponding tab bar item
 //		selectedViewController = viewController
 //		setupChildConstraints()
 //
 //	}
 //
 //
 //
 //}
 //
 //
 ///*
	// //
	// //  HomeTabBarController.swift
	// //  socialmedia_swift
	// //
	// //  Created by may on 2/11/23.
	// //
	//
	// import UIKit
	//
	// class HomeTabBarController: UITabBarController, UITabBarControllerDelegate {
	//
	//	 private let indicatorLine = UIView()
	//	 private let forYouVC = ForYouViewController()
	//	 private let followingVC = FollowingViewController()
	//
	//	 override func viewDidLoad() {
	//
	//		 super.viewDidLoad()
	//
	//		 setupTabBar()
	//		 setupForYouVC()
	//		 setupFollowingVC()
	//		 viewControllers = [forYouVC, followingVC]
	//
	//
	//		 tabBar.items?.forEach({
	//			 $0.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -15)
	//			 $0.setTitleTextAttributes([
	//				 NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold),
	//			 ], for: .normal)
	//		 })
	//
	//		 // Add the indicator line as a subview
	//		 indicatorLine.backgroundColor = .systemBlue
	//		 self.tabBar.addSubview(indicatorLine)
	//		 updateLinePosition()
	//
	//		 configureConstraints()
	//
	//	 }
	//
	//	 private func setupTabBar(){
	//		 tabBar.backgroundColor = .clear
	//		 tabBar.isTranslucent = true
	//		 tabBar.backgroundImage = UIImage()
	//		 tabBar.tintColor = .label
	//		 tabBar.barTintColor = .clear
	//
	//
	//		 // Set the delegate
	//		 self.delegate = self
	//	 }
	//
	//	 private func setupForYouVC() {
	//		 forYouVC.tabBarItem = UITabBarItem(title: "For You", image: nil, tag: 0)
	//		 addChild(forYouVC)
	//		 view.addSubview(forYouVC.view)
	//		 forYouVC.didMove(toParent: self)
	//	   }
	//
	//	 private func setupFollowingVC() {
	//		 followingVC.tabBarItem = UITabBarItem(title: "Following", image: nil, tag: 1)
	//		 addChild(followingVC)
	//		 view.addSubview(followingVC.view)
	//		 followingVC.didMove(toParent: self)
	//	   }
	//
	//	 private func configureConstraints(){
	//		 forYouVC.view.translatesAutoresizingMaskIntoConstraints = false
	//		 forYouVC.view.topAnchor.constraint(equalTo: tabBar.bottomAnchor).isActive = true
	//		 forYouVC.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
	//		 forYouVC.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
	//		 forYouVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	//
	//		 followingVC.view.translatesAutoresizingMaskIntoConstraints = false
	//		 followingVC.view.topAnchor.constraint(equalTo: tabBar.bottomAnchor).isActive = true
	//		 followingVC.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
	//		 followingVC.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
	//		 followingVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	//
	//	 }
	//
	//	 private func updateLinePosition(){
	//		 // Find the selected item
	//		guard let selectedItem = self.selectedViewController?.tabBarItem else { return }
	//		let items = self.tabBar.items!
	//
	//		// Find the UILabel for the selected item
	//		 let selectedIndex = items.firstIndex(of: selectedItem)!
	//		 guard let label = self.tabBar.subviews[selectedIndex + 1].subviews.first as? UILabel else { return }
	//
	//		 //hard code ;<
	//		 let prevbar = tabBar.subviews[selectedIndex]
	//		 let x = selectedIndex == 0 ? label.frame.minX : tabBar.convert(prevbar.frame, to: self.view).maxX + label.frame.minX
	//
	//		// Calculate the frame of the indicator line
	//		 let frame = CGRect(x: x, y: self.tabBar.frame.height - 3, width: label.frame.width + 3, height: 2)
	//
	//		 UIView.animate(withDuration: 0.5, delay: 0) { [weak self] in
	//			 self?.indicatorLine.frame = frame
	//
	//		 }
	//
	//	 }
	//
	//	 override func viewDidLayoutSubviews() {
	//		 super.viewDidLayoutSubviews()
	//		 setupTabBar()
	//		 updateLinePosition()
	//
	//	 }
	//
	//	 func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
	//		 // Update the position and width of the indicator line
	//		 self.view.setNeedsLayout()
	//
	//		 // Set the selected view controller to the corresponding tab bar item
	//		 selectedViewController = viewController
	//	 }
	//
	//
	//
	// }
	//
	//
	// import UIKit
	//
	// class HomeTabBarController: UITabBarController, UITabBarControllerDelegate {
	//
	//	 private let indicatorLine = UIView()
	//	 private let forYouVC = ForYouViewController()
	//	 private let followingVC = FollowingViewController()
	//
	//	 override func viewDidLoad() {
	//		 super.viewDidLoad()
	//
	//		 forYouVC.tabBarItem = UITabBarItem(title: "For You", image: nil, tag: 0)
	//		 followingVC.tabBarItem = UITabBarItem(title: "Following", image: nil, tag: 1)
	//		 viewControllers = [forYouVC, followingVC]
	//
	//		 tabBar.items?.forEach({
	//			 $0.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -15)
	//			 $0.setTitleTextAttributes([
	//				 NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold),
	//			 ], for: .normal)
	//		 })
	//
	//		 // Add the indicator line as a subview
	//		indicatorLine.backgroundColor = .systemBlue
	//		self.tabBar.addSubview(indicatorLine)
	//
	//
	//
	//		// Set the delegate
	//		self.delegate = self
	//
	//		 configureConstraints()
	//
	//	 }
	//
	//	 private func configureConstraints(){
	// //		tabBar.translatesAutoresizingMaskIntoConstraints = false
	// //		forYouVC.view.translatesAutoresizingMaskIntoConstraints = false
	// //		followingVC.view.translatesAutoresizingMaskIntoConstraints = false
	// //
	// //		NSLayoutConstraint.activate([
	// //			forYouVC.view.topAnchor.constraint(equalTo: tabBar.bottomAnchor),
	// //			forYouVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
	// //			forYouVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
	// //			forYouVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
	// //
	// //			followingVC.view.topAnchor.constraint(equalTo: tabBar.bottomAnchor),
	// //			followingVC.view.leftAnchor.constraint(equalTo: view.leftAnchor),
	// //			followingVC.view.rightAnchor.constraint(equalTo: view.rightAnchor),
	// //			followingVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
	// //		])
	//	 }
	//
	//	 private func updateLinePosition(){
	//		 // Find the selected item
	//		guard let selectedItem = self.selectedViewController?.tabBarItem else { return }
	//		let items = self.tabBar.items!
	//
	//		// Find the UILabel for the selected item
	//		 let selectedIndex = items.firstIndex(of: selectedItem)!
	//		 guard let label = self.tabBar.subviews[selectedIndex + 1].subviews.first as? UILabel else { return }
	//
	//		 //hard code ;<
	//		 let prevbar = tabBar.subviews[selectedIndex]
	//		 let x = selectedIndex == 0 ? label.frame.minX : tabBar.convert(prevbar.frame, to: self.view).maxX + label.frame.minX
	//
	//		// Calculate the frame of the indicator line
	//		 let frame = CGRect(x: x, y: self.tabBar.frame.height - 3, width: label.frame.width + 3, height: 2)
	//
	//		 UIView.animate(withDuration: 0.5, delay: 0) { [weak self] in
	//			 self?.indicatorLine.frame = frame
	//
	//		 }
	//
	//	 }
	//
	//	 override func viewDidLayoutSubviews() {
	//		 super.viewDidLayoutSubviews()
	//		 // Customize the appearance of the UITabBarController and UITabBar
	//		  tabBar.tintColor = .label
	//		  tabBar.barTintColor = .clear
	//
	//		 updateLinePosition()
	//
	//	 }
	//
	//	 func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
	//		 // Update the position and width of the indicator line
	//		 self.view.setNeedsLayout()
	//
	//		 // Set the selected view controller to the corresponding tab bar item
	//		 selectedViewController = viewController
	//	 }
	//
	//
	//
	// }
	// */
 
 
 */

