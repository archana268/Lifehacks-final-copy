
//  CategoryViewController.swift
//  LifeHacks
//
//  Created by Try Catch on 10/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Kingfisher
import CoreData


var detailarr = [String]()
 var mydetailtext = ""
var carry : [String] = []

class
CategoryViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet var customview: UIView!
    
    
    @IBOutlet weak var copywidth: NSLayoutConstraint!
    
    @IBOutlet weak var copyheight: NSLayoutConstraint!
    
    var isDataAssigned = false
    
    @IBOutlet weak var collectionview: UICollectionView!
    var myarr = NSArray()
    var catdata = NSArray()
    var idarray : [String] = []
    
  
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       
        
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            return CGSize(width: (collectionView.frame.width-60), height: (collectionView.frame.height-100))
//
//        }
//        else { UIDevice.current.userInterfaceIdiom == .phone
//
//            return CGSize(width: (collectionView.frame.width-50), height: (collectionView.frame.height-70))
//
//        }
        return CGSize(width: (collectionView.frame.width-10)/1.1, height: (collectionView.frame.height-130))
       
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myarr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categorycell", for: indexPath) as! CategoryCell
        cell.layer.cornerRadius = 15
        cell.clipsToBounds = true
        cell.layer.shadowColor = UIColor.darkGray.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 5
        cell.layer.masksToBounds = false
        
        
        
        
        if isDataAssigned == true{
      
            let Dict = myarr.object(at: indexPath.row) as! NSDictionary
             let c = Dict.value(forKey: "id") as! String
           // print(c)
             carry.append(c)
           // print(c)
            cell.lbl.text = myCategoryName
            cell.mytxtview.text = Dict.value(forKey:"post_desc") as? String
            detailarr.append(Dict.value(forKey:"post_desc") as! String)
            
        let url = URL(string: myImageid)
        cell.myimg.kf.setImage(with: url)
      
            let CurrentId = Dict.value(forKey: "id") as! String
          
            if favorited.contains(where:{$0.favID == CurrentId}) {
                cell.favoritebutton.setImage(#imageLiteral(resourceName: "favorite"), for: .normal)
            }else {
                cell.favoritebutton.setImage(#imageLiteral(resourceName: "favorite1.png"), for: .normal)
            }
             cell.favoritebutton.tag = indexPath.row
             cell.share.tag = indexPath.row
             cell.copybtn.tag = indexPath.row
              cell.share.addTarget(self, action: #selector(shareButton), for: .touchUpInside)
            
            cell.favoritebutton.addTarget(self, action: #selector(handleFavouriteButton), for: .touchUpInside)
            
            cell.copybtn.addTarget(self, action: #selector(copybutton), for: .touchUpInside)
            
            
            if UIDevice.current.userInterfaceIdiom == .pad{
                cell.lbl.font = UIFont.boldSystemFont(ofSize: 50)
                cell.mytxtview.font = UIFont.boldSystemFont(ofSize: 50)
              
            }
          
        }
        else{ 
            
        }
        
        return cell
    }
    
    
   
    
    @objc func copybutton(sender : UIButton) {
        let Dict = myarr.object(at: sender.tag) as! NSDictionary
       UIPasteboard.general.string = Dict.value(forKey:"post_desc") as? String
        
        //Alert
        let alertController = UIAlertController(title: "", message: "String copied to pasteboard!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    
      
    
    
    @objc func shareButton(sender : UIButton) {
        print(sender.tag)
        let Dict = myarr.object(at: sender.tag) as! NSDictionary
        
        if UIDevice.current.userInterfaceIdiom == .pad{
            
            let shareItems  = Dict.value(forKey:"post_desc") as? String
           
            let sharename  = myCategoryName//Dict.value(forKey: "post_audio") as! String
            let activity = UIActivityViewController(activityItems: [shareItems,sharename], applicationActivities: nil)
            self.present(activity, animated: true, completion: nil)
            
            if let popOver = activity.popoverPresentationController {
                popOver.sourceView = self.view
                popOver.sourceRect = .init(x: 20, y: 1000, width: view.frame.size.width, height: view.frame.size.height/4)
                //popOver.barButtonItem
            }
            
            
        }
        else {
            
            let shareItems  = Dict.value(forKey:"post_desc") as? String
            let sharename  = myCategoryName
            let activity = UIActivityViewController(activityItems: [shareItems!,sharename], applicationActivities: nil)
            self.present(activity, animated: true, completion: nil)
            
        }
        
        
    }
    
    @objc func handleFavouriteButton(sender : UIButton) {
        //print("Check Out \(sender.tag)")
        
        let appdel = UIApplication.shared.delegate as! AppDelegate
        let context = appdel.persistentContainer.viewContext
        let singleitem = Favourites(context: context)
        let dect = myarr.object(at: sender.tag) as! NSDictionary
        singleitem.favID = dect.value(forKey: "id") as? String
        singleitem.details = dect.value(forKey:"post_desc") as? String
        singleitem.label = myCategoryName
        appdel.saveContext()
        
        
        sender.setImage(#imageLiteral(resourceName: "favorite"), for: UIControlState.normal)
        sender.isUserInteractionEnabled = false
        
        let alert = UIAlertController(title: "Favourites", message: "Added to Favourites", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(ok)
        getdata()
        self.present(alert, animated: true, completion: nil)
        
        
    }
        
    var favorited : [Favourites] = []
    func getdata(){
        let appdel = UIApplication.shared.delegate as! AppDelegate
        let context = appdel.persistentContainer.viewContext
        do{
            favorited = try context.fetch(Favourites.fetchRequest())
            //  print(favorited)
            
        }catch{
            print("No Action")
        }
    }
    
    
    func getJsonFromUrl(){
        let url = URL(string: mylink)
      
        let task = URLSession.shared.dataTask(with: url!){(data,response,error) in
            
            if let  tempdata = data {
                do {
                    let  mydata = try JSONSerialization.jsonObject(with: tempdata, options: .mutableContainers) as! NSArray
                   
                    self.myarr = mydata
                
                    DispatchQueue.main.async {
                        self.isDataAssigned = true
                        self.collectionview.reloadData()
                    }
                } catch {
                    print ("Exception")
                    
                }
       
            }
            else
            {
                print("error")
            }
        }
        task.resume()
    }

    
 

    override func viewDidLoad() {
        super.viewDidLoad()
      
        getdata()
        getJsonFromUrl()
    
             let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(CategoryViewController.backpress(_:)))
            self.navigationItem.leftBarButtonItem = newBackButton
        
    }


    @IBAction func heartbtn(_ sender: UIBarButtonItem) {
      performSegue(withIdentifier: "favorated", sender: self)
   
    }

    
    
    @IBAction func backpress(_ sender: Any) {
   
        self.navigationController?.popViewController(animated: true)
    }
}







      
        
   
       




