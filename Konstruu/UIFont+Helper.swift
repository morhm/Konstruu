//
//  UIFont+Helper.swift
//  Konstruu
//
//  Created by David Xue on 4/18/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

extension UIFont {
  
  public class func konstruuFontWithSize(_ size:CGFloat) -> UIFont {
    return UIFont(name: "OpenSans", size:size)!
  }
  
  public class func konstruuSemiboldFontWithSize(_ size:CGFloat) -> UIFont {
    return UIFont(name: "OpenSans-Semibold", size:size)!
  }
  
  public class func konstruuBoldFontWithSize(_ size:CGFloat) -> UIFont {
    return UIFont(name: "OpenSans-Bold", size:size)!
  }
  
  public class func konstruuLightFontWithSize(_ size:CGFloat) -> UIFont {
    return UIFont(name: "OpenSans-Light", size:size)!
  }
  
}
