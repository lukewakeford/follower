//
//  FLabel.swift
//  follower
//
//  Created by Luke Wakeford on 29/08/2020.
//

import UIKit

enum FLabelType {
    case title
    case stat
}

class FLabel:UILabel {
    
    convenience init(_ type: FLabelType) {
        self.init(frame: CGRect.zero)
        switch type {
        case .title:
            self.font = .systemFont(ofSize: 16)
            self.textColor = .white
        case .stat:
            self.font = .boldSystemFont(ofSize: 30)
            self.textColor = .white
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
