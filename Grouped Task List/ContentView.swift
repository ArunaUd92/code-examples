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
    var isCompleted: Bool
}

struct ContentView: View {
    @State private var tasks: [Task] = [
        Task(name: "Buy groceries", category: "Personal", dueDate: Date(), isCompleted: false),
        Task(name: "Team meeting", category: "Work", dueDate: Date().addingTimeInterval(3600), isCompleted: false),
        Task(name: "Walk the dog", category: "Personal", dueDate: Date().addingTimeInterval(7200), isCompleted: false),
        Task(name: "Prepare presentation", category: "Work", dueDate: Date().addingTimeInterval(10800), isCompleted: false),
        Task(name: "Call plumber", category: "Personal", dueDate: Date().addingTimeInterval(14400), isCompleted: true)
    ]

    var groupedTasks: [String: [Task]] {
        Dictionary(grouping: tasks, by: { $0.category })
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(groupedTasks.keys.sorted(), id: \.self) { key in
                    Section(header: Text(key).font(.headline)) {
                        ForEach(groupedTasks[key]!) { task in
                            HStack {
                                Button(action: {
                                    toggleTaskCompletion(task: task)
                                }) {
                                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(task.isCompleted ? .green : .gray)
                                }

                                VStack(alignment: .leading) {
                                    Text(task.name)
                                        .strikethrough(task.isCompleted, color: .gray)
                                        .font(.subheadline)

                                    Text("Due: \(formattedDate(task.dueDate))")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
            .navigationTitle("Task Manager")
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
        // Add a new task to the list (for simplicity, this example just adds a dummy task)
        tasks.append(Task(name: "New Task", category: "Personal", dueDate: Date().addingTimeInterval(18000), isCompleted: false))
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    ContentView()
}
