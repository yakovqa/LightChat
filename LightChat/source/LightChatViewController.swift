//
//  LightChat
//
//  Created by Vladislav Stanishevsky.
//  Copyright © 2018 Stanishevsky. All rights reserved.
//

import UIKit

open class LightChatViewController<DataSource: LightChatDataSource, Layout: LightChatCollectionSizeable>: UIViewController, LightChatCollectionDataSource {

    public let collectionView: LightChatCollectionView<Layout>
    public let collectionViewLayout: UICollectionViewFlowLayout
    
    public unowned var dataSource: DataSource
    public unowned var layout: Layout

    public init(dataSource: DataSource, layout: Layout) {
        self.dataSource = dataSource
        self.layout = layout
        self.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView = LightChatCollectionView(collectionLayout: self.collectionViewLayout)
        super.init(nibName: nil, bundle: nil)
        collectionView.lightChatCollectionDataSource = self
    }
    
    //TODO: Will be implemented
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View life cycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    open func reload() {
        collectionView.reload()
    }
    
    open func raiseScrollContent(byKeyboardHeight raisedKeyboardHeight: CGFloat) {
        
        let emptyScrollSpace: CGFloat = view.frame.size.height - collectionView.contentSize.height
        
        let keyboardHeight: CGFloat = raisedKeyboardHeight
        
        guard emptyScrollSpace <= keyboardHeight else { return }
        
        let targetScrollOffset = emptyScrollSpace > 0 ? min(keyboardHeight, abs(emptyScrollSpace - keyboardHeight)) : keyboardHeight
        
        let contentOffset = CGPoint(x: collectionView.contentOffset.x,
                                    y: collectionView.contentOffset.y + targetScrollOffset)
        
        collectionView.setContentOffset(contentOffset, animated: true)
    }
    
    open func lowScrollContent(byKeyboardHeight raisedKeyboardHeight: CGFloat) {
        
        var targetScrollContentOffset: CGPoint
        
        let emptyScrollSpace: CGFloat = view.frame.size.height - collectionView.contentSize.height
        
        if emptyScrollSpace > 0 {
            
            targetScrollContentOffset = CGPoint(x: collectionView.contentOffset.x,
                                                y: 0.0)
        } else {
            
            let ledgeContentHeight: CGFloat = collectionView.contentSize.height - view.frame.size.height - collectionView.contentOffset.y
            
            let yContentOffset: CGFloat = collectionView.contentOffset.y
            
            let targetScrollOffset: CGFloat = min(raisedKeyboardHeight, abs(ledgeContentHeight))
            
            let minOffset: CGFloat = min(yContentOffset, targetScrollOffset)
            
            let targetContentOffset = yContentOffset - minOffset
            
            targetScrollContentOffset = CGPoint(x: collectionView.contentOffset.x,
                                                y: targetContentOffset)
            
        }
        
        collectionView.setContentOffset(targetScrollContentOffset, animated: true)
    }
    
    //MARK: Setup
    
    private func setup() {
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(collectionView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    //MARK: LightChatCollectionDataSource

    public func numberOfItems(inSection section: Int) -> Int {
        return dataSource.numberOfItems()
    }
    
    public func cellForItem(atIndexPath indexPath: IndexPath) -> LightChatCollectionViewCell {
        let type = dataSource.collectionCellType(forIndex: indexPath.item)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type.reuseIdentifier(),
                                                      for: indexPath) as! LightChatCollectionViewCell
        cell.updateWith(item: dataSource.item(atIndex: indexPath.item))
        
        return cell
    }
    
    public func sizeForItem(atIndexPath indexPath: IndexPath) -> CGSize {
        return layout.size(forItem: dataSource.item(atIndex: indexPath.item) as! Layout.Item)
    }
    
    public func willDisplay(cell: LightChatCollectionViewCell, forItemAt indexPath: IndexPath) {
        dataSource.willDisplayItem(atIndex: indexPath.item)
    }
}
