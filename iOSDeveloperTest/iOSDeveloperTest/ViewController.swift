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
    @IBOutlet weak var vwBottmNavigationBar: UIView!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    let cellIdentifier:String = "cell"
    var indexPath:IndexPath = IndexPath(item: 0, section: 0)
    var datasources = [] as NSMutableArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationBar()
        self.setupData()
        self.setupCollectionView()
        self.setUpBottomNavigationBar()
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
        self.indexPath = indexPath
        return cell
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        let visibleIndexPath: IndexPath = collectionView.indexPathForItem(at: visiblePoint)!
        self.indexPath = visibleIndexPath;
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var ratio:CGFloat = self.collectionView.contentOffset.x/self.collectionView.frame.size.width;
        var page:NSInteger = NSInteger(floor(ratio))

        if (page == self.datasources.count - 1)
        {
            self.btnNext.isUserInteractionEnabled = false
            self.btnNext.alpha = 0.2
            
            self.btnPrevious.isUserInteractionEnabled = true
            self.btnPrevious.alpha = 1
        }
        
        if (page == 0)
        {
            self.btnPrevious.isUserInteractionEnabled = false
            self.btnPrevious.alpha = 0.2
            
            self.btnNext.isUserInteractionEnabled = true
            self.btnNext.alpha = 1
        }
        
        if (page != self.datasources.count - 1 && page != 0)
        {
            self.btnNext.isUserInteractionEnabled = true
            self.btnNext.alpha = 1
            
            self.btnPrevious.isUserInteractionEnabled = true
            self.btnPrevious.alpha = 1
        }
    }
    
    // MARK: - Implementation
    func setUpBottomNavigationBar() {
        self.btnPrevious.isUserInteractionEnabled = false
        self.btnPrevious.alpha = 0.2
        
        self.btnNext.isUserInteractionEnabled = true
    }
    
    func setupCollectionView() {
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width, height: self.collectionView.frame.height - 0)
        layout.minimumLineSpacing = 40
        layout.scrollDirection = .horizontal;
        self.collectionView!.collectionViewLayout = layout
        
        self.collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
    }
    
    func setupData() {
        for _ in 0 ... 5 {
            let myDict:NSDictionary = ["Color" : self.getRandomColor(),"String" : self.randomizeAvailableLetters()]
            datasources.add(myDict)
        }
        
        print(datasources)
    }
    
    func setUpNavigationBar() {
        self.title = "Test App"
        let titleDict: NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedStringKey : Any]
        
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let homeButton : UIBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.plain, target: self, action:#selector(addCollectionView))
        
        let logButton : UIBarButtonItem = UIBarButtonItem(title: "Delete", style: UIBarButtonItemStyle.plain, target: self, action: #selector(deleteCollectionView))
        
        self.navigationItem.leftBarButtonItem = homeButton
        self.navigationItem.rightBarButtonItem = logButton
    }
    
    @objc func deleteCollectionView() {
        collectionView.performBatchUpdates({ () -> Void in
            if(self.datasources.count != 0){
                self.datasources.removeObject(at: self.indexPath.item)
                if(self.datasources.count == 0){
                    let view: UIView = UIView(frame: self.view.frame)
                    view.backgroundColor = UIColor.gray
                    let label: UILabel = UILabel(frame:CGRect(x: view.frame.width/3, y: view.frame.height/2.7, width: 200, height: 30))
                    label.text = "No page added."
                    view.tag = 101
                    view.addSubview(label)
                    self.collectionView.addSubview(view)
                    
                    self.btnNext.isUserInteractionEnabled = false;
                    self.btnNext.alpha = 0.2
                }
            }else{
                return
            }
            self.collectionView.deleteItems(at: [self.indexPath])
        }, completion: {
            finished in
            self.collectionView.reloadData()
            if(self.indexPath.item == self.datasources.count - 1){
                self.btnNext.isUserInteractionEnabled = false;
                self.btnNext.alpha = 0.2
            }else if (self.datasources.count == 1){
                self.btnNext.isUserInteractionEnabled = false;
                self.btnNext.alpha = 0.2
                self.btnPrevious.isUserInteractionEnabled = false;
                self.btnPrevious.alpha = 0.2
            }
        })
    }
    
    @objc func addCollectionView() {
        if((self.view.viewWithTag(101)) != nil){
            self.view.viewWithTag(101)?.removeFromSuperview()
        }
        let newItem:NSDictionary = ["Color" : self.getRandomColor(),"String" : self.randomizeAvailableLetters()]
        datasources.insert(newItem, at: self.indexPath.item)

        self.collectionView!.performBatchUpdates({
            //let insertIndexPath = IndexPath(item: 2, section: 0)
            self.collectionView.insertItems(at: [self.indexPath])
        }, completion: {
            finished in
            self.collectionView.scrollToItem(at: self.indexPath, at: UICollectionViewScrollPosition.centeredVertically, animated: true)
            if(self.datasources.count == 2){
                self.btnNext.isUserInteractionEnabled = true;
                self.btnNext.alpha = 1
            }else if(self.datasources.count > 2 && self.indexPath.item != 0 && self.indexPath.item != self.datasources.count - 1){
                self.btnNext.isUserInteractionEnabled = true;
                self.btnNext.alpha = 1
                
                self.btnPrevious.isUserInteractionEnabled = true;
                self.btnPrevious.alpha = 1
            }
        })
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
    
    @IBAction func clickBtnPreivous(_ sender: Any) {
        let visibleItems: NSArray = self.collectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let previousItem: IndexPath = IndexPath(item: currentItem.item - 1, section: 0)
        
        if previousItem.row < datasources.count && previousItem.row != -1 {
            self.collectionView.scrollToItem(at: previousItem, at: .right, animated: true)
        }
    }
    
    @IBAction func clickBtnNext(_ sender: Any) {
        let visibleItems: NSArray = self.collectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
        // next item was greater than the data.count
        if nextItem.row < datasources.count {
            self.collectionView.scrollToItem(at: nextItem, at: .left, animated: true)

        }
    }
}

extension ViewController:UIScrollViewDelegate{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellwidth = layout.itemSize.width + layout.minimumLineSpacing
        print(targetContentOffset.pointee)
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left)/cellwidth
        let roundedIndex = round(index)
        offset = CGPoint(x:roundedIndex * cellwidth - scrollView.contentInset.left, y:-scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}

