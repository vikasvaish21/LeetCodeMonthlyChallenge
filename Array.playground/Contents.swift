import UIKit
import Foundation
//func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
//    let length = numbers.count
//    var result = [Int]()
//    for i in 0..<length{
//        var j = i+1
//        for k in j..<length{
//            if numbers[i] + numbers[k] == target{
//                result.append(i+1)
//                result.append(k+1)
//                return result
//            }
//        }
//    }
//    return result
//}

func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
    var length = numbers.count - 1
    var result = [Int]()
    var low = 0
    while low < length{
        if numbers[low] + numbers[length] == target{
            result.append(low+1)
            result.append(length+1)
            return result
        } else if  numbers[low] + numbers[length] < target{
            low+=1
        } else if numbers[low] + numbers[length] > target{
            length -= 1
        }
    }
    return result
}

func calculateTax(_ brackets: [[Int]], _ income: Int) -> Double {
    let length = brackets.count
    var sum = Double()
    var prev : Double = 0.0
    var temp : Double = 0.0
    var res = Double()
    for i in 0..<length{
        temp = Double(brackets[i][0])
        sum = Double(brackets[i][0])
        sum = min(sum,Double(income))
        if sum - prev < 0.0{
            return res
        }
//        print(sum - prev)
        res += (sum - prev) * Double(brackets[i][1]) * 0.01
        prev = temp
    }
    return res
}

func maximumSubarray(_ nums: [Int]) -> Int {
    if nums.count == 1 { return nums[0] }
    var length = nums.count
    var subarray = [nums[0]]
    var result = nums[0]
    for i in 1..<length{
        if let repeatIndex = subarray.firstIndex(of: nums[i]){
//            print(repeatIndex+1)
            subarray.removeFirst(repeatIndex+1)
        }
        subarray.append(nums[i])
//        print(subarray)
        result = max(result, subarray.reduce(0,+))
        
    }
    return result
    
}

func maximumUniqueSubarray(_ nums: [Int]) -> Int {
       if nums.count == 1 { return nums[0] }
       var subarray = [nums[0]]
       var result = nums[0]
       for i in 1..<nums.count {
           if let repeatingIndex = subarray.firstIndex(of: nums[i]){
//               print(repeatingIndex)
               subarray.removeFirst(repeatingIndex)
               
           }
           subarray.append(nums[i])
           result = max(result, subarray.reduce(0,+))
       }

       return result
   }
func minimumTotal(_ triangle: [[Int]]) -> Int {
    var triangle = triangle
    for i in (0..<triangle.count-1).reversed(){
        for j in 0..<triangle[i].count{
            
            triangle[i][j] += min(triangle[i+1][j] ,triangle[i+1][j+1])
            print(triangle[i][j])
        }
    }
    return triangle[0][0]
}

//
//func longestDupSubstring(_ s: String) -> String {
//    var start = 0
//    var s = Array(s)
//    var end = s.count - 1
//    var result = [Character]()
//    while start <= end{
//        if s[start] == s[end]{
//            result.append(s[end])
//            start += 1
//            end -= 1
//        }
//    }
//}

func lengthOfLIS(_ nums: [Int]) -> Int {
    var dp = Array(repeating: 1,count:nums.count)
    var maxSubsequence = 1
    for end in 1..<nums.count{
        for start in 0..<end{
            if nums[end] > nums[start] && dp[end] <= dp[start]{
                dp[end] = dp[start] + 1
                maxSubsequence = max(maxSubsequence, dp[end])
            }
        }
    }
    return maxSubsequence
}

func longestPalindrome(_ s: String) -> String {
    let s = Array(s)
    let length = s.count
    var result = ""
    var high = 0
    var low = 0
    var maxlength = 0
    if s.count == 1{
        return String(s)
    } else if s.count >= 2 {
        for i in 0..<length{
            // for odd length
            low = i
            high = i
            while low >= 0 && high < length && s[low] == s[high]{
                if high-low+1 > maxlength{
                    result = String(s[low..<high+1])
                    maxlength = high-low+1
                }
                low -= 1
                high += 1
            }
            
            // for even length
            low = i
            high = i + 1
            while low >= 0 && high < length && s[low] == s[high]{
                if high-low+1 > maxlength{
                    result = String(s[low..<high+1])
                    maxlength = high-low+1
                }
                low -= 1
                high += 1
            }
        }
    }
    return result
}


