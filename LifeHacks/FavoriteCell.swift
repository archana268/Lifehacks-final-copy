//
//  FavoriteCell.swift
//  LifeHacks
//
//  Created by Try Catch on 15/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import CoreData


class FavoriteCell: UICollectionViewCell {
    
    @IBOutlet weak var favlbl: UILabel!
   
    
    @IBOutlet weak var sharebtn: UIButton!
    
    @IBOutlet weak var copybtn: UIButton!
    
    @IBOutlet weak var favtxtview: UITextView!

    @IBOutlet weak var deletebutton: UIButton!
    
    @IBOutlet weak var TextViewWidth: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            
          TextViewWidth.constant = -200
        
        }
    }
    
}



    
    







    


