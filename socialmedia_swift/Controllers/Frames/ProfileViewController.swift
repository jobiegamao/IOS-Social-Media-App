//
//  ProfileViewController.swift
//  twitterclone_swift
//
//  Created by may on 2/4/23.
//

import UIKit

class ProfileViewController: UIViewController {
	
//	statusbar to appear on scroll only
//	updated by viewdidscroll
	private var isStatusBarHidden = true
	private let statusBar: UIView = {
		let view = UIView()
		view.backgroundColor = .systemBackground
		view.layer.opacity = 0
		view.layer.zPosition = 99
		return view
	}()

	private let profileTableView: UITableView = {
		let table = UITableView()
		table.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
		table.translatesAutoresizingMaskIntoConstraints = false
		table.rowHeight = UITableView.automaticDimension
		return table
	}()
	
	lazy private var headerView: UIView = {
		let view = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height * 1/2))
		return view
	}()
	
	private func configureConstraints(){
		NSLayoutConstraint.activate([
			profileTableView.widthAnchor.constraint(equalTo: view.widthAnchor)
		])
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = .systemBackground
		
		view.addSubview(statusBar)
		view.addSubview(profileTableView)
		profileTableView.delegate = self
		profileTableView.dataSource = self
		
		profileTableView.tableHeaderView = headerView
		configureConstraints()
		
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		profileTableView.frame = view.frame
		statusBar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height > 800 ? 50 : 25)

	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
		profileTableView.contentInsetAdjustmentBehavior = .never
		
		tabBarController?.tabBar.isTranslucent = true
		tabBarController?.tabBar.backgroundColor = .systemBackground
		
		
		 
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.setNavigationBarHidden(false, animated: animated)
		tabBarController?.tabBar.isTranslucent = true
		tabBarController?.tabBar.barTintColor = UIColor.systemBackground
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



