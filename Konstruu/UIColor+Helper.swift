//
//  UIColor+Helper.swift
//  Konstruu
//
//  Created by David Xue on 4/18/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

extension UIColor {
  
  convenience init(hexString: String, alpha: CGFloat = 1) {
    assert(hexString[hexString.startIndex] == "#", "Expected hex string of format #RRGGBB")
    
    let scanner = Scanner(string: hexString)
    scanner.scanLocation = 1  // skip #
    
    var rgb: UInt32 = 0
    scanner.scanHexInt32(&rgb)
    
    self.init(
      red:   CGFloat((rgb & 0xFF0000) >> 16)/255.0,
      green: CGFloat((rgb &   0xFF00) >>  8)/255.0,
      blue:  CGFloat((rgb &     0xFF)      )/255.0,
      alpha: alpha)
  }
  
  public class func konstruuGray() -> UIColor {
    return UIColor(hexString: "#aaaaaa")
  }
  
  public class func konstruuLightGray() -> UIColor {
    return UIColor(hexString: "#f2f2f2")
  }
  
  public class func konstruuLightGreen() -> UIColor {
    return UIColor(hexString: "#50D2C2")
  }
  
  public class func konstruuGreen() -> UIColor {
    return UIColor(hexString: "#58b570")
  }
  
  public class func konstruuYellow() -> UIColor {
    return UIColor(hexString: "#f9a70c")
  }
  
  public class func konstruuDarkBlue() -> UIColor {
    return UIColor(hexString: "#1565c0")
  }
  
  public class func konstruuBlue() -> UIColor {
    return UIColor(hexString: "#123456")
  }
  
  public class func konstruuRed() -> UIColor {
    return UIColor(hexString: "#ff1744")
  }
  
  public class func konstruuSilver() -> UIColor {
    return UIColor(hexString: "#c0c0c0")
  }
  
  public class func konstruuGold() -> UIColor {
    return UIColor(hexString: "#d4af37")
  }
  
  public class func konstruuBlack() -> UIColor {
    return UIColor(hexString: "#000000")
  }
}
