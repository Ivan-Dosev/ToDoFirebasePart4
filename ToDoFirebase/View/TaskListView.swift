//
//  ContentView.swift
//  ToDoFirebase
//
//  Created by Ivan Dimitrov on 5.02.21.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskListVM = TaskListViewModel()
    let tasks = testDataTasks
    
    @State var presentAddNewItem = false
    @State var showSignInForm = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(taskListVM.taskCellViewModels) { taskCellVM in
                        TaskCell(taskCellVM: taskCellVM )
                    }
                    .onDelete(perform: { indexSet in
                        
                        self.taskListVM.taskCellViewModels.remove(atOffsets: indexSet)
                        removeTask(index: indexSet)
                    })
                    if presentAddNewItem {
                        TaskCell(taskCellVM: TaskCellViewModel(task: Task(title: "", completed: false))) {
                            task in
                            self.taskListVM.addTask(task: task)
                            self.presentAddNewItem.toggle()
                        }
                    }
                }
                Button(action: { self.presentAddNewItem.toggle() }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height:20)
                        Text("Add new task")
                    }
                }
            }
            .sheet(isPresented: $showSignInForm) {
                SignInView()
            }
            .navigationBarItems(trailing: Button(action: { self.showSignInForm.toggle() })
            {
                Image(systemName: "person.circle")
            })
            .navigationTitle("Tasks")
        }
    }
    func removeTask(index:IndexSet){
        for i in index {
                 let itemFromList = taskListVM.taskCellViewModels[i-1]
            taskListVM.removeTask(task: itemFromList.task)
        }
    }
}

struct TaskListView_Preview: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

struct TaskCell: View {
    @ObservedObject var taskCellVM: TaskCellViewModel
    var onCommit: (Task) -> (Void) = { _ in }
    var body: some View {
        HStack{
            Image(systemName: taskCellVM.task.completed ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height:20)
                .onTapGesture {
                    self.taskCellVM.task.completed.toggle()
                }
            TextField("Enter the task title", text: $taskCellVM.task.title, onCommit: {
                self.onCommit(self.taskCellVM.task)
            })
                .padding()
        }
    }
}
