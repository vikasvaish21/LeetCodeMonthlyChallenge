import Foundation
import UIKit

var greeting = "Hello, playground"
struct Heap<T: Comparable> {
    var nodes = [T]()
    private var comparator: (T, T) -> Bool
    
    var size: Int { nodes.count }
    
    init(_ sort: @escaping (T, T) -> Bool) {
        self.comparator = sort
        buildHeap()
    }
    
    func peek() -> T? {
        nodes.first
    }
    
    mutating func insert(_ value: T) {
      nodes.append(value)
      shiftUp(nodes.count - 1)
    }
    
    mutating func remove() -> T {
        if size == 1 {
            return nodes.removeLast()
        } else {
            let value = nodes[0]
            nodes[0] = nodes.removeLast()
            shiftDown(0)
            return value
        }
    }


    private func parentIndex(_ index: Int) -> Int {
        (index-1)/2
    }
    
    private func leftChildIndex(_ index: Int) -> Int {
        index * 2 + 1
    }
    
    private func rightChildIndex(_ index: Int) -> Int {
        index * 2 + 2
    }
    
    private func hasParent(_ index: Int) -> Bool {
        parentIndex(index) >= 0
    }
    
    private func hasLeftChild(_ index: Int) -> Bool {
        leftChildIndex(index) < size
    }
    
    private func hasRightChild(_ index: Int) -> Bool {
        rightChildIndex(index) < size
    }
    
    private mutating func shiftUp(_ index: Int) {
        var index = index
        while index > 0, comparator(nodes[parentIndex(index)], nodes[index]) == false {
            nodes.swapAt(index, parentIndex(index))
            index = parentIndex(index)
        }
    }
    
    private mutating func shiftDown(_ index: Int) {
        var index = index
        while hasLeftChild(index) {
            var smallerChildIndex = self.leftChildIndex(index)
            if hasRightChild(index), comparator(nodes[rightChildIndex(index)], nodes[leftChildIndex(index)]) {
                smallerChildIndex = rightChildIndex(index)
            }
            
            if comparator(nodes[index], nodes[smallerChildIndex]) == false {
                nodes.swapAt(index, smallerChildIndex)
            }
            index = smallerChildIndex
        }
        
    }
    
    private mutating func buildHeap() {
        for i in stride(from: size/2, through: 0, by: -1) {
            shiftDown(i)
        }
    }
}

struct Project: Comparable {
    var first = 0 // capital or profit
    var second = 0 // capital or profit

    init(_ first: Int, _ second: Int) {
        self.first = first
        self.second = second
    }

    static func <(_ lhs: Project, _ rhs: Project) -> Bool {
        lhs.first < rhs.first
    }

    static func ==(_ lhs: Project, _ rhs: Project) -> Bool {
        lhs.first == rhs.first
    }
}

func findMaximizedCapital(_ k: Int, _ w: Int, _ profits: [Int], _ capital: [Int]) -> Int {
    var minCapitalHaep = Heap<Project>(<)
    var maxProfitHeap = Heap<Project>(>)
    var money = w
    for i in 0..<profits.count{
        minCapitalHaep.insert(Project(capital[i],profits[i]))
    }
    print(minCapitalHaep)
    for _ in 0..<k{
        while minCapitalHaep.size > 0 , minCapitalHaep.peek()!.first <= money{
            let top = minCapitalHaep.remove()
            maxProfitHeap.insert(Project(top.second,top.first))
        }
        guard maxProfitHeap.size > 0 else {break}
        money +=  maxProfitHeap.remove().first
    }
    return money
}

findMaximizedCapital(2, 0, [1,2,3], [0,1,1])


