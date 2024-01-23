import Foundation

struct StepPassage: Equatable {
    let steps: [OrderStep]
    
    func printStepNames() {
        for step in steps {
            print(step.step.stringValue)
        }
    }
    
    func hasStep(_ step: OrderStep) -> Bool {
        return steps.contains(step)
    }
    
}
