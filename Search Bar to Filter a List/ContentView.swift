//
//  ContentView.swift
//  TimeLineView
//
//  Created by Aruna Udayanga on 29/08/2024.
//

import SwiftUI

struct SearchablePaginatedListView: View {
    @State private var tasks: [Task] = []
    @State private var isLoading: Bool = false
    @State private var currentPage: Int = 1
    @State private var searchText: String = "" // Text to search
    private let pageSize: Int = 20

    var filteredTasks: [Task] {
        if searchText.isEmpty {
            return tasks
        } else {
            return tasks.filter { $0.todo.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(filteredTasks) { task in
                    VStack(alignment: .leading) {
                        Text(task.todo)
                            .font(.headline)
                        
                        Text("Completed: \(task.completed ? "Yes" : "No")")
                            .font(.subheadline)
                            .foregroundColor(task.completed ? .green : .red)
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
            .navigationTitle("Searchable Task List")
            .searchable(text: $searchText) // Add the search bar
        }
        .onAppear {
            loadMoreTasks() // Initial load
        }
    }
    
    // Fetch tasks from DummyJSON API with pagination
    private func loadMoreTasks() {
        guard !isLoading else { return } // Prevent multiple loads

        isLoading = true
        
        let urlString = "https://dummyjson.com/todos?limit=\(pageSize)&skip=\((currentPage - 1) * pageSize)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(TodoResponse.self, from: data)
                    DispatchQueue.main.async {
                        tasks.append(contentsOf: result.todos)
                        currentPage += 1
                        isLoading = false
                    }
                } catch {
                    print("Failed to decode JSON: \(error)")
                }
            }
        }.resume()
    }
}

struct Task: Identifiable, Decodable {
    let id: Int
    let todo: String
    let completed: Bool
}

struct TodoResponse: Decodable {
    let todos: [Task]
    let total: Int
    let skip: Int
    let limit: Int
}

#Preview {
    SearchablePaginatedListView()
}
