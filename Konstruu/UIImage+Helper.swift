//
//  UIImage+Helper.swift
//  Konstruu
//
//  Created by David Xue on 6/1/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

extension UIImage {
  
  var jpeg: Data? {
    return UIImageJPEGRepresentation(self, 1)   // QUALITY min = 0 / max = 1
  }
  
  var png: Data? {
    return UIImagePNGRepresentation(self)
  }
  
}
