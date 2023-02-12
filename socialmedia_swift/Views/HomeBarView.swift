//
//  HomeBarView.swift
//  socialmedia_swift
//
//  Created by may on 2/12/23.
//

import UIKit

class HomeBarView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	private let homeBarTabs = ["For you", "Following"]

	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
		cv.translatesAutoresizingMaskIntoConstraints = false
		return cv
	}()
	
	private func configureCollectionView(){
		
		addSubview(collectionView)
		collectionView.delegate = self
		collectionView.dataSource = self
		NSLayoutConstraint.activate([
			collectionView.widthAnchor.constraint(equalTo: widthAnchor),
			collectionView.heightAnchor.constraint(equalTo: heightAnchor)
		])
		
		//set selected tab at first run
		let defaultSelected = IndexPath(item: 0, section: 0)
		collectionView.selectItem(at: defaultSelected, animated: true, scrollPosition: [])
	}
	
	override init(frame: CGRect){
		super.init(frame: frame)
		backgroundColor = .systemBackground
		heightAnchor.constraint(equalToConstant: 50).isActive = true
		
		configureCollectionView()
	}
	
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return homeBarTabs.count
	}
	
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {return UICollectionViewCell() }
		
		cell.label.text = homeBarTabs[indexPath.row]
		return cell
	}
	
	// size per cell
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSizeMake(frame.width / 2, frame.height)
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
	
	private lazy var indicatorBar: IndicatorLineView = {
		let line = IndicatorLineView()
		line.frame = CGRect(x: label.frame.origin.x, y: frame.maxY, width: label.frame.width, height: 5)
		return line
	}()
	
	
	override var isSelected: Bool {
		didSet {
			label.textColor = isSelected ? .label : .systemGray
			
			if isSelected {
				// Calculate the frame of the indicator line
				let newframe = CGRect(x: label.frame.origin.x, y: label.frame.origin.y + 2, width: label.frame.width + 3, height: 2)
				UIView.animate(withDuration: 0.5, delay: 0) { [weak self] in
					self?.indicatorBar.frame = newframe
				}
			}
			

			
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
		addSubview(indicatorBar)
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


