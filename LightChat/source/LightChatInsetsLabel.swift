//
//  LightChat
//
//  Created by Vladislav Stanishevsky.
//  Copyright © 2018 Stanishevsky. All rights reserved.
//

import UIKit

open class LightChatInsetsLabel: UILabel {
    
    static let defaultTextInsets: UIEdgeInsets = UIEdgeInsets(top: 14.5, left: 14.5, bottom: 12, right: 14.5)
    
    var textInsets: UIEdgeInsets = LightChatInsetsLabel.defaultTextInsets
    
    override open func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    override open var intrinsicContentSize: CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + textInsets.left + textInsets.right
        let heigth = superContentSize.height + textInsets.top + textInsets.bottom
        return CGSize(width: width, height: heigth)
    }
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSizeThatFits = super.sizeThatFits(size)
        let width = superSizeThatFits.width + textInsets.left + textInsets.right
        let heigth = superSizeThatFits.height + textInsets.top + textInsets.bottom
        return CGSize(width: width, height: heigth)
    }
}
