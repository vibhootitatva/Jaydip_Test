//
//  FARefereshTableView.swift
//  Favist
//
//  Created by Kashyap Patel on 23/09/17.
//  Copyright © 2017 Openxcell. All rights reserved.
//

import Foundation
import UIKit

class AppRefereshTableView: UITableView {
    
    var refControl: UIRefreshControl = UIRefreshControl()
    var handleRefresh: ((_ refreshControl: UIRefreshControl) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        refControl.tintColor = UIColor.darkGray
        refControl.attributedTitle = NSAttributedString(string: "",attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        refControl.addTarget(self, action: #selector(contentReferesh(refreshControl:)), for: .valueChanged)
        
        // Add to Table View
        if #available(iOS 10.0, *) {
            self.refreshControl = refControl
        } else {
            self.addSubview(refControl)
        }
    }
    
    @objc func contentReferesh(refreshControl: UIRefreshControl) {
        self.handleRefresh!(refreshControl)
    }
}
