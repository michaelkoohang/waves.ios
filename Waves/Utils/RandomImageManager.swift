//
//  RandomImageManager.swift
//  Waves
//
//  Created by Michael Koohang on 3/1/21.
//

import Foundation

struct RandomImageManager {
    static func getImage() -> String {
        return "doodle-\(Int.random(in: 1..<11))"
    }
}
