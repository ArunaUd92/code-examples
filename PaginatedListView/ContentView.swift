//
//  ContentView.swift
//  TimeLineView
//
//  Created by Aruna Udayanga on 29/08/2024.
//

import SwiftUI

struct PaginatedListView: View {
    @State private var tasks: [Task] = []
    @State private var isLoading: Bool = false
    @State private var currentPage: Int = 1
    private let pageSize: Int = 20
    private let totalTasks: Int = 100 // Simulating a total number of tasks
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tasks) { task in
                    VStack(alignment: .leading) {
                        Text(task.name)
                            .font(.headline)
                        
                        Text("Due: \(formattedDate(task.dueDate))")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text("Category: \(task.category)")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                    .padding(.vertical, 8)
                }
                
                // Show bottom loading indicator when loading new data
                if isLoading {
                    HStack {
                        Spacer()
                        ProgressView("Loading more tasks...")
                            .padding()
                        Spacer()
                    }
                } else {
                    // Load more content when scrolling to the bottom
                    Color.clear
                        .onAppear {
                            loadMoreTasks()
                        }
                }
            }
            .navigationTitle("Paginated Task List")
        }
        .onAppear {
            loadMoreTasks() // Initial load
        }
    }
    
    // Simulating an async data load for pagination
    private func loadMoreTasks() {
        guard !isLoading else { return } // Prevent multiple loads
        guard tasks.count < totalTasks else { return } // Stop when all tasks are loaded
        
        isLoading = true
        
        // Simulate an API delay for loading tasks
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let newTasks = generateTasks(for: currentPage)
            tasks.append(contentsOf: newTasks)
            currentPage += 1
            isLoading = false
        }
    }
    
    // Generate tasks for the given page
    private func generateTasks(for page: Int) -> [Task] {
        let startIndex = (page - 1) * pageSize
        let endIndex = min(startIndex + pageSize, totalTasks)
        
        return (startIndex..<endIndex).map { index in
            Task(name: "Task \(index + 1)",
                 category: index % 2 == 0 ? "Work" : "Personal",
                 dueDate: Date().addingTimeInterval(Double(index) * 60 * 60),
                 size: Int.random(in: 1...3),
                 isCompleted: false)
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct Task: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let dueDate: Date
    let size: Int // Could represent priority level
    var isCompleted: Bool
}

#Preview {
    PaginatedListView()
}

#Preview {
    ContentView()
}
