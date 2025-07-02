import Foundation

final class StoreManager {
    private let name: String
    private var stock: [String: Int]
    
    init(name: String, products: [String: Int]) {
        self.name = name
        self.stock = products
    }
    
    func getProducts() -> [String] {
        return Array(stock.keys)
    }
    
    func reserveProduct(_ product: String) throws {
        guard let current = stock[product], current > 0 else {
            throw StoreError.outOfStock
        }
        stock[product] = current - 1
    }
    
    func releaseProduct(_ product: String) {
        stock[product, default: 0] += 1
    }
}
