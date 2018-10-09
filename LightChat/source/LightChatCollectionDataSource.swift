//
//  LightChat
//
//  Created by Vladislav Stanishevsky.
//  Copyright © 2018 Stanishevsky. All rights reserved.
//

import UIKit

public protocol LightChatCollectionDataSource: class {
        
    func numberOfItems(inSection section: Int) -> Int
    
    func cellForItem(atIndexPath indexPath: IndexPath) -> LightChatCollectionViewCell
    
    func sizeForItem(atIndexPath indexPath: IndexPath) -> CGSize
    
    func willDisplay(cell: LightChatCollectionViewCell, forItemAt indexPath: IndexPath)
}
