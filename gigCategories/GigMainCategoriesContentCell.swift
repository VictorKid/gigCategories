//
//  GigMainCategoriesContentCell.swift
//  meetGigs
//
//  Created by 賴咸文 on 2016/4/2.
//  Copyright © 2016年 meetGigs. All rights reserved.
//

import UIKit

class GigMainCategoriesContentCell: UICollectionViewCell {
    
    var categoryContent: UIView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setCategoryConttent(content: UIView) {
        // in case unnecessary view hierarchy
        if let categoryContent = categoryContent {
            categoryContent.removeFromSuperview()
        }
        categoryContent = content
        contentView.addSubview(categoryContent!)
    }
    
}
