//
//  EventTypesInteractor.swift
//  Legio
//
//  Created by Mac on 09.11.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol EventTypesInteractorProtocol {
    
    func getInterestList(completion: @escaping InterestsService.AllInterestsResponse)
    func getMyInterests(completion: @escaping InterestsService.MyInterestsResponse)
    func updateMyInterests(idInterests: [Int], completion: @escaping InterestsService.MyInterestsResponse)
}

class EventTypesInteractor: EventTypesInteractorProtocol {
    
    private let interestsService: InterestsService = InterestsServiceImplementation()
    
    
    func getInterestList(completion: @escaping InterestsService.AllInterestsResponse) {
        interestsService.interestsList(completion: completion)
    }
    
    func getMyInterests(completion: @escaping InterestsService.MyInterestsResponse) {
        interestsService.myInterests(completion: completion)
    }
    
    func updateMyInterests(idInterests: [Int], completion: @escaping InterestsService.MyInterestsResponse) {
        interestsService.update(idMyInterests: idInterests, completion: completion)
    }
    
}
