//
//  PostTableView.swift
//  socialmedia_swift
//
//  Created by may on 2/12/23.
//

import UIKit

class PostTableView: UITableView, UITableViewDataSource, UITableViewDelegate {

	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
		dataSource = self
		delegate = self
		register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 20
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
	
		//as there is delegate in each cell
		cell.delegate = self
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	required init?(coder aDecoder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

}

extension PostTableView: PostTableViewCellDelegate {
	
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
