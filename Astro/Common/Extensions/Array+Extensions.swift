//
//  Array+Extensions.swift
//  Astro
//
//  Created by Suhendra Ahmad on 9/21/17.
//  Copyright © 2017 Ainasoft. All rights reserved.
//

import Foundation

extension Array {
    func chunks(_ chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
        }
    }
}
