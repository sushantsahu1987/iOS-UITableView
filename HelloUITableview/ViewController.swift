//
//  ViewController.swift
//  HelloUITableview
//
//  Created by Sushant Sahu on 01/02/17.
//  Copyright © 2017 Sushant Sahu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        requestProfile()
        
        
    }
    
    func requestProfile() {
        
        let url = URL(string: "http://localhost:3000/people/20")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url!) {
        
            (data,response,error) in
            
            if(error != nil) {
                print(error)
            }else {
                print("success !!")
                /*if let str = String(data: data!, encoding: String.Encoding.utf8) {
                    print(str)
                }*/
                
                do {
                 
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    //print(json)
                    
                    for dictionary in json as! [[String:AnyObject]] {
                        let fname = dictionary["fname"] as! String
                        let lname = dictionary["lname"] as! String
                        let address = dictionary["address"] as! String
                        let image = dictionary["image"] as! String
                        print("\(fname), \(lname)")
                        print("Living at \(address)")
                        print(image)
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

