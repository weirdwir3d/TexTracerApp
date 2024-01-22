import Foundation

class DateUtility {
    
    static func formatDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }

    static func formatDateTimeToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy, HH:mm"
        return dateFormatter.string(from: date)
    }
    
    static func convertDateTimeToDateString(_ dateTimeString: String) -> String? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy, HH:mm"
            
            if let date = dateFormatter.date(from: dateTimeString) {
                return formatDateToString(date)
            } else {
                return nil  // Failed to convert
            }
        }
}
