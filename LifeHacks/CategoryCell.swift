//
//  CategoryCell.swift
//  LifeHacks
//
//  Created by Try Catch on 10/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
var favID = 0

class CategoryCell: UICollectionViewCell {
   
    let screenSize: CGRect = UIScreen.main.bounds
 
    @IBOutlet weak var favoritebutton: UIButton!
    
    @IBOutlet weak var share: UIButton!
    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet weak var myimg: UIImageView!
    
    @IBOutlet weak var mytxtview: UITextView!
    
  
    @IBOutlet weak var imgwdt: NSLayoutConstraint!
    
    @IBOutlet weak var imghgt: NSLayoutConstraint!
    
    @IBOutlet weak var TextViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var copybtn: UIButton!

    @IBOutlet weak var ImgYAxis: NSLayoutConstraint!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            imgwdt.constant = 200
            imghgt.constant = 200
            TextViewWidth.constant = -100
            ImgYAxis.constant = -200
            
        }
    }
}
    
        
    
    
    
   
   
    
   
    


 
 
 
 





