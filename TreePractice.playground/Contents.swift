import UIKit
import Darwin

var greeting = "Hello, playground"


public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}
func preorderTraversal(_ root: TreeNode?) -> [Int] {
    guard let root = root else{
        return []
    }
    var arr = [Int]()
    var stack = [TreeNode]()
    stack.append(root)
    while stack.count > 0{
        let node = stack.popLast()!
        arr.append(node.val)
        if node.right != nil{
            stack.append(node.right!)
        }
        if node.left != nil{
            stack.append(node.left!)
        }
    }
    
    return arr
}


func postorder(_ root: TreeNode?) -> [Int] {
    guard let root = root else{
        return []
    }
    var arr = [Int]()
    var stack = [TreeNode]()
    stack.append(root)
    while stack.count > 0{
        let node = stack.popLast()!
        arr.insert(node.val, at: 0)
        if node.left != nil{
            stack.append(node.left!)
        }
        if node.right != nil{
            stack.append(node.right!)
        }
    }
    
    return arr
}

func numTrees(_ n: Int) -> Int {
    if n < 2{
        return 1
    }
    var res = Array(repeating: 0, count: n+1)
    res[0] = 1
    res[1] = 1
    for i in 2...n{
        for j in 0..<i{
            res[i] += res[j] * res[i-j-1]
        }
    }
    return res[n]
}

func generateTrees(_ n: Int) -> [TreeNode?] {
    if n==0{
        return []
    }
    return helper(1, n)
}

func helper(_ start:Int,_ end:Int) -> [TreeNode?]{
    if start > end{
        return [nil]
    }
    if start == end{
        return [TreeNode(start)]
    }
    var leftPart = [TreeNode?]()
    var rightPart = [TreeNode?]()
    var allTree = [TreeNode?]()
    for i in start...end{
         leftPart = helper(start, i-1)
         rightPart = helper(i+1, end)
        for left_Subtree in leftPart{
            for right_Subtree in rightPart{
                let node = TreeNode(i)
                node.left = left_Subtree
                node.right = right_Subtree
                allTree.append(node)
            }
        }
    }
    return allTree
}


func widthOfBinaryTree(_ root: TreeNode?) -> Int {
    guard let root = root else{
        return 0
    }

    var queue = [(TreeNode,Int)]()
    var maxWidth = 1
    queue.append((root,0))
    while !queue.isEmpty{
        let count = queue.count
        let firstNode = queue.first!
        let secondNode = queue.last!
        maxWidth = max(maxWidth,secondNode.1 - firstNode.1+1)
        for _ in 0..<count{
            let (node,indx) = queue.removeFirst()
            print(indx,firstNode.1)
            if let leftNode = node.left{
                queue.append((leftNode,(indx-firstNode.1)*2 + 1))
            }
            if let rightNode = node.right{
                queue.append((rightNode,(indx-firstNode.1)*2 + 2))
            }
        }
        
    }
    return maxWidth
}

func inorderTraversal(_ root: TreeNode?) -> [Int]{
//    guard let root = root else{
//        return []
//    }
    var result = [Int]()
    var stack = [TreeNode]()
    var node = root
    while node != nil || !stack.isEmpty{
        if let currentNode = node {
            stack.append(currentNode)
            node = currentNode.left
        } else{
            let prevNode = stack.removeLast()
            result.append(prevNode.val)
            node = prevNode.right
        }
    }
    return result
}

func maxDepth(_ root: TreeNode?) -> Int {
    
    guard let root = root else{
        return 0
    }
    var stack = [(root,1)]
    var maxDepth = 1
    while !stack.isEmpty{
        let (node,depth) = stack.popLast()!
        maxDepth = max(maxDepth, depth)
        if let leftNode = node.left{
            stack.append((leftNode,depth+1))
        }
        if let rightNode = node.right{
            stack.append((rightNode,depth+1))
        }
    }
    return maxDepth
}


//func maxPathSum(_ root: TreeNode?) -> Int {
//    guard let root = root else{
//        return 0
//    }
//    var maxi = Int.min
//    maxPath(root, &maxi)
//    return maxi
//}
//func maxPath(_ node:TreeNode?, _ maxi:inout Int) -> Int {
//    if node == nil{
//        return 0
//    }
//    let leftSum = max(0,maxPath(node?.left, &maxi))
//    let rightSum = max(0,maxPath(node?.right, &maxi))
//    maxi = max(maxi, node!.val + leftSum + rightSum)
//    return max(leftSum,rightSum) + node!.val
//}

func maxSumBST(_ root: TreeNode?) -> Int {
    guard let root = root else{
        return 0
    }
    var result = 0
    maxSum(root,&result)
    return result
}
func maxSum(_ node: TreeNode?,_ result: inout Int) -> [(Int,Int,Int)]{
    if node == nil {
        return [(Int.max,Int.min,0)]
    }
    var leftSum = maxSum(node?.left, &result)
    var rightSum = maxSum(node?.right, &result)
    if leftSum[0].1 >= node!.val || rightSum[0].0 <= node!.val{
        return [(Int.min,Int.max,0)]
    }
    var sum = leftSum[0].2 + node!.val + rightSum[0].2
    result = max(result,sum)
    return [(min(leftSum[0].0,node!.val),max(rightSum[0].1,node!.val),sum)]
}

