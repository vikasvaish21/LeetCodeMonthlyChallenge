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


func maxPathSum(_ root: TreeNode?) -> Int {
    guard let root = root else{
        return 0
    }
    var maxi = Int.min
    maxPath(root, &maxi)
    return maxi
}
func maxPath(_ node:TreeNode?, _ maxi:inout Int) -> Int {
    if node == nil{
        return 0
    }
    let leftSum = max(0,maxPath(node?.left, &maxi))
    let rightSum = max(0,maxPath(node?.right, &maxi))
    maxi = max(maxi, node!.val + leftSum + rightSum)
    return max(leftSum,rightSum) + node!.val
}

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


var root = TreeNode(0)
root.left = TreeNode(6)
//root.right = TreeNode(3)
root.left!.left = TreeNode(5)
//root.left!.right = TreeNode(4)
//root.right!.right = TreeNode(5)
//root.right!.left = TreeNode(2)
//root.right!.right?.right = TreeNode(6)
//root.right!.right?.left = TreeNode(4)
root.left!.left!.left = TreeNode(3)
root.left!.left!.left!.right =  TreeNode(4)
//postorder(root)
//numTrees(3)
//generateTrees(3)
//maxPathSum(root)
//widthOfBinaryTree(root)
//inorderTraversal(root)
//maxDepth(root)
//maxSumBST(root)
//levelOrder(root)
minCameraCover(root)
