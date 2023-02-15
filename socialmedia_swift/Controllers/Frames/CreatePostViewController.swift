//
//  CreatePostViewController.swift
//  socialmedia_swift
//
//  Created by may on 2/13/23.
//

import UIKit

class CreatePostViewController: UIViewController {
	
	private func configureNavbar(){
		let cancelBtn =  UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
		cancelBtn.tintColor = .label
		navigationItem.leftBarButtonItem = cancelBtn
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: postBtn)
	}

	private lazy var postBtn: CustomOvalButton = {
		let btn = CustomOvalButton(frame: .zero, primaryAction: nil, title: "Tweet", height: 30)
		btn.titleLabel?.font = .systemFont(ofSize: 15  , weight: .bold)
		btn.widthAnchor.constraint(equalToConstant: 80).isActive = true
		return btn
	}()
	
	private lazy var profileButton: UIButton = {
		let iconSize = 40.0
		let button = UIButton(type: .custom)
		button.translatesAutoresizingMaskIntoConstraints = false
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
	
	
	
	@objc func didTapProfile(){
		let vc = ProfileViewController()
		navigationController?.pushViewController(vc, animated: true)
	}
	
	private lazy var chooseBtn: UIButton = {
		
		var config = UIButton.Configuration.plain()
		config.image = UIImage(systemName: "chevron.down")
		config.imagePadding = 3
		config.imagePlacement = .trailing
		config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .medium)
		config.cornerStyle = .large
		
		let btn = UIButton(configuration: config)
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setTitle("All Followers", for: .normal)
		btn.setTitleColor(UIColor(named: "AccentColorBlue"), for: .normal)
		btn.titleLabel?.font = .systemFont(ofSize: 10, weight: .heavy)
		btn.layer.borderWidth = 1
		btn.layer.borderColor = UIColor(named: "AccentColorBlue")?.cgColor
		btn.layer.cornerRadius = 15
		btn.layer.masksToBounds = true
		
		btn.widthAnchor.constraint(equalToConstant: 150).isActive = true
		btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
		return btn
	}()
	
	private lazy var postTextView: CustomTextView = {
		let tv = CustomTextView(placeholder: "What's poppin in this world ey?")
		tv.layer.borderWidth = 0
		tv.padding = 0
		tv.placeholderLabel.textColor = .label
		tv.backgroundColor = .systemBackground
		
		return tv
	}()
	
	private func configurePostTextView(){
		
		view.addSubview(profileButton)
		view.addSubview(chooseBtn)
		view.addSubview(postTextView)
		NSLayoutConstraint.activate([
			profileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
			profileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			
			chooseBtn.centerYAnchor.constraint(equalTo: profileButton.centerYAnchor),
			chooseBtn.leadingAnchor.constraint(equalTo: profileButton.trailingAnchor, constant: 5),
			
			postTextView.leftAnchor.constraint(equalTo: profileButton.rightAnchor),
			postTextView.topAnchor.constraint(equalTo: profileButton.bottomAnchor),
			postTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			postTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
		])
	}
	
	@objc private func didTapCancel(){
		dismiss(animated: true)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground
		
		configureNavbar()
		configurePostTextView()
    }


}
