//
//  CenterCellCollectionViewFlowLayout.swift
//  gigCategories
//
//  Created by VictorKid on 2015/6/14.
//  Copyright (c) 2015年 VictorKid. All rights reserved.
//

import UIKit

class CenterCellCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

        if let cv = self.collectionView {
            
            let cvBounds = cv.bounds
            let halfWidth = cvBounds.size.width * 0.5;
            let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidth;
            
            if let attributesForVisibleCells = self.layoutAttributesForElementsInRect(cvBounds) as? [UICollectionViewLayoutAttributes] {
                
                var candidateAttributes : UICollectionViewLayoutAttributes?
                for attributes in attributesForVisibleCells {
                    
                    // == Skip comparison with non-cell items (headers and footers) == //
                    if attributes.representedElementCategory != UICollectionElementCategory.Cell {
                        continue
                    }
                    
                    if let candAttrs = candidateAttributes {
                        
                        let a = attributes.center.x - proposedContentOffsetCenterX
                        let b = candAttrs.center.x - proposedContentOffsetCenterX
                        
                        if fabsf(Float(a)) < fabsf(Float(b)) {
                            candidateAttributes = attributes;
                        }
                        
                    } else { // == First time in the loop == //
                        
                        candidateAttributes = attributes;
                        continue;
                    }
                    
                }
                
                return CGPoint(x : candidateAttributes!.center.x - halfWidth, y : proposedContentOffset.y);
                
            }
            
        }
        
        // Fallback
        return super.targetContentOffsetForProposedContentOffset(proposedContentOffset)
    }
   
}
