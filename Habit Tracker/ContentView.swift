//
//  ContentView.swift
//  Habit Tracker
//
//  Created by Myat Thu Ko on 6/6/20.
//  Copyright © 2020 Myat Thu Ko. All rights reserved.
//

import SwiftUI

class Habits: ObservableObject {
    @Published var habitsItems = [HabitItems]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(habitsItems) {
                UserDefaults.standard.set(encoded, forKey: "HabitsItems")
            }
        }
    }
    
    init() {
        if let habits = UserDefaults.standard.data(forKey: "HabitsItems") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([HabitItems].self, from: habits) {
                self.habitsItems = decoded
                return
            }
        }
        
        self.habitsItems = []
    }
}

struct ContentView: View {
    @ObservedObject var habits = Habits()
    @Environment(\.presentationMode) var presentationMode
    @State private var showAddView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.habitsItems) { habit in
                    NavigationLink(destination: HabitDetailView(habitDetail: habit.self)) {
                        VStack(alignment: .leading) {
                            Text("\(habit.name)")
                                .foregroundColor(.primary)
                                .font(.system(size: 23))
                            
                            Text("Times completed:  \(habit.completionAmount)")
                                .foregroundColor(.secondary)
                                .font(.caption)
                        }
                    }
                }
                .onDelete(perform: deleteHabit)
            }
            .navigationBarTitle("Habit Tracker")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showAddView.toggle()
            }) {
                Image(systemName: "plus.circle")
                    .font(.title)
            }
            .sheet(isPresented: $showAddView) {
                AddView(habit: self.habits)
            })
            
        }
    }
    
    func deleteHabit(at offSets: IndexSet) {
        habits.habitsItems.remove(atOffsets: offSets)
        habits.habitsItems = habits.habitsItems
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
