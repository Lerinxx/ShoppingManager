import Foundation

final class StoreManager {
    private let name: String
    private let products: [String]
    
    init(name: String, products: [String]) {
        self.name = name
        self.products = products
    }
    
    func getProducts() -> [String] {
        return products
    }
    
    func hasProduct(_ product: String) -> Bool {
        return products.contains(product)
    }
}
