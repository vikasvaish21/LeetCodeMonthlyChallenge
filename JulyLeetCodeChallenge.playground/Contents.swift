import UIKit
import Foundation


//func maximumUnits(_ boxTypes: [[Int]], _ truckSize: Int) -> Int {
//    var boxType = boxTypes.sorted{$0[1] > $1[1]}
//    print(boxType)
//    var truckSize = truckSize
//    let length = boxType.count
//    var sum = 0
//    for i in 0..<length{
//        var total = 0
//        while boxType[i][0] > 0 && truckSize > 0{
//            total += 1
//            boxType[i][0] -= 1
//            truckSize-=1
//        }
//        total *= boxType[i][1]
//        sum += total
//    }
//    return sum
//}
//
//func maxArea(_ h: Int, _ w: Int, _ horizontalCuts: [Int], _ verticalCuts: [Int]) -> Int {
//    let horizontalCut = (horizontalCuts+[0,h]).sorted(by: <)
//    let verticalCut = (verticalCuts+[0,w]).sorted(by: <)
//    var total = 0
//    var maxHorizontal = 0
//    var maxVertical = 0
//
//    for i in 0..<horizontalCut.count-1{
//        maxHorizontal = max(maxHorizontal,horizontalCut[i+1]-horizontalCut[i])
//    }
//
//
//    for j in 0..<verticalCut.count-1{
//        maxVertical = max(maxVertical,verticalCut[j+1]-verticalCut[j])
//    }
//    total = maxVertical * maxHorizontal % 1000000007
//    return total
//}
//
//MARK:  DP with Tabulation

//func wiggleMaxLength(_ nums: [Int]) -> Int {
//    let length = nums.count
//    if nums.count < 2{
//        return nums.count
//    }
//    var top = [Int](repeating: 0, count: nums.count)
//    var bottom = [Int](repeating: 0, count: nums.count)
//    for i in 1..<length{
//        if nums[i] < nums[i-1]{
//            bottom[i] = top[i-1] + 1
//            top[i] = top[i-1]
//        } else if nums[i] > nums[i-1]{
//            top[i] = bottom[i-1] + 1
//            bottom[i] = bottom[i-1]
//        } else{
//            top[i] = top[i-1]
//            bottom[i] = bottom[i-1]
//        }
//    }
//    return 1 + max(top[top.count-1],bottom[bottom.count-1])
//}
//
////MARK:  DP with Tabulation(space Optimization
//
//func wiggleMaxLength(_ nums: [Int]) -> Int {
//    let length = nums.count
//    if nums.count < 2{
//        return nums.count
//    }
//
//    var top = 0
//    var bottom = 0
//    for i in 1..<length{
//        if nums[i] < nums[i-1]{
//            bottom = top + 1
//        } else if nums[i] > nums[i-1]{
//            top = bottom + 1
//        }
//    }
//    return 1 + max(top,bottom)
//}
//
//func candy(_ ratings: [Int]) -> Int {
//    var left = [Int:Int]()
//    var right = [Int:Int]()
//    var ans = 0
//    for i in 0..<ratings.count{
//        left[i] = 1
//        right[i] = 1
//    }
//
//    for j in 1..<ratings.count{
//        if ratings[j] > ratings[j-1]{
//            left[j]! = left[j-1]! + 1
//        }
//    }
//
//    for k in (1..<ratings.count).reversed(){
//        if ratings[k] < ratings[k-1]{
//            right[k-1]! = right[k]! + 1
//        }
//    }
//
//    let first = left.sorted(by: <).map{$0.value}
//    let second = right.sorted(by: <).map{$0.value}
//
//    for i in 0..<first.count{
//        if first[i] > second[i]{
//            ans += first[i]
//        } else{
//            ans += second[i]
//        }
//    }
//    return ans
//}
//
//
//func fib(_ n: Int) -> Int {
//    if n <= 1{
//        return n
//    }
//    return fib(n-1) + fib(n-2)
//}
//
//func minCostClimbingStairs(_ cost: [Int]) -> Int {
//    let length = cost.count
//    var mc = Array(repeating: 0, count: length+1)
//    mc[0] = cost[0]
//    mc[1] = cost[1]
//    for i in 2..<length+1{
//        var value = 0
//        if i != length{
//            value = cost[i]
//        }else{
//            value = 0
//        }
//        mc[i] = min(mc[i-1] + value,mc[i-2] + value)
//    }
//    return mc[length]
//}
//
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
//
//
//func rightSideView(_ root: TreeNode?) -> [Int] {
//    guard let root = root else {
//        return []
//    }
//    var result = [Int]()
//    var queue: [TreeNode?] = []
//    queue.append(root)
//    while !queue.isEmpty {
//        var count = queue.count-1
//        var temp: [Int?] = []
//        while count >= 0{
//            let node = queue.removeFirst()
//            count-=1
//            temp.append(node?.val)
//            if let left = node?.left{
//                queue.append(left)
//            }
//            if let right = node?.right{
//                queue.append(right)
//            }
//        }
//        let node = temp[temp.count-1]
//        result.append(node!)
//    }
//    return result
//}

