//
//  StatisticsModel.swift
//  MeditationDemo
//
//  Created by Apple on 14/07/23.
//

import SwiftUI

struct StatisticsModel: Identifiable {
    let id = UUID().uuidString
    let color: Color
    let title: String
    let imgStr: String
    let value: String
    let unit: String
}
