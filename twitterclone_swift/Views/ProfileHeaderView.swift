//
//  ProfileHeaderView.swift
//  twitterclone_swift
//
//  Created by may on 2/4/23.
//

import UIKit

class ProfileHeaderView: UIView {
	
	let headerImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.image = UIImage(named: "header")
		imageView.clipsToBounds = true
		imageView.layer.masksToBounds = true
		
		return imageView
	}()
	
	private let avatarImageView: UIImageView = {
		let imageView = UIImageView()
		let circleSize = 100.0
		imageView.contentMode = .scaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.image = UIImage(named: "profile")
		imageView.clipsToBounds = true
		NSLayoutConstraint.activate([
			imageView.widthAnchor.constraint(equalToConstant: circleSize),
			imageView.heightAnchor.constraint(equalToConstant: circleSize),
		])
		imageView.layer.cornerRadius = circleSize / 2
		imageView.layer.borderColor = UIColor.systemBackground.cgColor
		imageView.layer.borderWidth = 2
		
		return imageView
	}()
	
	private let displaynameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 25, weight: .bold)
		label.textColor = .label
		label.text = "Jane Doe"
		
		return label

	}()
	
	private let usernameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 18, weight: .regular)
		label.textColor = .secondaryLabel
		label.text = "@janethefabulousDoe"
		
		return label

	}()
	
	private let userbioLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 18, weight: .regular)
		label.textColor = .label
		label.text = "This is the tweet post. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
		label.numberOfLines = 3
		return label

	}()
	
	
	private let joineddateView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15))
		imageView.tintColor = .secondaryLabel
		
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 16, weight: .regular)
		label.textColor = .secondaryLabel
		label.text = "Joined February 2023"
		
		view.addSubview(imageView)
		view.addSubview(label)
		
		NSLayoutConstraint.activate([
			label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
			label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
		])
		
		return view

	}()
	
	
	
	
	
	private func configureConstraints(){
		NSLayoutConstraint.activate([
			headerImageView.widthAnchor.constraint(equalTo: widthAnchor),
			headerImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/3),
			
			avatarImageView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: -30),
			avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			
			displaynameLabel.leftAnchor.constraint(equalTo: avatarImageView.leftAnchor),
			displaynameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10),
			
			usernameLabel.leftAnchor.constraint(equalTo: avatarImageView.leftAnchor),
			usernameLabel.topAnchor.constraint(equalTo: displaynameLabel.bottomAnchor, constant: 5),
			
			userbioLabel.leftAnchor.constraint(equalTo: avatarImageView.leftAnchor),
			userbioLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5),
			userbioLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
			
			joineddateView.leftAnchor.constraint(equalTo: avatarImageView.leftAnchor),
			joineddateView.topAnchor.constraint(equalTo: userbioLabel.bottomAnchor, constant: 10)
			
			
		])

	}
	override init(frame: CGRect) {
		super.init(frame: frame)

		addSubview(headerImageView)
		addSubview(avatarImageView)
		addSubview(displaynameLabel)
		addSubview(usernameLabel)
		addSubview(userbioLabel)
		addSubview(joineddateView)

		
		configureConstraints()
		
	}
	
	
	
	required init?(coder: NSCoder) {
		fatalError()
	}

}