func makesquare(_ matchsticks: [Int]) -> Bool {
    if matchsticks.count < 4{
        return false
    }
    let sum = matchsticks.reduce(0, +)
    if sum % 4 != 0{
        return false
    }
    let side = sum/4
    let matchsticks = matchsticks.sorted{$0>$1}
    var arr = [Int](repeating:0,count:4)
    return helper(&arr,matchsticks,0,side)
    
}
func helper(_ arr: inout [Int],_ nums: [Int],_ i: Int,_ target:Int) -> Bool{
    
    if i == nums.count{
        if arr[0] == target && arr[1] == target && arr[2] == target && arr[3] == target{
            return true
        }
        return false
    }
    for j in 0..<4{
        if arr[j] + nums[i] > target{
            continue
        }
        arr[j] += nums[i]
        if helper(&arr,nums,i+1, target){
            return true
        }
        arr[j] -= nums[i]
    }
    
    return false
}

func levelOrder(_ root: TreeNode?) -> [[Int]] {
    guard let root = root else{
        return [[]]
    }
    var result =  [[Int]]()
    var queue = [root]
    while queue.count > 0{
        var levelNode = queue.count
        var levelArray = [Int]()
        while levelNode > 0{
            let node =  queue.removeFirst()
            if let left = node.left{
                queue.append(left)
            }
            if let right = node.right{
                queue.append(right)
            }
            levelArray.append(node.val)
            levelNode -= 1
        }
        result.append(levelArray)
    }
    return result
}


//func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
//    return helper(0,0,inorder.count-1,preorder,inorder)
//}
//
//func helper(_ preStart:Int,_ inStart:Int,_ inEnd: Int,_ preorder:[Int],_ inorder:[Int]) -> TreeNode? {
//    if preStart > preorder.count-1 || inStart > inEnd{
//        return  nil
//    }
//    var inIndex = 0
//    let root = TreeNode(preorder[preStart], nil, nil)
//    for i in inStart...inEnd{
//        if inorder[i] == root.val{
//            inIndex = i
//            break
//        }
//    }
//    root.left = helper(preStart+1, inStart, inIndex-1, preorder, inorder)
//    root.right = helper(preStart + inIndex - inStart + 1, inIndex+1, inEnd, preorder, inorder)
//    print(root.val)
//    return root
//}
//

