//
//  HomeViewController.swift
//  twitterclone_swift
//
//  Created by may on 1/31/23.
//

import UIKit
import FirebaseAuth
import Combine

class HomeViewController: UIViewController {

	private var viewModel = HomeViewViewModel()
	private var subscriptions: Set<AnyCancellable> = []
	
	
//	private lazy var statusBarView = StatusBarView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height > 800 ? 50 : 25))
	
	private lazy var profileButton: UIButton = {
		let iconSize = 40.0
		let button = UIButton(type: .custom)
		NSLayoutConstraint.activate([
			button.widthAnchor.constraint(equalToConstant: iconSize),
			button.heightAnchor.constraint(equalToConstant: iconSize),
		])
		button.setImage(UIImage(named: "profile"), for: .normal)
		button.layer.cornerRadius = iconSize / 2
		button.clipsToBounds = true
		button.layer.masksToBounds = true
		button.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
		return button
	}()
	
	private let logoImageView: UIImageView = {
		//add logo in imageview
		let imageView = UIImageView(frame:CGRect(x: 0, y: 0, width: 30, height: 30))
		imageView.contentMode = .scaleAspectFill
		imageView.image = UIImage(named:"logo")
		return imageView
	}()
	
	
//	var isNavbarHidden: Bool = false {
//		didSet {
//			UIView.animate(withDuration: 0.3, delay: 1, options: .transitionCurlUp) { [weak self] in
//				if let state = self?.isNavbarHidden {
//					self?.statusBarView.layer.opacity = state ? 1 : 0
//					self?.navigationController?.navigationBar.isHidden = state
//				}
//			}
//		}
//	}
	private func configureNavbar(){
		
		navigationController?.hidesBarsOnSwipe = true

		// left nav item -> display photo
		navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileButton)
		
		// middle nav item -> title logo
		//view container for title
		let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
		// add imageview in uiview
		titleView.addSubview(logoImageView)
		//set nav title to the view created
		navigationItem.titleView = titleView
		
		//right nav item ->
		navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(didTapLogout))
	}
	
	@objc func didTapProfile(){
		print("profile")
		let vc = ProfileViewController()
		navigationController?.pushViewController(vc, animated: true)
		
	}
	
	@objc func didTapLogout(){
		try? Auth.auth().signOut()
		handleAuthentication()
	}

	private func handleAuthentication(){
		//when not authenticated
		if Auth.auth().currentUser == nil {
			let vc = UINavigationController(rootViewController: OnboardingViewController())
			vc.modalPresentationStyle = .fullScreen
			present(vc, animated: false)
		}
	}
	
	private func completeUserOnboarding(){
		let vc = ProfileDataViewController()
		present(vc, animated: true)
	}
	
	
	
	private func bindViews(){
		viewModel.$user.sink { [weak self] user in
			guard let user = user else {return}
			if !user.isUserOnboarded {
				self?.completeUserOnboarding()
			}
		}
		.store(in: &subscriptions)
		
	}
	
	private let homeBar = HomeBarView()
	private func configureHomeBar (){
		view.addSubview(homeBar)
		homeBar.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			homeBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			homeBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			homeBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			homeBar.heightAnchor.constraint(equalToConstant: 50)
		])
		
	}
	
	private let homefeedTable = PostTableView()
	private func configureHomefeedTable(){
		view.addSubview(homefeedTable)
		homefeedTable.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			homefeedTable.topAnchor.constraint(equalTo: homeBar.bottomAnchor),
			homefeedTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			homefeedTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			homefeedTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground
		configureNavbar()
		configureHomeBar()
		configureHomefeedTable()
		
		bindViews()

    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
	}
	
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.isHidden = false
		
		//removes horizontal divider
		navigationController?.navigationBar.shadowImage = UIImage()
		navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
		
		
		handleAuthentication()
		viewModel.retreiveUser()
	}

}

extension HomeViewController: UIScrollViewDelegate{

//	func scrollViewDidScroll(_ scrollView: UIScrollView) {
//		guard let navigationBar = navigationController?.navigationBar else {return}
//		let offset = scrollView.contentOffset.y
//		if offset > 20 && !navigationBar.isHidden {
//			navigationBar.frame.origin.y = -offset
//			homeTabVC.tabBar.frame.origin.y = view.frame.height - homeTabVC.tabBar.frame.height
//		} else {
//			navigationBar.frame.origin.y = 0
//			homeTabVC.tabBar.frame.origin.y = view.frame.height - homeTabVC.tabBar.frame.height - offset
//		}
//	}
}





