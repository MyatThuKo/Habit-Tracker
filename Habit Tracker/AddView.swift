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
    @State private var selectedType = "Journal"
    @State private var selectedDate = Date()
    
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    var types = ["Journal", "Habit"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $habitName)
                    Picker("Type", selection: $selectedType) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    DatePicker("Date: ", selection: $selectedDate)
                    TextView(placeholderText: "Description", text: $habitDescription).frame(numLines: 15)
                }
                
                if selectedType == "Habit" {
                    Section {
                        Stepper("Number of completion: \(habitCompletionCount)", value: $habitCompletionCount, in: 0...50)
                    }
                }
            }
            .navigationBarTitle("Add New Habit", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.addNewHabit()
                self.presentationMode.wrappedValue.dismiss()
            }){
                Text("Save")
            })
                .alert(isPresented: $showAlert) {
                    Alert.init(title: Text("Invalid Input"), message: Text(self.alertMessage), dismissButton: .default(Text("Okay")))
            }
        }
    }
    
    func addNewHabit() {
        guard !self.habitName.isEmpty else {
            self.showAlert.toggle()
            self.alertMessage = "Name is empty."
            return
        }
        
        guard !self.habitDescription.isEmpty else {
            self.showAlert.toggle()
            self.alertMessage = "Description is empty."
            return
        }
        
        let newHabitItem = HabitItems(name: self.habitName, description: self.habitDescription, completionAmount: self.habitCompletionCount, types: self.selectedType, date: self.selectedDate)
        
        self.habit.habitsItems.append(newHabitItem)
        self.habit.habitsItems = self.habit.habitsItems
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(habit: Habits())
    }
}
