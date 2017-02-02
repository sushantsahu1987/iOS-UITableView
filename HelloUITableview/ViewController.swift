//
//  ViewController.swift
//  HelloUITableview
//
//  Created by Sushant Sahu on 01/02/17.
//  Copyright © 2017 Sushant Sahu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableProfile.dataSource = self
        tableProfile.delegate = self
        
        requestProfile()
        
        
    }
    
    var profileList : [Profile]?
    @IBOutlet weak var tableProfile: UITableView!
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        
        let profile = profileList?[indexPath.row]
        let strUrl = (profile?.image)!

        tableCell.labelName.text = "\( (profile?.fname)! ) \((profile?.lname)!)"
        tableCell.labelAddress.text = profile?.address!
        
        if let imageFromCache = imageCache.object(forKey: strUrl as AnyObject) as? UIImage {
            print("Image taken from cache @ \(strUrl)")
            tableCell.imageProfile.image = imageFromCache
        } else {
            
            let url = URL(string: strUrl)
        
            URLSession.shared.dataTask(with: url!) {
                (data,response,error) in
            
                    if error != nil {
                        print(error!)
                        return
                    }
            
                    DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data!)
                        //print("key is \(profile?.image)!)")
                        self.imageCache.setObject(imageToCache!, forKey: strUrl as AnyObject)
                        // TODO: In some scenario strurl was unwrapped a nil value need to correct this ...
                        print("Image stored in cache @ \(strUrl)")
                        tableCell.imageProfile.image = imageToCache
                    }
            
                }.resume()
        }
        
        return tableCell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = profileList?.count {
            return count
        }
        
        return 0
    }
    
    
    
    func requestProfile() {
        
        let url = URL(string: "http://localhost:3000/people/20")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url!) {
        
            (data,response,error) in
            
            if(error != nil) {
                print(error!)
            }else {
                print("success !!")
                /*if let str = String(data: data!, encoding: String.Encoding.utf8) {
                    print(str)
                }*/
                
                do {
                 
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    //print(json)
                    
                    self.profileList = [Profile]()
                    
                    for dictionary in json as! [[String:AnyObject]] {
                        let fname = dictionary["fname"] as! String
                        let lname = dictionary["lname"] as! String
                        let address = dictionary["address"] as! String
                        let image = dictionary["image"] as! String
                        //print("\(fname), \(lname)")
                        //print("Living at \(address)")
                        //print(image)
                        
                        let profile:Profile = Profile()
                        profile.fname = fname
                        profile.lname = lname
                        profile.address = address
                        profile.image = image
                        self.profileList?.append(profile)
                        
                        
                    }
                    
                    print("count : \(self.profileList?.count)")
                    
                    DispatchQueue.main.async {
                        self.tableProfile.reloadData()
                    }
                    
                    
                    
                    
                } catch let jsonError {
                    print(jsonError)
                }
                
                
                
            }
            
        }
        
        task.resume()
        
        
        
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    


}

