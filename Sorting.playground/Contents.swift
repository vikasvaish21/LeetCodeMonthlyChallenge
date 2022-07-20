import UIKit
import Darwin

var greeting = "Hello, playground"


// Selection Sort

func sortArray(_ arr: [Int]) -> [Int] {
    var arr = arr
    let len = arr.count
    var minIndex = 0
    for i in 0..<len {
        minIndex = i
        for j in i+1..<len {
            if arr[minIndex] > arr[j] {
                minIndex = j
            }
            arr.swapAt(i, minIndex)
        }
    }
    return arr
}
var arr  = [2,6,9,4]
sortArray(arr)


// Bubble Sort

func bubbbleSortArray(_ arr: [Int]) -> [Int] {
    var arr = arr
    let len = arr.count
    var minIndex = 0
    for i in 0..<len {
        minIndex = i
        var swapped = false
        for j in 0..<len-i-1 {
            if arr[j] > arr[j+1] {
                arr.swapAt(j, j+1)
                swapped = true
            }
        }
        if swapped == false {
            break
        }
    }
    return arr
}
var arr1  = [2,6,9,4]
bubbbleSortArray(arr1)

//Insertion Sort

//
//func insertionSort(_ arr: [Int]) -> [Int] {
//    var arr = arr
//    let len = arr.count
//    var temp = 0
//    var j = 0
//    for i in 1..<len {
//        temp = arr[i]
//        j = i-1
//        while j >= 0 && temp < arr[j] {
//            arr[j+1] = arr[j]
//            j -= 1
//        }
//        arr[j+1] = temp
//    }
//    return arr
//}
//insertionSort(arr)


func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
    let nums = nums.sorted()
    var threeSum = 0
    var twoSum = 0
    var left = 0
    var right = 0
    var result  = [[Int]]()
    let length = nums.count

    guard nums.count >= 4 else{
        return result
    }

    for i in 0..<length-3{
        guard i == 0 || nums[i] != nums[i-1] else {
            continue
        }
        threeSum = target - nums[i]
        for j in i+1..<length-2{
            guard j == i+1 || nums[j] != nums[j-1] else {
                continue
            }
            twoSum = threeSum - nums[j]
            left = j+1
            right = length - 1
            while left < right {
                if nums[left] + nums[right] == twoSum {
                    result.append([nums[i],nums[j],nums[left],nums[right]])
                    repeat{
                        left += 1
                    } while left < right && nums[left] == nums[left-1]
                    repeat{
                        right -= 1
                    } while left < right && nums[right] == nums[right+1]
                } else if nums[left] + nums[right] < twoSum {
                    repeat{
                        left += 1
                    } while left < right && nums[left] == nums[left-1]
                } else{
                    repeat{
                        right -= 1
                    } while left < right && nums[right] == nums[right+1]
                }
            }
        }
    }
    return result
}

func groupAnagrams(_ strs: [String]) -> [[String]] {
    if strs.isEmpty { return []}
    var map = [String:[String]]()
    for str in strs {
        let sortedStr = String(str.sorted())
        map[sortedStr,default: []] += [str]
    }
    return Array(map.values)
}


func merge(_ intervals: [[Int]]) -> [[Int]] {
    let intervals = intervals.sorted{ $0[0] < $1[0]}
    var result  = [[Int]]()
    var current = intervals[0]
    for interval in intervals{
        if interval[0] <= current[1]{
            current[1] = max(current[1], interval[1])
        } else{
            result.append(current)
            current = interval
        }
    }
    if !result.contains(current){
        result.append(current)
    }
    return result
}


func sortColors(_ nums: inout [Int]) {
    if nums.count == 0 || nums.count == 1{
        return
    }
    let length = nums.count - 1
    var start = 0
    var end  = length
    var index = 0
    while index <= end && start <= end {
        if nums[index] == 0{
            nums[index] = nums[start]
            nums[start] = 0
            start += 1
            index += 1
        } else if nums[index] == 2{
            nums[index] = nums[end]
            nums[end] = 2
            end -= 1
        } else {
            index+=1
        }
    }
}

public class ListNode {
    public var val : Int
    public var next: ListNode?
    public init (_ val: Int){
        self.val = val
        self.next = nil
    }
    public init (_ val: Int,_ next: ListNode?){
        self.val = val
        self.next = next
    }
}


func insertSort(_ head: ListNode , _ inserNode: ListNode)  {
    var current : ListNode? = nil
    var head = head
    if head == nil || head.val >= inserNode.val{
        inserNode.next = head
        head = inserNode
    } else{
        current = head
        while let next = current!.next , inserNode.val > next.val{
            current = next
        }
        let next = current!.next
        current!.next = inserNode
        inserNode.next = next
    }
}



