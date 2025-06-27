final class StoreRepository {
    static func getCurrentStore() -> StoreManager {
        return StoreManager(name: "Shop", products: ["Bread": 100, "Milk": 10, "Eggs": 5, "Butter": 1, "Cheese": 8, "Tomatoes": 2, "Beer": 15, "Onions": 12, "Chicken": 6, "Beef": 2, "Mushrooms": 7, "Salami": 3])
    }
}