func countStudents(_ students: [Int], _ sandwiches: [Int]) -> Int {
    var students = students
    var sandwiches = sandwiches
    while !sandwiches.isEmpty{
        if sandwiches.first == students.first{
            sandwiches.removeFirst()
            students.removeFirst()
        }else{
            students.append(students.remove(at: 0))
        }
        if !students.contains(sandwiches.first!){
            break
        }
    }
    return students.count
}


func findLengthOfShortestSubarray(_ arr: [Int]) -> Int {
    let length =  arr.count
    var maxLength = 1
    var count = 0
    for i in 1..<length-1{
        if arr[i] - arr[i-1] == arr[i+1] - arr[i]{
            count+=1
        }
        maxLength = max(count,maxLength)
    }
    return maxLength
}

func greatestLetter(_ s: String) -> String {
    var capArr = [Character]()
    var smallArr = [Character]()
    var result = [String]()
    capArr = s.filter{("A"..."Z").contains($0)}
    smallArr = s.filter{("a"..."z").contains($0)}
    for i in capArr{
        for j in smallArr{
            if i.lowercased() == String(j){
                result.append(String(i))
            }
        }
    }
    if !result.isEmpty{
        result = result.sorted()
        return result[result.count-1]
    }
    return ""
    
}

func minimumNumbers(_ num: Int, _ k: Int) -> Int {
   
    if num == 0{
        return 0
    }
    for i in 1...100{
        if (k*i <= num && (k*i)%10 == num%10){
            return i
        }
    }
    return -1
}

func longestSubsequence(_ s: String, _ k: Int) -> Int {
    var s = s
    var binary = Int()
    binary = Int(s,radix: 2)!
    var arr = Array(s)
    var start = 0
    var end = s.count
    var mid = start + (end - start)/2
    var string1 = String(arr[start...mid])
    var string2 = String(arr[mid+1..<end])
    if Int(string1,radix: 2)! <= k{
        mid = mid+1
    } else if Int(string2,radix: 2)! <= k{
        mid = mid-1
        
    }
    return 0
}


func suggestedProducts(_ products: [String], _ searchWord: String) -> [[String]] {
    if products.isEmpty || searchWord.isEmpty{
        return [products]
    }
    var sortedProducts = products.sorted()
    let searchWordArr = Array(searchWord)
    var currentIndex = 0
    var searchString = String(searchWordArr[currentIndex])
    var subResults = [String]()
    var result = [[String]]()
    while currentIndex < searchWordArr.count{
        var index = 0
        while index < sortedProducts.count && subResults.count < 3{
            let product = sortedProducts[index]
            if product.hasPrefix(searchString){
                subResults.append(product)
            }
            index+=1
        }
        currentIndex+=1
        result.append(subResults)
        subResults = []
        if currentIndex < searchWordArr.count{
            searchString += String(searchWordArr[currentIndex])
        }
    }
    return result
}


func exist(_ board: [[Character]], _ word: String) -> Bool {
    let row = board.count
    let col = board[0].count
    let wordArr = Array(word)
    var visited = Array(repeating: Array(repeating: false, count: col), count: row)
        for i in 0..<row{
            for j in 0..<col{
                if board[i][j] == wordArr[0]{
                    if dfsSearch(row, col, i, j,0, wordArr, board, &visited) {
                        return true
                    }
                }
            }
        }
    return false
}


func dfsSearch(_ row: Int,_ col:Int,_ i: Int,_ j:Int,_ index:Int,_ wordArr: [Character],_ board: [[Character]],_ visited : inout [[Bool]]) -> Bool{
    var visited = visited
    var index = index
    guard i < row,j < col, i >= 0, j >= 0 else{
        return false
    }
    if visited[i][j] {
        return false
    }
    if board[i][j] != wordArr[index]{
        return false
    }
    if index == wordArr.count-1{
        return true
    }
    visited[i][j] = true
    if dfsSearch(row, col, i+1, j, index+1, wordArr, board, &visited) ||
        dfsSearch(row, col, i-1, j, index+1, wordArr, board, &visited) ||
        dfsSearch(row, col, i, j+1, index+1, wordArr, board, &visited) ||
        dfsSearch(row, col, i, j-1, index+1, wordArr, board, &visited){
            return true
    }
    visited[i][j] = false
    return false
}