func sortList(_ head: ListNode?) -> ListNode? {
    if head == nil || head?.next == nil{
        return head
    }
    
    var temp : ListNode?
    var slow = head
    var fast = head
    while fast != nil /*&& fast?.next != nil */{
        temp = slow
        slow = slow?.next
        fast = fast?.next?.next
    }
    temp!.next = nil
    let list1 = sortList(head)
    let list2 = sortList(slow)
    return mergeSort(list1,list2)
}


func mergeSort(_ head1: ListNode?,_ head2: ListNode?) -> ListNode?{
    var dummy = ListNode(0)
    var current: ListNode? = dummy
    var head1 = head1
    var head2 = head2
    while head1 != nil && head2 != nil{
        if head1!.val < head2!.val{
            current?.next = head1
            head1 = head1!.next
        } else {
            current?.next = head2
            head2 = head2!.next
        }
        current = current?.next
    }
    if head1 != nil{
        current?.next = head1
    }
    if head2 != nil{
        current?.next = head2
    }
    return dummy.next
}


func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
    if nums.count == 0{
        return 0
    }
    if nums.count == k {
        return nums.sorted()[0]
    }
    var array = [Int]()

    for i in nums{
        if array.count < k{
            array.append(i)
        } else if array.count == k{
            array.append(i)
            array.sort()
            array.remove(at: 0)
        }
    }
    return array[0]
}

func containsNearbyAlmostDuplicate(_ nums: [Int], _ k: Int, _ t: Int) -> Bool {
    let length = nums.count
    let newSet = Set(nums)
    if newSet.count == length && t == 0{
        return false
    }
    for i in 0..<length{
        for j in i+1..<i+1+k{
            if j >= length {
                break
            }
            if abs(nums[i] - nums[j]) <= t && abs(i-j) <= k {
                return true
            }
        }
    }
    return false
}

func coinChange(_ coins: [Int], _ amount: Int) -> Int {
    var dp = [Int](repeating: Int.max, count: amount+1)
    dp[0] = 0
    if amount < 1{
        return 0
    }
    for i in 1...amount{
        for coin in coins{
            if i - coin >= 0 {
                let remaining  = dp[i-coin]
                if remaining == Int.max{
                    continue
                }
                dp[i] = min(dp[i],1 + remaining)
            }
        }
    }
    return dp[amount] == Int.max ? -1 : dp[amount]
}

func containsDuplicate(_ nums: [Int]) -> Bool {
    let length = nums.count
    let newSet = Set(nums)
    let setLength = newSet.count
    if length == setLength{
        return false
    }
    return true
}

func hIndex(_ citations: [Int]) -> Int {
    let length = citations.count
    var citations = citations
    citations = citations.sorted()
    var low = 0
    var high = length-1
    var mid = 0
    while low<=high{
        mid = low + (high - low)/2
        if citations[mid] == length - mid {
            return citations[mid]
        } else if citations[mid] >= length - mid {
            high = mid - 1
        } else {
            low = mid + 1
        }
        
    }
    return length - low
}

func wiggleSort(_ nums: inout [Int]) {
    let sortedArray = nums.sorted()
    let length = nums.count
    var low = 0
    var high = (length - 1)/2 + 1
    for i in stride(from: length-1, through: 0, by: -1){
        if i % 2 == 1{
            nums[i] = sortedArray[high]
            high += 1
        } else {
            nums[i] = sortedArray[low]
            low += 1
        }
    }
}

func removeDuplicates(_ s: String, _ k: Int) -> String {
    var hashMap = [(char: Character, count: Int)]()
    for i in s{
        var count = 1
        if let last = hashMap.last ,last.char == i{
            count += last.count
        }
        hashMap.append((i,count))
        if let last = hashMap.last, last.count == k{
            for _ in 0..<k{
                hashMap.removeLast()
            }
        }
    }
    return String(hashMap.map{$0.char})
}


func longestValidParentheses(_ s: String) -> Int {
    if s.count == 0 {
        return 0
    }
    var charArray = [Int]()
    charArray.append(-1)
    let arr = Array(s)
    var result = 0
    for i in 0..<arr.count{
        if arr[i] == ")"{
            if charArray.count > 1 && arr[charArray.last!] == "(" {
                charArray.removeLast()
                result = max(result, i-charArray.last!)
            } else{
                charArray.append(i)
            }
        } else {
            charArray.append(i)
        }
    }
    return result
}

