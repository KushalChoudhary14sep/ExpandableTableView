//
//  FilterViewUIController.swift
//  FilterScreen
//
//  Created by Kushal Choudhary on 07/05/21.
//

import Foundation
import UIKit

class FilterViewUIController: NSObject, UITableViewDataSource, UITableViewDelegate, FilterHeaderViewDelegate {
    func didSelectHeader(group: CollectionFilterGroups) {
        ds.toggleExpandFilter(filter: group)
    }
    let ds = FilterDataSource()
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = FilterHeaderView()
        header.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 70)
        header.setData(delegate: self, group: ds.filters[section].0)
        return header
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return ds.filters.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ds.isExpanded(group: ds.filters[section].0){
            return ds.filters[section].1.count
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FilterTableViewCell()
        cell.setData(label: ds.filters[indexPath.section].1[indexPath.row].rawValue)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FilterTableViewCell
        cell.checked.toggle()
        if cell.checked {
            cell.button.setImage(UIImage(named: "checked_radioButton"), for: .normal)
        }else{
            cell.button.setImage(UIImage(named: "unchecked_radioButton"), for: .normal)
        }
        
    }
    
    weak var view:HeaderView? {
        didSet{
            setupTableView()
            setImage()
        }
    }
    func setupTableView(){
        ds.delegate = self
        view?.tableView.delegate = self
        view?.tableView.dataSource = self
        view?.headerLabel.text = "FILTER"
    }
    
    func setImage(){
        view?.leftImage.image = UIImage(named: "down_arrow")
        view?.rightImage.image = UIImage(named: "down_arrow")
    }
}

extension FilterViewUIController : HeaderViewDelegate {
    func didToggleHeaderImages() {
        view?.isExpended.toggle()
        if view!.isExpended {
            view?.leftImage.image = UIImage(named: "up_arrow")
            view?.rightImage.image = UIImage(named: "up_arrow")
            view?.headerLabel.textColor = .red
            
        }else{
            view?.leftImage.image = UIImage(named: "down_arrow")
            view?.rightImage.image = UIImage(named: "down_arrow")
            view?.headerLabel.textColor = .black
        }
    }
}

class FilterTableViewCell : UITableViewCell{
    var button : UIButton!
    var label  : UILabel!
    var checked : Bool = false
    init(){
        super.init(style: .default, reuseIdentifier: nil)
        button = UIButton(frame: CGRect(x: 40, y: 0, width: 40, height: self.frame.size.height))
        label = UILabel(frame: CGRect(x: 80, y: 0, width: self.frame.size.width - 80, height: self.frame.size.height))
        self.label.textAlignment = .left
        self.addSubview(button)
        self.addSubview(label)
        button.setImage(UIImage(named: "unchecked_radioButton"), for: .normal)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    func setData(label : String){
        self.label.text = label
    }
}




extension FilterViewUIController: FilterDataSourceDelegates {
    func didSortingOptionChanged(sort: SortByOptions) {
        self.view?.tableView.reloadData()
    }
    
    func didFiltersChanged(newFilters: [CollectionFilter]) {
        self.view?.tableView.reloadData()
        
    }
    
    func didFIlterExpanded(group: CollectionFilterGroups) {
        self.view?.tableView.reloadData()
    }
    
}

class SortUICOntroller: FilterViewUIController {
    override weak var view : HeaderView? {
        didSet{
            view?.headerLabel.text = "SORT BY"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ds.sortingOptions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SortByTableViewCell()
        cell.setData(label: ds.sortingOptions[indexPath.row].rawValue)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SortByTableViewCell
        cell.button.setImage(UIImage(named: "checked_radioButton"), for: .normal)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SortByTableViewCell
        cell.button.setImage(UIImage(named: "unchecked_radioButton"), for: .normal)
    }
}

class SortByTableViewCell : UITableViewCell{
    var button : UIButton!
    var label  : UILabel!
    init(){
        super.init(style: .default, reuseIdentifier: nil)
        button = UIButton(frame: CGRect(x: 40, y: 0, width: 40, height: self.frame.size.height))
        label = UILabel(frame: CGRect(x: 80, y: 0, width: self.frame.size.width - 80, height: self.frame.size.height))
        self.addSubview(button)
        self.addSubview(label)
        button.setImage(UIImage(named: "unchecked_radioButton"), for: .normal)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    func setData(label : String){
        self.label.text = label
    }
}