func levelOrder(_ A: TreeNode?) -> [[Int]] {
    guard let A = A else {
        return [[Int]]()
    }
    var queue = [A]
    var res = [[Int]]()
    
    while queue.count > 0{
        var levelNode = queue.count
        var levelArray = [Int]()
        while levelNode > 0{
            let node = queue.removeFirst()
            if let left = node.left{
                queue.append(left)
            }
            if let right = node.right{
                queue.append(right)
            }
            
            levelArray.append(node.val)
            levelNode -= 1
            
        }
        res.append(levelArray)
    }
    return res
}
var cameraCount = 0
func minCameraCover(_ root: TreeNode?) -> Int {
    guard let root = root else{
        return 1
    }
    
    var result = dfs(root) == 0 ? cameraCount+1 : cameraCount
    return result
    
    
}
func dfs(_ node: TreeNode?) -> Int{
    if node == nil{
        return 1
    }
//    2. has camera
//    1. covered with the camera
//    0. no camera is covering
    var left = dfs(node?.left)
    var right = dfs(node?.right)
    if left == 0||right == 0{
        cameraCount+=1
        return 2
    } else if left == 2||right == 2{
        return 1
    } else{
        return 0
    }
}

func findBottomLeftValue(_ root: TreeNode?) -> Int {
    guard let root = root else{
        return 0
    }
    var queue = [TreeNode?]()
    queue.append(root)
    var leftMost : Int = 0
    while queue.count > 0{
        var levelNode = queue.count
        while levelNode > 0{
            let node = queue.removeFirst()
            if let right = node?.right{
                queue.append(right)
            }
            if let left = node?.left{
                queue.append(left)
            }
            leftMost = node!.val
            levelNode -= 1
        }
    }
    return leftMost
}


func lcaDeepestLeaves(_ root: TreeNode?) -> TreeNode? {
    guard let root = root else{
        return nil
    }
    var maxDepth = 1
    var stack = [(TreeNode?,Int)]()
    stack.append((root,1))
    while !stack.isEmpty{
        let (node,depth) = stack.removeLast()
        maxDepth = max(maxDepth,depth)
        if let right = node?.right{
            stack.append((right,depth+1))
        }
        if let left = node?.left{
            stack.append((left,depth+1))
        }
    }
    return lowestCommonIncestor(root, 0, maxDepth-1)
}

//func lcaDeepestLeaves(_ root: TreeNode?) -> TreeNode? {
//    let cur = root
//    let start = 0
//    if root?.right == nil && root?.left == nil{
//        return root
//    }
//    let maxDepth = maxDepthDeepestNode(root)
//    return lowestCommonIncestor(cur, start, maxDepth-1)
//
//}

func maxDepthDeepestNode(_ root: TreeNode?) -> Int{
    guard let root = root else{
        return 0
    }
    let leftDepth = maxDepthDeepestNode(root.left)
    let rightDepth = maxDepthDeepestNode(root.right)
    return 1 + max(leftDepth,rightDepth)
}

func lowestCommonIncestor(_ root: TreeNode?,_ lvl: Int,_  maxDepth: Int) -> TreeNode?{
    guard let root = root else{
        return nil
    }
    if lvl == maxDepth{
        return root
    }
    let left = lowestCommonIncestor(root.left, lvl+1, maxDepth)
    let right = lowestCommonIncestor(root.right, lvl+1, maxDepth)
    if  left != nil && right != nil{
        return root
    }
    return left != nil ? left : right
}


func largestValues(_ root: TreeNode?) -> [Int] {
    guard let root = root else {
        return [Int]()
    }
    var result = [Int]()
    var queue = [TreeNode?]()
    queue.append(root)
    
    while queue.count > 0{
        var levelNode = queue.count
        var levelArray = [Int]()
        while levelNode > 0{
            let node = queue.removeFirst()
            if let left = node!.left{
                queue.append(left)
            }
            if let right = node!.right{
                queue.append(right)
            }
            levelNode -= 1
            levelArray.append(node!.val)
            
        }
        result.append(levelArray.max()!)
    }
    return result
}


func distanceK(_ root: TreeNode?, _ target: TreeNode?, _ k: Int) -> [Int] {
    guard let root = root else{
        return [Int]()
    }
    var parentMap = [Int:TreeNode?]()
    dfsForDistanceK(root,&parentMap)
    return bfsForDistanceK(target, k, &parentMap)
    
}

func bfsForDistanceK(_ root:TreeNode?, _ target: Int, _ parent: inout [Int:TreeNode?]) -> [Int]{
    var queue = [TreeNode?]()
    var visited = Set<Int>()
    var currentLevel = 0
    queue.append(root)
    while !queue.isEmpty {
        if currentLevel == target{
            return queue.map{$0!.val}
        }
        let nodeCount = queue.count
        
        for i in 0..<nodeCount{
            let node = queue.removeFirst()
            visited.insert(node!.val)
            if let left = node?.left, !visited.contains(left.val){
                queue.append(left)
            }
            if let right = node?.right, !visited.contains(right.val){
                queue.append(right)
            }
            if let parent = parent[node!.val], !visited.contains(parent!.val){
                queue.append(parent)
            }
        }
        currentLevel += 1
    }
    return []
}



