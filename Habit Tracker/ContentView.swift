//
//  ContentView.swift
//  Habit Tracker
//
//  Created by Myat Thu Ko on 6/6/20.
//  Copyright © 2020 Myat Thu Ko. All rights reserved.
//

import SwiftUI

struct HabitItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
    var completionCount: Int
}

class Habits: ObservableObject {
    @Published var items = [HabitItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([HabitItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        
        self.items = []
    }
}

struct ContentView: View {
    @ObservedObject private var habits = Habits()
    @State private var showSheets = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.items, id: \.id) { habit in
                    NavigationLink(destination: DetailView(habitName: habit.name, detail: habit.description)) {
                        Text("\(habit.name)")
                    }
                }
                .onDelete(perform: deleteHabit)
            }
            .navigationBarTitle("Habit Tracker")
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.showSheets.toggle()
                }) {
                    Image(systemName: "plus")
                }
            )
                .sheet(isPresented: $showSheets) {
                    HabitView(habits: self.habits)
            }
        }
    }
    
    func deleteHabit(at offSets: IndexSet) {
        habits.items.remove(atOffsets: offSets)
        habits.items = habits.items
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
