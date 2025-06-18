struct Stack<T> {
    private var elements: [T] = []
    
    mutating func push(_ element: T) {
        elements.append(element)
    }
    
    mutating func pop() -> T? {
        return elements.popLast()
    }
}

func testStackIntUsage() {
    var stackInt = Stack<Int>()
    print(stackInt.pop() ?? "nil")
    stackInt.push(10)
    stackInt.push(6)
    print(stackInt.pop() ?? "nil")
}

func testStackStringUsage() {
    var stackStr = Stack<String>()
    stackStr.push("hello")
    stackStr.push("world")
    print(stackStr.pop() ?? "nil")
}