func dfsForDistanceK(_ root: TreeNode?,_ parent: inout [Int:TreeNode?]){
    guard let root = root else{
        return
    }
    if let left = root.left{
        parent[left.val] = root
        dfsForDistanceK(left,&parent)
    }
    if let right = root.right{
        parent[right.val] = root
        dfsForDistanceK(right,&parent)
    }
        
}

func addOneRow(_ root: TreeNode?, _ val: Int, _ depth: Int) -> TreeNode? {
    if depth == 1{
        return TreeNode(val, root, nil)
    }
    var queue = [TreeNode?]()
    var deep = 1
    queue.append(root)
    while deep < depth - 1{
        var temp = [TreeNode]()
        for node in queue{
            if let left = node?.left{
                temp.append(left)
            }
            
            if let right = node?.right{
                temp.append(right)
            }
        }
        queue = temp
        deep += 1
    }
    for node in queue{
        node?.left = TreeNode(val, node?.left, nil)
        node?.right = TreeNode(val,nil,node?.right)
    }
    return root
}
    

//MARK: - 655. Print Binary Tree

func printTree(_ root: TreeNode?) -> [[String]] {
    var height = treeDepth(root)
    var maxNodes = Int(pow(2.0, Double(height))) - 1
    var ans = Array(repeating: Array(repeating: "", count: maxNodes), count: height)
    printTreeHelper(root, &ans, row: 0, i: 0, j: maxNodes-1)
    return ans
}

func printTreeHelper(_ root: TreeNode?,_ ans: inout [[String]],row: Int,i: Int,j:Int) {
    guard let root = root else{
        return
    }
    let col = i + (j-i)/2
    ans[row][col] = String(root.val)
    printTreeHelper(root.left, &ans, row: row+1, i: i, j: col-1)
    printTreeHelper(root.right, &ans, row: row+1, i: col+1, j: j)
}

func treeDepth(_ root: TreeNode?) -> Int{
    guard let root = root else{
        return 0
    }
    let leftDepth = treeDepth(root.left)
    let rightDepth = treeDepth(root.right)
    return 1 + max(leftDepth,rightDepth)
}

//MARK: - 637. Average of Levels in Binary Tree

func averageOfLevels(_ root: TreeNode?) -> [Double] {
    guard let root = root else{
        return [Double]()
    }
    var queue = [TreeNode?]()
    var result = [Double]()
    queue.append(root)
    while queue.count > 0{
        var subArr = [Double]()
        var nodeValue = queue.count
        while nodeValue > 0{
            var node = queue.removeFirst()
            if let left = node?.left{
                queue.append(left)
            }
            if let right = node?.right{
                queue.append(right)
            }
            subArr.append(Double(node!.val))
            nodeValue-=1
        }
        result.append(Double(subArr.reduce(0, +))/Double(subArr.count))
    }
    return result
}

func pruneTree(_ root: TreeNode?) -> TreeNode? {
    return checkSubTree(root) ? root : nil
}


func checkSubTree(_ root: TreeNode?) -> Bool{
    guard let root = root else{
        return false
    }
    let left = checkSubTree(root.left)
    let right = checkSubTree(root.right)
    if !left {
        root.left = nil
    }
    if !right{
        root.right = nil
    }
    return root.val == 1 || left  || right
}

// MARK: 1110. Delete Nodes And Return Forest

var targetValues = Set<Int>()

func delNodes(_ root: TreeNode?, _ to_delete: [Int]) -> [TreeNode?] {
    guard !to_delete.isEmpty else{
        return [root]
    }
    guard let root = root else{
         return [TreeNode?]()
    }
    var remainingRoots = [TreeNode?]()
    to_delete.forEach { targetValues.insert($0) }
    if !targetValues.contains(root.val) {
        remainingRoots.append(root)
    }
    getRootsAfterDeleting(root, &remainingRoots)
    return remainingRoots
}

func getRootsAfterDeleting(_ root: TreeNode?,_ remainingRoot: inout [TreeNode?]) -> TreeNode? {
    guard let root = root else {
        return nil
    }
    root.left = getRootsAfterDeleting(root.left, &remainingRoot)
    root.right = getRootsAfterDeleting(root.right, &remainingRoot)
    if targetValues.contains(root.val){
        if let left = root.left {
            remainingRoot.append(left)
        }
        
        if let right = root.right {
            remainingRoot.append(right)
        }
        return nil
    }
    return root
}

//MARK: - 474. Ones and Zeroes

//func findMaxForm(_ strs: [String], _ m: Int, _ n: Int) -> Int {
//    var strs = Array(strs)
//    var len = strs.count
//    var w = [(Int,Int)]()
//    for i in 0..<len{
//        var one = countOne(strs[i])
//    }
//}
//
//func countOne(_ str: String) -> Int {
//    var str = Array(str)
//    var ans = 0
//    for i in 0..<str.count{
//        if (str[i] == "1"){
//            ans+=1
//        }
//    }
//    return ans
//}

