//
//  LightChat
//
//  Created by Vladislav Stanishevsky.
//  Copyright © 2018 Stanishevsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataSource: DataSource = DataSource()
        let layout: Layout = Layout()
        let lightChatVC = LightChatViewController<DataSource, Layout>.init(dataSource: dataSource, layout: layout)
        addChild(lightChatVC)
    }
}

class Message {}

class Layout: LightChatCollectionSizeable {
    
    typealias Item = Message

    func size(forItem item: Message) -> CGSize { return .zero }
}

class DataSource: LightChatDataSource {
    
    typealias Item = Message
    
    func numberOfItems() -> Int {
        return 0
    }
    
    func item(atIndex index: Int) -> Message {
        return Message()
    }
    
    func collectionCellType(forIndex index: Int) -> LightChatCollectionViewCell.Type {
        return LightChatCollectionViewCell.self
    }
    
    func willDisplayItem(atIndex index: Int) {
        
    }
}