func countSubstrings(_ s: String) -> Int {
    let arr = Array(s)
    var res = 0
    for i in 0..<arr.count{
         res += countPallindrome(arr,i,i)
         res += countPallindrome(arr,i,i+1)
    }
    return res
}

func countPallindrome(_ s: [Character],_ l: Int,_ r: Int) -> Int{
    var l = l
    var r = r
    var res = 0
    print(s)
    while l >= 0 && r < s.count{
        if s[l] == s[r] {
            res += 1
            l-=1
            r+=1
        }else{
            break
        }
    }
    return res
}
public class TreeNode{
    public var val : Int
    public var left: TreeNode?
    public var right: TreeNode?
    
    public init(){
        self.val = 0
        self.left = nil
        self.right = nil
    }
    public init(_ val:Int){
        self.val = val
        self.left = nil
        self.right = nil
    }
    public init(_ val:Int,_ left: TreeNode?,_ right: TreeNode?){
        self.val = val
        self.left = left
        self.right = right
    }
}


func isValidBST(_ root: TreeNode?) -> Bool {
    checkBSTValid(root, Int.min, Int.max)
}
func checkBSTValid(_ root:TreeNode? ,_ min: Int,_ max: Int) -> Bool{
    guard let root = root else {
        return true
    }
    if min >= root.val || max <= root.val{
        return false
    }
    return checkBSTValid(root.left, min, root.val) && checkBSTValid(root.right, root.val, max)
}

func averageOfSubtree(_ root: TreeNode?) -> Int {
    var count = 0
    calculateSum(root, &count)
    return count
}
func calculateSum(_ node: TreeNode?,_ count: inout Int) -> (Int,Int) {
    var num = 0
    var sum = 0
    guard let node = node else {
        return (0,0)
    }
    let leftPart = calculateSum(node.left, &count)
    let rightPart = calculateSum(node.right, &count)
    sum += leftPart.0 + node.val + rightPart.0
    num += leftPart.1 + 1 + rightPart.1
    if node.val == sum/num{
        count+=1
    }
    return (sum,num)
}

func counting(_ count: Int) -> Int {
    if count <= 100{
        print(count)
    } else{
        return count
    }
    return counting(count+1)
}


func findMax(_ arr:[Int],_ count:Int,_ maxi:Int) ->  Int {
    var maxi = maxi
    if arr.isEmpty{
        return 0
    }
    if count < arr.count {
       maxi = max(maxi,arr[count])
    } else {
       return maxi
    }
    return findMax(arr,count+1,maxi)
}

func findSearch(_ arr:[Int],_ count:Int,_ target:Int) ->  Int {
    if arr.isEmpty{
        return 0
    }
    if count < arr.count {
        if target == arr[count]{
            return count
        }
    } else {
       return count
    }
    return findSearch(arr,count+1,target)
}

//let code = ["I","V","X","L","C","D","M"]
//let intCode = [1,5,10,50,100,500,1000]
let intCode = [1, 4, 5, 9, 10, 40, 50, 90, 100, 400, 500, 900, 1000]
let code = ["I", "IV", "V", "IX", "X", "XL", "L", "XC", "C", "CD", "D", "CM", "M"]

func intToRoman(_ num: Int) -> String {
    var num = num

    var result = String()
    while num != 0{
        var j = intCode.count - 1
        while j >= 0{
            if num - intCode[j] >= 0{
                break
            }
            j -= 1
        }
        result += code[j]
        num -= intCode[j]
    }
    return result
}

func romanToInt(_ s: String) -> Int {
    var arr = Array(s)
    let length  = arr.count-1
    var result = 0
    var j = 0
    for i in 0...length{
        while !arr.isEmpty && j < code.count{
            print(String(arr[i]),code[j])
            if String(arr[i]) == code[j]{
                break
            }
            j+=1
        }
        arr.remove(at: i)
        result += intCode[j]
    }
    return result
}


func recurCoinchange(_ coin:[Int],_ amount:Int ,_ n:Int,_ currentCoin:Int) -> Int{
    if amount == 0{
        return 1
    }
    if amount < 0{
        return 0
    }
    var ways = 0
    for i in currentCoin..<n{
        ways += recurCoinchange(coin, amount - coin[i], n, i)
    }
    return ways
}
func OptimalStatigy(_ arr:[Int],_ i:Int,_ j: Int) -> Int{
    if i > j{
        return 0
    }
    let choice1 = arr[i] + min(OptimalStatigy(arr, i+2, j), OptimalStatigy(arr, i+1, j-1))
    let choice2 = arr[j] + min(OptimalStatigy(arr, i+1, j-1), OptimalStatigy(arr, i, j-2))
    return max(choice1, choice2)
}