//func buildTree(_ A: inout [Int], _ B: inout [Int]) -> TreeNode? {
//        return helper(0,0,B.count-1,A,B)
//    }
//
//    func helper(_ preStart: Int,_ inStart: Int,_ inEnd: Int,_ preOrder: [Int],_ InOrder: [Int]) -> TreeNode?{
//        if preStart > preOrder.count-1 || inStart > inEnd{
//            return nil
//        }
//        var inIndex = 0
//        let root = TreeNode(preOrder[preStart],nil,nil)
//        for i in inStart...inEnd{
//            if InOrder[i] == root.val{
//                inIndex = i
//                break
//            }
//        }
//        root.left = helper(preStart+1,inStart,inIndex-1,preOrder,InOrder)
//        root.right = helper(preStart+inIndex-inStart+1,inIndex+1,inEnd,preOrder,InOrder)
//        return root
//    }
//
//func maxAreaOfIsland(_ grid: [[Int]]) -> Int {
//    var grid = grid
//    let row = grid.count
//    let col = grid[0].count
//    var result = 0
//    for i in 0..<row{
//        for j in 0..<col{
//            if grid[i][j] == 1{
//                var area = 0
//                maxAreaHelper(&grid,i,j,row,col,&area)
//                result = max(result, area)
//            }
//        }
//    }
//    return result
//}
//
//func maxAreaHelper(_ grid: inout [[Int]],_ i: Int,_ j: Int,_ row: Int,_ col: Int,_ area:inout Int) -> Int{
//    area += 1
//    grid[i][j] = 0
//    if isValid(i+1,j,row,col,grid){
//        maxAreaHelper(&grid,i+1,j,row,col,&area)
//    }
//    if isValid(i,j-1,row,col,grid){
//        maxAreaHelper(&grid,i,j-1,row,col,&area)
//    }
//    if isValid(i,j+1,row,col,grid){
//        maxAreaHelper(&grid,i,j+1,row,col,&area)
//    }
//    if isValid(i-1,j,row,col,grid){
//        maxAreaHelper(&grid,i-1,j,row,col,&area)
//    }
//    return area
//}
//
//func isValid(_ i:Int,_ j: Int,_ row: Int,_ col: Int,_ grid: [[Int]]) -> Bool{
//    if i >= 0 && i < row && j >= 0 && j < col && grid[i][j] == 1{
//        return true
//    }
//    return false
//}
//
//func findPaths(_ m: Int, _ n: Int, _ maxMove: Int, _ startRow: Int, _ startColumn: Int) -> Int {
//    var grid = Array(repeating: Array(repeating: Array(repeating: -1, count: maxMove+1), count: n+1), count: m+1)
//
//    return findPathHelper(&grid, m, n, maxMove, startRow, startColumn)
//
//}
//func findPathHelper(_ grid:inout [[[Int]]] , _ m :Int,_ n: Int,_ maxMove: Int, _ startRow: Int, _ startColumn: Int) -> Int{
//    if maxMove < 0{
//        return 0
//    }
//
//    if startRow == m || startColumn == n || startRow < 0 || startColumn < 0{
//        return 1
//    }
//
//    if grid[startRow][startColumn][maxMove] != -1{
//        return grid[startRow][startColumn][maxMove]
//    }
//    var total = 0
//    let leftMaxMove = findPathHelper(&grid, m, n, maxMove-1, startRow, startColumn-1)
//    let rightMaxMove = findPathHelper(&grid, m, n, maxMove-1, startRow, startColumn+1)
//    let upMaxMove = findPathHelper(&grid, m, n, maxMove-1, startRow-1, startColumn)
//    let downMaxMove = findPathHelper(&grid, m, n, maxMove-1, startRow+1, startColumn)
//    total = (leftMaxMove + rightMaxMove + upMaxMove + downMaxMove) % 1000000007
//    grid[startRow][startColumn][maxMove] = total
//    return grid[startRow][startColumn][maxMove]
//}
//
//func kInversePairs(_ n: Int, _ k: Int) -> Int {
//    var dp = Array(repeating: Array(repeating: 0, count: k+1), count: n+1)
//    for i in 1...n{
//        for j in 0...k{
//            if j == 0{
//                dp[i][j] = 1
//            }else{
//                for l in 0...min(j, i-1){
//                    dp[i][j] += dp[i-1][j-l] % 1000000007
//                }
//            }
//        }
//    }
//    return dp[n][k] % 1000000007
//}
//
//func generate(_ numRows: Int) -> [[Int]] {
//    if numRows == 0{
//        return [[Int]]()
//    }
//
//    if numRows == 1{
//        return [[1]]
//    }
//    var ans = [[1],[1,1]]
//    for row in 2..<numRows{
//        var newRow = Array(repeating: 1, count: row+1)
//        for i in 1..<row{
//            newRow[i] = ans[row-1][i] + ans[row-1][i-1]
//        }
//        ans.append(newRow)
//    }
//    return ans
//}
//
//func numMatchingSubseq(_ s: String, _ words: [String]) -> Int {
//    let arr = Array(s)
//    var result = 0
//    var map = [Character:[Int]]()
//    for (i,j) in arr.enumerated(){
//        map[j,default: []].append(i)
//    }
//
//    for i in 0..<words.count{
//        let curr = words[i]
//        var count = 0
//        var latest = -1
//        for j in curr{
//            for k in map[j,default:[]]{
//                if k > latest{
//                    count+=1
//                    latest = k
//                    break
//                }
//            }
//        }
//        result += count == curr.count ? 1:0
//    }
//    return result
//}


