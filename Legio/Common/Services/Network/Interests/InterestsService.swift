//
//  InterestsService.swift
//  Legio
//
//  Created by Mac on 17.03.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol InterestsService {
    
    func myInterests(completion: @escaping MyInterestsResponse)
    func interestsList(completion: @escaping AllInterestsResponse)
    func add(idMyInterests: [Int], completion: @escaping MyInterestsResponse)
    func update(idMyInterests: [Int], completion: @escaping MyInterestsResponse)
    
}

extension InterestsService {
    
    public typealias AllInterestsResponse = (Result<InterestsList, Error>) -> Void
    public typealias MyInterestsResponse = (Result<[Int], Error>) -> Void
}
