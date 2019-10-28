//
//  ArrayExtensions.swift
//  TheBoxDrop
//
//  Created by Madalina Sinca on 18/10/2019.
//  Copyright © 2019 Madalina Sinca. All rights reserved.
//

import Foundation

extension Array {
    func sortInDecreasingOrder<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { a, b in
            return a[keyPath: keyPath] > b[keyPath: keyPath]
        }
    }
}
