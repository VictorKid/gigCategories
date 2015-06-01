//
//  GigSubCategorViewCVCell.swift
//  gigCategories
//
//  Created by VictorKid on 2015/5/23.
//  Copyright (c) 2015年 VictorKid. All rights reserved.
//

import UIKit

let CATEGORY_DATA_IDNT = "Category_Data_Cell"

class GigSubCategorViewCVCell: UICollectionViewCell {
    
    var aCategoryView: UITableView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        aCategoryView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        aCategoryView.registerClass(UITableViewCell.self, forCellReuseIdentifier: CATEGORY_DATA_IDNT)
        aCategoryView.clipsToBounds = false
//        aCategoryView.backgroundColor = UIColor.redColor()
        contentView.addSubview(aCategoryView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        aCategoryView.frame = contentView.bounds
    }
    
    func setCategoryViewDataSourceDelegate(dataSouceDelegateClass: AnyObject, index: Int) {
        aCategoryView.dataSource = dataSouceDelegateClass as? UITableViewDataSource
        aCategoryView.delegate = dataSouceDelegateClass as? UITableViewDelegate
        aCategoryView.tag = index
        aCategoryView.reloadData()
    }
    
}
