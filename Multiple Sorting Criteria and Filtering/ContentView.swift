//
//  ContentView.swift
//  TimeLineView
//
//  Created by Aruna Udayanga on 29/08/2024.
//

import SwiftUI
import Charts


struct Task: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let dueDate: Date
    let size: Int // Could represent priority level
    var isCompleted: Bool
}

struct ContentView: View {
    @State private var tasks: [Task] = [
        Task(name: "Buy groceries", category: "Personal", dueDate: Date(), size: 2, isCompleted: false),
        Task(name: "Team meeting", category: "Work", dueDate: Date().addingTimeInterval(3600), size: 1, isCompleted: false),
        Task(name: "Walk the dog", category: "Personal", dueDate: Date().addingTimeInterval(7200), size: 3, isCompleted: true),
        Task(name: "Prepare presentation", category: "Work", dueDate: Date().addingTimeInterval(10800), size: 2, isCompleted: false),
        Task(name: "Call plumber", category: "Personal", dueDate: Date().addingTimeInterval(14400), size: 1, isCompleted: true)
    ]
    
    @State private var sortOrder: SortOrder = .alphabetical
    @State private var showCompletedTasks = true
    @State private var selectedCategory: String? = nil

    var sortedAndFilteredTasks: [Task] {
        var filteredTasks = tasks
        
        // Filtering based on completion status
        if !showCompletedTasks {
            filteredTasks = filteredTasks.filter { !$0.isCompleted }
        }
        
        // Filtering by category
        if let category = selectedCategory, !category.isEmpty {
            filteredTasks = filteredTasks.filter { $0.category == category }
        }
        
        // Sorting
        switch sortOrder {
        case .alphabetical:
            return filteredTasks.sorted { $0.name < $1.name }
        case .byDate:
            return filteredTasks.sorted { $0.dueDate < $1.dueDate }
        case .bySize:
            return filteredTasks.sorted { $0.size < $1.size }
        case .byCompletion:
            return filteredTasks.sorted { $0.isCompleted && !$1.isCompleted }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Filter and Sort Controls
                HStack {
                    Picker("Sort by", selection: $sortOrder) {
                        Text("Alphabetical").tag(SortOrder.alphabetical)
                        Text("Date").tag(SortOrder.byDate)
                        Text("Size").tag(SortOrder.bySize)
                        Text("Completion").tag(SortOrder.byCompletion)
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Toggle("Show Completed", isOn: $showCompletedTasks)
                        .toggleStyle(SwitchToggleStyle())
                }
                .padding()
                
                Picker("Category", selection: $selectedCategory) {
                    Text("All").tag(String?.none)
                    ForEach(categories, id: \.self) { category in
                        Text(category).tag(category as String?)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // Task List
                List(sortedAndFilteredTasks) { task in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(task.name)
                                .font(.headline)
                                .strikethrough(task.isCompleted, color: .gray)
                            
                            Text("Due: \(formattedDate(task.dueDate))")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Text("Category: \(task.category)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Text("Size: \(task.size)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Button(action: {
                            toggleTaskCompletion(task: task)
                        }) {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.isCompleted ? .green : .gray)
                        }
                    }
                }
            }
            .navigationTitle("Task Manager - Sorting")
            .toolbar {
                Button(action: addTask) {
                    Image(systemName: "plus")
                }
            }
        }
    }

    private func toggleTaskCompletion(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }

    private func addTask() {
        tasks.append(Task(name: "New Task", category: "Personal", dueDate: Date().addingTimeInterval(18000), size: 2, isCompleted: false))
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    private var categories: [String] {
        Set(tasks.map { $0.category }).sorted()
    }
}

enum SortOrder {
    case alphabetical
    case byDate
    case bySize
    case byCompletion
}

#Preview {
    ContentView()
}
