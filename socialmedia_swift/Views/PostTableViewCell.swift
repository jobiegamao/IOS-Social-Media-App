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
		label.text = "Jane Doe"
		
		
		return label

	}()
	
	private let usernameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 19, weight: .light)
		label.textColor = .secondaryLabel
		label.text = "@janethefabulousDoe"
		label.numberOfLines = 1
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
	
	private var buttons: [UIButton] = ["reply", "retweet", "heart", "share"].map {
		buttonImage in
	
		let btn = UIButton(type: .system)
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setImage(UIImage(named: buttonImage), for: .normal)
		btn.tintColor = .secondaryLabel
		
		return btn
	}
	
	lazy private var buttonsStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: self.buttons)
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.distribution = .equalSpacing
		stack.alignment = .center
		stack.axis = .horizontal
		
		return stack
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
			
			usernameLabel.leadingAnchor.constraint(equalTo: displaynameLabel.trailingAnchor, constant: 1),
			usernameLabel.bottomAnchor.constraint(equalTo: displaynameLabel.bottomAnchor),
			usernameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 150),
			
			postTimeLabel.leadingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
			postTimeLabel.bottomAnchor.constraint(equalTo: displaynameLabel.bottomAnchor),
			
			postParagraphLabel.leftAnchor.constraint(equalTo: displaynameLabel.leftAnchor),
			postParagraphLabel.topAnchor.constraint(equalTo: displaynameLabel.bottomAnchor, constant: 5),
			postParagraphLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
			
			buttonsStack.topAnchor.constraint(equalTo: postParagraphLabel.bottomAnchor, constant: 20),
			buttonsStack.leftAnchor.constraint(equalTo: displaynameLabel.leftAnchor),
			buttonsStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
			buttonsStack.rightAnchor.constraint(equalTo: postParagraphLabel.rightAnchor, constant: -10)

			
			
		])
		
	}
	
	
	private func configureButtons(){
		
		for (idx,btn) in buttonsStack.arrangedSubviews.enumerated() {
			guard let btn = btn as? UIButton else {return}
			btn.tag = idx
			btn.addTarget(self, action: #selector(didTapTabBtn(_:)), for: .touchUpInside)
		}
	}
	
	@objc private func didTapTabBtn(_ sender: UIButton){
		switch sender.tag{
			case 0:
				delegate?.postTableViewCellDelegateDidTapReply()
			case 1:
				delegate?.postTableViewCellDelegateDidTapRetweet()
			case 2:
				delegate?.postTableViewCellDelegateDidTapLike()
			case 3:
				delegate?.postTableViewCellDelegateDidTapShare()
			default:
				break
				
		}
	}

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
//		contentView.backgroundColor = .purple
		
		contentView.addSubview(avatarImageView)
		contentView.addSubview(displaynameLabel)
		contentView.addSubview(usernameLabel)
		contentView.addSubview(postTimeLabel)
		contentView.addSubview(postParagraphLabel)
		contentView.addSubview(buttonsStack)

		configureButtons()
		configureConstraints()
		
	}
	
	
	required init?(coder: NSCoder) {
		fatalError()
	}
}
