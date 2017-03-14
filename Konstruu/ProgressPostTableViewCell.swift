//
//  ProgressPostTableViewCell.swift
//  Konstruu
//
//  Created by Al Yuen on 3/9/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit
import Foundation
import DataStructures

class ProgressPostTableViewCell: UITableViewCell {

    // MARK: - Model
    
    var progressPost: DataStructures.ProgressPost? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - UI
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var progressPostImageView: UIImageView!
    
    @IBOutlet weak var progressPostTextLabel: UILabel!
    
    private func updateUI() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy hh:mm:ss"
        if let date = progressPost?.date {
            dateLabel.text = dateFormatter.string(from: date)
        }
        
        if let image = progressPost?.image {
            progressPostImageView.image = image
        } else {
            progressPostImageView.isHidden = true
        }
        
        progressPostTextLabel.text = progressPost?.text
    }
    
}
