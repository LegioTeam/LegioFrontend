//
//  PosterImage.swift
//  Legio
//
//  Created by Mac on 08.03.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import Foundation

class PosterImage: Codable {
    
    let preview: String?
    let original: String?
    
    enum CodingKeys: String, CodingKey {
        
        case preview = "preview"
        case original = "original"
    }
    
}

