//
//  GigCategoryCVCell.swift
//  gigCategories
//
//  Created by VictorKid on 2015/5/21.
//  Copyright (c) 2015年 VictorKid. All rights reserved.
//

import UIKit

class GigCategoryCVCell: UICollectionViewCell {
    
    var label: UILabel!
    var icon: UIImageView!
    var viewsDictionary: [String: AnyObject]!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.grayColor()
        icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(label)
        contentView.addSubview(icon)
        
        contentView.addConstraints(layoutConstraints())
        
        viewsDictionary = ["label": label,
            "icon": icon]
        
        icon.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[icon(32)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary))
        icon.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[icon(32)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[icon]-8-[label]-8-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary))
    }
    
    func layoutConstraints() -> [NSLayoutConstraint] {
        var result: [NSLayoutConstraint] = []
        result.append(NSLayoutConstraint(item: icon, attribute: .CenterX, relatedBy: .Equal, toItem: contentView, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
        result.append(NSLayoutConstraint(item: label, attribute: .CenterX, relatedBy: .Equal, toItem: contentView, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
        return result
    }
    
}