//MARK: -  112. Path Sum
func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
    guard let root = root else {
        return false
    }
    var stack = [TreeNode?]()
    stack.append(root)
    var SumStack = [Int]()
    SumStack.append(targetSum)
    while !stack.isEmpty{
        let currentNode = stack.removeFirst()
        let sumPop = SumStack.removeFirst()
        if currentNode?.left == nil && currentNode?.right == nil && currentNode?.val == sumPop{
            return true
        }
        if let left = currentNode?.left{
            stack.append(left)
            SumStack.append(sumPop-currentNode!.val)
        }
        if let right = currentNode?.right{
            stack.append(right)
            SumStack.append(sumPop-currentNode!.val)
        }
    }
    return false
}

var firstElement:TreeNode? = nil
var secondElement:TreeNode? = nil
var prevElement = TreeNode(Int.min)

func recoverTree(_ root: TreeNode?) {
    inorderTraverse(root)
    let temp = firstElement?.val
    firstElement?.val = secondElement!.val
    secondElement?.val = temp!
    
    
}

func inorderTraverse(_ root:TreeNode?){
    if root == nil{
        return
    }
    inorderTraverse(root?.left)
    if firstElement ==  nil && prevElement.val >= root!.val{
        firstElement = prevElement
    }
    if firstElement != nil && prevElement.val >= root!.val{
        secondElement = root
    }
    prevElement = root!
    inorderTraverse(root?.right)
}



func dfsHelper(_ root: TreeNode?) -> Int{
    guard let root = root else{
        return 0
    }
    return dfsHelper(root.left) + dfsHelper(root.right)  + root.val
}

func ProductHelper(_ root: TreeNode?,_ total: Int,_ ans: inout Int) -> Int{
    guard let root = root else{
        return 0
    }
    var left = ProductHelper(root.left, total, &ans)
    var right = ProductHelper(root.right, total,&ans)
    var up = total - left - right - root.val
    var option1 = left * (root.val + right + up)
    var option2 = right * (root.val + left + up)
    var option3 = up * (root.val + left + right)
    ans = max(ans, max(option1, max(option2, option3)))
    return left + right + root.val
}

func maxProduct(_ root: TreeNode?) -> Int {
    guard let root = root else{
        return 0
    }
    var ans = 0
    var total = dfsHelper(root)
    ProductHelper(root, total, &ans)
    return ans%1000000007
}


func rangeSumBST(_ root: TreeNode?, _ low: Int, _ high: Int) -> Int {
    guard let node = root else {
        return 0
    }
    var sum = 0
    if node.val <= high && node.val >= low{
        sum += node.val
    }
    if node.val > low{
        sum += rangeSumBST(node.left,low,high)
    }
    if node.val < high{
        sum += rangeSumBST(node.right,low,high)
    }
    
    return sum
}

func leafSimilar(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
    guard let root1 = root1,let root2 = root2 else{
        return false
    }
    var leaf1 = [Int]()
    var leaf2 = [Int]()
    var list1 = findLeafNodes(root1, &leaf1)
    var list2 = findLeafNodes(root2, &leaf2)
    if list1 == list2 {
        return true
    }
    return false
}

func findLeafNodes(_ root: TreeNode?,_ leaf :inout [Int]) -> [Int]{
    guard let node = root else{
        return [Int]()
    }
    if node.left == nil && node.right == nil{
        leaf.append(node.val)
    }
    findLeafNodes(node.left, &leaf)
    findLeafNodes(node.right, &leaf)
    return leaf
}

func maxAncestorDiff(_ root: TreeNode?) -> Int {
    return calculateMaxDiff(root!, root!.val, root!.val)
}

func calculateMaxDiff(_ root: TreeNode?,_ maxV: Int,_ minV:Int) -> Int{
    if root == nil{
        return abs(maxV-minV)
    }
    var maxV = maxV
    maxV = max(maxV, root!.val)
    var minV = minV
    minV = min(minV, root!.val)
    var left = calculateMaxDiff(root?.left, maxV, minV)
    var right = calculateMaxDiff(root?.right, maxV, minV)
    return max(left,right)
    
}

//func sumOfDistancesInTree(_ n: Int, _ edges: [[Int]]) -> [Int] {
//
//    }

func maxPathSum(_ root: TreeNode?) -> Int {
    guard let root = root else{
        return 0
    }
    var maxSum = Int.min
    calculateMaxSum(root,&maxSum)
    return maxSum
}

func calculateMaxSum(_ root: TreeNode?,_ maxSum : inout Int) -> Int{
    guard let node = root else{
        return 0
    }
    var left = max(0,calculateMaxSum(node.left,&maxSum))
    var right = max(0,calculateMaxSum(node.right,&maxSum))
    maxSum = max(maxSum, node.val + left + right)
    return node.val + max(left,right)
    
    
}

func calculatePreorderTraversal(_ root: TreeNode?,_ result: inout [Int]) -> [Int] {
    guard let node = root else{
        return [Int]()
    }
    result.append(node.val)
    if node.left != nil{
        var left = calculatePreorderTraversal(node.left, &result)
    }
    if node.right != nil{
        var right = calculatePreorderTraversal(node.right, &result)
    }
    return result
}
//func preorderTraversal(_ root: TreeNode?) -> [Int]{
//    var result = [Int]()
//    return calculatePreorderTraversal(root,&result)
//}

