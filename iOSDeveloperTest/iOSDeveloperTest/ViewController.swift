//
//  ViewController.swift
//  iOSDeveloperTest
//
//  Created by Moe Han on 10/27/17.
//  Copyright © 2017 NyeinEi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    let cellIdentifier:String = "cell"
    var indexPath:IndexPath!
    var datasources = [] as NSMutableArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationBar()
        self.setupData()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height - 100)
        layout.minimumLineSpacing = 40
        layout.scrollDirection = .horizontal;
        self.collectionView!.collectionViewLayout = layout
        
        self.collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        
    }
    
    func setupData() {
        for _ in 0 ... 2 {
            let myDict:NSDictionary = ["Color" : self.getRandomColor(),"String" : self.randomizeAvailableLetters()]
            datasources.add(myDict)
        }
        
        print(datasources)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datasources.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell:CustomCollectionViewCell
        cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CustomCollectionViewCell
        cell.setData(data: datasources[indexPath.item] as! NSDictionary)
        cell.position.text = String(indexPath.item);
        return cell
    }
    
    // MARK: - Implementations
    func setUpNavigationBar() {
        let homeButton : UIBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.plain, target: self, action:#selector(addCollectionView))
        
        let logButton : UIBarButtonItem = UIBarButtonItem(title: "Delete", style: UIBarButtonItemStyle.plain, target: self, action: #selector(deleteCollectionView))
        
        self.navigationItem.leftBarButtonItem = homeButton
        self.navigationItem.rightBarButtonItem = logButton
    }
    
    @objc func deleteCollectionView() {
//        collectionView.performBatchUpdates({ () -> Void in
//            self.collectionView.deleteItems(at: [self.indexPath])
//            if(self.itemCount != 0){
//                self.itemCount -= 1
//            }else{
//                return;
//            }
//            self.collectionView.reloadData()
//        }, completion:nil)
    }
    
    @objc func addCollectionView() {
        let newItem:NSDictionary = ["Color" : self.getRandomColor(),"String" : self.randomizeAvailableLetters()]
        datasources.add(newItem)
//        let insertIndexPath = IndexPath(item: 2, section: 0)
////        if(self.indexPath.item != 0){
////            self.indexPath.item -= 1
////        }
//        self.collectionView.insertItems(at: [insertIndexPath])
        
        self.collectionView!.performBatchUpdates({
            let insertIndexPath = IndexPath(item: 2, section: 0)
            self.collectionView.insertItems(at: [insertIndexPath])
        }, completion: nil)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()

        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size

        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

        let visibleIndexPath: IndexPath = collectionView.indexPathForItem(at: visiblePoint)!
        self.indexPath = visibleIndexPath;
        print(visibleIndexPath)
    }
    
    func getRandomColor() -> UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        
        let randomGreen:CGFloat = CGFloat(drand48())
        
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
    
    func randomizeAvailableLetters() -> String {
        let alphabet: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        var availableTiles:String!
        let rand = Int(arc4random_uniform(26))
        availableTiles = alphabet[rand]
        return availableTiles
    }
}

