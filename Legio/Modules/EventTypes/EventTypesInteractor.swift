//
//  EventTypesInteractor.swift
//  Legio
//
//  Created by Mac on 09.11.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol EventTypesInteractorProtocol {
    
    func getInterestList(completion: @escaping InterestsService.InterestsResponse)
    func updateMyInterests(idInterests: [Int]) 
}

class EventTypesInteractor: EventTypesInteractorProtocol {
    
    private let interestsService: InterestsService = InterestsServiceImplementation()
    
    func getInterestList(completion: @escaping (Result<InterestsList, Error>) -> Void) {
        interestsService.interestsList(completion: completion)
    }
    
    func updateMyInterests(idInterests: [Int]) {
        interestsService.update(idMyInterests: idInterests)
    }
    
}
