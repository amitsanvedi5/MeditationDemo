//
//  LineView.swift
//  MeditationDemo
//
//  Created by Apple on 14/07/23.
//

import SwiftUI

public struct LineView: View {
    @ObservedObject var data: ChartData
    public var title: String?
    public var legend: String?
    public var style: ChartStyle
    public var darkModeStyle: ChartStyle
    public var valueSpecifier: String
    public var legendSpecifier: String
    public var date: [String]

    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var showLegend = false
    @State private var dragLocation:CGPoint = .zero
    @State private var indicatorLocation:CGPoint = .zero
    @State private var closestPoint: CGPoint = .zero
    @State private var opacity:Double = 0
    @State private var currentDataNumber: Double = 0
    @State private var hideHorizontalLines: Bool = true
    @State private var currentDateString: String = ""

    public init(data: [Double],
                date: [String],
                title: String? = nil,
                legend: String? = nil,
                style: ChartStyle = Styles.lineChartStyleOne,
                valueSpecifier: String? = "%.1f",
                legendSpecifier: String? = "%.2f") {
        
        self.data = ChartData(points: data)
        self.date = date
        self.title = title
        self.legend = legend
        self.style = style
        self.valueSpecifier = valueSpecifier!
        self.legendSpecifier = legendSpecifier!
        self.darkModeStyle = style.darkModeStyle != nil ? style.darkModeStyle! : Styles.lineViewDarkMode
       
    }
    
    public var body: some View {
        GeometryReader{ geometry in
            VStack(alignment: .leading, spacing: 8) {
                ZStack{
                    GeometryReader{ reader in
//                        Rectangle()
//                            .foregroundColor(self.colorScheme == .light ? self.darkModeStyle.backgroundColor : self.style.backgroundColor)
                        if(self.showLegend){
                            //Mood Images
                            Legend(data: self.data,
                                   frame: .constant(reader.frame(in: .local)), hideHorizontalLines: self.$hideHorizontalLines, specifier: legendSpecifier)
                                .transition(.opacity)
                                //.animation(Animation.easeOut(duration: 1).delay(1))
                        }
                        Line(data: self.data,
                             frame: .constant(CGRect(x: 0, y: 0, width: reader.frame(in: .local).width - 30, height: reader.frame(in: .local).height - 25)),
                             touchLocation: self.$indicatorLocation,
                             showIndicator: self.$hideHorizontalLines,
                             minDataValue: .constant(0.0),
                             maxDataValue: .constant(100.0),
                             showBackground: false,
                             gradient: self.style.gradientColor
                        )
                        .offset(x: 30, y: 0)
                        .onAppear(){
                            self.showLegend = false
                        }
                        .onDisappear(){
                            self.showLegend = false
                        }
                    }
                    .frame(width: geometry.frame(in: .local).size.width, height: geometry.frame(in: .local).size.height)
                    .offset(x: 0, y: 10 )
//                    MagnifierRect(currentNumber: self.$currentDataNumber, currentDateString: self.$currentDateString, valueSpecifier: self.valueSpecifier)
//                        .opacity(self.opacity)
//                        .offset(x: self.dragLocation.x - geometry.frame(in: .local).size.width/2, y: 36)
                }
                .frame(width: geometry.frame(in: .local).size.width, height: geometry.frame(in: .local).size.height)
                .gesture(DragGesture()
                .onChanged({ value in
                    self.dragLocation = value.location
                    self.indicatorLocation = CGPoint(x: max(value.location.x-30,0), y: 32)
                    self.opacity = 1
                    self.closestPoint = self.getClosestDataPoint(toPoint: value.location, width: geometry.frame(in: .local).size.width-30, height: geometry.frame(in: .local).size.height - 25)
                    self.hideHorizontalLines = true
                })
                    .onEnded({ value in
                        self.opacity = 0
                        self.hideHorizontalLines = true
                    })
                )
            }
        }
    }
    
    func getClosestDataPoint(toPoint: CGPoint, width:CGFloat, height: CGFloat) -> CGPoint {
        let points = self.data.onlyPoints()
        let stepWidth: CGFloat = width / CGFloat(points.count-1)
        let stepHeight: CGFloat = height / CGFloat(points.max()! + points.min()!)
        
        let index:Int = Int(floor((toPoint.x-15)/stepWidth))
        if (index >= 0 && index < points.count){
            self.currentDataNumber = points[index]
            self.currentDateString = self.date[index]
            return CGPoint(x: CGFloat(index)*stepWidth, y: CGFloat(points[index])*stepHeight)
        }
        return .zero
    }
}

struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LineView(data: [8,23,54,32,12,37,7,23,43], date: [String](), title: "Full chart", style: Styles.lineChartStyleOne)
            
            LineView(data: [282.502, 284.495, 283.51, 285.019, 285.197, 286.118, 288.737, 288.455, 289.391, 287.691, 285.878, 286.46, 286.252, 284.652, 284.129, 284.188], date: [String](), title: "Full chart", style: Styles.lineChartStyleOne)
            
        }
    }
}

