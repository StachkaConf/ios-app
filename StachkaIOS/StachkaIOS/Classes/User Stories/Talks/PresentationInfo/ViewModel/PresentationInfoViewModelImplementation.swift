//
//  FeedViewModelImplementation.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PresentationInfoViewModelImplementation {

    weak var view: PresentationInfoView?

    fileprivate let presentationViewModelFactory: PresentationInfoCellViewModelFactory
    fileprivate var _presentationModels: Variable<[CellSectionModel]> = Variable([])

    init(view: PresentationInfoView,
         presentation: Presentation,
         presentationViewModelFactory: PresentationInfoCellViewModelFactory) {
        
        self.view = view
        self.presentationViewModelFactory = presentationViewModelFactory

        _presentationModels.value = [presentationViewModelFactory.section(from: presentation)]
    }
}

extension PresentationInfoViewModelImplementation: PresentationInfoViewModel {
    var presentationModels: Observable<[CellSectionModel]> {
        return _presentationModels.asObservable()
    }
}
