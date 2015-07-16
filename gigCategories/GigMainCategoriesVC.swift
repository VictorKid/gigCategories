//
//  GigMainCategoriesVC.swift
//  gigCategories
//
//  Created by VictorKid on 2015/5/23.
//  Copyright (c) 2015年 VictorKid. All rights reserved.
//

import UIKit

let DID_SELECT_SUBCATEGORY_ATINDEXPATH = "Did_Select_SubCategory_AtIndexPath"
protocol GigMainCategoriesViewDataSource {
    func numberOfCategoryViews() -> Int
    func numberOfSectionsInCategoryView(categoryView: UITableView) -> Int
    func categoryView(categoryView: UITableView, numberOfRowsInSection section: Int) -> Int
    func categoryView(categoryView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
}
@objc
protocol GigMainCategoriesViewDelegate {
    optional func categoryView(categoryView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    optional func categoryView(categoryView: UITableView, titleForHeaderInSection section: Int) -> String
}

class GigMainCategoriesVC: UIViewController {
    
    var maxWidth: CGFloat = 0.0
    var maxHeight: CGFloat = 0.0
    
    var dataSource: GigMainCategoriesViewDataSource?
    var delegate: GigMainCategoriesViewDelegate?
    var categoryItems: [CategoryItem]!
    var categoriesBar: GigCategoriesBar!
    
    lazy var categoriesContainerView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        var aCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        aCollectionView.dataSource = self
        aCollectionView.delegate = self
        aCollectionView.pagingEnabled = true
        aCollectionView.showsHorizontalScrollIndicator = false
        return aCollectionView
        }()
    let CATEGORY_VIEW_IDNT = "Category_View_Cell"
    
    let notificationCenter = NSNotificationCenter.defaultCenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        maxWidth = UIScreen.mainScreen().bounds.size.width
        maxHeight = UIScreen.mainScreen().bounds.size.height
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: maxWidth, height: 70))
        categoriesBar = GigCategoriesBar(sourceView: navBar, categoryItems: categoryItems)
        categoriesBar.delegate = self
        
        categoriesContainerView.frame = CGRect(x: 0, y: navBar.frame.origin.y + navBar.frame.size.height, width: maxWidth, height: maxHeight)
        categoriesContainerView.registerClass(GigSubCategorViewCVCell.self, forCellWithReuseIdentifier: CATEGORY_VIEW_IDNT)
        categoriesContainerView.backgroundColor = UIColor.clearColor()
        categoriesContainerView.reloadData()
        view.addSubview(categoriesContainerView)
        view.addSubview(navBar)
        
    }

}

// MARK: GigCategoriesBarDelegate

extension GigMainCategoriesVC: GigCategoriesBarDelegate {
    func gigCategoriesBarDidSelecItem(indexPath: NSIndexPath) {
        categoriesContainerView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
    }
}

// MARK: UICollectionViewDataSource


extension GigMainCategoriesVC: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let dataSource = dataSource {
            return dataSource.numberOfCategoryViews()
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(CATEGORY_VIEW_IDNT, forIndexPath: indexPath) as? GigSubCategorViewCVCell
        
        if cell == nil {
            cell = GigSubCategorViewCVCell(frame: CGRectZero) // cell's frame size will be set by 'sizeForItemAtIndexPath' delegate method.
        }
        
        cell!.setCategoryViewDataSourceDelegate(self, index: indexPath.row)
        
        return cell!
    }
}

// MARK: UICollectionViewDelegate

extension GigMainCategoriesVC: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension GigMainCategoriesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: maxWidth, height: maxHeight)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
}

// MARK: UIScrollViewDelegate

extension GigMainCategoriesVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let centeredIndexPath = categoriesContainerView.indexPathForItemAtPoint(CGPoint(x: CGRectGetMidX(categoriesContainerView.bounds), y: CGRectGetMidY(categoriesContainerView.bounds)))
        if let selectedIndexPath = centeredIndexPath {
            // Notify GigCategoriesCVC which category is viewing now
            notificationCenter.postNotificationName(DID_SELECT_SUBCATEGORY_ATINDEXPATH, object: nil, userInfo: ["indexPath": selectedIndexPath])
        }
        
    }
}

// MARK: GigMainCategoriesViewDataSource

extension GigMainCategoriesVC: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let dataSource = dataSource {
            return dataSource.numberOfSectionsInCategoryView(tableView)
        } else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataSource = dataSource {
            return dataSource.categoryView(tableView, numberOfRowsInSection: section)
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let dataSource = dataSource {
            return dataSource.categoryView(tableView, cellForRowAtIndexPath: indexPath)
        } else {
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CATEGORY_DATA_IDNT)
            return cell
        }
    }
    
}

// MARK: GigMainCategoriesViewDelegate

extension GigMainCategoriesVC: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.categoryView?(tableView, didSelectRowAtIndexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return delegate?.categoryView?(tableView, titleForHeaderInSection: section)
    }
}





























