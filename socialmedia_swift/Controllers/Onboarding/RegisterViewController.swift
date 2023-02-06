//
//  RegisterViewController.swift
//  socialmedia_swift
//
//  Created by may on 2/6/23.
//

import UIKit
import Combine

class RegisterViewController: UIViewController {
	
	private var viewModel = AuthViewViewModel()
	private var subscriptions: Set<AnyCancellable> = []
	
	private let registerLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 30, weight: .heavy)
		label.textColor = .label
		label.text = "Create your account"
		
		return label
	}()
	
	private let emailTextfield: UITextField = {
		let field = UITextField()
		field.translatesAutoresizingMaskIntoConstraints = false
		field.backgroundColor = .systemBackground
		field.layer.cornerRadius = 8.0
		field.layer.masksToBounds = true
		field.layer.borderWidth = 1.0
		field.layer.borderColor = UIColor(named: "AccentColorBlue")?.cgColor
		
		//left padding in text
		field.leftView = UIView(
			frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: field.frame.height))
		field.leftViewMode = .always
		
		field.keyboardAppearance = .default
		field.keyboardType = .emailAddress
		field.placeholder = "Email"
		
		return field
	}()
	
	private let passwordTextfield: UITextField = {
		let field = UITextField()
		field.translatesAutoresizingMaskIntoConstraints = false
		
		field.backgroundColor = .systemBackground
		field.layer.cornerRadius = 8.0
		field.layer.masksToBounds = true
		field.layer.borderWidth = 1.0
		field.layer.borderColor = UIColor(named: "AccentColorBlue")?.cgColor
		field.keyboardAppearance = .default
		
		//left padding in text
		field.leftView = UIView(
			frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: field.frame.height))
		field.leftViewMode = .always
		
		
		field.placeholder = "Password"
		field.isSecureTextEntry = true
		
		return field
	}()
	
	lazy private var signUpBtn: UIButton = {
		let btn = UIButton(type: .system)
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setTitle("Create account", for: .normal)
		btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
		btn.backgroundColor = UIColor(named: "AccentColorBlue")
		btn.tintColor = .white
		btn.layer.cornerRadius = 25
		
		btn.isEnabled = false
		btn.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
		
		return btn
	}()
	
	@objc func didTapSignUp(){
		viewModel.createUser()
	}
	
	private func bindViews(){
		emailTextfield.addTarget(self, action: #selector(didChangeEmailField), for: .editingChanged)
		passwordTextfield.addTarget(self, action: #selector(didChangePasswordField), for: .editingChanged)
		
		// when $isAuthenticationValid changes
		// $ gets publisher itself
		// enables the create account btn
		viewModel.$isAuthenticationValid.sink { [weak self] isValid in
			self?.signUpBtn.isEnabled = isValid
		}
		.store(in: &subscriptions)
		
		// when $user changes
		// dismiss onboarding vc when account is created
		viewModel.$user.sink { [weak self] user in
			guard user != nil else {return}
			guard let vc = self?.navigationController?.viewControllers.first as? OnboardingViewController else {return}
			vc.dismiss(animated: true)
		}
		.store(in: &subscriptions)
		
		// when $error changes
		viewModel.$error.sink { [weak self] error in
			guard let error = error?.localizedDescription else {return}
			self?.presentAlert(with: error)
		}
		.store(in: &subscriptions)
	}
	
	private func presentAlert(with error: String){
		let ac = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
		let dismissBtn = UIAlertAction(title: "Ok", style: .cancel)
		ac.addAction(dismissBtn)
		present(ac, animated: true)
	}
	
	@objc func didChangeEmailField(){
		viewModel.email = emailTextfield.text
		viewModel.validateForm()
	}
	
	@objc func didChangePasswordField(){
		viewModel.password = passwordTextfield.text
		viewModel.validateForm()
	}
	
	@objc func didTapElsewhere(){
		view.endEditing(true)
	}
	
	private func configureConstraints(){
		let safe = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			registerLabel.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 30),
			registerLabel.topAnchor.constraint(equalTo: safe.topAnchor, constant: 100),
			
			emailTextfield.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: 30),
			emailTextfield.leftAnchor.constraint(equalTo: registerLabel.leftAnchor),
			emailTextfield.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -30),
			emailTextfield.heightAnchor.constraint(equalToConstant: 60),
			
			passwordTextfield.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor, constant: 20),
			passwordTextfield.leftAnchor.constraint(equalTo: emailTextfield.leftAnchor),
			passwordTextfield.rightAnchor.constraint(equalTo: emailTextfield.rightAnchor),
			passwordTextfield.heightAnchor.constraint(equalToConstant: 60),
			
			signUpBtn.rightAnchor.constraint(equalTo: passwordTextfield.rightAnchor),
			signUpBtn.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 20),
			signUpBtn.widthAnchor.constraint(equalToConstant: 180),
			signUpBtn.heightAnchor.constraint(equalToConstant: 50),
		])
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground
		
		// dismiss keyboard when outside is tapped
		view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapElsewhere)))
		
		
		view.addSubview(registerLabel)
		view.addSubview(emailTextfield)
		view.addSubview(passwordTextfield)
		view.addSubview(signUpBtn)
		
		configureConstraints()
		bindViews()

    }
    
}
