import Foundation

final class Basket {
    private var purchases = [String: Int]()
    private let store: StoreManager
    
    init(store: StoreManager) {
        self.store = store
    }
    
    func add(product: String) throws {
        let currentQuantity = purchases[product] ?? 0
        guard currentQuantity < 99 else {
            throw StoreError.invalidQuantity
        }
        
        try store.reserveProduct(product)
        purchases[product, default: 0] += 1
    }
    
    func remove(product: String) {
        guard let count = find(product), count > 0 else { return }
        
        let amount = count - 1
        purchases[product] = amount
        
        if amount == 0 {
            purchases.removeValue(forKey: product)
        }
        
        store.releaseProduct(product)
    }
    
    func find(_ product: String) -> Int? {
        return purchases[product]
    }
    
    func totalQuantity() -> Int {
        return purchases.values.reduce(0, +)
    }
}
