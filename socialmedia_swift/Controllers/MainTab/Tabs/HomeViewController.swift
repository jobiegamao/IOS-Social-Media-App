//
//  HomeViewController.swift
//  twitterclone_swift
//
//  Created by may on 1/31/23.
//

import UIKit

class HomeViewController: UIViewController {

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
	}
	
	@objc func didTapProfile(){
		print("profile")
		let vc = ProfileViewController()
		navigationController?.pushViewController(vc, animated: true)
		
	}
	
	private func configureConstraints(){
		
		NSLayoutConstraint.activate([
			
		])
	}
	
	private let homefeedTable: UITableView = {
		let tableView = UITableView()
//		when in test
//		table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
		
		return tableView
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		configureNavbar()
		view.addSubview(homefeedTable)
		homefeedTable.delegate = self
		homefeedTable.dataSource = self
		configureConstraints()
		
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		homefeedTable.frame = view.bounds
		
	}
    

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
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
		print("button tapped")
	}
	
	func postTableViewCellDelegateDidTapRetweet() {
		print("button tapped")
	}
	
	func postTableViewCellDelegateDidTapLike() {
		print("button tapped")
	}
	
	func postTableViewCellDelegateDidTapShare() {
		print("button tapped")
	}
	
	
}