/*
 //
 //  HomeViewController.swift
 //  twitterclone_swift
 //
 //  Created by may on 1/31/23.
 //

 import UIKit
 import FirebaseAuth
 import Combine

 class HomeViewController: UIViewController {

	 private var viewModel = HomeViewViewModel()
	 private var subscriptions: Set<AnyCancellable> = []
	 
	 
 //	private lazy var statusBarView = StatusBarView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height > 800 ? 50 : 25))
	 
	 private lazy var profileButton: UIButton = {
		 let iconSize = 40.0
		 let button = UIButton(type: .custom)
		 NSLayoutConstraint.activate([
			 button.widthAnchor.constraint(equalToConstant: iconSize),
			 button.heightAnchor.constraint(equalToConstant: iconSize),
		 ])
		 button.setImage(UIImage(named: "profile"), for: .normal)
		 button.layer.cornerRadius = iconSize / 2
		 button.clipsToBounds = true
		 button.layer.masksToBounds = true
		 button.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
		 return button
	 }()
	 
	 private let logoImageView: UIImageView = {
		 //add logo in imageview
		 let imageView = UIImageView(frame:CGRect(x: 0, y: 0, width: 30, height: 30))
		 imageView.contentMode = .scaleAspectFill
		 imageView.image = UIImage(named:"logo")
		 return imageView
	 }()
	 
	 
 //	var isNavbarHidden: Bool = false {
 //		didSet {
 //			UIView.animate(withDuration: 0.3, delay: 1, options: .transitionCurlUp) { [weak self] in
 //				if let state = self?.isNavbarHidden {
 //					self?.statusBarView.layer.opacity = state ? 1 : 0
 //					self?.navigationController?.navigationBar.isHidden = state
 //				}
 //			}
 //		}
 //	}
	 private func configureNavbar(){

		 // left nav item -> display photo
		 navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileButton)
		 
		 // middle nav item -> title logo
		 //view container for title
		 let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
		 // add imageview in uiview
		 titleView.addSubview(logoImageView)
		 //set nav title to the view created
		 navigationItem.titleView = titleView
		 
		 //right nav item ->
		 navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(didTapLogout))
	 }
	 
	 @objc func didTapProfile(){
		 print("profile")
		 let vc = ProfileViewController()
		 navigationController?.pushViewController(vc, animated: true)
		 
	 }
	 
	 @objc func didTapLogout(){
		 try? Auth.auth().signOut()
		 handleAuthentication()
	 }

	 private func handleAuthentication(){
		 //when not authenticated
		 if Auth.auth().currentUser == nil {
			 let vc = UINavigationController(rootViewController: OnboardingViewController())
			 vc.modalPresentationStyle = .fullScreen
			 present(vc, animated: false)
		 }
	 }
	 
	 private func completeUserOnboarding(){
		 let vc = ProfileDataViewController()
		 present(vc, animated: true)
	 }
	 
	 
	 
	 private func bindViews(){
		 viewModel.$user.sink { [weak self] user in
			 guard let user = user else {return}
			 if !user.isUserOnboarded {
				 self?.completeUserOnboarding()
			 }
		 }
		 .store(in: &subscriptions)
		 
	 }
	 

	 
	 private let homeTabContainerView = UIView()
	 private let homeTabViewController = HomeTabBarController()

	 var previousScrollViewYOffset: CGFloat = 0
	 
	 override func viewDidLoad() {
		 super.viewDidLoad()
		 configureNavbar()
		 view.backgroundColor = .systemBackground
		 
		 
		 // Add the homeTabContainerView to the HomeViewController's view
		 view.addSubview(homeTabContainerView)
		 
		 
		 // Add the homeTabViewController as a child view controller
		 addChild(homeTabViewController)
		 homeTabContainerView.addSubview(homeTabViewController.view)
		 homeTabViewController.didMove(toParent: self)
		 homeTabViewController.view.translatesAutoresizingMaskIntoConstraints = false
		 NSLayoutConstraint.activate([
			 homeTabViewController.tabBar.topAnchor.constraint(equalTo: homeTabContainerView.topAnchor),
			 homeTabViewController.tabBar.leadingAnchor.constraint(equalTo: homeTabContainerView.leadingAnchor),
			 homeTabViewController.tabBar.trailingAnchor.constraint(equalTo: homeTabContainerView.trailingAnchor),
			 homeTabViewController.tabBar.heightAnchor.constraint(equalToConstant: 50),
			 
			 
			 homeTabViewController.view.leadingAnchor.constraint(equalTo: homeTabContainerView.leadingAnchor),
			 homeTabViewController.view.trailingAnchor.constraint(equalTo: homeTabContainerView.trailingAnchor),
			 homeTabViewController.view.topAnchor.constraint(equalTo: homeTabContainerView.topAnchor),
			 homeTabViewController.view.bottomAnchor.constraint(equalTo: homeTabContainerView.bottomAnchor)
		   
		 ])
		 homeTabViewController.tabBar.backgroundColor = .green
		 homeTabContainerView.backgroundColor = .brown
		 print(homeTabContainerView)

		 // Set the delegate for the scroll view inside the HomeTabBarController
		 if let scrollView = homeTabViewController.view.subviews.first as? UIScrollView {
			 scrollView.delegate = self
		 }
		 
		 
		 bindViews()

	 }
	 override func viewDidLayoutSubviews() {
		 super.viewDidLayoutSubviews()
		 homeTabContainerView.frame = view.safeAreaLayoutGuide.layoutFrame
		 // Make the tab bar transparent
		 homeTabViewController.tabBar.isTranslucent = true
		 homeTabViewController.tabBar.backgroundImage = UIImage()
		 homeTabViewController.tabBar.shadowImage = UIImage()
	 }
	 
	 
	 
	 override func viewWillAppear(_ animated: Bool) {
		 super.viewWillAppear(animated)
		 navigationController?.navigationBar.isHidden = false
		 handleAuthentication()
		 viewModel.retreiveUser()
	 }

 }

 extension HomeViewController: UIScrollViewDelegate{

	 func scrollViewDidScroll(_ scrollView: UIScrollView) {
		 guard let navigationBar = navigationController?.navigationBar else {return}
		 let offset = scrollView.contentOffset.y
		 if offset > 0 {
			 navigationBar.frame.origin.y = -offset
			 homeTabViewController.tabBar.frame.origin.y = view.frame.height - homeTabViewController.tabBar.frame.height
		 } else {
			 navigationBar.frame.origin.y = 0
			 homeTabViewController.tabBar.frame.origin.y = view.frame.height - homeTabViewController.tabBar.frame.height - offset
		 }
	 }
 }





 */
