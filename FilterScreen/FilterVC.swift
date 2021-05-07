//
//  FilterVC.swift
//  FilterScreen
//
//  Created by Kushal Choudhary on 07/05/21.
//

import Foundation
import UIKit

class FilterVC: UIViewController {
    
    @IBOutlet weak var filterView: HeaderView!
    @IBOutlet weak var sortView: HeaderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        filterView.controller = FilterViewUIController()
        sortView.controller = SortUICOntroller()
    }
}