func longestConsecutive(_ nums: [Int]) -> Int {
    var hashSet = Set<Int>()
    var longestStreak = 1
    if nums.isEmpty{
        return 0
    }
    for i in nums{
        hashSet.insert(i)
    }
    for i in nums{
        // Mark: set number to minimum value available in hashSet
        if !hashSet.contains(i-1) {
           var currentNum = i
            var currentStreak = 1
            // Mark: increase the count if the next increasing number available in hashSet
            while hashSet.contains(currentNum+1){
                currentNum += 1
                currentStreak += 1
            }
            // Mark: Getting the longest Consecutive Sequence
            longestStreak = max(longestStreak, currentStreak)
        }
    }
    return longestStreak
}


func furthestBuilding(_ heights: [Int], _ bricks: Int, _ ladders: Int) -> Int {
    var bricks = bricks
    var ladders = ladders
    var length = heights.count
    var count = 0
    var priorityQueue = [Int]()
    for i in 1..<length{
        var diff = heights[i]-heights[i-1]
        if diff > 0 {
            priorityQueue.append(diff)
        }
    }
    return count
}


func longestCommonPrefix(_ strs: [String]) -> String {
    var minStr = (strs.min{$0.count < $1.count})!
    for str in strs{
        while !str.hasPrefix(minStr){
            minStr.removeLast()
        }
    }
    return minStr
}

func strStr(_ haystack: String, _ needle: String) -> Int {
    if haystack.isEmpty{
        if needle.isEmpty {
            return 0
        }
        return -1
    }
    if needle.isEmpty{
        return 0
    }
    var start = 0
    var end = needle.count-1
    while end < haystack.count{
        let startIndex = haystack.index(haystack.startIndex,offsetBy: start)
        
        let endIndex = haystack.index(haystack.startIndex,offsetBy: end)
        let subString = haystack[startIndex...endIndex]
        if subString == needle{
            return start
        }
        start+=1
        end+=1
        
    }
    return -1
}

//func climbStairs(_ n: Int) -> Int {
//    var dp = [1,1]
//    if n < 2{
//        return 1
//    }
//    if n==2{
//        return dp[0] + dp[1]
//    }
//    for i in 2...n{
//        dp.append(dp[i-1] + dp[i-2])
//    }
//    return dp[n]
//}

func isPossible(_ target: [Int]) -> Bool {
    var sum = 0
    var max = 0
    var target = target
    for i in 0..<target.count{
        sum += target[i]
        if target[max] < target[i]{
            max = i
        }
    }
    let diff = sum - target[max]
    if target[max] == 1 || diff == 1{
        return true
    }
    if diff > target[max] || diff == 0 || target[max]%diff==0{
        return false
    } 
    target[max]%=diff
    return isPossible(target)
}

func checkPossibility(_ nums: [Int]) -> Bool {
    let length = nums.count
    var nums = nums
    var count = 0
    for i in 1..<length{
        if nums[i-1] < nums[i]{
            continue
        } else if nums[i-1] > nums[i]{
            count+=1
            if count > 1{
                return false
            }
            if i==1 || nums[i-2] <= nums[i]{
                nums[i-1] = nums[i]
            } else{
                nums[i] = nums[i-1]
            }
        }
    }
    return true
}

//func countAsterisks(_ s: String) -> Int {
//    let StringArr = s.split(separator: "|")
//    print(StringArr)
//    var maxi = 0
//    var newArr = [String]()
//    for i in stride(from: 0, through: StringArr.count-1, by: 2){
//            newArr.append(StringArr[i].filter{ $0 == "*"})
//    }
//    for j in newArr{
//        maxi += j.count
//    }
//    return maxi
//}

func countAsterisks(_ s: String) -> Int {
    let n = s.count
    let s = Array(s)
    if n == 0 {
        return 0
    }
    var maxi = 0
    var bars = 0
    for i in 0..<n{
        if s[i] == "|"{
            bars += 1
        }
        if bars%2 == 0 && s[i] == "*"{
            maxi+=1
        }
    }
    return maxi
}


