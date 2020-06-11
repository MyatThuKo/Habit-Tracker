//
//  AddView.swift
//  Habit Tracker
//
//  Created by Myat Thu Ko on 6/11/20.
//  Copyright © 2020 Myat Thu Ko. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var habit = Habits()
    @Environment(\.presentationMode) var presentationMode
    @State private var habitName = ""
    @State private var habitDescription = ""
    @State private var habitCompletionCount = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Habit Name", text: $habitName)
                    TextField("Habit Description", text: $habitDescription)
                }
                
                Section {
                    Stepper("Number of completion: \(habitCompletionCount)", value: $habitCompletionCount, in: 0...50)
                }
            }
            .navigationBarTitle("Add New Habit", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.addNewHabit()
                self.presentationMode.wrappedValue.dismiss()
            }){
                Text("Save")
            })
        }
    }
    
    func addNewHabit() {
        let newHabitItem = HabitItems(name: self.habitName, description: self.habitDescription, completionAmount: self.habitCompletionCount)
        
        self.habit.habitsItems.append(newHabitItem)
        self.habit.habitsItems = self.habit.habitsItems
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(habit: Habits())
    }
}
