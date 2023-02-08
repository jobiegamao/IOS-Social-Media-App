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
	
	private var iconSize: CGFloat = 30
	
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
	
	private lazy var logoImageView: UIImageView = {
		//add logo in imageview
		let imageView = UIImageView(frame:CGRect(x: 0, y: 0, width: iconSize, height: iconSize))
		imageView.contentMode = .scaleAspectFill
		imageView.image = UIImage(named:"logo")
		return imageView
	}()
	
	
	private func configureNavbar(){

		// left nav item -> display photo
		navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileButton)
		
		// middle nav item -> title logo
		//view container for title
		let titleView = UIView(frame: CGRect(x: 0, y: 0, width: iconSize, height: iconSize))
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

	
	private lazy var headerView: UIView = {
		let view = HomeHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height * 1/8))
		view.backgroundColor = .clear
		return view
	}()
	
	private let homefeedTable: UITableView = {
		let tableView = UITableView()
//		when in test
//		table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
		
		return tableView
	}()
	
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
	
	private func configureConstraints(){
		
		NSLayoutConstraint.activate([
			
		])
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.addSubview(homefeedTable)
		homefeedTable.delegate = self
		homefeedTable.dataSource = self
		
		configureNavbar()
		configureConstraints()
		
		homefeedTable.tableHeaderView = headerView
		
		bindViews()

    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		homefeedTable.frame = view.bounds
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.isHidden = false
		handleAuthentication()
		viewModel.retreiveUser()
	}
	
	
	
	
	
    

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 20
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		whne in test
//		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//		cell.textLabel?.text = "text"
		guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
	
//		as there is delegate in each cell
		cell.delegate = self
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

extension HomeViewController: PostTableViewCellDelegate {
	
	func postTableViewCellDelegateDidTapReply() {
		print("reply tapped")
	}
	
	func postTableViewCellDelegateDidTapRetweet() {
		print("retweet tapped")
	}
	
	func postTableViewCellDelegateDidTapLike() {
		print("like tapped")
	}
	
	func postTableViewCellDelegateDidTapShare() {
		print("share tapped")
	}
	
	
}
