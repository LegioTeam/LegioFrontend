//
//  EventTypesCell.swift
//  Legio
//
//  Created by Sergey Mikhailov on 30.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import UIKit

protocol EventTypesCellProtocol {
    func configure(event: EventTypesEntity<String>)
}

class EventTypesCell: UICollectionViewCell, EventTypesCellProtocol{

    @IBOutlet var nameEventType: UILabel!
    
    func configure(event: EventTypesEntity<String>) {
        nameEventType.text = event.value
    }
}
