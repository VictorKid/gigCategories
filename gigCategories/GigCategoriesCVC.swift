//
//  GigCategoriesCVC.swift
//  gigCategories
//
//  Created by VictorKid on 2015/5/21.
//  Copyright (c) 2015年 VictorKid. All rights reserved.
//

import UIKit

protocol GigCategoriesCVCDelegate {
    func gigCategoriesCVCDidSelectIndexPath(indexPath: NSIndexPath)
}

class GigCategoriesCVC: UIViewController {
    
    var delegate: GigCategoriesCVCDelegate?
    var maxWidth: CGFloat = 0.0
    lazy var gigCategoriesCView: UICollectionView = {
        let layout = CenterCellCollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        var aCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        aCollectionView.dataSource = self
        aCollectionView.delegate = self
        aCollectionView.pagingEnabled = false
        aCollectionView.showsHorizontalScrollIndicator = false
        return aCollectionView
    }()
    let CATEGORY_ITEM_IDNT = "Category_Item_Cell"
    var categoryItems = [CategoryItem]()
    var isCenter: Bool!
    
    let notificationCenter = NSNotificationCenter.defaultCenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        maxWidth = UIScreen.mainScreen().bounds.size.width
        gigCategoriesCView.registerClass(GigCategoryCVCell.self, forCellWithReuseIdentifier: CATEGORY_ITEM_IDNT)
        gigCategoriesCView.backgroundColor = UIColor.clearColor()
        view.addSubview(gigCategoriesCView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isCenter == true {
            var insets = gigCategoriesCView.contentInset
            let value = (maxWidth - (maxWidth / 2)) / 2
            insets.left = value
            insets.right = value
            gigCategoriesCView.contentInset = insets
        }
    }
    
    // MARK: Fn For Handling Category Change
    func onCategoryChange(indexPath: NSIndexPath) {
        gigCategoriesCView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
    }
    
}

// MARK: UICollectionViewDataSource

extension GigCategoriesCVC: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryItems.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CATEGORY_ITEM_IDNT, forIndexPath: indexPath) as! GigCategoryCVCell
    
        let item = categoryItems[indexPath.row]
        cell.label.text = item.title
        cell.label.sizeToFit()
        cell.icon.image = item.icon
        //cell.contentView.backgroundColor = UIColor.greenColor()
        
        return cell
    }
    
}

// MARK: UICollectionViewDelegate

extension GigCategoriesCVC: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        if let delegate = delegate {
            collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
            delegate.gigCategoriesCVCDidSelectIndexPath(indexPath)
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension GigCategoriesCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if isCenter == true {
            return CGSize(width: maxWidth / 2, height: 70)
        } else {
            return CGSize(width: maxWidth / 4, height: 70)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
}

// MARK: UIScrollViewDelegate

extension GigCategoriesCVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let centeredIndexPath = gigCategoriesCView.indexPathForItemAtPoint(CGPoint(x: CGRectGetMidX(gigCategoriesCView.bounds), y: CGRectGetMidY(gigCategoriesCView.bounds)))
        if let selectedIndexPath = centeredIndexPath,
            delegate = delegate {
                delegate.gigCategoriesCVCDidSelectIndexPath(selectedIndexPath)
        }
    }
}