public class ListNode {
     public var val: Int
     public var next: ListNode?
     public init() { self.val = 0; self.next = nil; }
     public init(_ val: Int) { self.val = val; self.next = nil; }
     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 }

func reverseBetween(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
    guard  head != nil else{
        return nil
    }
    let dummy:ListNode? = ListNode(0)
    dummy!.next = head
    var end = dummy
    let m  = left
    let n  = right
    for i in 0..<m-1{
        end = end!.next
    }
    let endOfReverse = end?.next
    var prev = end?.next
    var curr = prev?.next
    
    for i in 0..<n-m{
        let next  = curr?.next
        curr?.next = prev
        prev = curr
        curr = next
    }
    end?.next = prev
    endOfReverse?.next = curr
    return dummy?.next
}


func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
    var before = ListNode(0)
    let beforeHead = before
    var after = ListNode(0)
    let afterHead = after
    var curr = head
    while curr != nil{
        if curr!.val < x{
            before.next = curr
            before = before.next!
        } else{
            after.next = curr
            after = after.next!
        }
        curr = curr?.next
    }
    after.next = nil
    before.next = afterHead.next
    return beforeHead.next
}

//func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
//    var row = matrix.count
//    var col =  matrix[0].count
//    for i in 0..<row{
//        for j in 0..<col{
//            if matrix[i][j] == target{
//                return true
//            }
//        }
//    }
//    return false
//}

func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
    var m = 0
    var n =  matrix[0].count - 1
    while m < matrix.count && n >= 0{
        if matrix[m][n] == target{
            return true
        }
        if matrix[m][n] > target{
            n-=1
        }else{
            m+=1
        }
    }
    return false
}

func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
    var length = nums.count
    var result = [Int]()
    if nums.isEmpty{
        return [-1,-1]
    }
    if nums.contains(target){
        for i in 0..<length{
            if nums[i] == target{
                result.append(i)
            }
        }
    } else {
        return [-1,-1]
    }
    return [result.first!,result.last!]
}

//maximumUnits([[5,10],[2,5],[4,7],[3,9]],10)
//maxArea(5,4,[1,2,4],[1,3]
//wiggleMaxLength([1,17,5,10,13,15,10,5,16,8])
//candy([1,2,87,87,87,2,1])
//fib(9)
//minCostClimbingStairs([1,100,1,1,1,100,1,1,100,1])
//rightSideView(TreeNode(1, TreeNode(2, nil, TreeNode(5)), TreeNode(3, nil, TreeNode(4))))
//rightSideView(TreeNode(1, nil, TreeNode(3)))
//makesquare([1,1,2,2,2])
//makesquare([4,8,12,16,20,24,28,32,36,40,44,48])
//levelOrder(TreeNode(3, TreeNode(9, nil, nil), TreeNode(20, TreeNode(15,nil,nil), TreeNode(7))))
var arr1 = [3,9,20,15,7]
var arr2 = [9,3,15,20,7]
//buildTree(&arr1,&arr2)
//maxAreaOfIsland([[0,0,1,0,0,0,0,1,0,0,0,0,0],[0,0,0,0,0,0,0,1,1,1,0,0,0],[0,1,1,0,1,0,0,0,0,0,0,0,0],[0,1,0,0,1,1,0,0,1,0,1,0,0],[0,1,0,0,1,1,0,0,1,1,1,0,0],[0,0,0,0,0,0,0,0,0,0,1,0,0],[0,0,0,0,0,0,0,1,1,1,0,0,0],[0,0,0,0,0,0,0,1,1,0,0,0,0]])
//findPaths(2,2,2,0,0)
//kInversePairs(1000,1000)
//generate(2)
//numMatchingSubseq("abcde",["a","bb","acd","ace"])
var arr = [5]
var list = ListNode(1, ListNode(4, ListNode(3,ListNode(2, ListNode(5, ListNode(2))))))
//reverseBetween(list,1,4)
//partition(list, 3)
//searchMatrix([[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]],5)
searchRange([5,7,7,8,8,10],6)
