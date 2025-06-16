import Foundation

final class Basket {
    private var purchases = [String: Int]()
    
    func add(product: String) {
        purchases[product, default: 0] += 1
    }
    
    func remove(product: String) {
        guard let count = purchases[product] else { return }
        if count > 1 {
            purchases[product] = count - 1
        } else {
            purchases.removeValue(forKey: product)
        }
    }
    
    func find(product: String) -> Int? {
        return purchases[product]
    }
}
