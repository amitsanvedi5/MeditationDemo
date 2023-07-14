//
//  IndicatorPoint.swift
//  MeditationDemo
//
//  Created by Apple on 14/07/23.
//

import SwiftUI

struct IndicatorPoint: View {
    var body: some View {
        ZStack{
            Circle()
                .fill(Color(MeditationConstant.Color.Purple))
            Circle()
                .stroke(Color(red: 0.98, green: 0.98, blue: 0.98),
                        style: StrokeStyle(lineWidth: 8))
        }
        .frame(width: 16, height: 16)
    }
}

struct IndicatorPoint_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorPoint()
    }
}
