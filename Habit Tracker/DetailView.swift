//
//  DetailView.swift
//  Habit Tracker
//
//  Created by Myat Thu Ko on 6/6/20.
//  Copyright © 2020 Myat Thu Ko. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    var habitName: String
    var detail: String
    
    
    var body: some View {
        Form {
            Text(detail)
        }
        .navigationBarTitle("\(habitName)", displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(habitName: "", detail: "")
    }
}
