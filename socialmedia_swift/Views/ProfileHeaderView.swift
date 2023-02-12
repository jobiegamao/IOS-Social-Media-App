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
	
	private let avatarImageView: CustomCircleImageView = {
		let imageView = CustomCircleImageView(frame: .zero, size: 100)
		imageView.image = UIImage(named: "profile")
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
		label.numberOfLines = 2
		return label

	}()
	
	private var joineddateLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 16, weight: .regular)
		label.textColor = .secondaryLabel
		label.text = "Joined February 2023"
		
		return label
	}()
	
	
	lazy private var joineddateView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
		imageView.tintColor = .secondaryLabel
		
		let label = self.joineddateLabel
		
		view.addSubview(imageView)
		view.addSubview(label)
		
		NSLayoutConstraint.activate([
			label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
			label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
		])
		
		return view

	}()
	
	private var followingCount: UILabel = {
		let count = UILabel()
		count.translatesAutoresizingMaskIntoConstraints = false
		count.font = .systemFont(ofSize: 16, weight: .bold)
		count.textColor = .label
		count.text = "2.5K"
		
		return count
	}()
	
	private var followersCount: UILabel = {
		let count = UILabel()
		count.translatesAutoresizingMaskIntoConstraints = false
		count.font = .systemFont(ofSize: 16, weight: .bold)
		count.textColor = .label
		count.text = "1.4M"
		
		return count
	}()
	
	
	lazy private var followView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		
		let followingCount = self.followingCount
		let followingText = UILabel()
		followingText.translatesAutoresizingMaskIntoConstraints = false
		followingText.font = .systemFont(ofSize: 16, weight: .regular)
		followingText.textColor = .secondaryLabel
		followingText.text = "Following"
		
		view.addSubview(followingCount)
		view.addSubview(followingText)
		
		
		let followersCount = self.followersCount
		let followersText = UILabel()
		followersText.translatesAutoresizingMaskIntoConstraints = false
		followersText.font = .systemFont(ofSize: 16, weight: .regular)
		followersText.textColor = .secondaryLabel
		followersText.text = "Followers"
		
		view.addSubview(followersCount)
		view.addSubview(followersText)
		
		NSLayoutConstraint.activate([
			followingText.leadingAnchor.constraint(equalTo: followingCount.trailingAnchor, constant: 5),
			followingText.centerYAnchor.constraint(equalTo: followingCount.centerYAnchor),
			
			
			followersCount.leadingAnchor.constraint(equalTo: followingText.trailingAnchor, constant: 10),
			followersText.leadingAnchor.constraint(equalTo: followersCount.trailingAnchor, constant: 5),
			followersText.centerYAnchor.constraint(equalTo: followersCount.centerYAnchor)
		])
		
		return view

	}()
	
	private var tabs: [UIButton] = ["Tweets", "Tweets & Replies", "Media", "Likes"].map {
		buttonTitle in
		let btn = UIButton(type: .system)
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setTitle(buttonTitle, for: .normal)
		btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
		
		return btn
	}
	
	lazy private var tabsStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: self.tabs)
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.distribution = .equalSpacing
		stack.alignment = .center
		stack.axis = .horizontal
		
		return stack
	}()
	
	private func configureTabsStackBtns() {
		for (idx,btn) in tabsStack.arrangedSubviews.enumerated(){
			guard let btn = btn as? UIButton else {return}
			btn.tag = idx
			btn.tintColor = idx == 0 ? UIColor(named: "AccentColorBlue") : .secondaryLabel
			btn.addTarget(self, action: #selector(didTapTabBtn(_:)), for: .touchUpInside)
		}
	}
	
	private var indicatorLeadTrail: [(leading: NSLayoutConstraint, trailing: NSLayoutConstraint)] = []
	
	private let indicatorForTab: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor(named: "AccentColorBlue")
		
		return view
	}()
	
	private var selectedTabIndex: Int = 0 {
		didSet{
			for i in 0..<tabs.count{
				
				//add animation on change
				UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut) { [weak self] in
					// if i==selectedIndex then color is blue else gray
					self?.tabsStack.arrangedSubviews[i].tintColor = i == self?.selectedTabIndex ? UIColor(named: "AccentColorBlue") : .secondaryLabel
					
				}
				
				UIView.animate(withDuration: 0.4, delay: 1, options: .curveEaseIn) { [weak self] in
					
					// tabstack indicator
					// if selected, add the leading and trailing constraint for the indicator,
					// else turn off the constraint
					self?.indicatorLeadTrail[i].leading.isActive = i == self?.selectedTabIndex ? true : false
					self?.indicatorLeadTrail[i].trailing.isActive = i == self?.selectedTabIndex ? true : false
				
				}
				
			}
		}
	}
	
	@objc func didTapTabBtn(_ sender: UIButton){
		selectedTabIndex = sender.tag
	}
	
	
	
	private func configureConstraints(){
		
		// indicator size per tab
		for i in 0..<tabs.count {
			let leadingAnchor = indicatorForTab.leadingAnchor.constraint(equalTo: tabsStack.arrangedSubviews[i].leadingAnchor)
			let trailingAnchor = indicatorForTab.trailingAnchor.constraint(equalTo: tabsStack.arrangedSubviews[i].trailingAnchor)
			
			indicatorLeadTrail.append((leadingAnchor,trailingAnchor))
		}
		
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
			joineddateView.topAnchor.constraint(equalTo: userbioLabel.bottomAnchor, constant: 10),
			
			followView.leftAnchor.constraint(equalTo: avatarImageView.leftAnchor),
			followView.topAnchor.constraint(equalTo: joineddateView.bottomAnchor, constant: 25),
			
			tabsStack.topAnchor.constraint(equalTo: followView.bottomAnchor, constant: 30),
			tabsStack.leftAnchor.constraint(equalTo: avatarImageView.leftAnchor),
			tabsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
			tabsStack.heightAnchor.constraint(equalToConstant: 40.0),
			
			indicatorForTab.topAnchor.constraint(equalTo: tabsStack.bottomAnchor),
			indicatorForTab.heightAnchor.constraint(equalToConstant: 3),
			indicatorLeadTrail[0].leading,
			indicatorLeadTrail[0].trailing,
			
			
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
		addSubview(followView)
		addSubview(tabsStack)
		addSubview(indicatorForTab)
		
		configureTabsStackBtns()
		configureConstraints()
		
	}
	
	
	
	required init?(coder: NSCoder) {
		fatalError()
	}

}
