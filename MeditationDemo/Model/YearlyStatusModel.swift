//
//  YearlyStatusModel.swift
//  MeditationDemo
//
//  Created by Apple on 14/07/23.
//

import SwiftUI

struct YearlyStatusModel: Identifiable {
    let id = UUID().uuidString
    let month: String
    let minutes: Int
}

extension YearlyStatusModel {
    static let walkWorkout: [YearlyStatusModel] = [
        .init(month: "Jan", minutes: 23),
        .init(month: "Mar", minutes: 35),
        .init(month: "May", minutes: 55),
        .init(month: "Jul", minutes: 30),
        .init(month: "Sep", minutes: 15),
        .init(month: "Nov", minutes: 65),
    ]
}
