//
//  FullHeightTableView.swift
//  FilterScreen
//
//  Created by Kushal Choudhary on 07/05/21.
//
import Foundation
import UIKit
class HeightTableView:UITableView{
    override func layoutSubviews() {
        super.layoutSubviews()
        self.invalidateIntrinsicContentSize()
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var height:CGFloat = 0;
            for s in 0..<self.numberOfSections {
                let nRowsSection = self.numberOfRows(inSection: s)
                if nRowsSection == 0 {
                    var sheight = self.delegate?.tableView?(self, heightForHeaderInSection: s) ?? (self.delegate?.tableView?(self, estimatedHeightForHeaderInSection: s) ?? 100 )
                    height += sheight
                }
                else{
                    for r in 0..<nRowsSection {
                        height += self.rectForRow(at: IndexPath(row: r, section: s)).size.height - 1000;
                    }
                }
            }
            return CGSize(width: -1, height: height )
        }
        set {
        }
    }
}