func calculateSameTree(_ node1: TreeNode?, _ node2: TreeNode?) ->Bool{
    
    if node1?.val != node2?.val{
        return false
    }
    if node1 == nil && node2 == nil{
        return true
    }
    if node1 == nil && node2 != nil{
        return false
    }
    if node1 != nil && node2 == nil{
        return false
    }
    return calculateSameTree(node1?.left,node2?.left) && calculateSameTree(node1?.right,node2?.right)
}

func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
    guard let node1 = p ,let node2 = q else{
        return true
    }
    return calculateSameTree(node1,node2)
}


func isValidSerialization(_ preorder: String) -> Bool {
    var preOrder = preorder.components(separatedBy: ",")
    var vacancy = 1
    for i in preOrder{
        vacancy-=1
        if vacancy < 0{
            return false
        }
        if i != "#"{
            vacancy += 2
        }
    }
    return vacancy == 0
}


func deleteNode(_ root: TreeNode?, _ key: Int) -> TreeNode? {
    guard root != nil else{
        return nil
    }
    var root = root
    if root?.val == key{
        return helperDeleteNode(root)
    }
    var dummy = root
    while root != nil{
        if root!.val > key{
            if root?.left != nil && root?.left?.val == key{
                root?.left = helperDeleteNode(root?.left)
                break
            }else{
                root = root?.left
            }
        } else {
            if root?.right != nil && root?.right?.val == key{
                root?.right = helperDeleteNode(root?.right)
                break
            }else{
                root = root?.right
            }
        }
    }
    return dummy
}


func helperDeleteNode(_ root: TreeNode?) -> TreeNode?{
    if root?.left == nil{
        return root?.right
    }else if root?.right == nil{
        return root?.left
    }else{
        var rightChild = root?.right
        var lastRightNode = findLastRightNode(root?.left)
        lastRightNode?.right = rightChild
        return root?.left
    }
    
    
}

func findLastRightNode(_ root: TreeNode?) -> TreeNode? {
    if root?.right == nil{
        return root
    }
    return findLastRightNode(root?.right)
}

func calculateInvertTree(_ root: TreeNode?) -> TreeNode?{
    
    var node = root
    if node?.left == nil && node?.right == nil{
        return root
    }else{
        var temp = node?.left
        node?.left = node?.right
        node?.right = temp
    }
    var left = calculateInvertTree(node?.left)
    var right = calculateInvertTree(node?.right)
    return root
}

func invertTree(_ root: TreeNode?) -> TreeNode? {
    guard root != nil else{
        return nil
    }
    return calculateInvertTree(root)
}


func findFrequentTreeSum(_ root: TreeNode?) -> [Int] {
    var map = [Int:Int]()
    calculateFrequentTreeSum(root, &map)
    print(map)
    var res = [Int]()
    var maxVal = Int.min
    for item in map{
       if item.value > maxVal{
            res.removeAll()
            res.append(item.key)
            maxVal = item.value
        }else if item.value == maxVal{
            res.append(item.key)
        }
    }
    return res
}

func calculateFrequentTreeSum(_ root: TreeNode?,_ map:inout [Int:Int]) -> Int{
    guard let node = root else{
        return 0
    }
    var left = calculateFrequentTreeSum(node.left, &map)
    var right = calculateFrequentTreeSum(node.right, &map)
    var sum = left + right + node.val
    if map[sum] == nil{
        map[sum] = 1
    }else{
        map[sum]! += 1
    }
    return sum
}

func findDuplicateSubtrees(_ root: TreeNode?) -> [TreeNode?] {
    var treeCounts = [String:Int]()
    var duplicates = [TreeNode]()
    calculateDuplicateSubTree(root,&treeCounts,&duplicates)
    return duplicates
}

func calculateDuplicateSubTree(_ root: TreeNode?,_ treeCounts:inout [String:Int],_ duplicates:inout [TreeNode]) -> String{
    guard let node = root else{
        return "."
    }
    let key = "(" + calculateDuplicateSubTree(root?.left,&treeCounts, &duplicates) + "\(root?.val)" + calculateDuplicateSubTree(root?.right,&treeCounts,&duplicates) + ")"
    var count = treeCounts[key] ?? 0
    if count == 1{
        duplicates.append(node)
    }
    treeCounts[key] = count + 1
    return key
}

func constructMaximumBinaryTree(_ nums: [Int]) -> TreeNode? {
    var start = 0
    var end = nums.count-1
    return buildMaximumBinaryTree(start, end, nums)
}

func buildMaximumBinaryTree(_ start: Int,_ end:Int,_ nums:[Int]) -> TreeNode?{
    if start > end{
        return nil
    }
    if start == end{
        return TreeNode(nums[start])
    }
    var index = findMaxIndex(nums,start,end)
    let root = TreeNode(nums[index])
    root.left =  buildMaximumBinaryTree(start, index-1, nums)
    root.right = buildMaximumBinaryTree(index+1, end, nums)
    return root
    
}


func findMaxIndex(_ nums:[Int],_ start: Int,_ end:Int) -> Int{
    var maxElement = Int.min
    var curIndex = -1
    for i in start...end{
        if nums[i] > maxElement{
            maxElement = nums[i]
            curIndex = i
        }
    }
    return curIndex
}

func insertIntoBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
    guard root != nil else{
        return TreeNode(val)
    }
    var cur = root
    while true{
        if cur!.val <= val{
            if cur?.right != nil {
                cur = cur?.right
            }else{
                cur?.right = TreeNode(val)
                break
            }
        }else{
            if cur?.left != nil {
                cur = cur?.left
            }else{
                cur?.left = TreeNode(val)
                break
            }
        }
    }
    return root
}


func sufficientSubset(_ root: TreeNode?, _ limit: Int) -> TreeNode? {
    guard let node = root else{
        return nil
    }
    if node.left == nil && node.right == nil{
        if node.val < limit{
            return nil
        }
        return root
    }
    var left = sufficientSubset(node.left,limit - node.val )
    var right = sufficientSubset(node.right,limit - node.val)
    if left == nil && right == nil{
       return nil
    }
    node.left = left
    node.right = right
    return root
}
var sum = 0
func sumEvenGrandparent(_ root: TreeNode?) -> Int {
    guard root != nil else{
        return 0
    }
    
    if root!.val % 2 == 0 {
        calculateSumEvenGrandparent(root)
    }
    sumEvenGrandparent(root?.left)
    sumEvenGrandparent(root?.right)
    return sum
}

func calculateSumEvenGrandparent(_ root:TreeNode?) -> Int{
    guard let node = root else{
        return 0
    }
    
    if let left = node.left{
        sum += (left.left?.val ?? 0) + (left.right?.val ?? 0)
    }
    if let right = node.right{
        sum += (right.left?.val ?? 0) + (right.right?.val ?? 0)
    }
    return sum
}


func isEvenOddTree(_ root: TreeNode?) -> Bool {
    guard root != nil else{
        return false
    }
    var queue  = [TreeNode?]()
    var level = 0
    queue.append(root)
    while !queue.isEmpty{
        
        var arr = [TreeNode]()
        var prev :Int? = nil
        while !queue.isEmpty{
            var node = queue.removeFirst()
            if let left = node?.left{
                arr.append(left)
            }
            if let right = node?.right{
                arr.append(right)
            }
            if level % 2 == 0{
                if (prev != nil && node!.val <= prev!) || node!.val % 2 == 0{
                    return false
                }
            }else{
                if (prev != nil && node!.val >= prev!) || node!.val % 2 != 0{
                    return false
                }
            }
            prev = node?.val
            
        }
        queue.append(contentsOf: arr)
        level += 1
    }
    return true
}



func calculateGoodPair(_ root: TreeNode?, _ distance: Int,_ ans: inout Int) -> [Int]{
    guard root != nil else {
        return [0]
    }
    if root?.left == nil && root?.right == nil{
        return [1]
    }
    
    var left = calculateGoodPair(root?.left, distance, &ans)
    var right = calculateGoodPair(root?.right, distance, &ans)
    for i in left{
        for j in right{
            if i != 0 && j != 0 && i+j <= distance{
                ans += 1
            }
        }
        
    }
    var res = [Int]()
    for a in left{
        if a != 0 && a+1 < distance{
            res.append(a+1)
        }
    }
    
    for b in right{
        if b != 0 && b+1 < distance{
            res.append(b+1)
        }
    }
    return res
}

func countPairs(_ root: TreeNode?, _ distance: Int) -> Int {
    guard root != nil else{
        return 0
    }
    var ans = 0
    calculateGoodPair(root, distance, &ans)
    return ans
}

func removeLeafNodes(_ root: TreeNode?, _ target: Int) -> TreeNode? {
    guard root != nil else {
        return nil
    }
    return deleteAllLeafNode(root, target)
    
}

func deleteAllLeafNode(_ root: TreeNode?, _ target: Int) -> TreeNode?{
    guard root != nil else{
        return nil
    }
  
    var left = deleteAllLeafNode(root?.left, target)
    var right = deleteAllLeafNode(root?.right, target)
    if left == nil && right == nil && root!.val == target {
        return nil
    }
    root?.left = left
    root?.right = right
    return root
}

func flipEquiv(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
    if root1 == nil && root2 == nil{
        return true
    }
    guard root1?.val == root2?.val else{
        return false
    }
    var isFlip = false
    if root1?.left?.val == root2?.right?.val && root2?.left?.val == root1?.right?.val{
        isFlip = true
    }
    
    var left = flipEquiv(root1?.left, isFlip ? root2?.right : root2?.left)
    var right = flipEquiv(root1?.right, isFlip ? root2?.left : root2?.right)
    return left && right
}

func maxLevelSum(_ root: TreeNode?) -> Int {
    var queue = [TreeNode?]()
    queue.append(root)
    var result = [Int]()
    while queue.count > 0{
        var sum = 0
        var levelNodes = queue.count
        while levelNodes > 0{
            var node = queue.removeFirst()
            if let left = node?.left{
                queue.append(left)
            }
            if let right = node?.right{
                queue.append(right)
            }
            sum += node!.val
            levelNodes -= 1
        }
        result.append(sum)
    }
    var index = result.firstIndex(of:result.max()!)
    return index! + 1
}

