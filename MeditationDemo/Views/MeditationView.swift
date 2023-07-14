//
//  MeditationView.swift
//  MeditationDemo
//
//  Created by Apple on 14/07/23.
//

import SwiftUI
import Charts

struct MeditationView: View {
    var body: some View {
        VStack {
            HStack {
                Image(MeditationConstant.Image.back)
                    .resizable()
                    .frame(width: 30, height: 30)
                Spacer()
                Text("Meditation")
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
                MenuView()
            }
            ScrollView(.vertical, showsIndicators: false) {
                StatisticsView()
                Spacer(minLength: 20)
                CelenderMainView()
                Spacer(minLength: 20)
                YearlyStatusView()
                Spacer(minLength: 20)
                MemosView()
                Spacer(minLength: 20)
            }
        }
        .padding()
    }
}

struct MeditationView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationView()
    }
}
struct MenuView: View {
    
    var body: some View {
        Menu {
            Button(action: editAction) {
                Image(MeditationConstant.Image.edit)
                    .resizable()
                    .frame(width: 14, height: 14)
                Text("Edit")
                    .font(.system(size: 10, weight: .regular))
            }
            Button(action: archiveAction) {
                Image(MeditationConstant.Image.archive)
                    .resizable()
                    .frame(width: 14, height: 14)
                Text("Archive")
                    .font(.system(size: 10, weight: .regular))
            }
            Button(action: deleteAction) {
                Image(MeditationConstant.Image.delete)
                    .resizable()
                    .frame(width: 14, height: 14)
                Text("Delete")
                    .font(.system(size: 10, weight: .regular))
            }
        } label: {
            Image(MeditationConstant.Image.more)
                .resizable()
                .frame(width: 24, height: 24)
        }
    }
    
    func editAction() { print(#function) }
    func archiveAction() { print(#function) }
    func deleteAction() { print(#function) }
}

struct StatisticsView: View {
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible())]
    let data = [StatisticsModel(color: Color(MeditationConstant.Color.LightPurple),
                                title: "Monthly check-ins",
                                imgStr: MeditationConstant.Image.month_calendar,
                                value: "30",
                                unit: "Days"),
                StatisticsModel(color: Color(MeditationConstant.Color.LightOrange),
                                title: "Monthly check-ins rate",
                                imgStr: MeditationConstant.Image.percent,
                                value: "25",
                                unit: "%"),
                StatisticsModel(color: Color(MeditationConstant.Color.LightGreen),
                                title: "Total check-ins",
                                imgStr: MeditationConstant.Image.total_calendar,
                                value: "260",
                                unit: "Days"),
                StatisticsModel(color: Color(MeditationConstant.Color.LightBlue),
                                title: "Current Streak",
                                imgStr: MeditationConstant.Image.streak,
                                value: "24",
                                unit: "Days")]

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            HStack {
                Text("Check-ins Statistics")
                    .font(.system(size: 18, weight: .medium))
                    .padding(.leading, 12)
                    .padding(.top, 20)
                Spacer()
            }
            LazyVGrid(columns: columns,alignment: .center, spacing: 12) {
                ForEach(data, id: \.id) { result in
                    VStack {
                        Spacer(minLength: 12)
                        HStack(alignment: .center) {
                            Image(result.imgStr)
                                .resizable()
                                .frame(width: 14, height: 14)
                            Text(result.title)
                                .font(.system(size: 10, weight: .regular))
                            Spacer()
                        }
                        Spacer(minLength: 12)
                        HStack(alignment: .center) {
                            Text(result.value)
                                .font(.system(size: 20, weight: .bold))
                            Text(result.unit)
                                .font(.system(size: 12, weight: .semibold))
                            Spacer()
                        }
                        Spacer(minLength: 12)
                    }
                    .padding(.leading, 12)
                    .background(result.color)
                }
                .cornerRadius(8)
                .padding(.trailing, 4)
            }
            .padding([.leading,.trailing, .bottom], 12)
        }
        .background(.white)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(MeditationConstant.Color.Border), lineWidth: 2)
        )
    }
}

struct MemosView: View {

    @State var textMemo : String = ""
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            HStack {
                Text("Memos")
                    .font(.system(size: 14, weight: .bold))
                    .padding(.leading, 12)
                    .padding(.top, 20)
                Spacer()
            }
            HStack {
                Spacer(minLength: 16)
                HStack {
                    TextField("No memos yet", text: $textMemo)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.gray)
                    Spacer()
                }
                .frame(height: 50)
                .padding([.leading, .trailing], 12)
                .background(Color(MeditationConstant.Color.Border))
                .cornerRadius(8)
                Spacer(minLength: 16)
            }
            Spacer(minLength: 2)
        }
        .background(.white)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(MeditationConstant.Color.Border), lineWidth: 2)
        )
    }
}

struct YearlyStatusView: View {
    
    @State private var walk = YearlyStatusModel.walkWorkout
    let data : [Double] = [23,35,55,30,15,65]
    let date : [String] = ["Jan","Mar","May","Jul","Sep","Nov"]
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            HStack {
                Text("Yearly Status")
                    .font(.system(size: 16, weight: .medium))
                Spacer()
                Button {
                } label: {
                    Image(MeditationConstant.Image.back)
                        .resizable()
                        .frame(width: 20, height: 20, alignment: .center)
                }
                Text("2023")
                    .font(.system(size: 16, weight: .medium))
                    .frame(alignment: .center)
                Button {
                } label: {
                    Image(MeditationConstant.Image.next)
                        .resizable()
                        .frame(width: 20, height: 20, alignment: .center)
                }
            }
            .padding([.leading, .trailing], 12)
            .padding(.top, 20)
            LineView(data: data,
                     date: date,
                     style: ChartStyle(backgroundColor: .white,
                                       accentColor: .white,
                                       lineColor: Color(MeditationConstant.Color.Purple),
                                       textColor: .clear,
                                       legendTextColor: .clear,
                                       dropShadowColor: .clear))
            .padding([.trailing,.bottom], 24)
            .frame(height: 200, alignment: .center)
            HStack {
                ForEach(date, id: \.self) { month in
                    Text(month)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding([.leading, .trailing], 10)
            .padding(.bottom, 20)
        }
        .background(.white)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(MeditationConstant.Color.Border), lineWidth: 2)
        )
    }
}

