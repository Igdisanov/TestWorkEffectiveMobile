//
//  Category.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 24.08.2022.
//

import Foundation

enum Categories {
    case Phone
    case Computer
    case Health
    case Books
}

struct Category {
    
    var category: Categories
    
    var name: String {
        switch category {
        case .Phone:
            return "Phone"
        case .Computer:
            return "Computer"
        case .Health:
            return "Health"
        case .Books:
            return "Books"
        }
    }
    
    var image: String {
        switch category {
        case .Phone:
            return "Phone"
        case .Computer:
            return "Computer"
        case .Health:
            return "Health"
        case .Books:
            return "Books"
        }
    }
    var chosen: Bool = false
}
