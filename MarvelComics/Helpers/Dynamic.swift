//
//  Dynamic.swift
//  MarvelComics
//
//  Created by Murat Sudan on 07/11/2017.
//  Copyright © 2017 Tarum Nadus. All rights reserved.
//

import Foundation

class Dynamic<T> {
    
    typealias NotifierBlock =  (T) -> Void
    var notifier: NotifierBlock?
    
    var value:T {
        didSet {
            notifier?(value)
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    func bind(_ notifier:NotifierBlock?) {
        self.notifier = notifier
    }
    
    func bindAndFire(_ bindBlock: NotifierBlock?) {
        self.notifier = bindBlock
        notifier?(value)
    }
    
}
