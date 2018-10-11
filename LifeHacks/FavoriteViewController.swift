//
//  FavoriteViewController.swift
//  LifeHacks
//
//  Created by Try Catch on 15/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    var detailsarr : [Favourites] = []
    var favarr : [String] = []
    var favidarr : [String] = []
    var pressed = false
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: (collectionView.frame.width-50), height: (collectionView.frame.height-200))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    }
    

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     
       return detailsarr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoritecell", for: indexPath) as! FavoriteCell
        
        cell.layer.cornerRadius = 15
        cell.clipsToBounds = true
        cell.layer.shadowColor = UIColor.purple.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 5
        cell.layer.masksToBounds = false
       
        let coredetail = detailsarr[indexPath.row]
    
       let fav = coredetail.details
      // print("\(String(describing: fav))")
        cell.favtxtview?.text = (String(describing: fav!))
        cell.favlbl.text = "# Favorite"
        
        
        cell.copybtn.tag = indexPath.row
        cell.deletebutton.tag = indexPath.row
        cell.sharebtn.tag = indexPath.row
        
        cell.deletebutton?.addTarget(self, action: #selector(deleteUser(sender:)) , for: .touchUpInside)
       
         cell.sharebtn?.addTarget(self, action: #selector(share(sender:)) , for: .touchUpInside)
       
       cell.copybtn.addTarget(self, action: #selector(copytext(sender:)) , for: .touchUpInside)
        
        if UIDevice.current.userInterfaceIdiom == .pad{
           cell.favtxtview?.font = UIFont.boldSystemFont(ofSize: 50)
             cell.favlbl.font = UIFont.boldSystemFont(ofSize: 50)
            
            
        }
        
       
        return cell
    }
    
     @objc func copytext(sender:UIButton){
      // let i : Int = (sender.layer.value(forKey: "index")) as! Int
        let coredetail = detailsarr[sender.tag]
        
        let fav = coredetail.details
       
        UIPasteboard.general.string = (String(describing: fav!))
        
        //Alert
        let alertController = UIAlertController(title: "", message: "String copied to pasteboard!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(alertController, animated: true, completion: nil)
        
    }
    @objc func share(sender:UIButton){
       //let i : Int = (sender.layer.value(forKey: "index")) as! Int
      
        
        let coredetail = detailsarr[sender.tag]
        
        let fav = coredetail.details
        if UIDevice.current.userInterfaceIdiom == .pad{
            
            let shareItems  = (String(describing: fav!))
            
            let sharename  = myCategoryName
            let activity = UIActivityViewController(activityItems: [shareItems,sharename], applicationActivities: nil)
            self.present(activity, animated: true, completion: nil)
            
            if let popOver = activity.popoverPresentationController {
                popOver.sourceView = self.view
                popOver.sourceRect = .init(x: 20, y: 1000, width: view.frame.size.width, height: view.frame.size.height/4)
               
            }
            
            
        }
        else {
            
            let shareItems  = (String(describing: fav!))
            let sharename  = myCategoryName
            let activity = UIActivityViewController(activityItems: [shareItems,sharename], applicationActivities: nil)
            self.present(activity, animated: true, completion: nil)
        }
    }
    
 @objc func deleteUser(sender:UIButton) {
    
    
    if  sender.isSelected {
        sender.setImage(#imageLiteral(resourceName: "favorite"), for: .normal)
        sender.isSelected = false
        
    }else {
        sender.setImage(#imageLiteral(resourceName: "favorite-heart-button.png"), for: .selected)
        sender.isSelected = true
    }
   
        let dataAppDelegatde = UIApplication.shared.delegate as? AppDelegate
        
        let mngdCntxt = dataAppDelegatde?.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favourites")
    do {
        let result = try mngdCntxt?.fetch(fetchRequest)
        if (result?.count)! > 0 {
            //print("favId alredy exists")
            let item = result![sender.tag]
            mngdCntxt?.delete(item as! NSManagedObject)
            dataAppDelegatde?.saveContext()
            
        }
    }catch{
        let saveError = error as NSError
        
    }
    
    }

    
    func getdata() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            detailsarr = try context.fetch(Favourites.fetchRequest())
        }
        catch{
            print("No action")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getdata()
        self.collectionView.reloadData()
        if detailsarr.count > 0 {
            collectionView.isHidden = false
            myview.isHidden = true
        }
        else {
            collectionView.isHidden = true
            myview.isHidden = false
        }
        
    }
    
    @IBOutlet weak var myview: UIView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getdata()
        self.collectionView.reloadData()
        // Do any additional setup after loading the view.
    }

    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let centerX = scrollView.contentOffset.x + scrollView.frame.size.width/2
        for cell in collectionView.visibleCells {
            
            var offsetX = centerX - cell.center.x
            if offsetX < 0 {
                offsetX *= -1
            }
            
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
            if offsetX > 50 {
                
                let offsetPercentage = (offsetX - 50) / view.bounds.width
                var scaleX = 1-offsetPercentage
                
                if scaleX < 0.8 {
                    scaleX = 0.8
                }
                cell.transform = CGAffineTransform(scaleX: scaleX, y: scaleX)
            }
        }
    }
    
 

}