func hammingWeight(_ n: Int) -> Int {
    var num = n
    var count = 0
    while num != 0{
        let digit = num&1
        if digit == 1{
            count += 1
        }
        num >>= 1
    }
    return count
}

var count = 0
func numberOfSteps(_ num: Int) -> Int {
    var num = num
    if num == 0{
        return 0
    }
    if num % 2 == 0 {
        num = num/2
        count += 1
    } else if num % 2 == 1 {
        num -= 1
        count += 1
    }
    if num != 0{
        return numberOfSteps(num)
    }
    return count
}
//func getDirections(_ root: TreeNode?, _ startValue: Int, _ destValue: Int) -> String {
//
//}
func missingNumber(_ nums: [Int]) -> Int {
    var sum = nums.reduce(0,+)
    var total = 0
    for i in 0...nums.count{
        total += i
    }
    sum = total - sum
    
    return sum
}



func merge(left:[Int],right:[Int]) -> [Int] {
    var mergedList = [Int]()
    var left = left
    var right = right
    
    while left.count > 0 && right.count > 0 {
        if left.first! < right.first! {
            mergedList.append(left.removeFirst())
        } else {
            mergedList.append(right.removeFirst())
        }
    }
    while left.count > 0  {
        mergedList.append(left.removeFirst())
    }
    while right.count > 0{
        mergedList.append(right.removeFirst())
    }

    return mergedList
}

func bubbleSort(_ Arr: [Int]) -> [Int]{
    let length = Arr.count
    var arr = Arr
    for i in 0..<length{
        for j in 0..<length-i-1{
            if arr[j] > arr[j+1]{
                arr.swapAt(j, j+1)
            }
        }
    }
    return arr
}




//func mergeSort(list:[Int]) -> [Int] {
//    guard list.count > 1 else {
//        return list
//    }
//
//    let leftList = Array(list[0..<list.count/2])
//    let rightList = Array(list[list.count/2..<list.count])
//
//    return merge(left: mergeSort(list:leftList), right: mergeSort(list:rightList))
//}

func merge(list:[Int]) -> [Int]{
    guard list.count > 1 else{
        return list
    }
    let mid = list.count/2
    let leftList = list[0..<mid]
    let rightList = list[mid..<list.count]
    let list1 = merge(list: Array(leftList))
    let list2 = merge(list: Array(rightList))
    return mergeSort(left: list1, right: list2)
}

func mergeSort(left : [Int],right:[Int]) -> [Int]{
    var leftIndex = 0
    var rightIndex = 0
    var orderedArray = [Int]()
    while leftIndex < left.count && rightIndex < right.count{
        if left[leftIndex] < right[rightIndex]{
            orderedArray.append(left[leftIndex])
            leftIndex+=1
        } else if left[leftIndex] > right[rightIndex]{
            orderedArray.append(right[rightIndex])
            rightIndex+=1
        }
    }
    while leftIndex < left.count{
        orderedArray.append(left[leftIndex])
        leftIndex+=1
    }
    while rightIndex < right.count{
        orderedArray.append(right[rightIndex])
        rightIndex+=1
    }
    return orderedArray
}


func insertionSort(_ arr: [Int]) -> [Int]{
    let length = arr.count
    var arr = arr
    for i in 1..<length{
        let key = arr[i]
        var j = i-1
        while j >= 0 && key < arr[j]{
            arr[j+1] = arr[j]
            j-=1
        }
        arr[j+1] = key
    }
    return arr
}

func quickSort(_ arr: [Int]) -> [Int]{
    guard arr.count > 1 else { // 1
        return arr
      }
    let pivot = arr[arr.count/2]
    let less = arr.filter{$0 < pivot}
    let equal = arr.filter{ $0 == pivot}
    let high = arr.filter{$0 > pivot}
    return quickSort(less) + equal + quickSort(high)
}


func minimumLines(_ stockPrices: [[Int]]) -> Int {
    if stockPrices.count <= 1 {
               return 0
           }
    let stockPrices = stockPrices.sorted{ $0[0] < $1[0]}
    print(stockPrices)
    let col = stockPrices.count
    var count = stockPrices.count > 1 ? 1 : 0
    print(stockPrices[1][0],stockPrices[0][0])
    for i in 1..<col-1{
        let x1 =  stockPrices[i-1][0]
        let y1 =  stockPrices[i-1][1]
        let x2 = stockPrices[i][0]
        let y2 = stockPrices[i][1]
        let x3 = stockPrices[i+1][0]
        let y3 = stockPrices[i+1][1]
        let delta1 = (y2-y1)*(x3 - x2)
        let delta2 =  (y3 - y2)*(x2-x1)
        if delta1 != delta2{
            count+=1
        }
    }
    return count
}

