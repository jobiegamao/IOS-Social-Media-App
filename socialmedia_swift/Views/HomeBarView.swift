//
//  HomeBarView.swift
//  socialmedia_swift
//
//  Created by may on 2/12/23.
//

import UIKit

class HomeBarView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	private let homeBarTabs = ["For you", "Following"]

	private let tabsCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
		cv.translatesAutoresizingMaskIntoConstraints = false
		return cv
	}()
	private func configureCollectionView(){
		
		addSubview(tabsCollectionView)
		tabsCollectionView.delegate = self
		tabsCollectionView.dataSource = self
		NSLayoutConstraint.activate([
			tabsCollectionView.widthAnchor.constraint(equalTo: widthAnchor),
			tabsCollectionView.heightAnchor.constraint(equalTo: heightAnchor, constant: -5)
		])
		
		//sets selected tab to be For You
		let defaultSelected = IndexPath(item: 0, section: 0)
		tabsCollectionView.selectItem(at: defaultSelected, animated: true, scrollPosition: [])
		
		
		
	}
	
	
	private let indicatorBar: UIView = {
		let b = UIView()
		b.backgroundColor = UIColor(named: "AccentColorBlue")
		b.layer.cornerRadius = 2.5
		return b
	}()
	
	
	override init(frame: CGRect){
		super.init(frame: frame)
		backgroundColor = .systemBackground
		heightAnchor.constraint(equalToConstant: 50).isActive = true
		
		configureCollectionView()
		addSubview(indicatorBar)
	}
	
	private var indicatorBarAdded = false
	
	override func layoutSubviews() {
		super.layoutSubviews()
		tabsCollectionView.layoutIfNeeded()
		
		if !indicatorBarAdded{
			guard let firstCell = tabsCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? CollectionViewCell else {return}

			let label = firstCell.label.frame
			
			print(label.origin.x, frame.maxY, label.width)
			indicatorBar.frame = CGRect(x: label.origin.x, y: tabsCollectionView.frame.maxY - 2, width: label.width, height: 5)
			
			indicatorBarAdded = true
		}
			
			
	}
	
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return homeBarTabs.count
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print(indexPath.item)
		guard let selectedCell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell else {return}
		let label = selectedCell.label.frame
		let screenX = selectedCell.convert(label.origin, to: nil).x
		print(label.origin.x, screenX, indicatorBar.frame.origin.y)
		let newframe = CGRect(x: screenX, y: indicatorBar.frame.origin.y, width: label.width, height: indicatorBar.frame.height)
		
		UIView.animate(withDuration: 0.75, delay: 0) { [weak self] in
			self?.indicatorBar.frame = newframe
		}
		
	}
	
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {return UICollectionViewCell() }
		
		cell.label.text = homeBarTabs[indexPath.row]
		
		
		
		return cell
	}
	
	// size per cell
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSizeMake(collectionView.frame.width / 2, collectionView.frame.height)
	}

	//spacing

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	

	required init?(coder: NSCoder) {
		fatalError()
	}
}



// CELL FOR COLLECTION VIEW

class CollectionViewCell: UICollectionViewCell {
	
	static let identifier = "CollectionViewCell"
	
	let label: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = .systemFont(ofSize: 20, weight: .bold)
		label.textColor = .systemGray
		label.isUserInteractionEnabled = true
		label.sizeToFit()
		return label
	}()
	
	
	override var isSelected: Bool {
		didSet {
			label.textColor = isSelected ? .label : .systemGray
		}
	}
	
	override var isHighlighted: Bool {
		didSet {
			label.textColor = isHighlighted ? .label : .systemGray
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(label)
		NSLayoutConstraint.activate([
			label.centerXAnchor.constraint(equalTo: centerXAnchor),
			label.centerYAnchor.constraint(equalTo: centerYAnchor),
			label.heightAnchor.constraint(equalTo: heightAnchor)
		])
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


