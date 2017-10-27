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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return 3
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CustomCollectionViewCell
        if(indexPath.row == 0){
            cell.webView.backgroundColor = UIColor.red
        }
        if(indexPath.row == 1){
            cell.webView.backgroundColor = UIColor.blue
        }
        if(indexPath.row == 2){
            cell.webView.backgroundColor = UIColor.green
        }
        return cell
    }
}

