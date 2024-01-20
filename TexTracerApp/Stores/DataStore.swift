import SwiftUI
import Foundation
import Combine

//keeps track of what the user chooses to upload order evidence for
class DataStore: ObservableObject {
    
    //current task
    @Published private var currentTask: UploadEvidenceTask?
    //all steps of an order
    @Published private var allOrderSteps: [OrderStep] = []
    //all steps the user chose to upload order evidence for
    @Published private var selectedSteps: [OrderStep] = []
    //each step associated with one image
    @Published private var picturesForSteps: [OrderStep: Image] = [:]
    //list of steps that share the same image
    @Published private var stepsWithSharedPicture: [OrderStep] = []
    //list of orders the user can upload evidence for
    @Published private var orders: [Order] = []
    //list of orders the user selected to upload evidence for
    @Published private var selectedOrders: [Order] = []
    //makes it easier to keep track of what steps share the same order evidence (true) and which ones dont (false)
    @Published private var listBooleanSteps: [OrderStep: Bool] = [:]
    
    // steps to create progress bar
    @Published private var stepsProgressBar: [OrderStep] = []
    @Published private var doneStepsProgressBar: [OrderStep] = []
    // keeps track of what stepsProgressBar share the same evidence (true) and whicon ones dont (false)
    @Published private var stepsIsSameEvidence: [Bool] = []
    @Published private var currentSteps: [OrderStep] = []
    
    //image that the user selects for order evidence before confirming its upload
    @Published private var selectedImage: UIImage?
    
    
    func setSelectedImage(_ image: UIImage?) {
        selectedImage = image
//        print("image set to \(selectedImage)")
    }
    
    func getSelectedImage() -> UIImage? {
        return selectedImage
    }
    
    func getCurrentSteps() -> [OrderStep] {
        return currentSteps
    }

    func addStepToCurrentSteps(_ stepToAdd: OrderStep) {
        if !currentSteps.contains(stepToAdd) {
            currentSteps.append(stepToAdd)
        }
    }

    func clearCurrentSteps() {
        currentSteps.removeAll()
    }
    
    func getDoneStepsProgressBar() -> [OrderStep] {
        return doneStepsProgressBar
    }
    
    func addStepToDoneStepsProgressBar(_ step: OrderStep) {
        doneStepsProgressBar.append(step)
    }
    
    func getStepsIsSameEvidence() -> [Bool] {
        return stepsIsSameEvidence
    }
    
    func addStepsIsSameEvidence(_ boolVal: Bool) {
        stepsIsSameEvidence.append(boolVal)
    }
    
    func addStepToProgressBar(_ step: OrderStep) {
        stepsProgressBar.append(step)
    }
    
    //get list of steps for the progress bar
    func getStepsProgressBar() -> [OrderStep] {
        return stepsProgressBar
    }
    
    func getListBooleanSteps() -> [OrderStep: Bool] {
        return listBooleanSteps
    }

    func createListBooleanSteps() {
        for step in selectedSteps {
            if stepsWithSharedPicture.contains(step) {
                listBooleanSteps[step] = true
            } else {
                listBooleanSteps[step] = false
            }
        }
//        print("SELECTED STEPS LIST: \(getSelectedSteps())")
//        print("CREATED LIST: \(getListBooleanSteps())")
    }
    
    func alignSelectedStepsOrder() {
        selectedSteps = allOrderSteps.compactMap { step in
            selectedSteps.first { $0 == step }
        }
        stepsWithSharedPicture = selectedSteps.compactMap { step in
            stepsWithSharedPicture.first { $0 == step }
        }
    }
    
    func getOrder(by code: String) -> Order? {
        return selectedOrders.first { $0.code == code }
    }
    
    func getStep(by step: String) -> OrderStep? {
        return stepsWithSharedPicture.first { $0.step.stringValue == step }
    }
    
    func getCurrentTask() -> Task {
        return currentTask!
    }
    
    func addCurrentTask(_ taskToAdd: UploadEvidenceTask) {
        currentTask = taskToAdd
    }
    
    //add step with same order evidence as at least another step
    func addSameEvidenceStep(_ stepToAdd: OrderStep) {
        // Check if the order step is not already present
        if !stepsWithSharedPicture.contains(stepToAdd) {
            stepsWithSharedPicture.append(stepToAdd)
        }
    }
    
    //get list of steps with same order evidence
    func getAllSameEvidenceSteps() -> [OrderStep] {
        return stepsWithSharedPicture
    }
    
    //remove step the user chose to upload order evidence for
    func removeSelectedStep(_ stepToRemove: OrderStep) {
        if let index = selectedSteps.firstIndex(of: stepToRemove) {
            selectedSteps.remove(at: index)
        }
    }
    
    //add step the user chose to upload order evidence for
    func addSelectedStep(_ stepToAdd: OrderStep) {
        // Check if the order step is not already present
        if !selectedSteps.contains(stepToAdd) {
            selectedSteps.append(stepToAdd)
        }
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
    
    //add order the user chose to upload order evidence for
    func addSelectedOrder(_ order: Order) {
        selectedOrders.append(order)
    }
    
    //add orders the user chose to upload order evidence for
    func addSelectedOrders(_ orders: [Order]) {
        selectedOrders.append(contentsOf: orders)
    }
    
    //all orders the user chose to upload order evidence for
    func getSelectedOrders() -> [Order] {
            return selectedOrders
        }
    
    func getDummyImage() -> UIImage {
        return UIImage(named: "exampleImage")!
    }
    
}

