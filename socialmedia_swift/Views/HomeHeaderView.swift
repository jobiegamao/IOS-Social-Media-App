//
//  HomeHeaderView.swift
//  socialmedia_swift
//
//  Created by may on 2/7/23.
//

import UIKit

class HomeHeaderView: UIView {

	private var tabs: [UIButton] = ["For you", "Following"].map {
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
		stack.distribution = .fillEqually
		stack.spacing = 5.0
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
			
			tabsStack.topAnchor.constraint(equalTo: topAnchor, constant: 30),
//			tabsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
//			tabsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
			tabsStack.widthAnchor.constraint(equalTo: widthAnchor),
			tabsStack.heightAnchor.constraint(equalToConstant: 40.0),
			
			indicatorForTab.topAnchor.constraint(equalTo: tabsStack.bottomAnchor),
			indicatorForTab.heightAnchor.constraint(equalToConstant: 3),
			indicatorLeadTrail[0].leading,
			indicatorLeadTrail[0].trailing,
			
			
		])
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .clear
		
		addSubview(tabsStack)
		addSubview(indicatorForTab)
		
		configureTabsStackBtns()
		configureConstraints()
		
	}
	
	required init?(coder: NSCoder) {
		fatalError()
	}

}
