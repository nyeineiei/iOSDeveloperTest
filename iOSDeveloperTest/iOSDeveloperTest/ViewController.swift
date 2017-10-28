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
    var itemCount = 3
    var isNewAddedRow:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationBar()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        layout.minimumLineSpacing = 40
        layout.scrollDirection = .horizontal;
        self.collectionView!.collectionViewLayout = layout
        
        self.collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemCount
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell:CustomCollectionViewCell = CustomCollectionViewCell()
        if(!self.isNewAddedRow){
            self.indexPath = indexPath;
            cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CustomCollectionViewCell
        }else{
            cell = UINib(nibName: "CustomCollectionViewCell", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CustomCollectionViewCell
        }
        
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
        collectionView.performBatchUpdates({ () -> Void in
            self.collectionView.deleteItems(at: [self.indexPath])
            if(self.itemCount != 0){
                self.itemCount -= 1
            }else{
                return;
            }
            self.collectionView.reloadData()
        }, completion:nil)
    }
    
    @objc func addCollectionView() {
//        collectionView.performBatchUpdates({ () -> Void in
//            self.collectionView.insertItems(at: [self.indexPath])
//            self.itemCount += 1
//            self.isNewAddedRow = true
//            self.collectionView.reloadData()
//        }, completion:nil)
    }
}

