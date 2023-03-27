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

func minTime(_ n: Int, _ edges: [[Int]], _ hasApple: [Bool]) -> Int {
    var adjMat = Array(repeating: [Int](), count: n+1)
    var visited = Array(repeating: 0, count: n+1)
    for i in 0..<edges.count{
        let child = edges[i][0]
        let Parent = edges[i][1]
        adjMat[child].append(Parent)
        adjMat[Parent].append(child)
    }
    return calculateApple(0,adjMat,&visited,hasApple)
}


func calculateApple(_ start: Int,_ adjMAt: [[Int]],_ visited:inout [Int],_ hasApple: [Bool]) -> Int{
    var temp = 0
    if hasApple[start] && start != 0{
        temp += 2
    }
    visited[start] = 1
    for i in adjMAt[start]{
        if visited[i] == 0{
            temp += calculateApple(i, adjMAt, &visited, hasApple)
        }
    }
    if temp > 0 && !hasApple[start] && start != 0{
        temp += 2
    }
    return temp
}

func countSubTrees(_ n: Int, _ edges: [[Int]], _ labels: String) -> [Int] {
    var adjMat = Array(repeating: [Int](), count: n+1)
    for i in 0..<edges.count{
        var child = edges[i][0]
        var parent = edges[i][1]
        adjMat[child].append(parent)
        adjMat[parent].append(child)
    }
    let labels = labels.map{Int($0.asciiValue!) - 97}
    var result = Array(repeating: 0, count: n)
    var parents = Array(repeating: [Int](), count: 26)
    visitedSubTree(0, labels[0],labels,adjMat,&parents,&result)
    return result
}


func visitedSubTree(_ node: Int,_ label:Int,_ labels: [Int],_ adjMat:[[Int]],_ parents:inout [[Int]],_ result :inout [Int]) {
    parents[label].append(node)
    parents[label].forEach { i in
        result[i] += 1
    }
    for child in adjMat[node] where result[child] == 0{
        visitedSubTree(child, labels[child],labels, adjMat, &parents, &result)
    }
    parents[label].removeLast()
}
var res = 1
var dist = Array(repeating: -1, count: 10005)
func longestPath(_ parent: [Int], _ s: String) -> Int {
    let arr = Array(s)
    let n = parent.count
    var graph = Array(repeating: [Int](), count: n)
    
    for i in 1..<n {
        graph[parent[i]].append(i)
    }
    
    longestPathDfs(0,parent,graph, arr)
    return res
}



func longestPathDfs(_ i: Int,_ parent: [Int],_ graph:[[Int]], _ arr: [Character]){
    dist[i] = 1
    for j in graph[i]{
        longestPathDfs(j, parent, graph, arr)
        if arr[i] != arr[j] {
            res = max(res, dist[i] + dist[j])
            dist[i] = max(dist[i], dist[j] + 1)
        }
    }
}

func solve(_ board: inout [[Character]]) {
    var m = board.count
    var n = board[0].count
    var delRow = [-1,0,1,0]
    var delCol = [0,1,0,-1]
    var visited = Array(repeating: Array(repeating: 0, count: n), count: m)
    for j in 0..<n{
        
        // First Row
        if visited[0][j] == 0 && board[0][j] == "O"{
            dfsForBoard(0, j, &visited, board,delRow,delCol)
        }
        
        // Last Row
        if visited[m-1][j] == 0 && board[m-1][j] == "O"{
            dfsForBoard(m-1, j, &visited, board,delRow,delCol)
        }
    }
    
    
    for i in 0..<m{
        if visited[i][0] == 0 && board[i][0] == "O"{
            dfsForBoard(i, 0, &visited, board,delRow,delCol)
        }
        
        // Last Row
        if visited[i][n-1] == 0 && board[i][n-1] == "O"{
            dfsForBoard(i, n-1, &visited, board,delRow,delCol)
        }
    }
    
    for k in 0..<m{
        for l in 0..<n{
            if visited[k][l] == 0 && board[k][l] == "O"{
                board[k][l] = "X"
            }
        }
    }
}

func dfsForBoard(_ row: Int,_ col : Int,_ vis: inout [[Int]], _ mat: [[Character]],_ delRow: [Int],_ delCol:[Int]) {
    vis[row][col] = 1
    var m = mat.count
    var n = mat[0].count
    for i in 0..<4{
        var nRow = row + delRow[i]
        var nCol = col + delCol[i]
        if nRow >= 0 && nRow < m && nCol >= 0 && nCol < n && vis[nRow][nCol] == 0 && mat[nRow][nCol] == "O" {
            dfsForBoard(nRow, nCol, &vis, mat, delRow, delCol)
        }
    }
}


