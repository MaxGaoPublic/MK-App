//
//  PlanViewController.swift
//  MK-App
//
//  Created by Max Gao on 21.12.15.
//  Copyright © 2015 Max Gao. All rights reserved.
//

import UIKit

class PlanViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var header: UILabel!
    
    
    
    let vp = Vertretungsplan()
    var all = [String]()
    var b = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        self.collectionView.showsHorizontalScrollIndicator = false
        self.navigationController?.navigationBarHidden = true
        image.alpha = 0.0
        all = vp.plaene.values.first!
        header.text = vp.plaene.keys.first
        
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        loadData()
    }
    
    func loadData() {
        
        print(all.count)
    }
    
    @IBAction func test(sender: AnyObject) {
    
        if(b == false) {
            
            for (key, value) in vp.plaene {
                
                if(!key.containsString(header.text!)) {
                    all = value
                    header.text = key
                    
                }
                
            }
            
            b = true
            
            self.collectionView.reloadData()
        } else {
            all = vp.plaene.values.first!
            header.text = vp.plaene.keys.first
            b = false
            self.collectionView.reloadData()
        }
        

        
    }
    
     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PlanCell", forIndexPath: indexPath) as? PlanCell {
            
            let data = all[indexPath.row]
            
            if(data.componentsSeparatedByString("tsep")[0].containsString("Entfall")) {
                cell.prepareForEntfall(data)
            } else if(data.componentsSeparatedByString("tsep")[0].containsString("Raum")) {
                cell.prepareForRaum(data)
            } else {
                cell.prepareForVertretung(data)
            }
            
            cell.layer.cornerRadius = 8.0
            cell.clipsToBounds = true
            
            return cell
            
        } else {
            
            return PlanCell()
        }


    }

    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return all.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 25.0
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat  {
        return 25.0
    }


    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    

}
