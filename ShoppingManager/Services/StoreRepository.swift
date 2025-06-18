final class StoreRepository {
    static func getCurrentStore() -> StoreManager {
        return StoreManager(name: "Shop", products: ["Bread", "Milk", "Eggs", "Butter", "Cheese", "Tomatoes", "Beer", "Onions", "Chicken", "Beef", "Mushrooms", "Salami"])
    }
}
