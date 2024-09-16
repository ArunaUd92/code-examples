//
//  ContentView.swift
//  TimeLineView
//
//  Created by Aruna Udayanga on 29/08/2024.
//


import SwiftUI
import UIKit

struct TaskListView: View {
    @State private var tasks = [
        Task(id: 1, todo: "Buy groceries", completed: false),
        Task(id: 2, todo: "Walk the dog", completed: true),
        Task(id: 3, todo: "Send an email to Bob", completed: false)
    ]
    
    @State private var isShareSheetPresented = false
    @State private var selectedTask: Task?

    var body: some View {
        NavigationView {
            List {
                ForEach(tasks) { task in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(task.todo)
                                .font(.headline)

                        }
                        Spacer()
                        
                        // Share Button
                        Button(action: {
                            selectedTask = task
                            isShareSheetPresented.toggle()
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.blue)
                                .font(.title2)
                        }
                        .buttonStyle(BorderlessButtonStyle()) // Allows button clicks in list row
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Share List Items")
            .sheet(isPresented: $isShareSheetPresented) {
                if let taskToShare = selectedTask {
                    ShareSheet(activityItems: [taskToShare.todo])
                }
            }
        }
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // No update required
    }
}

struct Task: Identifiable {
    let id: Int
    let todo: String
    let completed: Bool
}

#Preview {
    TaskListView()
}
