//
//  GeoRequestInteractor.swift
//  Legio
//
//  Created by Mac on 25.05.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol GeoRequestInteractorProtocol {
    
    func getInterestList(completion: @escaping InterestsService.AllInterestsResult)
    func getMyInterests(completion: @escaping InterestsService.MyInterestsResult)
    func updateMyInterests(
        idInterests: [Int],
        completion: @escaping InterestsService.MyInterestsResult)
}

final class GeoRequestInteractor: GeoRequestInteractorProtocol {
    
    private let interestsService: InterestsService = InterestsServiceImplementation()
    
    
    func getInterestList(completion: @escaping InterestsService.AllInterestsResult) {
        interestsService.interestsList(completion: completion)
    }
    
    func getMyInterests(completion: @escaping InterestsService.MyInterestsResult) {
        interestsService.myInterests(completion: completion)
    }
    
    func updateMyInterests(
        idInterests: [Int],
        completion: @escaping InterestsService.MyInterestsResult) {
        interestsService.update(idMyInterests: idInterests, completion: completion)
    }
    
}