func numEnclaves(_ grid: [[Int]]) -> Int {
    var m = grid.count
    var n = grid[0].count
    var queue = [(Int,Int)]()
    var visited = Array(repeating: Array(repeating: 0, count: n), count: m)
    for i in 0..<m{
        for j in 0..<n{
            // first row,last row,first col,last col
            if i == 0 || i == m-1 || j == 0 || j == n-1{
                if grid[i][j] == 1{
                    queue.append((i,j))
                    visited[i][j] = 1
                }
            }
        }
    }
    var delRow = [-1,0,1,0]
    var delCol = [0,1,0,-1]
    
    while !queue.isEmpty{
        var row = queue.first!.0
        var col =  queue.first!.1
        queue.removeFirst()
        
        // traverse ALL four direction
        for i in 0..<4{
            var nRow = row + delRow[i]
            var nCol = col + delCol[i]
            if nRow >= 0 && nRow < m &&  nCol >= 0 && nCol < n && visited[nRow][nCol] == 0 && grid[nRow][nCol] == 1{
                queue.append((nRow,nCol))
                visited[nRow][nCol] = 1
            }
        }
    }

    var count = 0
    for i in 0..<m{
        for j in 0..<n{
            if grid[i][j] == 1 && visited[i][j] == 0{
                count += 1
            }
        }
    }
    return count
}




func closestDistanceBetweenNode(_ i:Int,_ distance: Int,_ arr: inout [Int],_ edges:[Int]){
    if i != -1 && arr[i] == -1{
        arr[i] = distance
        closestDistanceBetweenNode(edges[i], distance+1, &arr, edges)
    }
}
    
func closestMeetingNode(_ edges: [Int], _ node1: Int, _ node2: Int) -> Int {
    var ans = -1
    var minDistance = Int.max
    var arr1 = Array(repeating: -1, count: edges.count)
    var arr2 = Array(repeating: -1, count: edges.count)
    closestDistanceBetweenNode(node1,0, &arr1, edges)
    closestDistanceBetweenNode(node2,0, &arr2, edges)
    for i in 0..<edges.count{
        if min(arr1[i],arr2[i]) >= 0 && max(arr1[i],arr2[i]) < minDistance{
            minDistance = max(arr1[i],arr2[i])
            ans = i
        }
    }
    return ans
}

var dx = [0,0,-1,1]
var dy = [-1,1,0,0]
func maxDistance(_ grid: [[Int]]) -> Int {
    var grid = grid
    var row = grid.count
    var col = grid[0].count
    var queue = [(Int,Int)]()
    for i in 0..<row{
        for j in 0..<col{
            if grid[i][j] == 1{
                queue.append((i,j))
                grid[i][j] = 2
            }
        }
    }
    
    if queue.count == row * col || queue.isEmpty{
        return -1
    }
    var maxi = 0
    while !queue.isEmpty{
        var size = queue.count
        for _ in 0..<size{
            var node = queue.removeFirst()
            for i in 0..<4{
                var next_i = node.0 + dx[i]
                var next_j = node.1 + dy[i]
                if (next_i >= 0 && next_j >= 0 && next_i < row && next_j < col){
                    if grid[next_i][next_j] == 0{
                        queue.append((next_i,next_j))
                        grid[next_i][next_j] = 2
                    }
                }
            }
        }
        maxi += 1
    }
    return maxi-1
}


func shortestAlternatingPaths(_ n: Int, _ redEdges: [[Int]], _ blueEdges: [[Int]]) -> [Int] {
    var red = [Int: [Int]]()
    var blue = [Int: [Int]]()
    for edge in redEdges {
        red[edge[0],default: []].append(edge[1])
    }
    for edge in blueEdges {
        blue[edge[0],default: []].append(edge[1])
    }
    var queue = [(0,0,-1)]
    var visit = Set<[Int]>()
    visit.insert([0,-1])
    var ans = Array(repeating: -1, count: n)
    while !queue.isEmpty{
        let (node,length,color) = queue.removeFirst()
        if ans[node] == -1{
            ans[node] = length
        }
        if color != 1{
            for neighbour in red[node] ?? [Int](){
                if !visit.contains([neighbour,1]) {
                    visit.insert([neighbour,1])
                    queue.append((neighbour, length+1, 1))
                }
            }
        }
        
        if color != 2{
            for neighbour in blue[node] ?? [Int](){
                if !visit.contains([neighbour,2]) {
                    visit.insert([neighbour,2])
                    queue.append((neighbour, length+1, 2))
                }
            }
        }
    }
    return ans
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
//countPairs(7, [[0,2],[0,5],[2,4],[1,6],[5,4]])
//minTime(7, [[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]], [false,false,true,false,true,true,false])
//countSubTrees(7,[[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]],"abaedcd")
//longestPath([-1,0,0,1,1,2], "abacbe")
//var board = [["X","X","X","X"],["X","O","O","X"],["X","X","O","X"],["X","O","X","X"]]
//solve(&board)
//numEnclaves([[0,0,0,0],[1,0,1,0],[0,1,1,0],[0,0,0,0]])
//findJudge(2, [[1,2]])
//closestMeetingNode([2,2,3,-1], 0, 1)
maxDistance([[1,0,1],[0,0,0],[1,0,1]])
shortestAlternatingPaths(3, [[0,1],[1,2]], [])
