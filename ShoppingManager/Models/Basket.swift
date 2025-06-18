import Foundation

final class Basket {
    private var purchases = [String: Int]()
    
    func add(product: String) {
        purchases[product, default: 0] += 1
    }
    
    func remove(product: String) {
        guard let count = find(product) else { return }
        
        let amount = count - 1
        purchases[product] = amount
        
        if amount == 0 {
            purchases.removeValue(forKey: product)
        }
    }
    
    func find(_ product: String) -> Int? {
        return purchases[product]
    }
    
    func totalQuantity() -> Int {
        return purchases.values.reduce(0, +)
    }
}
