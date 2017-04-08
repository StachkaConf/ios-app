//
//  SectionHeader.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 08.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

protocol TableHeader {
    /// идентификатор ячейки в сториборде
    static var identifier: String { get }

    func configure(with viewModel: TableHeaderViewModel)
}

protocol TableStaticHeader: TableHeader {
    static var headerHeight: CGFloat { get }
}

extension TableHeader {
    static var identifier: String {
        return String(describing: self)
    }
}

protocol TableHeaderViewModel {
    var associatedHeader: TableHeader.Type { get }
}
