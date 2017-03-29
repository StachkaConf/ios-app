//
//  UITableView.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 29.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

extension UITableView {
    func register<C: UITableViewCell>(_ cell: C.Type) where C: ConfigurableCell {
        let cell = UINib(nibName: C.identifier, bundle: Bundle.main)
        register(cell, forCellReuseIdentifier: C.identifier)
    }

    func dequeueCell(_ cell: ConfigurableCell.Type) -> ConfigurableCell {
        guard let cell = dequeueReusableCell(withIdentifier: cell.identifier) as? ConfigurableCell else {
            fatalError()
        }
        return cell
    }

}
