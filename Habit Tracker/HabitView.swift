//
//  HabitView.swift
//  Habit Tracker
//
//  Created by Myat Thu Ko on 6/6/20.
//  Copyright © 2020 Myat Thu Ko. All rights reserved.
//

import SwiftUI

struct HabitView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var habits: Habits
    @State private var habitName = ""
    @State private var habitDescript = ""
    @State private var numberDone = 0
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Habit Name", text: $habitName)
                TextField("Habit Description", text: $habitDescript)
                    .multilineTextAlignment(.leading)
            }
            .navigationBarTitle("Add a new habit")
            .navigationBarItems(trailing: Button("Save") {
                guard !self.habitName.isEmpty else {
                    self.showAlert.toggle()
                    self.alertTitle = "Invalid Input"
                    self.alertMessage = "Please put the name..."
                    return
                }
                
                guard !self.habitDescript.isEmpty else {
                    self.showAlert.toggle()
                    self.alertTitle = "Invalid Input"
                    self.alertMessage = "Please put the description..."
                    return
                }
                
                self.numberDone = 1
                
                let habit = HabitItem(name: "\(self.habitName)", description: "\(self.habitDescript)", completionCount: self.numberDone)
                self.habits.items.append(habit)
                self.habits.items = self.habits.items
                self.presentationMode.wrappedValue.dismiss()
            })
                .alert(isPresented: $showAlert) {
                    Alert.init(title: Text(self.alertTitle), message: Text(self.alertMessage), dismissButton: .default(Text("Okay")))
            }
        }
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView(habits: Habits())
    }
}
