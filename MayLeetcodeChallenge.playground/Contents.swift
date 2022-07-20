import UIKit
import Darwin


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

class Solution {
    func removeDuplicates(_ s: String, _ k: Int) -> String {
        let s = Array(s)
        var stack = [(char: Character,count:Int)]()
        let len = s.count
        for i in 0..<len{
            if !stack.isEmpty && s[i] == stack.last?.char {
                if stack.last?.count == k - 1{
                    stack.removeLast()
                } else {
                    stack[stack.count - 1] = (s[i],stack.last!.count+1)
                }
                
            } else {
                stack.append((s[i],1))
            }
        }
        return stack.reduce(into: String(), {
            $0 += String(repeating: $1.char, count: $1.count)
        })
    }
    
    
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        var nums = nums
        var result: Set<[Int]> = []
        solve(&nums,0,&result)
        return Array(result)
    }
    
    func solve(_ nums: inout [Int], _ current: Int,_ result: inout Set<[Int]>){
        guard nums.count > current else {
            result.insert(nums)
            return
        }
        for i in current..<nums.count {
            nums.swapAt(current, i)
            solve(&nums, current+1, &result)
            nums.swapAt(i, current)
        }
    }
    
    var sum = 0
    func deepestLeavesSum(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        var maxDepth = maxDepth(root)
        totalSum(root,1, maxDepth)
        return sum
    }
    
    func maxDepth(_ root: TreeNode?) -> Int{
        guard let root = root else{
            return 0
        }
        return 1 + max(maxDepth(root.left) , maxDepth(root.right))
    }
    
    func totalSum(_ root: TreeNode?,_ current: Int,_ depth: Int){
        if root != nil{
            if current == depth{
                sum += root!.val
            }
            totalSum(root?.left, current+1, depth)
            totalSum(root?.right, current+1, depth)
        }
    }
    
    
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        guard nums.count >= 3 else { return 0 }
        let nums = nums.sorted()
        var closestSum = nums[0] + nums[1] + nums[nums.count-1]
        var sum = 0
        for i in 0..<nums.count-2 {
            var ptr1 = i + 1
            var ptr2 = nums.count - 1
            while ptr1 < ptr2 {
                sum = nums[i] + nums[ptr1] + nums[ptr2]
                if  abs(target - sum) < abs(target - closestSum) {
                    closestSum = sum
                }
                if sum > target{
                    ptr2 -= 1
                } else if sum < target {
                    ptr1 += 1
                } else if sum == target {
                    return sum
                }
            }
        }
        return closestSum
    }
    
    func getMappedDigit(_ mapping: [Int], _ num : Int) -> Int {
        var num = num
        var strNum = ""
        repeat {
            let rem  = num % 10
            strNum = String(mapping[rem]) + strNum
            num /= 10
        } while (num != 0)
        return Int(strNum) ?? 0
    }

    func sortJumbled(_ mapping: [Int], _ nums: [Int]) -> [Int] {
        var res = [Int]()
        for num in nums {
            res.append(getMappedDigit(mapping, num))
        }
        print(nums)
        print(res)
        let combine = zip(nums, res).sorted { $0.1 < $1.1 }
        return combine.map{$0.0}
    }

//
    func maxProduct(_ words: [String]) -> Int {
        var dict = [Int:Int]()
        let offset = Character("a").asciiValue
        for i in words{
            var val = 0
            for char in i{
                print(char.asciiValue!)
                val |= 1 << (char.asciiValue! - offset!)
            }
            dict[val] = max(dict[val,default: 0],i.count)
        }
        var result = 0
        for (key, value) in dict {
            for (key2, value2) in dict {
                if key & key2 == 0 {
                    result = max(result, value * value2)
                }
            }
        }
        return result
    }
    
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        var dividend = dividend
        guard (dividend <= Int32.max && dividend >= Int.min) || ((divisor >= Int32.min) && (divisor <= Int32.max)) else{
            return 0
        }
        var result = 0
        print(Int32.max,Int32.min)
        while dividend >= divisor{
            dividend -= divisor
            result += 1
        }
        if dividend != 0{
            return dividend <= Int32.max ? dividend: Int(Int32.max)
        }
        return -1
    }
    
    func reverse(_ x: Int) -> Int {
        guard x > Int.min && x < Int.max else{
            return 0
        }
        var x = x
        var result = 0
        while x > 0 || x < 0{
            var a = x % 10
            result = result * 10 + a
            x = x/10
        }
        if result > Int32.max{
            return 0
        }
        return result
    }
    
    func hasAllCodes(_ s: String, _ k: Int) -> Bool {
        var hashSet = Set<String>()
        if s.count < k { return false }
        let s = Array(s)
        let length = s.count - (k+1)
        for i in 0...length{
            var substring = ""
            for j in i..<(i+k){
                substring.append(s[j])
            }
            hashSet.insert(substring)
            print(hashSet)
        }
        return hashSet.count == pow(k)
    }
    
    private func pow(_ k: Int) -> Int
        {
            var result = 1
            for _ in 1...k {
                result *= 2
            }
            return result
        }
}
var sol = Solution()
sol.removeDuplicates("deeedbbcccbdaa",2)
sol.permuteUnique([1,2,3])

sol.deepestLeavesSum(TreeNode(1, TreeNode(2, TreeNode(4, TreeNode(7, nil, nil), nil), TreeNode(5, nil, nil)), TreeNode(3, nil, TreeNode(6, nil, TreeNode(8, nil, nil)))))
sol.threeSumClosest([1,1,1,1], -100)
sol.sortJumbled([8,9,4,0,2,1,3,5,7,6], [991,338,38])
//sol.maxEnvelopes([[5,4],[6,4],[6,7],[2,3]])
//sol.maxEnvelopes([[1,1]])
//sol.maxEnvelopes([[4,5],[4,6],[6,7],[2,3],[1,1]])
sol.maxProduct(["abcw","baz","foo","bar","xtfn","abcdef"])
sol.divide(-2147483648,-1)
sol.reverse(1534236469)
sol.hasAllCodes("0", 20)
