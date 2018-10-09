//
//  LightChat
//
//  Created by Vladislav Stanishevsky.
//  Copyright © 2018 Stanishevsky. All rights reserved.
//

import UIKit

public protocol LightChatCollectionSizeable: LightChatItemable {

    func size(forItem item: Item) -> CGSize
}
