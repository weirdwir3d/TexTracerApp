import SwiftUI
import Foundation
import Combine

//keeps track of what the user chooses to upload order evidence for
class SelectedDataStore: ObservableObject {
    //all steps of an order
    @Published var allOrderSteps: [OrderStep] = []
    //all steps the user chose to upload order evidence for
    @Published var selectedSteps: [OrderStep] = []
    //each step associated with one image
    @Published var picturesForSteps: [OrderStep: Image] = [:]
    //list of steps that share the same image
    @Published var stepsWithSharedPictures: [OrderStep] = []
    //list of orders the user selected to upload evidence for
    @Published var selectedOrders: [Order] = []
    
}

