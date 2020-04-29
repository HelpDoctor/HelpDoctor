//
//  InterestCollectionViewLayout.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 11.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

protocol InterestCollectionViewLayoutDelegate: class {
    func width(forItemAt indexPath: IndexPath) -> CGFloat
}

class InterestCollectionViewLayout: UICollectionViewLayout {
    
    weak var delegate: InterestCollectionViewLayoutDelegate?
    
    private var cache: [IndexPath: UICollectionViewLayoutAttributes] = [:]
    
    override var collectionViewContentSize: CGSize {
        var maxX = 0.f
        var maxY = 0.f
        for attribute in self.cache.values {
            if maxX < attribute.frame.maxX {
                maxX = attribute.frame.maxX
            }
            if maxY < attribute.frame.maxY {
                maxY = attribute.frame.maxY
            }
        }
        return CGSize(width: maxX, height: maxY)
    }
    
    override func prepare() {
        super.prepare()
        self.cache = [:]
        guard let collectionView = self.collectionView, let delegate = self.delegate else {
            return
        }
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        let cellHeight = 44.f
        
        var firstRowWidth = 0.f
        var secondRowWidth = 0.f
        var thirdRowWidth = 0.f
        var allAttributes: [IndexPath: UICollectionViewLayoutAttributes] = [:]
        for itemIndex in 0 ..< numberOfItems {
            let indexPath = IndexPath(item: itemIndex, section: 0)
            let cellWidth = delegate.width(forItemAt: indexPath)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            let isForFirstRow = firstRowWidth <= secondRowWidth
            let isForSecondRow = secondRowWidth <= thirdRowWidth
            if isForFirstRow {
                let x = firstRowWidth
                let y = 0.f
                attributes.frame = CGRect(x: x, y: y, width: cellWidth, height: cellHeight)
                allAttributes[indexPath] = attributes
                firstRowWidth += cellWidth + 9
            } else {
                let x = isForSecondRow ? secondRowWidth : thirdRowWidth
                let y = isForSecondRow ? cellHeight + 12 : (cellHeight + 12) * 2
                attributes.frame = CGRect(x: x, y: y, width: cellWidth, height: cellHeight)
                allAttributes[indexPath] = attributes
                isForSecondRow ? (secondRowWidth += cellWidth + 9) : (thirdRowWidth += cellWidth + 9)
            }
//            let x = isForFirstRow ? firstRowWidth : secondRowWidth
//            let y = isForFirstRow ? 0.0 : cellHeight + 2
//            attributes.frame = CGRect(x: x, y: y, width: cellWidth, height: cellHeight)
//            allAttributes[indexPath] = attributes
//            isForFirstRow ? (firstRowWidth += cellWidth + 2) : (secondRowWidth += cellWidth + 2)
        }
        self.cache = allAttributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.cache.values.filter { $0.frame.intersects(rect) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.cache[indexPath]
    }
    
}
