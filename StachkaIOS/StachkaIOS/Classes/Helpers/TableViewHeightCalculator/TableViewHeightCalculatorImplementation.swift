//
//  TableViewHeightCalculatorImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class TableViewHeightCalculatorImplementation: TableViewHeightCalculator {
    var cachedHeights: [Int: CGFloat] = [:]
    var cells: [String: UITableViewCell] = [:]
    
    func clearCache() {
        cachedHeights = [:]
    }
    
    func height(for row: Int, viewModel: CellViewModel, tableView: UITableView) -> CGFloat {
        if let height = cachedHeights[row] {
            return height
        }

        if let cellType = viewModel.associatedCell as? ConfigurableStaticHeightCell.Type {
            return cellType.cellHeight
        }
        let identifier = viewModel.associatedCell.identifier
        var prototypeCell = cells[identifier]
        
        if prototypeCell == nil {
            prototypeCell = tableView.dequeueReusableCell(withIdentifier: identifier)
            cells[identifier] = prototypeCell
        }
        
        guard let cell = prototypeCell,
              let configurable = prototypeCell as? ConfigurableCell else { return 0 }
        
        cell.prepareForReuse()
        configurable.configure(with: viewModel)
        cell.bounds = CGRect(x: 0,
                             y: 0,
                             width: tableView.bounds.size.width,
                             height: cell.bounds.height)
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        let height = cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        cachedHeights[row] = ceil(height)
        
        return ceil(height)
    }
}