func calculateGreaterBST(_ root: TreeNode? , _ ans : inout Int) {
    if root == nil {
        return
    }
    calculateGreaterBST(root?.right, &ans)
    root?.val += ans
    ans = root!.val
    calculateGreaterBST(root?.left, &ans)
}

func bstToGst(_ root: TreeNode?) -> TreeNode? {
    guard root != nil else{
        return nil
    }
    var ans = Int()
    calculateGreaterBST( root, &ans)
    return root
}

func calculateBalanceBST(_ start:Int,_ end:Int,_ arr:[Int]) -> TreeNode? {
    if start > end{
        return nil
    }
    var mid = start + (end - start)/2
    var node = TreeNode(arr[mid])
    node.left = calculateBalanceBST( start, mid-1, arr)
    node.right = calculateBalanceBST( mid+1, end, arr)
    return node
}


func calculateArrayOfNodes(_ root: TreeNode?,_ arr:inout [Int]){
    guard root != nil else{
        return
    }
    calculateArrayOfNodes(root?.left,&arr)
    arr.append(root!.val)
    calculateArrayOfNodes(root?.right, &arr)
}

func balanceBST(_ root: TreeNode?) -> TreeNode?{
    guard root != nil else {
        return nil
    }
    var arr = [Int]()
    calculateArrayOfNodes(root,&arr)
    return calculateBalanceBST(0, arr.count-1, arr)
}


func isCompleteTree(_ root: TreeNode?) -> Bool {
    guard root != nil else  {
        return true
    }
    var queue = [TreeNode?]()
    var isComplete = false
    queue.append(root)
    while !queue.isEmpty {
        var count = queue.count
        while count > 0{
            var node = queue.removeFirst()
            if let left = node?.left{
                if isComplete {
                    return false
                }
                queue.append(left)
            }else{
                isComplete = true
            }
            if let right = node?.right{
                if isComplete {
                    return false
                }
                queue.append(right)
            }else{
                isComplete = false
            }
            count-=1
        }
    }
    return true
}

func dfsPreFlip(_ index: Int, _ root: TreeNode?,_ ans:inout [Int],_ voyage: [Int]) -> Int? {
    if root == nil { return index }
    if root!.val != voyage[index] {
        return nil
    }
    if let newIn = dfsPreFlip(index + 1, root?.left,&ans,voyage) {
        return dfsPreFlip(newIn, root?.right,&ans,voyage)
    }
    if let newIn = dfsPreFlip(index + 1, root?.right,&ans,voyage) {
        ans.append(root!.val)
        return dfsPreFlip(newIn, root?.left,&ans,voyage)
    }
    return nil
}

func flipMatchVoyage(_ root: TreeNode?, _ voyage: [Int]) -> [Int] {
    if root == nil { return [] }
    var ans: [Int] = []
    return dfsPreFlip(0, root,&ans,voyage) == nil ? [-1] : ans
}

func maxDepthNew(_ root: TreeNode?) -> Int {
    guard let root = root else{
        return 0
    }
    var stack = [(root,1)]
    var maxDepth = 1
    while !stack.isEmpty{
        var (node,depth) = stack.popLast()!
        maxDepth = max(maxDepth,depth)
        if let left = node.left{
            stack.append((left,depth+1))
        }
        if let right = node.right{
            stack.append((right,depth+1))
        }
    }
    return maxDepth
}

func minDiffInBST(_ root: TreeNode?) -> Int {
    var root = root
    var stack = [TreeNode]()
    var minDiff = Int.max
    var prev : TreeNode?
    while !stack.isEmpty || root != nil{
        while root != nil{
            stack.append(root!)
            root = root?.left
        }
        root = stack.removeLast()
        if prev != nil{
            minDiff = min(minDiff,root!.val - prev!.val)
        }
        prev = root
        root = root?.right
    }
    return minDiff
}

func wordBreak2(_ s: String, _ wordDict: [String]) -> [String] {
    var cache = [String: [String]]()
    return DfSWordBreak(s, wordDict, &cache)
}

func DfSWordBreak(_ s: String,_ wordDict: [String],_ cache: inout [String: [String]]) -> [String]{
    if s.count == 0{
        return [""]
    }
    if let value = cache[s]{
        return value
    }
    var result = [String]()
    for word in wordDict{
        if s.hasPrefix(word) {
            let subWords = DfSWordBreak(s.substring(from: word.endIndex), wordDict, &cache)
            for subWord in subWords{
                if subWord.isEmpty{
                    result.append(word)
                }else{
                    result.append(word + " " + subWord)
                }
            }
        }
        cache[s] = result
    }
    return result
}

func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
    guard let root = root else{
        return []
    }
    var result = [[Int]]()
    var queue = [root]
    var counter = 0
    while !queue.isEmpty {
        var count = queue.count
        var currentList = [Int]()
        for i in 0..<count{
            let node = queue.removeFirst()
            if let left = node.left{
                queue.append(left)
            }
            if let right = node.right{
                queue.append(right)
            }
            if counter % 2 == 0{
                currentList.append(node.val)
            } else{
                currentList.insert(node.val, at: 0)
            }
        }
        counter += 1
        result.append(currentList)
    }
    return result
}

func isSymmetric(_ root: TreeNode?) -> Bool {
    return isSym(root?.left, root?.right)
}

