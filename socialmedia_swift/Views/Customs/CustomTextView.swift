//
//  CustomTextView.swift
//  socialmedia_swift
//
//  Created by may on 2/8/23.
//

import UIKit


class CustomTextView: UITextView {
	
	var padding: CGFloat = 5.0
	var borderColor: UIColor = UIColor.systemGray4
	var selectedBorderColor: UIColor? = UIColor(named: "AccentColorBlue")
	var bcgColor: UIColor = .secondarySystemFill
	
	lazy var placeholderLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .lightGray
		return label
	}()
	
	
	 init(placeholder: String, fontSize: Double = 17.0) {
		super.init(frame: .zero, textContainer: nil)
		 
		self.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundColor = bcgColor
		self.layer.cornerRadius = 8
		self.layer.masksToBounds = true
		self.layer.borderWidth = 1
		self.layer.borderColor = borderColor.cgColor
		
		self.textColor = .label
		self.font = .systemFont(ofSize: fontSize)
		self.textContainerInset = .init(top: padding * 2, left: padding, bottom: padding, right: padding)
		
		self.addSubview(placeholderLabel)
		self.placeholderLabel.text = placeholder
		placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
		placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
		
		// add listener
		self.delegate = self
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
}

extension CustomTextView: UITextViewDelegate {
	
	func textViewDidBeginEditing(_ textView: UITextView) {
		print("CustomTextView UITextViewDelegate")
		placeholderLabel.isHidden = true
		layer.borderColor = selectedBorderColor?.cgColor
		
		// Add content offset on the parent scroll view if there is
		if let parent = self.superview as? UIScrollView {
			if let isPortrait = self.window?.windowScene?.interfaceOrientation.isPortrait{
				let offsetY: Double = isPortrait ? 200 : 25
				parent.setContentOffset(CGPoint(x: 0, y: self.frame.origin.y - offsetY), animated: true)
			}
		}
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {
		if textView.text.isEmpty {
			placeholderLabel.isHidden = false
		}
		layer.borderColor = borderColor.cgColor
		
		//return scrollview back
		if let parent = self.superview as? UIScrollView {
			parent.setContentOffset(
				CGPoint(x: 0, y: 0), animated: true)
		}
	}
}




