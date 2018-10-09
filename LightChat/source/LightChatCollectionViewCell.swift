//
//  LightChat
//
//  Created by Vladislav Stanishevsky.
//  Copyright © 2018 Stanishevsky. All rights reserved.
//

import UIKit

open class LightChatCollectionViewCell: UICollectionViewCell {
    
    open class func reuseIdentifier() -> String {
        fatalError()
    }
    
    /**
     *  Must be overriden. Item must be cast to custom type.
     */
    open func updateWith(item: Any) {}
}
