//
//  MagnifierRect.swift
//  MeditationDemo
//
//  Created by Apple on 14/07/23.
//

import SwiftUI

public struct MagnifierRect: View {
    @Binding var currentNumber: Double
    @Binding var currentDateString: String
    
    var valueSpecifier:String

    @Environment(\.colorScheme) var colorScheme: ColorScheme
    func checkMood() -> String {
        let val : Double = self.currentNumber
        switch val {
        case 0...20:
            return "Really Bad"
        case 20...40:
            return "Not Good"
        case 40...60:
            return "I'm Ok"
        case 60...80:
            return "Really Great"
        default:
            return "Best Day Ever"
        }
    }
    func getWidthFromString(_ str : String) -> CGFloat {
        let font = UIFont(name: "Helvetica", size: 13)
        let fontAttributes = [NSAttributedString.Key.font: font]
        let text = str
        let size = (text as NSString).size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])
        return size.width + 15
    }

    public var body: some View {
        ZStack{
            Text(self.checkMood())
                .font(.system(size: 13, weight: .semibold))
                .offset(x: 0, y:-12)
                .foregroundColor(Color.black)
            Text("\(self.currentNumber, specifier: valueSpecifier)")
                .font(.system(size: 11, weight: .semibold))
                .offset(x: 0, y: 0)
                .foregroundColor(Color.black)
            Text(self.currentDateString)
                .font(.system(size: 11, weight: .semibold))
                .offset(x: 0, y:12)
                .foregroundColor(Color.black)
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black, lineWidth: 2)
                .foregroundColor(Color.white)
                .shadow(color: Color.gray, radius: 8, x: 0, y: 0)
                .frame(width: getWidthFromString(self.checkMood()), height: 50)
        }
        .offset(x: 0, y: -15)
        
    }
}
