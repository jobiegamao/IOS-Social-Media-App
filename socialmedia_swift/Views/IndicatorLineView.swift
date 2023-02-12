//
//  IndicatorLineView.swift
//  socialmedia_swift
//
//  Created by may on 2/11/23.
//

import UIKit

class IndicatorLineView: UIView {
	var title: String = "" {
		didSet {
		  setNeedsDisplay()
		}
	  }
	override func draw(_ rect: CGRect) {
		// Draw a line with a fixed height in the center of the view
		let lineHeight: CGFloat = 2.0
		let lineRect = CGRect(x: 0, y: (rect.height - lineHeight) / 2, width: rect.width, height: lineHeight)
		let line = UIBezierPath(roundedRect: lineRect, cornerRadius: 3)
		
		
		
		if let color = UIColor(named: "AccentColorBlue") {
			color.setFill()
			line.fill()
		}
		
		
	}

}
