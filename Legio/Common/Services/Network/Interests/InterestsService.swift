//
//  InterestsService.swift
//  Legio
//
//  Created by Mac on 17.03.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol InterestsService {
    
    func interestsList(completion: @escaping InterestsResponse)
    func myInterests(completion: @escaping InterestsResponse)
    func update(idMyInterests: [Int])
}

extension InterestsService {
    
    public typealias InterestsResponse = (Result<InterestsList, Error>) -> Void
}
