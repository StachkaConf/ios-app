//
//  TableViewHeightCalculator.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

protocol TableViewHeightCalculator {
    func height(for row: Int, viewModel: CellViewModel, tableView: UITableView) -> CGFloat
    func clearCache()
}
