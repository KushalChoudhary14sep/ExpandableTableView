//
//  HeaderView.swift
//  FilterScreen
//
//  Created by Kushal Choudhary on 07/05/21.
//

import UIKit

protocol HeaderViewDelegate : class {
    func didToggleHeaderImages()
}

class HeaderView: UIView{
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: HeightTableView!
    @IBOutlet var contentView: UIView!
   
    var isExpended : Bool = false
    var controller : FilterViewUIController? = nil {
        didSet{
            controller?.view = self
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commoninit()
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commoninit()
    }
    @IBAction func didTapOnHeaderView(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.tableView.isHidden.toggle()
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
        controller?.didToggleHeaderImages()
    }
    
    private func commoninit(){
        Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)
        addSubview(contentView)
        self.tableView.isHidden = true
        self.tableView.separatorStyle = .none
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
