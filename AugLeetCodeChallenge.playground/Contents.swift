import UIKit
import Foundation
var greeting = "Hello, playground"
public class TreeNode{
    public var val : Int
    public var left :TreeNode?
    public var right :TreeNode?
    public init(){
        self.val = 0
        self.left = nil
        self.right = nil
    }
    public init(_ val: Int){
        self.val = val
        self.left = nil
        self.right = nil
    }
    public init(_ val: Int,_ left: TreeNode?,_ right: TreeNode?){
        self.val = val
        self.left = left
        self.right = right
    }
}

public class ListNode {
     public var val: Int
     public var next: ListNode?
     public init() { self.val = 0; self.next = nil; }
     public init(_ val: Int) { self.val = val; self.next = nil; }
     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 }

func combination(_ nums: [Int], _ target: Int,_ dp: inout [Int]) -> Int {
    if target < 0{
        return 0
    }
    if target == 0{
        return 1
    }
    if dp[target] != -1{
        return dp[target]
    }
    var ans = 0
    for i in 0..<nums.count{
        ans += combination(nums,target-nums[i],&dp)
    }
    dp[target] = ans
    return dp[target]
}

func combinationSum4(_ nums: [Int], _ target: Int) -> Int {
    var dp = Array(repeating: -1, count: target+1)
    return combination(nums, target, &dp)
}


func countVowelPermutation(_ n: Int) -> Int {
    guard n >= 1 else{
        return 0
    }
    let modulo = 100000007
    var prev = Array(repeatElement(1, count: 5))
    var curr = prev
    for i in 1..<n{
        curr[0] = prev[1] % modulo
        curr[1] = (prev[0] + prev[2])%modulo
        curr[2] = (prev[0] + prev[1] + prev[3] + prev[4])%modulo
        curr[3] = (prev[2] + prev[4])%modulo
        curr[4] = prev[0]%modulo
        prev = curr
    }
    return curr.reduce(0){$0 + $1} % modulo
}

//func numFactoredBinaryTrees(_ arr: [Int]) -> Int {
//
//}

func sortedArray(_ nums:[Int],_ start: Int,_ end: Int) -> TreeNode? {
    guard start <= end else{
        return nil
    }
    let mid = start + (end - start)/2
    let node = TreeNode(nums[mid],nil,nil)
    node.left = sortedArray(nums, start, mid-1)
    node.right = sortedArray(nums, mid+1, end)
    return node
}

func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
    guard !nums.isEmpty else{
        return nil
    }
    let root = sortedArray(nums,0,nums.count-1)
    return root
}


func sortedListToBST(_ head: ListNode?) -> TreeNode? {
    guard let head = head else {
        return nil
    }
    var data = [Int]()
    var currentNode: ListNode? = head
    while let cn = currentNode{
        data.append(cn.val)
        currentNode = cn.next
    }
    return sortedArrayToBST(data)
}
//combinationSum4([1,2,3],4)
//countVowelPermutation(2)
sortedArrayToBST([-10,-3,0,5,9])
