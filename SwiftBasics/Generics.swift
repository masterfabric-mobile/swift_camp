//
//  Generics.swift
//  
//
//  Created by Yunus Oktay on 8.02.2026.
//

import Foundation

// MARK: - Generics
/*
 Generics let you write flexible, reusable, and type-safe code by avoiding duplicate implementations for different types.
 */

// MARK: - 1) Generic Function

/// Swaps two values of the same type.
/// This is a classic example used to demonstrate why generics exist.
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}

// Example usage:
var x = 10
var y = 20
swapTwoValues(&x, &y)


// MARK: - 2) Generic Type: Stack

/// A generic stack that can store values of any element type.
/// Similar to the example used in Swift's Generics documentation.
struct Stack<Element> {
    private var items: [Element] = []

    var isEmpty: Bool { items.isEmpty }
    var count: Int { items.count }

    mutating func push(_ item: Element) {
        items.append(item)
    }

    mutating func pop() -> Element? {
        items.popLast()
    }

    func peek() -> Element? {
        items.last
    }
}

// Example usage:
var intStack = Stack<Int>()
intStack.push(10)
intStack.push(20)

let top = intStack.peek()        // 20
let popped = intStack.pop()      // 20
let afterPop = intStack.peek()   // 10


// MARK: - 3) Generic Constraints (e.g., Equatable)

/// This function works only when T conforms to Equatable.
func areEqual<T: Equatable>(_ lhs: T, _ rhs: T) -> Bool {
    lhs == rhs
}

// Example usage:
areEqual(1, 1) // true
areEqual("a", "b") // false


// MARK: - 4) Specialized / Conditional Extensions

/// This method is available ONLY when Element conforms to Equatable.
/// A common Swift pattern: add APIs only when constraints are satisfied.
extension Stack where Element: Equatable {
    func contains(_ item: Element) -> Bool {
        // We can use `==` because Element is Equatable.
        // Array.contains requires Equatable as well.
        // Note: `items` is private, but this extension is in the same file,
        // so it can still access it.
        return items.contains(item)
    }
}

// Example Usage
let has10 = intStack.contains(10) // true (Int is Equatable)


// MARK: - 5) Protocols with Associated Types (Container)

/// Associated types let protocols describe a "family of types" in a generic way.
/// This is commonly shown using a Container protocol + Stack conformance.
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    mutating func pop() -> Item?
    var count: Int { get }
}

extension Stack: Container {
    typealias Item = Element

    mutating func append(_ item: Element) {
        push(item)
    }

    mutating func pop() -> Element? {
        popLast()
    }

    // Helper method to keep naming consistent with the protocol.
    private mutating func popLast() -> Element? {
        items.popLast()
    }
}

// Example Usage
var c1 = Stack<Int>(); c1.append(1); c1.append(2)
var c2 = Stack<Int>(); c2.append(1); c2.append(2)


// MARK: - 6) Generic where clause with associated types

/// Compares two containers if they store the same Item type and the Item is Equatable.
/// Demonstrates a practical where-clause: "same element type + Equatable".
func allItemsMatch<C1: Container, C2: Container>(_ c1: C1, _ c2: C2) -> Bool where C1.Item == C2.Item, C1.Item: Equatable {

    guard c1.count == c2.count else { return false }

    // Since Container doesn't define subscripting, a simple approach is to
    // pop elements from *copies* of the containers and compare them.
    var left = c1
    var right = c2

    while left.count > 0 && right.count > 0 {
        guard let l = left.pop(), let r = right.pop() else { return false }
        if l != r { return false }
    }
    return true
}

// Example usage:
var s1 = Stack<Int>(); s1.push(1); s1.push(2)
var s2 = Stack<Int>(); s2.push(1); s2.push(2)
allItemsMatch(s1, s2) // true


// MARK: - Notes
/*
 - Generic `where` clauses are key for expressing constraints, especially with associated types.
 - Specialized extensions (extension Type where ...) are how Swift conditionally adds APIs and conformances (e.g., Array is Equatable when Element is Equatable).
 */
