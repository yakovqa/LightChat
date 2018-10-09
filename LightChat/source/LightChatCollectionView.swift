//
//  LightChat
//
//  Created by Vladislav Stanishevsky.
//  Copyright © 2018 Stanishevsky. All rights reserved.
//

import UIKit

public class LightChatCollectionView<Layout: LightChatCollectionSizeable>: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    public weak var lightChatCollectionDataSource: LightChatCollectionDataSource!
    public weak var scrollDelegate: UIScrollViewDelegate?
    
    required public init(collectionLayout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: collectionLayout)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload() {
        // Stop scrolling
        setContentOffset(contentOffset, animated: false)
        
        // Saving previous offset before reloadData
        let beforeContentSize = contentSize
        
        reloadData()
        layoutIfNeeded()
        
        let afterContentSize = contentSize
        
        // Calculate new contentOffset after data is updated
        let newOffset = CGPoint(
            x: contentOffset.x + (afterContentSize.width - beforeContentSize.width),
            y: contentOffset.y + (afterContentSize.height - beforeContentSize.height))
        
        setContentOffset(newOffset, animated: false)
    }
    
    public func scrollToBottom(animated: Bool) {
        layoutIfNeeded()
        
        let contentLedge = contentSize.height - frame.height
        
        if contentLedge > 0 {
            setContentOffset(CGPoint(x: contentOffset.x, y: contentLedge), animated: animated)
        }
    }
    
    //MARK: UICollectionViewDataSource
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lightChatCollectionDataSource.numberOfItems(inSection: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return lightChatCollectionDataSource.cellForItem(atIndexPath: indexPath)
    }
    
    //MARK: UICollectionViewDelegate
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        return lightChatCollectionDataSource.sizeForItem(atIndexPath: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        lightChatCollectionDataSource.willDisplay(cell: cell as! LightChatCollectionViewCell, forItemAt: indexPath)
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidScroll?(scrollView)
    }

    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewWillBeginDragging?(scrollView)
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        scrollDelegate?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }
    
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewWillBeginDecelerating?(scrollView)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidEndDecelerating?(scrollView)
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidEndScrollingAnimation?(scrollView)
    }

    public func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidScrollToTop?(scrollView)
    }

    //MARK: Private
    
    private func initialize() {
        dataSource = self
        delegate = self
        showsVerticalScrollIndicator = false
    }
}

