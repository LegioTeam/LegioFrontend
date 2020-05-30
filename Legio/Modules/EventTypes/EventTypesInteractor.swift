//
//  EventTypesInteractor.swift
//  Legio
//
//  Created by Mac on 09.11.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol EventTypesInteractorProtocol {
    
    func getInterestList(completion: @escaping InterestsService.AllInterestsResult)
    func getMyInterests(completion: @escaping InterestsService.MyInterestsResult)
    func updateMyInterests(
        idInterests: [Int],
        completion: @escaping InterestsService.MyInterestsResult)
}

class EventTypesInteractor: EventTypesInteractorProtocol {
    
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
