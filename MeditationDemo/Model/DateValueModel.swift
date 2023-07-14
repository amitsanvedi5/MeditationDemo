//
//  DateValueModel.swift
//  MeditationDemo
//
//  Created by Apple on 14/07/23.
//

import SwiftUI

struct DateValueModel: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
    var isSelected: Bool = false
    var percent: Double = 0
}
