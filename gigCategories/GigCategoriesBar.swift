//
//  GigCategoriesBar.swift
//  gigCategories
//
//  Created by VictorKid on 2015/5/21.
//  Copyright (c) 2015年 VictorKid. All rights reserved.
//

import UIKit

protocol GigCategoriesBarDelegate {
    func gigCategoriesBarDidSelecItem(indexPath: NSIndexPath)
}

class GigCategoriesBar: NSObject {
    
    var delegate: GigCategoriesBarDelegate?
    var maxWidth: CGFloat = 0.0
    var gigCategoriesCVC = GigCategoriesCVC()
    
    override init() {
        super.init()
    }
    
    init(sourceView: UIView, categoryItems: [CategoryItem], center: Bool, mainCategoriesVC: GigMainCategoriesVC) {
        super.init()
        
        maxWidth = UIScreen.mainScreen().bounds.size.width
        
        mainCategoriesVC.scrollDelegate = self
        
        gigCategoriesCVC.delegate = self
        gigCategoriesCVC.categoryItems = categoryItems
        gigCategoriesCVC.isCenter = center;
        gigCategoriesCVC.gigCategoriesCView.frame = sourceView.bounds
        
        sourceView.addSubview(gigCategoriesCVC.view)
        
    }
   
}

// MARK: GigCategoriesCVCDelegate

extension GigCategoriesBar: GigCategoriesCVCDelegate {
    func gigCategoriesCVCDidSelectIndexPath(indexPath: NSIndexPath) {
        if let delegate = delegate {
            delegate.gigCategoriesBarDidSelecItem(indexPath)
        }
    }
}

extension GigCategoriesBar: GigMainCategoriesViewScrollDelegate {
    func didScrollToAnotherCategory(indexPath: NSIndexPath) {
        gigCategoriesCVC.onCategoryChange(indexPath)
    }
}