//
//  RandomHelper.swift
//  Cast Number
//
//  Created by Султан Магомедкадиев on 26/03/2017.
//  Copyright © 2017 Magomedkadiev. All rights reserved.
//

import UIKit


class RandomHelper {
    
    static let shared = RandomHelper()
    
    func generateNumber<T : SignedInteger>(inRange range: ClosedRange<T> = 1...6) -> T {
        let length = (range.upperBound - range.lowerBound + 1).toIntMax()
        let value = arc4random().toIntMax() % length + range.lowerBound.toIntMax()
        return T(value)
    }
    
}
