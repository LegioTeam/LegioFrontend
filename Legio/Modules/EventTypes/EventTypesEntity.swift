//
//  EventTypesEntity.swift
//  Legio
//
//  Created by Sergey Mikhailov on 30.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

public class EventTypesEntity<T> {
  public var value: T

  public weak var parent: EventTypesEntity?
  public var children = [EventTypesEntity<T>]()

  public init(value: T) {
    self.value = value
  }

  public func addChild(_ node: EventTypesEntity<T>) {
    children.append(node)
    node.parent = self
  }
}

extension EventTypesEntity: CustomStringConvertible {
  public var description: String {
    var s = "\(value)"
    if !children.isEmpty {
      s += " {" + children.map { $0.description }.joined(separator: ", ") + "}"
    }
    return s
  }
}