//func maxScore(_ cardPoints: [Int], _ k: Int) -> Int {
//    let cardPoints = cardPoints
//    let length = cardPoints.count
//    let window = cardPoints.endIndex-k
//    print(window)
//    var total = cardPoints.reduce(0,+)
//    var curr = 0
//    var sum = 0
//    if window <= 0{
//        return total
//    }
//    for i in 0..<length{
//        let point = cardPoints[i]
//        curr += point
//        if i+1 >= window{
//            sum = max(sum,total-curr)
//            curr -= cardPoints[i-window+1]
//            print(curr)
//        }
//    }
//    return sum
//}

func maxScore(_ cardPoints: [Int], _ k: Int) -> Int {
    let cardPoints = cardPoints
    let length = cardPoints.count
    var window = 0
    let total = cardPoints.reduce(0,+)
    var sum = 0
    if length == k{
        return total
    }
//    for i in 0..<length-k-1{
//        window+=cardPoints[i]
//    }
    window = cardPoints[0..<length-k-1].reduce(0, +)
    for j in length-k-1..<length{
        window += cardPoints[j]
        sum = max(sum,total-window)
        window -= cardPoints[j-(length-k-1)]
    }
    return sum
}

func maximumXOR(_ nums: [Int]) -> Int {
    var ans = 0
    for num in nums {
        ans = ans | num
    }
    return ans
}


func checkXMatrix(_ grid: [[Int]]) -> Bool {
    let row = grid.count
    let col = grid.count
    for i in 0..<row{
        for j in 0..<col{
            if i == j || i+j == row - 1{
                if grid[i][j] == 0{
                    return false
                }
            } else{
                if grid[i][j] != 0{
                    return false
                }
            }
        }
    }
    return true
}

func countHousePlacements(_ n: Int) -> Int {
    if n == 1{
        return 4
    }
    var mod = 1000000007
    var cout1 = 1
    var cout2 = 1
    var result = 0
    for i in 2...n{
        let preCout1 = cout1
        let preCout2 = cout2
        cout2 = preCout1 + preCout2
        cout1 = preCout2
    }
    result = cout1 + cout2
    result*=result
    result %= mod
    return result
}
// Jump 1
func canJump(_ nums: [Int]) -> Bool {
    let length = nums.count
    var MaxDist = 0
    for i in 0..<length{
        if MaxDist < i{
            return false
        }
        MaxDist = max(MaxDist, i+nums[i])
    }
    return true
}
// Jump 2
//func jump(_ nums: [Int]) -> Int {
//    let length = nums.count
//    var dp = Array(repeating: Int.max, count: length)
//    if nums.count <= 1{
//        return 0
//    }
//    dp[length-1] = 0
//    for i in (0...length-2).reversed(){
//        print(i)
//        var minValue = Int.max
//        for j in i+1...min(length-1, i+nums[i]){
//                print(length-1,i+1)
//                minValue = min(minValue, dp[j])
//            }
//            if minValue != Int.max{
//                dp[i] = minValue + 1
//            }
//
//    }
//    return dp[0]
//}
//

func jump(_ nums: [Int]) -> Int {
    var start = 0
    var end = 0
    var fartehest = 0
    var count = 0
    for i in 0..<nums.count-1 {
        fartehest = max(fartehest,i+nums[i])
        if i == end{
            count += 1
            end=fartehest
        }
    }
    return count
}

func minPartitions(_ n: String) -> Int {
    var maxi = 0
    for i in n{
        maxi = max(maxi,i.wholeNumberValue!)
    }
    return maxi
}



//func climbStairs(_ n: Int) -> Int {
//    var first = 1
//    var second = 1
//    if n < 2{
//        return 1
//    }
//    for i in 2...n{
//       let temp = first + second
//        first = second
//        second = temp
//    }
//    return second
//}
var arr = [Int: Int]()
func climbStairs(_ n: Int) -> Int{
    if let val = arr[n]{
        return val
    }
    if n == 0{
        return 1
    }
    if n == 1{
        return 1
    }
    arr[n] = climbStairs(n-1) + climbStairs(n-2)
    return arr[n] ?? 0
}