func maximumBags(_ capacity: [Int], _ rocks: [Int], _ additionalRocks: Int) -> Int {
    var bagCapacity = Array(repeating: 0, count: capacity.count)
    for i in 0..<capacity.count{
        bagCapacity[i] = capacity[i] - rocks[i]
    }
    var additionalRocks = additionalRocks
    bagCapacity=bagCapacity.sorted()
    var count = 0
    var result = 0
    while additionalRocks > 0 && count < bagCapacity.count{
        if bagCapacity[count] == 0{
            result+=1
        } else if bagCapacity[count] <= additionalRocks{
            result+=1
            additionalRocks -= bagCapacity[count]
            
        } else if bagCapacity[count] > additionalRocks{
            return result
        }
        count+=1
    }
    return result
}


func maxConsecutive(_ bottom: Int, _ top: Int, _ special: [Int]) -> Int {
    let special = special.sorted()
    var result = max(abs(top - special[special.count-1]),abs(bottom - special[0]))
    for i in  1..<special.count{
        result = max(result, special[i] - special[i-1] - 1)
    }
    return result
}

func removeDuplicateLetters(_ s: String) -> String {
    var dict = [Character:Int]()
    var stack = [Character]()
    var visited = Set<Character>()
    for char in s{
        if dict[char] == nil{
            dict[char] = 0
        }
        dict[char]! += 1
    }
    for char in s{
        dict[char] = dict[char]! - 1
        if !visited.contains(char){
            while (stack.count > 0 && stack.last! > char && dict[stack.last!]! > 0){
                visited.remove(stack.removeLast())
                
            }
            stack.append(char)
            visited.insert(char)
        }
    }
    var res = ""
    while(stack.count > 0){
        res += "\(stack.removeFirst())"
    }
    return res
}


//func letterCombinations(_ digits: String) -> [String] {
//    let arr = ["","","abc","def","ghi","jkl","mno","pqwr","tuv","wxyz"]
//    var result = [String]()
//    let index = 0
//    let output = ""
//    solveLetterCombination(arr, &result, digits,index,output)
//    return result
//}
//
//func solveLetterCombination(_ arr: [String],_ result:inout [String],_ digits: String,_ index:Int,_ output :String) -> [String]{
//
//}
//fourSum([1,0,-1,0,-2,2],0)
//groupAnagrams(["eat","tea","tan","ate","nat","bat"])
////merge([[1,3],[2,6],[8,10],[15,18]])
//var sortCol = [2,0,1]
//sortColors(&sortCol)
//sortList(ListNode(4, ListNode(2,ListNode(1, ListNode(3, nil)))))
//findKthLargest([3,2,1,5,6,4],2)
//containsNearbyAlmostDuplicate([0], 0, 0)
//coinChange([1,2,5], 11)
//containsDuplicate([1,2,3,1])
//hIndex([3,0,6,1,5])
//var arr2 = [1,3,2,2,3,1]
//wiggleSort(&arr2)
//removeDuplicates("abcd",2)
//longestValidParentheses(")()())")
//countSubstrings("abc")
//averageOfSubtree(TreeNode(4,TreeNode(8,TreeNode(0,nil,nil),TreeNode(1,nil,nil)),TreeNode(5, nil, TreeNode(6,nil,nil))))
//counting(1)
//findSearch([4,2,6,9,1,0,12],0,1)
//createBinaryTree([[20,15,1],[20,17,0],[50,20,1],[50,80,0],[80,19,1]])
//intToRoman(12)
//romanToInt("LVIII")
//var coin = [1,2]
//recurCoinchange(coin,4,coin.count, 0)
//OptimalStatigy([20, 30, 2, 2, 2, 10], 0, 5)
//hammingWeight(00000000000000000000000000001011)
//numberOfSteps(0)
//missingNumber([0,1])
//mergeSort(list: [12,11,13,5,6,7])
merge(list: [64, 34, 25, 12, 22, 11, 90])
quickSort([12,11,13,5,6,7])
bubbleSort([64, 34, 25, 12, 22, 11, 90])
insertionSort([64, 34, 25, 12, 22, 11, 90])
//minimumLines([[3,4],[1,2],[7,8],[2,3]])
minimumLines([[1,7],[2,6],[3,5],[4,4],[5,4],[6,3],[7,2],[8,1]])
maximumBags([2,3,4,5], [1,2,4,4], 2)
maxConsecutive(2, 9, [4,6])
maxConsecutive(3, 15, [7,9,13])
removeDuplicateLetters("bcabc")
