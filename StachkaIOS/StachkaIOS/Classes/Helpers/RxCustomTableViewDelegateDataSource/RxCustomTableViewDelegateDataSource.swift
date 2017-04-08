//
//  RxCustomTableViewDelegateDataSource.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 08.04.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import RxDataSources
import UIKit

class RxCustomTableViewDelegateDataSource<S: SectionModelType>: RxTableViewSectionedReloadDataSource<S>, UITableViewDelegate {

    typealias ConfigureCellHeight = (_ item: S.Item, _ tableView: UITableView) -> CGFloat

    var configureCellHeight: ConfigureCellHeight!

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return configureCellHeight(self[indexPath], tableView)
    }
}

