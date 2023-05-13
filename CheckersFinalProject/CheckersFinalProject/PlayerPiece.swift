//
//  PlayerPiece.swift
//  CheckersFinalProject
//
//  Created by Dylan Shu on 5/6/23.
//

import Foundation
import SwiftUI

struct pieces{
        let id = UUID()
        var piece_alive: Bool = true
        var king: Bool = false
        var color = Color.red
        var select: Bool = false
        var transparent: Double = 0
    }