func isSym(_ left: TreeNode?,_ right: TreeNode?) -> Bool{
    if left == nil && right == nil{
        return true
    }
    if left == nil || right == nil || left?.val != right?.val{
        return false
    }
    return isSym(left?.left, right?.right) && isSym(left?.right, right?.left)
}

func sumNumbers(_ root: TreeNode?) -> Int {
    guard let root = root else{
        return 0
    }
    var sum = 0
    var total = 0
    return calculateSum(root,&sum,&total)
}

func calculateSum(_ root: TreeNode?,_ sum: inout Int,_ total:inout Int) -> Int {
    guard let root = root else {return total}
    var sum = sum * 10 + root.val
    if root.left == nil && root.right == nil{
        return sum + total
    }
    var left = calculateSum(root.left, &sum,&total)
    var right = calculateSum(root.right, &sum,&total)
    return total + left + right
}

func buildTree(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
    return calculateInorderToPostOrder(0,inorder.count-1,0,postorder.count-1,inorder,postorder)
}

func calculateInorderToPostOrder(_ instart: Int,_ inEnd: Int,_ postStart: Int,_ postEnd:Int,_ inorder: [Int],_ postorder: [Int]) -> TreeNode?{
    if postStart > postEnd{
        return nil
    }
    let root = TreeNode(postorder[postEnd], nil, nil)
    var inIndex = 0
    for i in instart...inEnd{
        if inorder[i] == root.val{
            inIndex = i
            break
        }
    }
    root.left = calculateInorderToPostOrder(instart, inIndex - 1, postStart, postStart + inIndex - instart - 1,inorder,postorder)
    root.right = calculateInorderToPostOrder(inIndex+1, inEnd, postEnd-inEnd+inIndex, postEnd-1,inorder,postorder)
    return root
}
var root = TreeNode(3)
root.left = TreeNode(9)
root.right = TreeNode(20)
root.right?.left = TreeNode(15)
root.right?.right = TreeNode(7)
//root.left?.left = TreeNode(3)
//root.left?.right = TreeNode(4)
//root.left?.left?.left = TreeNode(12)
//root.left?.left?.right = TreeNode(8)
//root.left?.right?.right = TreeNode(6)
//root.left?.right?.right = TreeNode(7)
//root.right?.left = TreeNode(4)
//root.right?.left?.left = TreeNode(6)
//root.right?.right = TreeNode(3)
//root.right?.right?.right = TreeNode(4)
//root.right?.right?.left = TreeNode(5)
//var root1 = TreeNode(5)
//root1.left = TreeNode(2)
//root1.right = TreeNode(-5)
//root1.left!.left = TreeNode(6)
//root1.left!.right = TreeNode(7)
//root1.right!.left = TreeNode(4)
//root1.right!.right = TreeNode(2)
//root1.right?.right?.left = TreeNode(9)
//root1.right?.right?.right = TreeNode(8)
//root.right!.right?.right = TreeNode(1)
//root.right!.right?.left = TreeNode(4)
//root.right!.left?.left = TreeNode(7)
//root.left!.left!.left = TreeNode(7)
//root.left!.left!.right = TreeNode(2)
//root.left!.left!.left!.right =  TreeNode(4)
//postorder(root)
//numTrees(3)
//generateTrees(3)
//maxPathSum(root)
//widthOfBinaryTree(root)
//inorderTraversal(root)
//maxDepth(root)
//maxSumBST(root)
//levelOrder(root)
//minCameraCover(root)
//findBottomLeftValue(root)
//lcaDeepestLeaves(root)?.val
//maxDepthDeepestNode(root)
//largestValues(root)
//distanceK(root, TreeNode(5), 2)
//addOneRow(root, 1, 2)
//printTree(root)
//averageOfLevels(root)
//pruneTree(root)
//delNodes(root, [3,5])
//findMaxForm(["10","0001","111001","1","0"], 5, 3)
//hasPathSum(root, 22)
//recoverTree(root)
//maxProduct(root)
//rangeSumBST(root,7,15)
//leafSimilar(root,root1)
//maxAncestorDiff(root)
//maxPathSum(root)
//preorderTraversal(root)
//isSameTree(root,root1)
//isValidSerialization("9,3,4,#,#,1,#,#,2,#,6,#,#")
//deleteNode(root,3)
//invertTree(root)
//findFrequentTreeSum(root)
//findFrequentTreeSum(root1)
//findDuplicateSubtrees(root)
//constructMaximumBinaryTree([3,2,1,6,0,5])
//insertIntoBST(root,5)
//sufficientSubset(root,22)?.left?.left?.val
//sumEvenGrandparent(root)
//isEvenOddTree(root)
//countPairs(root, 3)
//removeLeafNodes(root, 2)
//maxLevelSum(root)
//balanceBST(root)?.val
//isCompleteTree(root)
//flipMatchVoyage(root,[1,3,2])
//maxDepthNew(root)
//minDiffInBST(root)
//wordBreak2("catsanddog", ["cat","cats","and","sand","dog"])
//zigzagLevelOrder(root)
//isSymmetric(root)
//sumNumbers(root)
buildTree([9,3,15,20,7],  [9,15,7,20,3])