//func frogJump(_ n:Int,heights: inout [Int],_ dp:inout [Int:Int]) -> Int{
//    if let val = dp[n]{
//        return val
//    }
//    if n == 0{
//        return 0
//    }
//    var left = Int.max
//    var right = Int.max
//    left = frogJump(n-1, heights: &heights, &dp) + abs(heights[n] - heights[n-1])
//    if n > 1 {
//        right = frogJump(n-2, heights: &heights, &dp) + abs(heights[n] - heights[n-2])
//    }
//    dp[n] = min(left,right)
//    return dp[n] ?? 0
//}

func newJump(_ n: Int, _ heights: [Int]) -> Int{
    var heights = heights
    var dp = [Int:Int]()
    return frogJump(n-1, heights: &heights,&dp)
}
var dp = [Int:Int]()
func frogJump(_ n:Int,heights: inout [Int],_ dp:inout [Int:Int]) -> Int{
    dp[0] = 0
    for i in 1..<n{
        let left = dp[i-1] ?? 0 + abs(heights[i] - heights[i-1])
        var right = Int.max
        if i > 1 {
        right = dp[i-2] ?? 0 + abs(heights[i] - heights[i-2])
        }
        dp[i] = min(left, right)
    }
    
    return dp[n-1] ?? 0
}

func kthSmallest(_ matrix: [[Int]], _ k: Int) -> Int {
    var matrix = matrix.flatMap{$0}
    matrix = matrix.sorted()
    return matrix[k-1]
}



func maxArea(_ h: Int, _ w: Int, _ horizontalCuts: [Int], _ verticalCuts: [Int]) -> Int {
    let horizontalCut = (horizontalCuts+[0,h]).sorted(by: <)
    let verticalCut = (verticalCuts+[0,w]).sorted(by: <)
    var total = 0
    var maxHorizontal = 0
    var maxVertical = 0
    
    for i in 0..<horizontalCut.count-1{
        maxHorizontal = max(maxHorizontal,horizontalCut[i+1]-horizontalCut[i])
    }
    
    
    for j in 0..<verticalCut.count-1{
        maxVertical = max(maxVertical,verticalCut[j+1]-verticalCut[j])
    }
    total = maxVertical * maxHorizontal % 1000000007
    return total
}
//twoSum([0,0,3,4],0)
//calculateTax([[3,50],[7,10],[12,25]],10)
//maximumSubarray([187,470,25,436,538,809,441,167,477,110,275,133,666,345,411,459,490,266,987,965,429,166,809,340,467,318,125,165,809,610,31,585,970,306,42,189,169,743,78,810,70,382,367,490,787,670,476,278,775,673,299,19,893,817,971,458,409,886,434])
//minimumTotal([[2],[3,4],[6,5,7],[4,1,8,3]])
//longestDupSubstring("banana")
//lengthOfLIS([3,2,1])
//longestPalindrome("ac")
//countStudents([1,1,1,0,0,1], [1,0,0,0,1,1])
//findLengthOfShortestSubarray([1,2,3,10,4,2,3,5])
//greatestLetter("AbCdEfGhIjK")
//minimumNumbers(10, 8)
//longestSubsequence("1001010", 5)
//suggestedProducts(["mobile","mouse","moneypot","monitor","mousepad"],"mouse")
//exist([["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], "ABCCED")
//longestConsecutive([100,4,200,1,3,2])
//furthestBuilding([1,5,1,2,3,4,10000],4,1)
//longestCommonPrefix(["flower","flow","flight"])
//strStr("hello", "ll")
//climbStairs(5)
//isPossible([9,3,5])
//checkPossibility([5,7,1,8])
//countAsterisks("*||*|||||*|*|***||*||***|")
//countAsterisks("yo|uar|e**|b|e***au|tifu|l")
//maxScore( [1,2,3,4,5,6,1],3)
//maximumXOR([3,2,4,6])
//checkXMatrix([[2,0,0,1],[0,3,1,0],[0,5,2,0],[4,0,0,2]])
//checkXMatrix([[5,7,0],[0,3,1],[0,5,0]])
//countHousePlacements()
//canJump([2,3,1,1,4])
//jump([2,3,0,1,4])
//minPartitions("27346209830709182346")
newJump(5,[30,10,60,10,60,50])
kthSmallest([[1,5,9],[10,11,13],[12,13,15]],8)
maxArea(5,4,[1,2,4],[1,3])
