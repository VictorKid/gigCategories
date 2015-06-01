//
//  ViewController.swift
//  gigCategories
//
//  Created by VictorKid on 2015/5/21.
//  Copyright (c) 2015年 VictorKid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var maxWidth: CGFloat = 0.0
    var maxHeight: CGFloat = 0.0
    
    var gigMainCategoriesVC = GigMainCategoriesVC()
    var categoryItems = [CategoryItem]()
    var categoryData = [
        ["1"],
        ["1", "2"],
        ["1", "2", "3"],
        ["1", "2", "3", "4"],
        ["1", "2", "3", "4", "5"],
        ["1", "2", "3", "4", "5", "6"],
        ["1", "2", "3", "4", "5", "6", "7"],
        ["1", "2", "3", "4", "5", "6", "7", "8"],
        ["1", "2", "3", "4", "5", "6", "7", "8", "9"],
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryItems = [
            CategoryItem(title: "傢俱", icon: UIImage(named: "double_bed")!),
            CategoryItem(title: "影音", icon: UIImage(named: "films")!),
            CategoryItem(title: "科技", icon: UIImage(named: "mac")!),
            CategoryItem(title: "文藝", icon: UIImage(named: "music_note")!),
            CategoryItem(title: "理財", icon: UIImage(named: "note_dollar")!),
            CategoryItem(title: "文具", icon: UIImage(named: "ruler_pencil")!),
            CategoryItem(title: "體育", icon: UIImage(named: "soccer_ball")!),
            CategoryItem(title: "戶外", icon: UIImage(named: "surfer")!),
            CategoryItem(title: "休閒", icon: UIImage(named: "tea_cup")!),
        ]
        
        gigMainCategoriesVC.categoryItems = categoryItems
        gigMainCategoriesVC.dataSource = self
        gigMainCategoriesVC.delegate = self
        
        view.addSubview(gigMainCategoriesVC.view)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
}

extension ViewController: GigMainCategoriesViewDataSource {
    func numberOfCategoryViews() -> Int {
        return categoryItems.count
    }
    
    func numberOfSectionsInCategoryView(categoryView: UITableView) -> Int {
        return 1
    }
    
    func categoryView(categoryView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryData[categoryView.tag].count
    }
    
    func categoryView(categoryView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = categoryView.dequeueReusableCellWithIdentifier(CATEGORY_DATA_IDNT, forIndexPath: indexPath) as? UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CATEGORY_DATA_IDNT)
        }
    
        let cellData = categoryData[categoryView.tag]
        let aLable = UILabel()
        aLable.text = cellData[indexPath.row] as String
        aLable.sizeToFit()
        aLable.center = CGPoint(x: CGRectGetMidX(cell!.contentView.frame), y: CGRectGetMidY(cell!.contentView.frame))
        cell!.contentView.addSubview(aLable)
        
        return cell!
    }
}

extension ViewController: GigMainCategoriesViewDelegate {
    func categoryView(categoryView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        categoryView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("showGigDetails", sender: self)
    }
}
















