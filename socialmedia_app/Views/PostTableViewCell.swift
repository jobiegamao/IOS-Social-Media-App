//
//  PostTableViewCell.swift
//  twitterclone_swift
//
//  Created by may on 2/3/23.
//

import UIKit

protocol PostTableViewCellDelegate: AnyObject {
	func postTableViewCellDelegateDidTapReply()
	func postTableViewCellDelegateDidTapRetweet()
	func postTableViewCellDelegateDidTapLike()
	func postTableViewCellDelegateDidTapShare()
}

class PostTableViewCell: UITableViewCell {

	static let identifier = "PostTableViewCell"
	
	weak var delegate: PostTableViewCellDelegate?
	
	private let avatarImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.layer.cornerRadius = 25
		imageView.layer.masksToBounds = true
		imageView.clipsToBounds = true
		imageView.backgroundColor = .darkGray
		imageView.image = UIImage(named: "profile")
		return imageView
	}()
	
	private let displaynameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 20, weight: .bold)
		label.textColor = .label
		label.text = "Jane"
		
		
		return label

	}()
	
	private let usernameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 19, weight: .light)
		label.textColor = .secondaryLabel
		label.text = "@Jane.Doe"
		
		return label

	}()
	
	private let postTimeLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 18, weight: .light)
		label.textColor = .secondaryLabel
		label.text = "\u{2022} 20m"
		
		return label

	}()
	
	private let postParagraphLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 18, weight: .regular)
		label.textColor = .label
		label.text = "This is the tweet post. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
		label.numberOfLines = 0
		label.lineBreakMode = .byWordWrapping
		label.setContentHuggingPriority(.defaultLow, for: .vertical)
		
		return label

	}()
	
	private let replyBtn: UIButton = {
		let btn = UIButton(type: .system)
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setImage(UIImage(named: "reply"), for: .normal)
		btn.tintColor = .secondaryLabel
		
		return btn
	}()
	
	private let retweetBtn: UIButton = {
		let btn = UIButton(type: .system)
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setImage(UIImage(named: "retweet"), for: .normal)
		btn.tintColor = .secondaryLabel
		
		return btn
	}()
	
	private let likeBtn: UIButton = {
		let btn = UIButton(type: .system)
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setImage(UIImage(systemName: "heart"), for: .normal)
		btn.setImage(UIImage(systemName: "heart.fill"), for: .selected)
		btn.tintColor = .secondaryLabel
		
		return btn
	}()
	
	private let shareBtn: UIButton = {
		let btn = UIButton(type: .system)
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setImage(UIImage(named: "share"), for: .normal)
		btn.tintColor = .secondaryLabel
		
		return btn
	}()
	
	private func configureConstraints(){
		
		// Texts
		NSLayoutConstraint.activate([
			avatarImageView.widthAnchor.constraint(equalToConstant: 50),
			avatarImageView.heightAnchor.constraint(equalToConstant: 50),
			avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
			
			displaynameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 5),
			displaynameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
			
			usernameLabel.leadingAnchor.constraint(equalTo: displaynameLabel.trailingAnchor),
			usernameLabel.bottomAnchor.constraint(equalTo: displaynameLabel.bottomAnchor),
			
			postTimeLabel.leadingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
			postTimeLabel.bottomAnchor.constraint(equalTo: displaynameLabel.bottomAnchor),
			
			postParagraphLabel.leftAnchor.constraint(equalTo: displaynameLabel.leftAnchor),
			postParagraphLabel.topAnchor.constraint(equalTo: displaynameLabel.bottomAnchor, constant: 5),
			postParagraphLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//			postParagraphLabel.heightAnchor.constraint(equalToConstant: 50),
			
		])
		
		// Buttons
		let btnSpacing: CGFloat = 90
		NSLayoutConstraint.activate([
			replyBtn.topAnchor.constraint(equalTo: postParagraphLabel.bottomAnchor, constant: 20),
			replyBtn.leftAnchor.constraint(equalTo: displaynameLabel.leftAnchor),
			replyBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
			
			retweetBtn.centerYAnchor.constraint(equalTo: replyBtn.centerYAnchor),
			retweetBtn.leftAnchor.constraint(equalTo: displaynameLabel.leftAnchor, constant: btnSpacing * 1),
			retweetBtn.bottomAnchor.constraint(equalTo: replyBtn.bottomAnchor),
			
			likeBtn.centerYAnchor.constraint(equalTo: replyBtn.centerYAnchor),
			likeBtn.leftAnchor.constraint(equalTo: displaynameLabel.leftAnchor, constant: btnSpacing * 2),
			likeBtn.bottomAnchor.constraint(equalTo: replyBtn.bottomAnchor),
			
			shareBtn.centerYAnchor.constraint(equalTo: replyBtn.centerYAnchor),
			shareBtn.leftAnchor.constraint(equalTo: displaynameLabel.leftAnchor, constant: btnSpacing * 3),
			shareBtn.bottomAnchor.constraint(equalTo: replyBtn.bottomAnchor),
		])
	}
	
	@objc func didTapReply(){
		delegate?.postTableViewCellDelegateDidTapReply()
	}
	@objc func didTapRetweet(){
		delegate?.postTableViewCellDelegateDidTapRetweet()
	}
	@objc func didTapLike(){
		delegate?.postTableViewCellDelegateDidTapLike()
	}
	@objc func didTapShare(){
		delegate?.postTableViewCellDelegateDidTapShare()
	}
	
	private func configureButtons(){
		replyBtn.addTarget(self, action: #selector(didTapReply), for: .touchUpInside)
		replyBtn.addTarget(self, action: #selector(didTapRetweet), for: .touchUpInside)
		replyBtn.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
		replyBtn.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
	}

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
//		contentView.backgroundColor = .purple
		
		contentView.addSubview(avatarImageView)
		contentView.addSubview(displaynameLabel)
		contentView.addSubview(usernameLabel)
		contentView.addSubview(postTimeLabel)
		contentView.addSubview(postParagraphLabel)
		contentView.addSubview(replyBtn)
		contentView.addSubview(retweetBtn)
		contentView.addSubview(likeBtn)
		contentView.addSubview(shareBtn)
	
		configureConstraints()
		configureButtons()
	}
	
	
	required init?(coder: NSCoder) {
		fatalError()
	}
}
