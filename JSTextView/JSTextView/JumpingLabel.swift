//
//  JumpingLabel.swift
//  JSTextView
//
//  Created by Ehud Adler on 11/12/17.
//  Copyright © 2017 Jesse Seidman. All rights reserved.
//

import UIKit

public class JumpingLabel: UILabel {

  var padding: UIEdgeInsets
  var edge:Edge = .right
  var shadowLayer: CAShapeLayer!

  // Allow padding to be chosen programatically
  public required init(padding: UIEdgeInsets, edge:Edge) {
    self.padding = padding
    self.edge    = edge
    super.init(frame: CGRect.zero)
  }
  
  // Create regular label -- No padding
  override init(frame: CGRect) {
    padding = UIEdgeInsets.zero
    super.init(frame: frame)
  }
  
  // Create from storyboard
  public required init?(coder aDecoder: NSCoder) {
    padding = UIEdgeInsets.zero
    super.init(coder: aDecoder)
  }
  
  public override func drawText(in rect: CGRect) {
    super.drawText(in: self.edge == .right ? self.bounds.insetBy(dx: padding.top, dy: padding.left) : self.bounds.insetBy(dx: padding.top, dy: padding.right))
  }
  
  public override func layoutSubviews() {
    self.layoutCornerRadiusAndShadow(corners: self.edge == .right ? [.topLeft,.bottomLeft] : [.topRight, .bottomRight], cornerRadius: 10)
  }
  
}

extension UILabel {

  // Apply corner radius and rounded shadow path
  func layoutCornerRadiusAndShadow(corners: UIRectCorner, cornerRadius: CGFloat) {
    
    // Apply corner radius for background fill only
    let cornerRadii = CGSize(width: cornerRadius, height: cornerRadius)
    let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: cornerRadii)
    
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    
    layer.mask = mask
    
    // Apply shadow with rounded path
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.30
    layer.shadowRadius = 2.0
    layer.shadowOffset = CGSize(width: 0.5, height: 2.0)
    layer.shadowPath = path.cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = UIScreen.main.scale
  }
}

