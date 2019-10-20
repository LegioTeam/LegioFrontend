//
//  PresetEntity.swift
//  Legio
//
//  Created by Mac on 20.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

enum TypePreset {
    case Party
    case Nerdy
}

struct PresetEntity {
    var typePreset: TypePreset
    var percent: Int
    var size: Float
}
