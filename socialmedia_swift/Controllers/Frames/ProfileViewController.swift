//
//  ProfileViewController.swift
//  twitterclone_swift
//
//  Created by may on 2/4/23.
//

import UIKit
import Combine
import SDWebImage

class ProfileViewController: UIViewController {
	
	private let viewModel = ProfileViewViewModel()
	private var subscriptions: Set<AnyCancellable> = []
	
	//statusbar to appear on scroll only. updated by viewdidscroll
	private var isStatusBarHidden = true
	private lazy var statusBar = StatusBarView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height > 800 ? 50 : 25))

	private let profileTableView: UITableView = {
		let table = UITableView()
		table.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
		table.translatesAutoresizingMaskIntoConstraints = false
		table.rowHeight = UITableView.automaticDimension
		return table
	}()
	
	private lazy var headerView = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height * 1/2 + 20))
	
	private func configureConstraints(){
		NSLayoutConstraint.activate([
		])
	}
	
	private func bindViews(){
		viewModel.$user.sink { [weak self] userAccount in
			guard let user = userAccount, let header = self?.headerView else {return}
			
			header.avatarImageView.sd_setImage(with: URL(string: user.avatarPath), placeholderImage: UIImage(named: "profile"), context: [:])
			header.displaynameLabel.text = user.displayName
			header.usernameLabel.text = "@" + user.username
			header.followersCount.text = "\(user.followersCount)"
			header.followingCount.text = "\(user.followingCount)"
			header.userbioLabel.text = user.bio
			header.joineddateLabel.text = "Joined " + (self?.viewModel.getFormattedDate(date: user.createdOn) ?? "today")
		}
		.store(in: &subscriptions)
		
	}
	
	private func configureProfileTable(){
		profileTableView.tableHeaderView = headerView
		view.addSubview(profileTableView)
		profileTableView.delegate = self
		profileTableView.dataSource = self
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = .systemBackground
		
		self.navigationController?.view.addSubview(statusBar)
		
		configureProfileTable()
		configureConstraints()
		bindViews()
		
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		profileTableView.frame = view.frame
	}

	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
		profileTableView.contentInsetAdjustmentBehavior = .never
		
		viewModel.retreiveUser()
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.setNavigationBarHidden(false, animated: animated)
	}
	

}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else {return UITableViewCell() }
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let yPositionScroll = scrollView.contentOffset.y

		if yPositionScroll > (view.bounds.height * 1/15) && isStatusBarHidden {
			isStatusBarHidden = false
			UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) {
				[weak self] in
				self?.statusBar.layer.opacity = 1
			}
		} else if yPositionScroll < 0 && !isStatusBarHidden {
			isStatusBarHidden = true
			UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) {
				[weak self] in
				self?.statusBar.layer.opacity = 0
			}
		}
	}
}



