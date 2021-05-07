//
//  FilterHeaderView.swift
//  FilterScreen
//
//  Created by Kushal Choudhary on 07/05/21.
//

import UIKit
protocol FilterHeaderViewDelegate {
    func didSelectHeader(group:CollectionFilterGroups)
}
class FilterHeaderView: UIView {
    @IBOutlet weak var rightImageInInsideHeader: UIImageView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var lineView: UIView!
    
    
    var delegate: FilterHeaderViewDelegate!
    var group: CollectionFilterGroups!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commoninit()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commoninit()
    }
    private func commoninit(){
        Bundle.main.loadNibNamed("FilterHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    func setData(delegate:FilterHeaderViewDelegate,group: CollectionFilterGroups){
        self.button.setTitle(group.rawValue, for: .normal)
        self.button.setTitleColor(.black, for: .normal)
        self.delegate = delegate
        self.group = group
    }
    @IBAction func didTapButton(_ sender: Any) {
        button.isSelected.toggle()
        if button.isSelected {
            rightImageInInsideHeader.image = UIImage(named: "up_arrow")
            lineView.backgroundColor = UIColor.red
            button.titleLabel?.textColor = UIColor.red
            
        }else{
            rightImageInInsideHeader.image = UIImage(named: "down_arrow")
            lineView.backgroundColor = UIColor.gray
            button.titleLabel?.textColor = UIColor.black
        }
        self.delegate.didSelectHeader(group: group)
    }
}

