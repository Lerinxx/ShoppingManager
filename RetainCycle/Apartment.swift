class Apartment {
    let number: Int
    // If both Person.apartment and Apartment.tenant are strong references,
    // they create a retain cycle and neither object will be deallocated.
    // To break the cycle, uncomment the weak var line.
    var tenant: Person?
//    weak var tenant: Person?
    
    init(number: Int) {
        self.number = number
    }
    
    // deinit won't be called due to the retain cycle. Marking `tenant` as weak breaks the cycle.
    deinit {
        print("Apartment \(number) deinit")
    }
}
