//
//  CelenderMainView.swift
//  MeditationDemo
//
//  Created by Apple on 14/07/23.
//

import SwiftUI

struct CelenderMainView: View {
    
    @State var currentDate : Date = Date()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            CelenderView(currentDate: $currentDate)
        }
    }
}

struct CelenderView: View {
    
    @Binding var currentDate : Date
    @State var currentMonth: Int = 0
    
    var body: some View {
        LazyVStack(alignment: .center, spacing: 16) {
            VStack {
                // Month...
                HStack {
                    Button {
                        withAnimation {
                            currentMonth -= 1
                        }
                    } label: {
                        Image(MeditationConstant.Image.back)
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    Spacer()
                    Text(extraDate())
                        .font(.system(size: 18, weight: .semibold))
                    Spacer()
                    Button {
                        withAnimation {
                            currentMonth += 1
                        }
                    } label: {
                        Image(MeditationConstant.Image.next)
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
                .padding([.leading, .trailing], 12)
                .padding(.top, 20)
                Spacer(minLength: 20)
                
                // Days...
                let days: [String] = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
                HStack {
                    ForEach(days, id: \.self) { day in
                        Text(day)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor((day == "Sat") ? .black : .gray)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding([.leading, .trailing], 12)
                
                // Date...
                let columns = Array(repeating: GridItem(.flexible()), count: 7)
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(extractDate()) { value in
                        CardView(value: value)
                    }
                }
                .padding([.leading, .trailing], 12)
                .padding(.top, 6)
                .padding(.bottom, 20)
            }
        }
        .onChange(of: currentMonth) { newValue in
            currentDate = getCurrentMonth()
        }
        .background(.white)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(MeditationConstant.Color.Border), lineWidth: 2)
        )
    }
    
    @ViewBuilder
    func CardView(value: DateValueModel) -> some View {
        ZStack {
            if value.day != -1 {
                Text("\(value.day)")
                    .font(.system(size: 14, weight: .medium))
                    .frame(width: 30, height: 30)
                    .background((value.isSelected && value.percent == 1) ? Color(MeditationConstant.Color.LightPurple) : .clear)
                    .clipShape(Capsule())
                if value.isSelected {
                    Circle()
                        .trim(from: 0, to: value.percent)
                        .stroke(
                            Color(MeditationConstant.Color.Purple),
                            lineWidth: 2
                        )
                        .frame(width: 30, height: 30)
                        .rotationEffect(.degrees(-90))
                }
            }
        }
    }
    func extraDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        
        let date = formatter.string(from: currentDate)
        return date
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month,
                                               value: self.currentMonth,
                                               to: Date()) else {
            return Date()
        }

        return currentMonth
    }
    func extractDate() -> [DateValueModel] {
        // Getting Current Month Date...
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth()
        let allDates = currentMonth.getAllDates()
        
        var days = allDates.compactMap { date -> DateValueModel in
            // getting day..
            let day = calendar.component(.day, from: date)
            if [15,16].contains(day) {
                return DateValueModel(day: day,
                                      date: date,
                                      isSelected: true,
                                      percent: 1.0)
            } else if [13,17].contains(day) {
                return DateValueModel(day: day,
                                      date: date,
                                      isSelected: true,
                                      percent: 0.5)
            } else {
                return DateValueModel(day: day,
                                      date: date)
            }
        }
        // adding offset days to get exact week day...
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValueModel(day: -1,
                                       date: Date()), at: 0)
        }
        return days
    }
}

//Extending Date to get Current Month Dates...
extension Date {
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day,
                                   in: .month,
                                   for: startDate)!
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day,
                                 value: day - 1,
                                 to: startDate)!
        }
    }
}
