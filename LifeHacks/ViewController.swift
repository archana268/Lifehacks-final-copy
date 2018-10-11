//
//  ViewController.swift
//  LifeHacks
//
//  Created by Try Catch on 08/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

var namearr = [String]()
var imagearr = [String]()
var idarr = [String]()
var mylink = ""
var myid = ""
var myCategoryName = ""
var myImageid = ""
var a = 0
class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    enum UIUserInterfaceIdiom : Int {
        case unspecified
        
        case phone // iPhone and iPod touch style UI
        case pad // iPad style UI
    }
    
    
    @IBAction func DiscliamerBtn(_ sender: UIBarButtonItem) {
   
        let alert = UIAlertController(title: "Disclaimer!", message: "The content on this app was created for artistic and entertainment purposes. It was not created with the intention to offend.", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
    
    
    }
    
    var arr = NSArray()
    var mydata = NSArray()
    var idarray : [String] = []
    var mycount = [0]
  
    @IBOutlet weak var collectionview: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: (collectionView.frame.width-40)/2, height: (collectionView.frame.height-30)/2.5)
           
        }
            
           return CGSize(width: (collectionView.frame.width-20)/2, height: (collectionView.frame.height-5)/3)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
             return UIEdgeInsetsMake(15, 15, 15, 15)
            
        }
        
        return UIEdgeInsetsMake(15, 5, 15, 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LifeCollectionViewCell
        
        cell.layer.cornerRadius = 15
        cell.clipsToBounds = true
        cell.layer.shadowColor = UIColor.darkGray.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 5
        cell.layer.masksToBounds = false
    
        let Dict = arr.object(at: indexPath.row) as! NSDictionary
       
        cell.lbl.text = Dict.value(forKey:"cat_name") as? String
         namearr.append(Dict.value(forKey:"cat_name") as! String)
        
        let url = URL(string: (Dict.value(forKey: "cat_image") as! String))
        cell.Img.kf.setImage(with: url!)
       
        imagearr.append((Dict.value(forKey: "cat_image") as! String))
       
        idarr.append((Dict.value(forKey: "id") as! String))
        if UIDevice.current.userInterfaceIdiom == .pad{
         cell.lbl.font = UIFont.boldSystemFont(ofSize: 50)
        }
        
        return cell
    }

    
    func getJsonFromUrl(){
        let url = URL(string:"http://mapi.trycatchtech.com/v1/lifehacks/category_list")
        let task = URLSession.shared.dataTask(with: url!){(data,response,error) in
            
            if let  tempdata = data {
                do {
                    let  mydata = try JSONSerialization.jsonObject(with: tempdata, options: .mutableContainers) as! NSArray
                    
                    self.arr = mydata
                    
                    for i in 0..<self.arr.count{
                        myid = (self.arr.object(at: i) as! NSDictionary).value(forKey: "id") as! String
                        self.idarray.append(myid)
                        
                    }
                   
                    DispatchQueue.main.async {
                        
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        mylink = "http://mapi.trycatchtech.com/v1/lifehacks/post_list?category_id=\(idarray[indexPath.item])&page=1"
        myCategoryName = namearr[indexPath.item]
        myImageid = imagearr[indexPath.item]
       
      
        // Safe Push VC
        let vc = storyboard?.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
            if let navigator = navigationController {
                navigator.pushViewController(vc, animated: true)
            }
        }
   
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJsonFromUrl()
  
       
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func barbtnpress(_ sender: Any) {
      
        performSegue(withIdentifier: "favorated", sender: self)
        
    
}
}
