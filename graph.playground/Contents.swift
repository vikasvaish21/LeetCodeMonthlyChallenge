import UIKit
import Foundation


class Node {
    
    var value: Int?
    var edges: [Edge]
    var visited = false
    
    init(value: Int?) {
        self.value = value
        self.edges = []
    }
}

class Edge {
    
    var value: Int?
    var nodeFrom: Node?
    var nodeTo: Node?
    
    init(value: Int?, nodeFrom: Node?, nodeTo: Node?) {
        self.value = value
        self.nodeFrom = nodeFrom
        self.nodeTo = nodeTo
    }
}

class Graph {
    
    var nodes: [Node]
    var edges: [Edge]
    
    init(nodes: [Node], edges: [Edge]) {
        self.nodes = nodes
        self.edges = edges
    }
    
    // Create a recursive implementation.
    // Return a list of the node values.
    func dfs(_ startNode: Node) -> [Int] {
        var visited = [startNode.value!]
        return dfsHelper(startNode, visited: visited)
    }
    
    // Create an iterative implementation.
    // Return a list of the node values.
    func bfs(_ startNode: Node) -> [Int] {
        var visited : [Int] = []
        var toVisitQueue : [Node] = []
        toVisitQueue.append(startNode)
        visited.append(startNode.value!)
        while !toVisitQueue.isEmpty{
            let node = toVisitQueue.removeFirst()
            for edge in node.edges {
                let neighbourNode = edge.nodeTo
                if !neighbourNode!.visited{
                    toVisitQueue.append(neighbourNode!)
                    neighbourNode?.visited = true
                    visited.append((neighbourNode?.value)!)
                }
            }
        }
        return visited
    }
    
    // helper method - use to implement DFS recursively
    func dfsHelper(_ current: Node, visited: [Int]) -> [Int] {
        var result = visited
        for edgeObject in current.edges{
            if !result.contains((edgeObject.nodeTo?.value)!){
                result.append((edgeObject.nodeTo?.value)!)
                result = dfsHelper(edgeObject.nodeTo!, visited: result)
            }
        }
        return result
    }
    
    // creates a now with a given value and inserts it into the graph
    func insertNodeWithValue(_ value: Int) {
        let newNode = Node(value: value)
        nodes.append(newNode)
    }
    
    func getEdgesList() -> [[Int]]{
        var edgeList = [[Int]]()
        for edgeObject in edges{
            let edge = [edgeObject.value!,edgeObject.nodeFrom!.value!,edgeObject.nodeTo!.value!]
            edgeList.append(edge)
        }
        return edgeList
    }
    
    func getAdjacencyList() -> [[[Int]]] {

        let max = getMaxIndex()
        var adjacencyList = [[[Int]]]()

        for _ in 0...max {
            adjacencyList.append([])
        }

        for edgeObject in edges {
            if !adjacencyList[(edgeObject.nodeFrom?.value)!].isEmpty {
                adjacencyList[(edgeObject.nodeFrom?.value)!].append([edgeObject.nodeTo!.value!, edgeObject.value!])
            } else {
                adjacencyList[edgeObject.nodeFrom!.value!] = [[edgeObject.nodeTo!.value!, edgeObject.value!]]
            }
        }

        return adjacencyList
    }
    
    func getMaxIndex() -> Int {
            var maxIndex = 0
            
            for node in nodes {
                if node.value! > maxIndex {
                    maxIndex = node.value!
                }
            }
            
            return maxIndex
        }
    
    // inserts an edge between the "to" and "from" nodes with the given value
    func insertEdgeWithValue(_ newEdgeValue: Int, nodeFromValue: Int, nodeToValue: Int) {
        var fromFound: Node? = nil
        var toFound: Node? = nil
        
        for node in nodes {
            if nodeFromValue == node.value {
                fromFound = node
            }
            if nodeToValue == node.value {
                toFound = node
            }
        }
        
        if fromFound == nil {
            fromFound = Node(value: nodeFromValue)
            nodes.append(fromFound!)
        }
        if toFound == nil {
            toFound = Node(value: nodeToValue)
            nodes.append(toFound!)
        }
        
        let newEdge = Edge(value: newEdgeValue, nodeFrom: fromFound, nodeTo: toFound)
        fromFound?.edges.append(newEdge)
        toFound?.edges.append(newEdge)
        edges.append(newEdge)
    }
    
    
    func validPath(_ n: Int, _ edges: [[Int]], _ source: Int, _ destination: Int) -> Bool {
        var graph = [[Int]](repeating: [],count:n)
        for edge in edges{
//            print(edge)
            graph[edge[0]].append(edge[1])
            graph[edge[1]].append(edge[0])
        }
//        print(graph)
        var visited = Set<Int>()
        var queue = [Int]()
        queue.append(source)
        while !queue.isEmpty{
            let curr = queue.removeFirst()
            visited.insert(curr)
            if curr == destination{
                return true
            }
            for edge in graph[curr] {
                if !visited.contains(edge){
                    queue.append(edge)
                }
            }
        }
        return false
    }
}

func findJudge(_ n: Int, _ trust: [[Int]]) -> Int {
    var arr1 = [[Int]](repeating: [],count:n+1)
    var arr2 = [[Int]](repeating: [],count:n+1)
    for i in trust{
        let a = i[0]
        let b = i[1]
        arr1[a].append(b)
        arr2[b].append(a)
    }
//    print(arr1)
//    print(arr2)
    
    for i in 1..<n+1{
        let adjecencyList1 = arr1[i]
        let adjecencyList2 = arr2[i]
        if adjecencyList2.count == n-1 && adjecencyList1.count == 0{
            return i
        }

    }
    return -1
}

func countPairs(_ n: Int, _ edges: [[Int]]) -> Int {
    var graph = [[Int]](repeating: [],count: n)

    for edge in edges{
        graph[edge[0]].append(edge[1])
        graph[edge[1]].append(edge[0])
    }
    print(graph)
    var visited = Set<Int>()
    
    func dfs(_ node: Int) -> Int{
        if visited.contains(node){
            return 0
        }
        visited.insert(node)
        var res = 1
//        print(graph[node])
        for i in graph[node]{
            
            res += dfs(i)
//            print(i,res)
        }
        return res
    }

    var components = [Int]()
    var totalSum = 0
    for i in 0..<n{
        let temp = dfs(i)
//        print(temp)
        if temp != 0{
            totalSum += temp
            print(totalSum)
            components.append(temp)
        }
    }
    
    
    var result = 0
    for i in components{
        result += (totalSum-i)*i
    }
    return result/2
}
//Test cases
let graph = Graph(nodes: [], edges: [])
graph.insertEdgeWithValue(100, nodeFromValue: 1, nodeToValue: 2)
graph.insertEdgeWithValue(101, nodeFromValue: 1, nodeToValue: 3)
graph.insertEdgeWithValue(102, nodeFromValue: 1, nodeToValue: 4)
graph.insertEdgeWithValue(103, nodeFromValue: 3, nodeToValue: 4)
graph.getEdgesList()
//print(graph.dfs(graph.nodes[0])) // Should be [1, 2, 3, 4]
//print(graph.bfs(graph.nodes[0])) // Should be [1, 2, 3, 4]
//print(graph.getAdjacencyList())
//print(graph.dfs(graph.nodes[0]))
//graph.validPath(3,[[0,1],[1,2],[2,0]], 0, 2)
//findJudge(3, [[1,3],[2,3],[3,1]])
countPairs(7, [[0,2],[0,5],[2,4],[1,6],[5,4]])
