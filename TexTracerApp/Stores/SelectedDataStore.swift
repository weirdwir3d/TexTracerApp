import SwiftUI
import Foundation
import Combine

//keeps track of what the user chooses to upload order evidence for
class SelectedDataStore: ObservableObject {
    
    //current task
    @Published var task: UploadEvidenceTask?
    //all steps of an order
    @Published var allOrderSteps: [OrderStep] = []
    //all steps the user chose to upload order evidence for
    @Published var selectedSteps: [OrderStep] = []
    //each step associated with one image
    @Published var picturesForSteps: [OrderStep: Image] = [:]
    //list of steps that share the same image
    @Published var stepsWithSharedPictures: [OrderStep] = []
    //list of orders the user can upload evidence for
    @Published var orders: [Order] = []
    //list of orders the user selected to upload evidence for
    @Published var selectedOrders: [Order] = []
    
    
    func addTask(_ taskToAdd: UploadEvidenceTask) {
        task = taskToAdd
    }
    
    //remove step the user chose to upload order evidence for
    func removeSelectedStep(_ stepToRemove: OrderStep) {
        if let index = selectedSteps.firstIndex(of: stepToRemove) {
            selectedSteps.remove(at: index)
        }
    }
    
    //add step the user chose to upload order evidence for
    func addSelectedStep(_ stepToAdd: OrderStep) {
        selectedSteps.append(stepToAdd)
    }
    
    //all steps of an order
    func addAllOrderSteps(_ stepsToAdd: [OrderStep]) {
        allOrderSteps.append(contentsOf: stepsToAdd)
        }
    
    //all steps of an order
    func getAllOrderSteps() -> [OrderStep] {
        return allOrderSteps
    }
    
    //all steps the user chose to upload order evidence for
    func addSelectedSteps(_ stepsToAdd: [OrderStep]) {
            selectedSteps.append(contentsOf: stepsToAdd)
        }
    
    //all steps the user chose to upload order evidence for
    func getSelectedSteps() -> [OrderStep] {
        return selectedSteps
    }
    
    //add orders the user can upload order evidence for
    func addOrders(_ ordersToAdd: [Order]) {
        orders.append(contentsOf: ordersToAdd)
    }
    
    //all orders the user can upload order evidence for
    func getOrders() -> [Order] {
            return Array(Set(orders))
        }
    
    //add orders the user chose to upload order evidence for
    func addSelectedOrders(_ orders: [Order]) {
        selectedOrders.append(contentsOf: orders)
    }
    
    //all orders the user chose to upload order evidence for
    func getSelectedOrders() -> [Order] {
            return selectedOrders
        }
    
}

