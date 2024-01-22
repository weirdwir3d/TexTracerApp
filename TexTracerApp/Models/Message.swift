import Foundation

class Message: Identifiable, Hashable {
    
    var content: String
    var dateTime: String
    
    init(content: String, dateTime: String) {
        self.content = content
        self.dateTime = dateTime
    }
    
    // Getter for content
    func getContent() -> String {
        return content
    }
    
    // Setter for content
    func setContent(_ newContent: String) {
        content = newContent
    }
    
    // Getter for dateTime
    func getDateTime() -> String {
        return dateTime
    }
    
    // Setter for dateTime
    func setDateTime(_ newDateTime: String) {
        // You can add additional logic if needed before setting the new dateTime
        dateTime = newDateTime
    }
    
    // Implementing Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(content)
        hasher.combine(dateTime)
    }
    
    // Implementing Equatable for completeness
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.content == rhs.content && lhs.dateTime == rhs.dateTime
    }
}


