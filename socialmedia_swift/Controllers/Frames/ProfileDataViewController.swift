//
//  ProfileDataViewController.swift
//  socialmedia_swift
//
//  Created by may on 2/7/23.
//

import UIKit
import PhotosUI

class ProfileDataViewController: UIViewController {

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
		let imageView = CustomCircleImageView(height: 100)
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
		let textView = CustomTextView(placeholder: "Describe yourself, in a positive look!")
		return textView
	}()
	
	private lazy var submitBtn: CustomOvalButton = {
		let btn = CustomOvalButton(title: "Submit & Save")
//		btn.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
		
		return btn
	}()
	
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
    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .systemBackground
		view.addSubview(scrollView)
		scrollView.addSubview(textLabel)
		scrollView.addSubview(avatarPlaceholderImageView)
		scrollView.addSubview(displaynameTextfield)
		scrollView.addSubview(usernameTextfield)
		scrollView.addSubview(bioTextview)
		scrollView.addSubview(submitBtn)
		configureConstraints()
		
		// dont allow closing of modal view
		isModalInPresentation = true
    }
	

}

extension ProfileDataViewController: PHPickerViewControllerDelegate {
	func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
		picker.dismiss(animated: true)
		
		let chosenImage = results[0]
		chosenImage.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
			if let image = object as? UIImage {
				DispatchQueue.main.async {
					self?.avatarPlaceholderImageView.image = image
					self?.avatarPlaceholderImageView.contentMode = .scaleAspectFill
				}
			}
		}
	}
	
	
}
