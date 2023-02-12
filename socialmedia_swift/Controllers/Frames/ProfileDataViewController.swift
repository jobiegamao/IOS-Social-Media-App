//
//  ProfileDataViewController.swift
//  socialmedia_swift
//
//  Created by may on 2/7/23.
//

import UIKit
import PhotosUI
import Combine

class ProfileDataViewController: UIViewController{

	private var viewModel = ProfileDataViewViewModel()
	private var subscriptions: Set<AnyCancellable> = []
	
	//properties for textView delegate
	var borderColor: UIColor = UIColor.systemGray4
	var selectedBorderColor: UIColor? = UIColor(named: "AccentColorBlue")

	
	private let scrollView: UIScrollView = {
		let view = UIScrollView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.alwaysBounceVertical = true //important!
		view.keyboardDismissMode = .onDrag
		
		return view
	}()
	
	private let textLabel: UILabel = {
		
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Fill in your data"
		label.font = .systemFont(ofSize: 32, weight: .bold)
		label.textColor = .label
		
		return label
	}()
	
	private lazy var avatarPlaceholderImageView: CustomCircleImageView = {
		let imageView = CustomCircleImageView(frame: .zero, size: 100)
		imageView.image = UIImage(systemName: "camera.fill")
		imageView.contentMode = .scaleAspectFit
		imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapUpload)))
		
		return imageView
	}()
	
	@objc func didTapUpload(){
		var config = PHPickerConfiguration()
		config.filter = .images //pick only photos
		config.selectionLimit = 1
		
		let picker = PHPickerViewController(configuration: config)
		picker.delegate = self
		present(picker, animated: true)
	}
	
	
	private let displaynameTextfield: CustomTextField = {
		let field = CustomTextField(placeholder: "Name")
		return field
	}()
	
	private let usernameTextfield: CustomTextField = {
		let field = CustomTextField(placeholder: "Username")
		return field
	}()
	
	private let bioTextview: CustomTextView = {
		let textView = CustomTextView(
			placeholder: "Describe yourself, in a positive look!")
		return textView
	}()
	
	private lazy var submitBtn: CustomOvalButton = {
		let btn = CustomOvalButton(title: "Submit & Save")
		btn.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
		return btn
	}()
	
	@objc func didUpdateDisplayname(){
		viewModel.displayName = displaynameTextfield.text
		viewModel.validateForm()
	}
	@objc func didUpdateUsername(){
		viewModel.username = usernameTextfield.text
		viewModel.validateForm()
	}
	@objc func didUpdateBio(){
		viewModel.bio = bioTextview.text
		viewModel.validateForm()
	}
	@objc func didTapSubmit(){
		viewModel.uploadAvatar()
	}
	
	private func bindViews(){
		displaynameTextfield.addTarget(self, action: #selector(didUpdateDisplayname), for: .editingChanged)
		usernameTextfield.addTarget(self, action: #selector(didUpdateUsername), for: .editingChanged)
		// for bio, textview has no addTarget, utilize textviewDidChange
		
		
		viewModel.$isFormValid.sink { [weak self] isFormValid in
			self?.submitBtn.isEnabled = isFormValid
		}
		.store(in: &subscriptions)
		
		
		viewModel.$isOnboardingDone.sink { [weak self] boolResult in
			if boolResult {
				self?.presentAlert()
				self?.dismiss(animated: true)
			}
		}
		.store(in: &subscriptions)
	}
	
	private func presentAlert(){
		let ac = UIAlertController(title: "Welcome \(displaynameTextfield.text!)", message: nil, preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "Let's Get Started!", style: .default))
		present(ac, animated: true)
	}
	
	private func configureConstraints(){
		
		let fieldSpacing = 20.0
		let margin = 30.0
		NSLayoutConstraint.activate([
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			scrollView.topAnchor.constraint(equalTo: view.topAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
												  
			textLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
			textLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
			
			avatarPlaceholderImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
			avatarPlaceholderImageView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 10),
			avatarPlaceholderImageView.widthAnchor.constraint(equalToConstant: 100),
			avatarPlaceholderImageView.heightAnchor.constraint(equalToConstant: 100),
			
			displaynameTextfield.topAnchor.constraint(equalTo: avatarPlaceholderImageView.bottomAnchor, constant: fieldSpacing + 10),
			displaynameTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: margin),
			displaynameTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -margin),
			
			usernameTextfield.topAnchor.constraint(equalTo: displaynameTextfield.bottomAnchor, constant: fieldSpacing),
			usernameTextfield.leftAnchor.constraint(equalTo: displaynameTextfield.leftAnchor),
			usernameTextfield.rightAnchor.constraint(equalTo: displaynameTextfield.rightAnchor),
			
			bioTextview.topAnchor.constraint(equalTo: usernameTextfield.bottomAnchor, constant: fieldSpacing),
			bioTextview.leftAnchor.constraint(equalTo: displaynameTextfield.leftAnchor),
			bioTextview.rightAnchor.constraint(equalTo: displaynameTextfield.rightAnchor),
			bioTextview.heightAnchor.constraint(equalToConstant: 150),
			
			submitBtn.leftAnchor.constraint(equalTo: displaynameTextfield.leftAnchor),
			submitBtn.rightAnchor.constraint(equalTo: displaynameTextfield.rightAnchor),
			submitBtn.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -fieldSpacing)
			
			
		])
	}
	
	func scrollViewsSubviews(){
		scrollView.addSubview(textLabel)
		scrollView.addSubview(avatarPlaceholderImageView)
		scrollView.addSubview(displaynameTextfield)
		scrollView.addSubview(usernameTextfield)
		scrollView.addSubview(bioTextview)
		scrollView.addSubview(submitBtn)
	}
	
	func setupViews(){
		//textview delegate for bio
		bioTextview.delegate = self
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .systemBackground
		view.addSubview(scrollView)
		
		// dont allow closing of modal view
		isModalInPresentation = true
		
		scrollViewsSubviews()
		
		setupViews()
		bindViews()
		configureConstraints()
    }

	
	

}


extension ProfileDataViewController: PHPickerViewControllerDelegate {
	func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
		picker.dismiss(animated: true)
		
		for result in results {
			result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
				if let image = object as? UIImage {
					DispatchQueue.main.async {
						self?.avatarPlaceholderImageView.image = image
						self?.avatarPlaceholderImageView.contentMode = .scaleAspectFill
						self?.viewModel.imageData = image
						self?.viewModel.validateForm()
					}
				}
			}
		}
				
		
	}
}

extension ProfileDataViewController: UITextViewDelegate {
	
	
	func textViewDidChange(_ textView: UITextView) {
		switch textView {
			case bioTextview:
				didUpdateBio()
			default:
				break
		}
	}
	
	func textViewDidBeginEditing(_ textView: UITextView) {
		bioTextview.placeholderLabel.isHidden = true
		textView.layer.borderColor = selectedBorderColor?.cgColor
		
		// Add content offset on the parent scroll view if there is
		if let isPortrait = textView.window?.windowScene?.interfaceOrientation.isPortrait {
			let offsetY: Double = isPortrait ? 200 : 25
			scrollView.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y - offsetY), animated: true)
		}
		
		
		
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {
		if textView.text.isEmpty {
			bioTextview.placeholderLabel.isHidden = false
		}
		textView.layer.borderColor = borderColor.cgColor
		
		//return scrollview back
		scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
		
	}
	
	
	
}


