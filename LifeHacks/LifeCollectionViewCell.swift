//
//  LifeCollectionViewCell.swift
//  LifeHacks
//
//  Created by Try Catch on 08/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class LifeCollectionViewCell: UICollectionViewCell {
 
    
    @IBOutlet weak var Img: UIImageView!
    
    @IBOutlet weak var lbl: UILabel!

    @IBOutlet weak var ImgWidth: NSLayoutConstraint!
    
    @IBOutlet weak var ImgHeight: NSLayoutConstraint!
    
    @IBOutlet weak var ImgTop: NSLayoutConstraint!
    
    @IBOutlet weak var ImgLeading: NSLayoutConstraint!
    
    @IBOutlet weak var LblTop: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            ImgWidth.constant = 150
            ImgHeight.constant = 150
            ImgTop.constant = 75
            ImgLeading.constant = 50
            LblTop.constant = 50
            
        }
        
    }
}
