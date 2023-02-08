//
//  OnboardingViewController.swift
//  socialmedia_swift
//
//  Created by may on 2/5/23.
//

import UIKit

class OnboardingViewController: UIViewController {
	
	private let welcomeLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 32, weight: .heavy)
		label.textColor = .label
		label.text = "See what's happening in the world right now."
		label.textAlignment = .center
		label.numberOfLines = 0
		
		return label
		
	}()
	
	private lazy var signUpBtn: UIButton = {
		let btn = UIButton(type: .system)
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setTitle("Create Account", for: .normal)
		btn.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
		btn.backgroundColor = UIColor(named: "AccentColorBlue")
		btn.tintColor = .white
		btn.layer.cornerRadius = 30
		
		btn.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
		
		return btn
	}()
	
	@objc func didTapSignUp(){
		let vc = RegisterViewController()
		navigationController?.pushViewController(vc, animated: true)
	}
	
	private lazy var loginBtn: UIButton = {
		let btn = UIButton(type: .system)
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setTitle("Login", for: .normal)
		btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
		btn.tintColor = UIColor(named: "AccentColorBlue")
		
		btn.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
		
		return btn
	}()
	
	@objc func didTapLogin(){
		let vc = LoginViewController()
		navigationController?.pushViewController(vc, animated: true)
	}
	
	private let loginLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 14, weight: .regular)
		label.textColor = .label
		label.text = "Have an account already?"
		
		return label
	}()
	
	private lazy var loginView: UIStackView = {
		let view = UIStackView(arrangedSubviews: [loginLabel,loginBtn])
		view.translatesAutoresizingMaskIntoConstraints = false
		view.alignment = .center
		view.axis = .horizontal
		view.distribution = .fillProportionally
		loginBtn.leadingAnchor.constraint(
			equalTo: loginLabel.trailingAnchor, constant: 15).isActive = true
		
		
		return view
		
	}()
	
	private func configureConstraints(){
		NSLayoutConstraint.activate([
			welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			
			signUpBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			signUpBtn.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
			signUpBtn.widthAnchor.constraint(equalTo: welcomeLabel.widthAnchor, constant: -20),
			signUpBtn.heightAnchor.constraint(equalToConstant: 60),
			
			loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
			
		])
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground
		
		view.addSubview(welcomeLabel)
		view.addSubview(signUpBtn)
		view.addSubview(loginView)
		
        configureConstraints()
    }
    

    

}
