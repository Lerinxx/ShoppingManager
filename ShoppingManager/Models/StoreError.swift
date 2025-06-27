import Foundation

enum StoreError: Error, LocalizedError {
    case outOfStock
    case invalidQuantity
    
    var errorDescription: String? {
        switch self {
        case .outOfStock:
            "This product is out of stock"
        case .invalidQuantity:
            "You can't add more than 99 units of the same product"
        }
    }
}
