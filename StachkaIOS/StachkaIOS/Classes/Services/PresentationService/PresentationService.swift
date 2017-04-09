//
//  PresentationService.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 01.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import RxSwift

protocol PresentationService {
    func updatePresentationsAndSave() -> Observable<Void>
    func updatePresentationsAndSave(with configuration: PresentationServcieConfiguration) -> Observable<Void>
    func presentationsUpdated() -> Observable<Void>
    func filteredPresentations(with filters: [Filter]) -> Observable<[Presentation]>
}
