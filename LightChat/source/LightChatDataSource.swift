//
//  LightChat
//
//  Created by Vladislav Stanishevsky.
//  Copyright © 2018 Stanishevsky. All rights reserved.
//

import UIKit

public protocol LightChatDataSource: LightChatItemable {
    
    func numberOfItems() -> Int
    
    func collectionCellType(forIndex index: Int) -> LightChatCollectionViewCell.Type
    
    func item(atIndex index: Int) -> Item
    
    func willDisplayItem(atIndex index: Int)
}
