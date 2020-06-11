//
//  HabitItem.swift
//  Habit Tracker
//
//  Created by Myat Thu Ko on 6/11/20.
//  Copyright © 2020 Myat Thu Ko. All rights reserved.
//

import Foundation

struct HabitItems: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
    var completionAmount: Int
}
