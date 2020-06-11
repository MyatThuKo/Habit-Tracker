//
//  HabitDetailView.swift
//  Habit Tracker
//
//  Created by Myat Thu Ko on 6/11/20.
//  Copyright © 2020 Myat Thu Ko. All rights reserved.
//

import SwiftUI

struct HabitDetailView: View {
    var habitDetail: HabitItems
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Spacer()
            
            Text("\(habitDetail.name)")
                .font(.system(size: 50))
            
            Text("\(habitDetail.description)")
                .font(.system(size: 30))
            
            Text("Number of completion: \(habitDetail.completionAmount)")
                .font(.system(size: 20))
            
            Spacer()
        
            Button(action: {
                self.increaseNumber()
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 50))
            }
        }
        .navigationBarTitle("\(habitDetail.name)", displayMode: .inline)
    }
    
    func increaseNumber() {
        //
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailView(habitDetail: HabitItems.init(name: "Demo", description: "Demo description", completionAmount: 100))
    }
}
