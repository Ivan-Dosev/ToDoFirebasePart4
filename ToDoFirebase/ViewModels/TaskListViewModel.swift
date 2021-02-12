//
//  TaskListViewModel.swift
//  ToDoFirebase
//
//  Created by Ivan Dimitrov on 6.02.21.
//

import Foundation
import Combine


class TaskListViewModel: ObservableObject {
    
    @Published var taskRepository = TaskRepository()
    @Published var taskCellViewModels = [TaskCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        taskRepository.$tasks.map { tasks in
            tasks.map { task in
            TaskCellViewModel(task: task)
        }
      }
        .assign(to: \.taskCellViewModels, on: self)
        .store(in: &cancellables)
    }
    func addTask(task: Task) {
        taskRepository.addTask(task)
//        let taskVM = TaskCellViewModel(task: task)
//        self.taskCellViewModels.append(taskVM)
    }
    func removeTask(task: Task) {
        taskRepository.deleteTask(task: task)
//        let taskVM = TaskCellViewModel(task: task)
//        self.taskCellViewModels.append(taskVM)
    }
}
