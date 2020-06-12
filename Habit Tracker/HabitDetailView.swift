//
//  HabitDetailView.swift
//  Habit Tracker
//
//  Created by Myat Thu Ko on 6/11/20.
//  Copyright © 2020 Myat Thu Ko. All rights reserved.
//

import SwiftUI

struct HabitDetailView: View {
    @State private var angle = 0.0
    @State private var phase: CGFloat = 0
    var habitDetail: HabitItems
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            
            Text("\(habitDetail.name)")
                .font(.system(size: 50))
            
            Text("Type: \(habitDetail.types)")
            
            Text("Date: \(habitDetail.formattedDate)")
            
            if habitDetail.types == "Habit" {
                HStack(spacing: 30) {
                    Text("Number of completion: \(habitDetail.completionAmount)")
                        .font(.system(size: 20))
                    
                    Button(action: {
                        self.angle += 360
                        self.increaseNumber()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 50))
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .strokeBorder(style: .init(lineWidth: 5, dash: [1], dashPhase: phase))
                                    .frame(width: 100, height: 50)
                                    .animation(Animation.linear.repeatForever(autoreverses: false))
                        )
                            .foregroundColor(.red)
                    }
                    .rotation3DEffect(.degrees(angle), axis: (x: 0, y: 1, z: 0))
                    .animation(.easeIn)
                }
            }
            
            Spacer()
            
            Text("\(habitDetail.description)")
                .font(.system(size: 30))
            
            Spacer()
        }
        .navigationBarTitle("\(habitDetail.name)", displayMode: .inline)
        .onAppear { self.phase -= 20}
    }
    
    func increaseNumber() {
        //
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailView(habitDetail: HabitItems.init(name: "Demo", description: "Demo description", completionAmount: 100, types: "Demo Type", date: Date()))
    }
}
