import Foundation

struct Toast: Equatable {
  var style: ToastStyle
  var message: String
  var duration: Double = 3
  var width: Double = .infinity
}
