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
//func canJump(_ nums: [Int]) -> Bool {
//    let length = nums.count
//    var MaxDist = 0
//    for i in 0..<length{
//        if MaxDist < i{
//            return false
//        }
//        MaxDist = max(MaxDist, i+nums[i])
//    }
//    return true
//}


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


func countPoints(_ points: [[Int]], _ queries: [[Int]]) -> [Int] {
    var result = [Int]()
    var count = 0
    for i in 0..<queries.count{
        for j in 0..<points.count {
            var x = Double(abs(points[j][0] - queries[i][0]))
            var y = Double(abs(points[j][1] - queries[i][1]))
            var distance = Double(x * x + y * y).squareRoot()
            if distance <= Double(queries[i][2]) {
                count += 1
            }
        }
        result.append(count)
        count = 0
    }
    return result
}

func restoreMatrix(_ rowSum: [Int], _ colSum: [Int]) -> [[Int]] {
    var rowSum = rowSum
    var colSum = colSum
    var row = rowSum.count
    var col = colSum.count
    var i = 0
    var j = 0
    var res = Array(repeating: Array(repeating: 0, count: col), count: row)
    while i < row && j < col{
        var x  = min(rowSum[i], colSum[j])
        res[i][j] = x
        rowSum[i] -= x
        colSum[j] -= x
        if rowSum[i] == 0{
            i += 1
        }
        if colSum[j] == 0{
            j += 1
        }
    }
    return res
}


func maxIncreaseKeepingSkyline(_ grid: [[Int]]) -> Int {
    var m = grid.count
    var rows = Array(repeating: 0, count: m)
    var cols = Array(repeating: 0, count: m)
    for i in 0..<m{
        for j in 0..<m{
            rows[i] = max(rows[i], grid[i][j])
            cols[j] = max(cols[j], grid[i][j])
        }
    }
    var ans = 0
    for i in 0..<m{
        for j in 0..<m{
            ans += min(rows[i],cols[j]) - grid[i][j]
        }
    }
    return ans
}

func groupThePeople(_ groupSizes: [Int]) -> [[Int]] {
    var result = [[Int]]()
    var dict:[Int: [Int]] = [:]
    for (i,s) in groupSizes.enumerated(){
        dict[s,default:[]].append(i)
        let g = dict[s]!
        if g.count == s{
            result.append(g)
            dict[s] = []
        }
    }
    return result
}

func makeGood(_ s: String) -> String {
    var stack = [Character]()
    for i in s{
        if stack.last?.uppercased() == String(i) && i.isUppercase && stack.last!.isLowercase{
            stack.popLast()
        } else if stack.last?.lowercased() == String(i) && i.isLowercase && stack.last!.isUppercase{
            stack.popLast()
        } else{
            stack.append(i)
        }
    }
    return String(stack)
}


func restoreArray(_ adjacentPairs: [[Int]]) -> [Int] {
    var adjacentPairs = adjacentPairs.flatMap{$0}
    var pairSet : Set<Int> = []
    var result:[Int] = []
    for i in 0..<adjacentPairs.count{
        pairSet.insert(adjacentPairs[i])
    }
    result += pairSet.map{$0}
    result = result.sorted()
    return result
}


func numIdenticalPairs(_ nums: [Int]) -> Int {
    var dict = [Int:Int]()
    var pairCount :[Int] = [0]
    for i in 1..<nums.count{
        pairCount.append(pairCount.last! + i)
    }
    for i in nums{
        dict[i,default: 0] += 1
    }
    var result = 0
    for (num,count) in dict {
        result += pairCount[count-1]
    }
    return result
}

func buildArray(_ nums: [Int]) -> [Int] {
    return nums.indices.map{nums[nums[$0]]}
}

func countDistinctIntegers(_ nums: [Int]) -> Int {
    var nums = Set(nums)
    var secondArr = [Int]()
    for i in nums{
        var j = i
        var newNum = reverseNumber(&j)
        secondArr.append(newNum)
    }
    for k in secondArr{
        if !nums.contains(k){
            nums.insert(k)
        }
    }
    return nums.count
}

func reverseNumber(_ num: inout Int) -> Int{
    var remainder = 0
    var reverseNum = 0
    while num != 0{
        remainder = num%10
        reverseNum = reverseNum * 10 + remainder
        num = num / 10
    }
    return reverseNum
}

func maxSum(_ grid: [[Int]]) -> Int {
    var maxSum = Int.min
    for i in 0..<(grid.count-2){
        for j in 0..<grid[0].count-2{
            var sum = grid[i][j] + grid[i][j+1] + grid[i][j+2] + grid[i+1][j+1] + grid[i+2][j] + grid[i+2][j+1] + grid[i+2][j+2]
            maxSum = max(sum, maxSum)
        }
    }
    return maxSum
}

func matrixBlockSum(_ mat: [[Int]], _ k: Int) -> [[Int]] {
    var row = mat.count
    var col = mat[0].count
    var output = [[Int]](repeating: [Int](repeating: 0, count: col),count: row)
    for i in 0..<row{
        for j in 0..<col{
            output[i][j] = sum(mat, row, col, i, j, k)
        }
    }
    return output
}

func sum(_ mat:[[Int]],_ row: Int,_ col : Int,_ i: Int,_ j: Int,_ k: Int) -> Int{
    var sum = 0
    for m in i-k..<i+k+1{
        for n in j-k..<j+k+1{
            if m >= 0 && m < row && n >= 0 && n < col{
                sum += mat[m][n]
            }
        }
    }
    return sum
}



//func sumSubarrayMins(_ arr: [Int]) -> Int {
//    var result = [[Int]]
//    for i in arr{
//        result
//    }
//}

func kSmallestPairs(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> [[Int]] {
    if nums1.isEmpty || nums2.isEmpty || k == 0{
        return []
    }
    var arr = [([Int],Int)]()
    for i in 0..<nums1.count{
        for j in 0..<nums2.count{
            arr.append(([nums1[i],nums2[j]],nums1[i]+nums2[j]))
        }
    }
    let sorted =  arr.sorted {$0.1 < $1.1}
    var result = [[Int]]()
    var count = 0
    for data in sorted where count < k{
        result.append([data.0[0],data.0[1]])
        count += 1
    }
    return result
}


func findWinners(_ matches: [[Int]]) -> [[Int]] {
    var winnerDict = [Int:Int]()
    var losserDict = [Int:Int]()
    for i in 0..<matches.count{
        winnerDict[matches[i][0],default: 0] += 1
    }
    for i in 0..<matches.count{
        losserDict[matches[i][1],default: 0] += 1
    }

    for losser in losserDict.keys{
        if winnerDict[losser] != nil{
            winnerDict.removeValue(forKey: losser)
        }
    }
    for losser in losserDict.keys{
        if winnerDict[losser] != nil {
            winnerDict.removeValue(forKey: losser)
        }
            
            
        if losserDict[losser]! > 1{
            losserDict.removeValue(forKey: losser)
        }
    }
    
    for winner in winnerDict.keys{
        if losserDict[winner] != nil{
            losserDict.removeValue(forKey: winner)
        }
    }
    var winnerResult = [Int]()
    var loserResult = [Int]()
    winnerResult = winnerDict.keys.map{$0}.sorted()
    loserResult = losserDict.keys.map{$0}.sorted()
    return [winnerResult,loserResult]
}

func wateringPlants(_ plants: [Int], _ capacity: Int) -> Int {
    var i = 0
    var step = 0
    var inCapacity = capacity
        while i < plants.count{
            if inCapacity - plants[i] >= 0{
                inCapacity -= plants[i]
                step += 1
                i += 1
            } else{
                inCapacity = capacity
                step += 2*i
            }
        }
    return step
}

func evaluate(_ s: String, _ knowledge: [[String]]) -> String {
    var hashMap = [String:String]()
    var result = ""
    for i in knowledge{
        hashMap[i[0]] = i[1]
    }
    var currentWord = ""
    var arr = Array(s)
    var startedCount = false
    for j in 0..<arr.count{
        if startedCount && arr[j] != ")"{
            currentWord += String(arr[j])
        }
        if arr[j] == "("{
            startedCount = true
        }
        else if arr[j] == ")"{
            startedCount = false
            result += hashMap[currentWord] ?? "?"
            currentWord = ""
        }else{
            if !startedCount{
                result += String(arr[j])
            }
        }
    }
    return result
}

func backtrack(_ candidates:[Int], _ start: Int,_ target: Int,_ list: inout [Int],_ result: inout [[Int]],_ k : Int) {
    if target < 0{
        return
    }
    
    if list.count > k{
        return
    }
    
    if target == 0 && list.count == k{
        result.append(list)
        return
    }
    
    for i in start..<candidates.count{
        list.append(candidates[i])
        backtrack(candidates, i+1, target-candidates[i], &list, &result, k)
        list.removeLast()
    }
}

func combinationSum3(_ k: Int, _ n: Int) -> [[Int]] {
    var candidates = [1,2,3,4,5,6,7,8,9]
    var tempList = [Int]()
    var result = [[Int]]()
    backtrack(candidates, 0, n, &tempList, &result, k)
    return result
}

func uniqueOccurrences(_ arr: [Int]) -> Bool {
    var dict = [Int:Int]()
    var newArr = [Int]()
    var newSet = Set<Int>()
    for i in arr{
        dict[i,default:0] += 1
    }
    print(dict)
    newArr = dict.values.map{$0}
    newSet = Set(newArr)
    if newArr.count == newSet.count{
        return true
    }
    return false
}

func findDuplicates(_ nums: [Int]) -> [Int] {
    var dict = [Int:Int]()
    var result = [Int]()
    for i in nums{
        dict[i,default: 0] += 1
    }
    for index in dict.keys{
        if dict[index]! > 1{
            result.append(index)
        }
    }
    return result
}

func peakIndexInMountainArray(_ arr: [Int]) -> Int {
    var end = arr.count-1
    var start = 0
    while start < end{
        var mid = start + (end - start)/2
        if arr[mid] < arr[mid+1]{
            start = mid + 1
        } else{
            end = mid
        }
    }
    return start
}
//
//func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
//    var sum = 0
//    for candidate in candidates {
//
//        if
//    }
//}

func maxProfitAssignment(_ difficulty: [Int], _ profit: [Int], _ worker: [Int]) -> Int {
    var element = 0
    var sum = 0
    var profit = profit.sorted()
    var difficulty = difficulty.sorted()
    for i in worker{
        element = internalBinarySearch(difficulty,i)
        sum += profit[element]
    }
    return sum
}

func internalBinarySearch(_ difficulty: [Int],_ searchWorker: Int) -> Int{
    var start = 0
    var end = difficulty.count
    while start < end{
        var mid = start + (end - start)/2
        if  difficulty[mid] <= searchWorker{
            return mid
        } else if difficulty[mid] > searchWorker{
            end = mid
        }
    }
    return 0
}

//func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
//    var length = temperatures.count
//    var arr = [Int]()
//    for i in 0..<length{
//        if i + 1 == length{
//            arr.append(0)
//            break
//        }
//        for j in i+1..<length{
//            if temperatures[i] < temperatures[j]{
//                arr.append(j-i)
//                break
//            }
//            if j+1 == length{
//                arr.append(0)
//                break
//            }
//        }
//    }
//    return arr
//}


func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
    var result: [Int] = [Int](repeating: 0, count: temperatures.count)
    var stacks: [Int] = []
    
    for i in 0..<temperatures.count {
        
        while !stacks.isEmpty && temperatures[stacks.last!] < temperatures[i] {
            let last = stacks.removeLast()
            result[last] = i-last
        }
        
        stacks.append(i)
    }
    
    return result
}

func canVisitAllRooms(_ rooms: [[Int]]) -> Bool {
    var visited = Array(repeating: false, count: rooms.count)
    visited[0] = true
    var stack = [Int]()
    stack.append(0)
    while !stack.isEmpty{
        var temp = stack.removeLast()
        for i in rooms[temp]{
            if visited[i] == false {
                visited[i] = true
                stack.append(i)
            }
        }
        
    }
    for i in visited{
        if i == false{
            return false
        }
    }
    return true
}

func possibleBipartition(_ n: Int, _ dislikes: [[Int]]) -> Bool {
    var edges = Array(repeating: [Int](), count: n+1)
    for dislike in dislikes {
        edges[dislike[0]].append(dislike[1])
        edges[dislike[1]].append(dislike[0])
    }
    var color = [Int](repeating: -1, count: n+1)
    for p in 1...n{
        if color[p] == -1{
            color[p] = 1
            var queue = [p]
            while queue.isEmpty == false{
                let curr = queue.removeFirst()
                let currColor = color[curr]
                for adjacent in edges[curr]{
                    if color[adjacent] == -1{
                        color[adjacent] = currColor ^ 1
                        queue.append(adjacent)
                    } else if color[adjacent] != currColor ^ 1{
                        return false
                    }
                }
                
            }
        }
    }
    return true
}



func answerQueries(_ nums: [Int], _ queries: [Int]) -> [Int] {
    var newQueue = queries
    var sortedNum = nums.sorted(by: <)
    var result = Array(repeating: 0, count: queries.count)
    for i in 0..<sortedNum.count{
        for j in 0..<queries.count {
            if sortedNum[i] <= newQueue[j]  {
                newQueue[j] -= sortedNum[i]
                result[j] += 1
            }
        }
    }
    return result
}


func canJump(_ nums: [Int]) -> Bool {
    var length = nums.count
    var maxNum = 0
    for i in 0..<length{
        if maxNum < i{
            return false
        }
        maxNum = max(maxNum,i + nums[i])
    }
    return true
}

func calculateIndex(_ arr: [Int], _ start: Int,_ reached: inout [Int]) -> Bool{
    if start > arr.count-1 || start < 0 {
        return false
    }
    if reached.contains(start){
        return false
    }
    if arr[start] == 0{
        return true
    }
    reached.append(start)
    return calculateIndex(arr, start + arr[start],&reached) || calculateIndex(arr, start - arr[start],&reached)
}
func canReach(_ arr: [Int], _ start: Int) -> Bool {
    var reached = [Int]()
    return calculateIndex(arr, start, &reached)
}

func minJumps(_ arr: [Int]) -> Int {
    var length = arr.count
    var numMap = [Int:[Int]]()
    var nextQueue = [Int]()
    var unvisited = Set<Int>()
    for i in 0..<length{
        numMap[arr[i],default: [Int]()].append(i)
    }
    print(numMap)
    nextQueue.append(0)
    unvisited.insert(0)
    var result = 0
    while !nextQueue.isEmpty{
        var queueCount = nextQueue.count
        for _ in 0..<queueCount{
            let node = nextQueue.removeFirst()
            if node == length-1{
                return result
            }
            if node != 0 && !unvisited.contains(node-1){
                nextQueue.append(node-1)
                unvisited.insert(node-1)
            }
            if node != arr.count-1 && !unvisited.contains(node+1){
                nextQueue.append(node+1)
                unvisited.insert(node+1)
            }
            if let elements = numMap[arr[node]]{
                for i in elements{
                    if !unvisited.contains(i){
                        nextQueue.append(i)
                        unvisited.insert(i)
                    }
                }
            }
            numMap[arr[node]] = nil
        }
        result+=1
    }
    return result
}

func maximumBags(_ capacity: [Int], _ rocks: [Int], _ additionalRocks: Int) -> Int {
    var customCap = capacity
    var additionalRocks = additionalRocks
    for i in 0..<customCap.count{
        customCap[i] -= rocks[i]
    }
    customCap = customCap.sorted()
    var count = 0
    for i in 0..<customCap.count{
        if customCap[i] == 0{
            count += 1
        } else if customCap[i] <= additionalRocks{
            count += 1
            additionalRocks -= customCap[i]
        } else{
            break
        }
    }
    return count
}



func minStoneSum(_ piles: [Int], _ k: Int) -> Int {
    var k = k
    var length = piles.count
    var piles = piles.sorted(by: >)
    for i in 0..<length{
        if k > 0{
            if piles[i] % 2 == 0{
                piles[i] = piles[i] / 2
            }else if piles[i] % 2 == 1{
                piles[i] = (piles[i] / 2)+1
            }
            k -= 1
        }else{
            break
        }
    }
    print(piles)
    return piles.reduce(0,+)
}


func nextGreaterElement(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var length =  nums2.count
    var result = [Int]()
    for i in nums1{
        var curIndex = nums2.firstIndex(of: i)!
        for j in curIndex..<length{
            if nums2[j] > i{
                result.append(nums2[j])
                break
            }else if j == length-1{
                result.append(-1)
            }
        }
    }
    return result
}

func nextGreaterElement(_ n: Int) -> Int {
    var numberString = Array(String(n))
    var length = numberString.count
    guard length >= 2 else{
        return -1
    }
    for currIndex in (0...(length-2)).reversed(){
        var prevIndex = currIndex + 1
        if numberString[prevIndex] > numberString[currIndex]{
            var swapIndex = length-1
            print(swapIndex,currIndex)
            while swapIndex > currIndex{
                if numberString[swapIndex] > numberString[currIndex]{
                    numberString.swapAt(swapIndex, currIndex)
                    numberString = Array(numberString[0...currIndex]) + Array(numberString[prevIndex..<length]).reversed()
                    let result = Int(numberString.map{String($0)}.reduce(""){$0 + $1})!
                    if result <= Int32.max{
                        return result
                    }else{
                        return -1
                    }
                }else{
                    swapIndex -= 1
                }
            }
        }
        
    }
    return -1
}


func wordPattern(_ pattern: String, _ s: String) -> Bool {
    var dictPattern = [Character: Int]()
    var pattern = Array(pattern)
    var words = s.split(separator: " ")
    guard pattern.count == words.count && Set(pattern).count == Set(words).count else{
        return false
    }
    for i in 0..<pattern.count{
        if let index = dictPattern[pattern[i]]{
            if words[i] != words[index]{
                return false
            }
        }else{
            dictPattern[pattern[i]] = i
        }
    }
    return true
}

func countDigits(_ num: Int) -> Int {
    var originalNum = num
    var numString = String(num)
    var arrNum = numString.map{Int(String($0))!}
    var count = 0
    for i in arrNum{
        if originalNum % i == 0{
            count += 1
        }
    }
    return count
}

func distinctPrimeFactors(_ nums: [Int]) -> Int {
    var nums = nums
    var m = [Int]()

    for i in 0..<nums.count{
        var sq = sqrt(Double(nums[i]))
        for j in 2..<Int(sq)+1{
            if  nums[i] % j == 0{
                m.append(j)
            }
            while nums[i] % j == 0{
                nums[i] /= j
            }
        }
        if nums[i] >= 2{
            m.append(nums[i])
        }
    }
    return Set(m).count
}

func minimumPartition(_ s: String, _ k: Int) -> Int {
    var arr = Array(s)
    var flag = false
    var ans = 0
    var num = 0
    if k < 10{
        for i in arr{
            if Int(String(i))! > k{
                flag = true
            }
        }
    }
    if flag == true{
        return -1
    }
    for i in 0..<arr.count{
        num = num * 10 + Int(String(arr[i]))!
        if num > k{
            ans+=1
            num = Int(String(arr[i]))!
        }
        
    }
    if num > 0{
        ans+=1
    }
    return ans
}

func closestPrimes(_ left: Int, _ right: Int) -> [Int] {
    var left = 0
    var k = 0
    var count = 0
    var arr = [Int]()
    while left <= right{
        for i in 2..<left{
            if left % i == 0{
                k+=1
            }
        }
        if k == 0{
            count+=1
            arr.append(left)
        }
        left += 1
        k=0
    }
    return arr
}

func detectCapitalUse(_ word: String) -> Bool {
    return (word == word.capitalized || word == word.uppercased() || word == word.lowercased()) ? true : false
}

func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
    var result = [[Int]]()
    var res = [Int]()
    calculateCombinationSum(0, candidates, target,&result,&res)
    return result
}

func calculateCombinationSum(_ i:Int,_ candidates: [Int], _ target: Int,_ result : inout [[Int]],_ res : inout [Int]){
    var target = target
    if i == candidates.count{
        if target == 0{
            result.append(res)
        }
        return
    }
    
    if candidates[i] <= target{
        res.append(candidates[i])
        calculateCombinationSum(i, candidates, target-candidates[i], &result,&res)
        res.popLast()
    }
    calculateCombinationSum(i+1, candidates, target, &result,&res)
}


func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
    var result = [[Int]]()
    var res = [Int]()
    print(candidates.sorted())
    calculateCombinationSum2(0, candidates.sorted(), target,&result,&res)
    return result
}

func calculateCombinationSum2(_ currentIndex:Int,_ candidates: [Int], _ target: Int,_ result : inout [[Int]],_ res : inout [Int]){
    var target = target
    if target == 0{
        result.append(res)
        return
    }
    
    for i in currentIndex..<candidates.count{
        if i > currentIndex && candidates[i] == candidates[i-1]{
            continue
        }
        if candidates[i] > target{
            break
        }
        res.append(candidates[i])
        calculateCombinationSum2(i+1, candidates, target - candidates[i],&result,&res)
        res.popLast()
    }
}

func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
    var result = [[Int]]()
    var subAns = [Int]()
    calculateSubsetsWithDup(0, nums.sorted(),&result,&subAns)
    return result
}

func calculateSubsetsWithDup(_ index: Int,_ num:[Int],_ result: inout [[Int]], _ res : inout [Int]){
    result.append(res)
    
    for i in index..<num.count{
        if i > index && num[i] == num[i-1]{
            continue
        }
        res.append(num[i])
        calculateSubsetsWithDup(i+1, num, &result, &res)
        res.popLast()
    }
}

func permute(_ nums: [Int]) -> [[Int]] {
    var result = [[Int]]()
    var nums = nums
    calculatePermutate(0, &nums,&result)
    return result
}

func calculatePermutate(_ index: Int,_ num: inout [Int],_ result: inout [[Int]]){
    if index == num.count{
        result.append(num)
    }
    
    for i in index..<num.count{
        num.swapAt(index, i)
        calculatePermutate(index+1, &num, &result)
        num.swapAt(index, i)
    }
}


func calculateCombination(_ i: Int,_ temp : inout [Character],_ digits: [Character],_ map : [Character:String],_ result: inout [String])  {
    if digits.isEmpty{
        return
    }
    if i == digits.count{
        result.append(temp.map{String($0)}.joined())
        return
    }
    var str = map[digits[i]]
    if let str = str{
        for j in str{
            temp += String(j)
            calculateCombination(i+1, &temp, digits, map, &result)
            temp.popLast()
        }
    }
}

func letterCombinations(_ digits: String) -> [String] {
    var digits = Array(digits)
    var map = [Character:String]()
    map["2"] = "abc"
    map["3"] = "def"
    map["4"] = "ghi"
    map["5"] = "jkl"
    map["6"] = "mno"
    map["7"] = "pqrs"
    map["8"] = "tuv"
    map["9"] = "wxyz"
    var result = [String]()
    var temp = [Character]()
    calculateCombination(0,&temp,digits,map,&result)
    return result
}

func minDeletionSize(_ strs: [String]) -> Int {
    var result = 0
    var arr = strs.compactMap{Array($0)}
    print(arr)
    for i in 0..<strs[0].count{
        var temp = ""
        for j in 0..<strs.count{
            temp += String(arr[j][i])
        }
        if temp != String(temp.sorted()){
            result += 1
        }
    }
    return result
}

func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
    var result = [[Int]]()
    var newInterval = newInterval
    for i in intervals{
        if i[1] < newInterval[0]{
            result.append(i)
        }else if newInterval[1] < i[0]{
            result.append(newInterval)
            newInterval = i
        }else{
            newInterval[0] = min(newInterval[0], i[0])
            newInterval[1] = max(newInterval[1], i[1])
        }
    }
    result.append(newInterval)
    return result
}

func calculateCombination(_ i:Int,_ n: Int,_ k:Int,_ temp: inout [Int],_ result: inout [[Int]]) {
    if temp.count == k{
        let sorted = temp.sorted()
        if !result.contains(temp){
            result.append(temp)
        }
        return
    }
    
    guard i <= n else {return}
    for j in i...n{
        temp.append(j)
        calculateCombination(j+1,n, k, &temp, &result)
        temp.popLast()
    }
}

func combine(_ n: Int, _ k: Int) -> [[Int]] {
    var result = [[Int]]()
    var temp = [Int]()
    calculateCombination(1,n,k,&temp,&result)
    return result
}

func minimumRounds(_ tasks: [Int]) -> Int {
    var map = [Int:Int]()
    for i in tasks{
        map[i,default: 0] += 1
    }
    var result = 0
    for i in map{
        let i = i.value
        if i == 1{
            return -1
        }
        if i % 3 == 0{
            result += (i / 3)
        }else{
            result += (i / 3) + 1
        }
    }
    return result
}


func removeDuplicates(_ nums: inout [Int]) -> Int {
    var i = 0
    print(nums)
    for num in nums where i < 2 || num != nums[i-2]{
        nums[i] = num
        i+=1
    }
    return i
}

func multiply(_ num1: String, _ num2: String) -> String {
    var resultArr = Array(repeating: 0, count: num1.count + num2.count)
    for (i,n1) in num1.enumerated().reversed(){
        for (j,n2) in num2.enumerated().reversed(){
            guard let digit1 = Int(String(n2)),let digit2 = Int(String(n1)) else{ return ""}
            let p1 = i + j
            let p2 =  i + j + 1
            let mult = (digit1 * digit2) + resultArr[p2]
            resultArr[p2] = mult % 10
            resultArr[p1] += mult / 10
        }
    }
    while let firstSum = resultArr.first,firstSum == 0{
        resultArr.removeFirst()
    }
    let res = resultArr.map({String($0)}).joined()
    return res.count > 0 ? res : "0"
}

func restoreIpAddresses(_ s: String) -> [String] {
    var res = [String]()
    var temp = [Int]()
    var s = Array(s)
    calculateRestoreIpAddresses(0,&res,&temp,s)
    return res
}

func calculateRestoreIpAddresses(_ index :Int,_ result: inout [String],_ temp:inout [Int],_ s: [Character]){
    if temp.count == 4 && index == s.count{
        result.append(temp.map({String($0)}).joined(separator: "."))
        return
    }
    
    if temp.count >= 4{
        return
    }
    for i in index..<s.count{
        if s[index] == "0" && i > index{
            break
        }
        let startIndex = s.index(s.startIndex, offsetBy: index)
        let endIndex = s.index(s.startIndex, offsetBy: i)
        let num = Int(String(s[startIndex...endIndex])) ?? 0
        if num > 255{
            break
        }
        temp.append(num)
        calculateRestoreIpAddresses(i+1, &result, &temp, s)
        temp.popLast()
    }
}

func findMinArrowShots(_ points: [[Int]]) -> Int {
    if points.count == 0{
        return 0
    }
    var points = points.sorted{ $0[1] < $1[1]}
    var count = 1
    var endPoint = points[0][1]
    for i in 1..<points.count{
        if endPoint < points[i][0]{
            count+=1
            endPoint = points[i][1]
        }
    }
    return count
}

func maxIceCream(_ costs: [Int], _ coins: Int) -> Int {
    var coins = coins
    var count = 0
    for value in costs.sorted(){
        if value <= coins {
            coins-=value
            count+=1
        }
    }
    return count
}

func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
    var length = cost.count
    var sum = 0
    if gas.reduce(0, +) < cost.reduce(0, +){
        return -1
    }
    var startIndex = 0
    for i in 0..<length{
        sum += gas[i] - cost[i]
        if sum < 0{
            sum = 0
            startIndex = i+1
        }
    }
    return startIndex
}


func singleNonDuplicate(_ nums: [Int]) -> Int {
    var nums = nums
    var left = 0
    var right = nums.count-1
    if nums.count == 1{
        return nums.first!
    }
    if nums[left] != nums[left+1]{
        return nums[left]
    }
    if nums[right] != nums[right-1]{
        return nums[right]
    }
    while left<=right{
        var mid = left + (right-left)/2
        if nums[mid] != nums[mid-1] && nums[mid] != nums[mid+1]{
            return nums[mid]
        }else if  (nums[mid] == nums[mid+1] && mid % 2 == 0) || (nums[mid] == nums[mid-1] && mid % 2 != 0) {
            left = mid+1
        }else{
            right = mid-1
        }
    }
    return -1
}

func maximumCount(_ nums: [Int]) -> Int {
    var positive = 0
    var negative = 0
    for i in nums{
        if i > 0{
            positive += 1
        }else if i < 0{
            negative += 1
        }
    }
    return max(positive,negative)
}
//
//func maxKelements(_ nums: [Int], _ k: Int) -> Int {
//    var nums = nums
//    var score = 0
//    var k = k
//    for i in 0..<nums.count{
//        while nums[i] >= 3 && k > 0{
//            score += nums[i]
//            if nums[i]%3 != 0{
//                nums[i] = (nums[i]/3)+1
//            }else{
//                nums[i] = (nums[i]/3)
//            }
//            k-=1
//        }
//    }
//    return score
//}

func isItPossible(_ word1: String, _ word2: String) -> Bool {
    var word1 = Array(word1)
    var word2 = Array(word2)
    for i in 0..<word1.count{
        for j in 0..<word2.count{
            var temp = word1[i]
            word1[i] = word2[j]
            word2[j] = temp
            if checkUniqueElement(word1,word2){
                return true
            }
        }
    }
    return false
}

func checkUniqueElement(_ arr1: [Character],_ arr2: [Character]) -> Bool{
    var map1 = [Character:Int]()
    var map2 = [Character:Int]()
    var uniqueElementMap1 = 0
    var uniqueElementMap2 = 0
    for i in arr1{
        map1[i,default: 0] += 1
    }
    
    for j in arr2{
        map2[j,default: 0] += 1
    }
    
    for i in map1{
        if i.value == 1{
            uniqueElementMap1+=1
        }
    }
    for j in map2{
        if j.value  == 1{
            uniqueElementMap2+=1
        }
    }
    return uniqueElementMap1 == uniqueElementMap2
}


func maxPoints(_ points: [[Int]]) -> Int {
    var n = points.count
    if n <= 2{
        return n
    }
    var maxi = 2
    for i in 0..<n{
        for j in i+1..<n{
            var total = 2
            for k in 0..<n{
                if k != i  && k != j{
                    if (points[j][1] - points[i][1]) * (points[i][0] - points[k][0]) ==
                        (points[i][1] - points[k][1]) * (points[j][0] - points[i][0]){
                        total+=1
                    }
                }
            }
            maxi = max(maxi, total)
        }
    }
    return maxi
}

func checkValidString(_ s: String) -> Bool {
    var arr = Array(s)
    var dp = Array(repeating: Array(repeating: -1, count: 101), count: 101)
    print(dp)
    return calculateCheckValidString(0, arr,0,&dp)
}

func calculateCheckValidString(_ index: Int,_ arr: [Character],_ open:Int,_ dp : inout [[Int]]) -> Bool{
    if index == arr.count{
        if open == 0{
            return true
        }
        return false
    }
    
    if open < 0 || index > arr.count{
        return false
    }
    if dp[index][open] != -1{
        return dp[index][open] == 0
    }
    var flag = false
    if arr[index] == "("{
        flag = flag || calculateCheckValidString(index+1, arr, open+1,&dp)
    }else if arr[index] == ")"{
        flag = flag || calculateCheckValidString(index+1, arr, open-1,&dp)
    }else{
        flag = flag || calculateCheckValidString(index+1, arr, open+1,&dp) || calculateCheckValidString(index+1, arr, open-1,&dp) || calculateCheckValidString(index+1, arr, open,&dp)
    }
    if flag == false{
        dp[index][open] = 1
    }else{
        dp[index][open] = 0
    }
    
    return dp[index][open] == 0
}

func numTeams(_ rating: [Int]) -> Int {
    var increaseNumberDp = Array(repeating: 0, count: rating.count)
    var decreaseNumberDp = Array(repeating: 0, count: rating.count)
    var Count = 0
    
    for i in (0..<rating.count).reversed(){
        for j in i+1..<rating.count{
            if rating[i] < rating[j]{
                increaseNumberDp[i]+=1
                Count += increaseNumberDp[j]
            }else{
                decreaseNumberDp[i]+=1
                Count += decreaseNumberDp[j]
            }
        }
    }
    
    return Count
}

func maxSubarraySumCircular(_ nums: [Int]) -> Int {
    var curMaxSum = nums[0]
    var curMinSum = nums[0]
    var maxLinearSum = nums[0]
    var minLinearSum = nums[0]
    var total = nums[0]
    for i in 1..<nums.count{
        curMaxSum = max(curMaxSum + nums[i],nums[i])
        maxLinearSum  = max(maxLinearSum,curMaxSum)
        curMinSum = min(curMinSum + nums[i],nums[i])
        minLinearSum = min(minLinearSum,curMinSum)
        total += nums[i]
    }
    
    return maxLinearSum > 0 ? max(maxLinearSum,total-minLinearSum) : maxLinearSum
}

func calculateSubsequence(_ i: Int,_ num: [Int],_ result:inout [[Int]],_ current:inout [Int],_ prev: Int){
    if current.count > 1{
        if !result.contains(current){
            result.append(current)
        }
    }
    for j in i..<num.count{
        if prev <= num[j]{
            current.append(num[j])
            calculateSubsequence(j+1, num, &result, &current,num[j])
            current.popLast()
        }
    }
}

func findSubsequences(_ nums: [Int]) -> [[Int]] {
    var result = [[Int]]()
    var current = [Int]()
    var prev = Int.min
    calculateSubsequence(0, nums, &result, &current,prev)
    return result
}

func maxJump(_ stones: [Int]) -> Int {
    var length = stones.count
    if length == 2{
        return stones[-1]
    }
    var difference = 0
    for i in 0..<(length-2){
        difference = max(difference,(stones[i+2] - stones[i]))
    }
    return difference
}


func isPallindrome(_ x: [Character],_ i: Int,_ j: Int) -> Bool{
    var i = i
    var j = j
    while i < j{
        if x[i] != x[j]{
            return false
        }
        i += 1
        j -= 1
    }
    return true
}

func partition(_ s: String) -> [[String]] {
    var result = [[String]]()
    var current = [String]()
    var arr = Array(s)
    calculatePartion(0, arr, &result, &current)
    return result
}

func calculatePartion(_ i:Int,_ arr:[Character],_ result:inout [[String]],_ current:inout [String]) {
    if i == arr.count{
        result.append(current)
        return
    }
    
    
    var partionStr = ""
    for j in i..<arr.count{
        partionStr.append(arr[j])
        if isPallindrome(arr, i, j){
            current.append(partionStr)
            calculatePartion(j+1, arr, &result, &current)
            current.popLast()
        }
    }
}


func fourSumCount(_ nums1: [Int], _ nums2: [Int], _ nums3: [Int], _ nums4: [Int]) -> Int {
    var map1 = [Int:Int]()
    for i in 0..<nums1.count{
        for j in 0..<nums2.count{
            var sum = nums1[i] + nums2[j]
            map1[sum,default:0] += 1
        }
    }
    
    var count = 0
    for i in 0..<nums3.count{
        for j in 0..<nums4.count{
            var sum = nums3[i] + nums4[j]
            if let num2Count = map1[-sum]{
                count += num2Count
            }
        }
    }
    
    return count
}

func countPrimes(_ n: Int) -> Int {
    if n <= 2{
        return 0
    }
    var prime = Array(repeating: true, count: n)
    var i = 2
    while i * i < n{
        if prime[i]{
            var j = i
            while j * i < n{
                prime[j*i] = false
                j+=1
            }
        }
        i+=1
    }
    print(prime)
    
    var count = 0
    for i in stride(from: 2, to: n, by: 1){
        count += prime[i] ? 1 : 0
    }
    return count
}


func trailingZeroes(_ n: Int) -> Int {
    var sum = 0
    var input = n
    while input > 0{
        input /= 5
        sum += input
    }
    return sum
}

func increasingTriplet(_ nums: [Int]) -> Bool {
    var num1 = Int.max
    var num3 = Int.max
    for i in nums{
        if i < num1{
            num1 = i
        }else if  i < num3{
            num3 = i
        }else{
            return true
        }
    }
    return false
}
func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
    var nums = nums.sorted()
    var length = nums.count
    var ans = 0
    var maximumAns = Int.max
    for i in 0..<length{
        var start = i+1
        var end = length-1
        while start < end{
            var sum = nums[i] + nums[start] + nums[end]
            var diff = abs(sum - target)
            if diff < maximumAns{
                maximumAns = diff
                ans = sum
            }else if sum > target{
                end-=1
            }else{
                start+=1
            }
        }
    }
    return ans
}
    
//
//func canArrange(_ arr: [Int], _ k: Int) -> Bool {
//    var map = [Int:Int]()
//    for i in arr{
//        var rem = ((i%k) + k)%k
//        map[rem,default: 0] += 1
//    }
//    for i in 1..<k{
//       if map[i] != map[k-i]{
//            return false
//        }
//    }
//    return ((map[0] ?? 2) % 2) == 0
//}

func canArrange(_ arr: [Int], _ k: Int) -> Bool {
    var arr = arr.map{$0%k}
    arr = arr.sorted()
    var start = 0
    var end = arr.count - 1
    while start <= end && arr[start] == 0{
        start += 1
    }
    if start % 2 == 1{
        return false
    }
    while start < end{
        if arr[start] + arr[end] != k{
            return false
        }
        start+=1
        end-=1
    }
    return true
}


func findTheArrayConcVal(_ nums: [Int]) -> Int {
    var start = 0
    var end = nums.count-1
    var sum = 0
    while start < end{
        var concatenated = String(nums[start]) + String(nums[end])
        sum += Int(concatenated)!
        start += 1
        end -= 1
    }
    if start == end{
        sum += nums[start]
    }
    return sum
}

func countFairPairs(_ nums: [Int], _ lower: Int, _ upper: Int) -> Int {
    var nums = nums.sorted()
    return smaller(nums,upper) - smaller(nums, lower-1)
}

func smaller(_ nums: [Int],_ value:Int) -> Int{
    var l = 0
    var r = nums.count - 1
    var result = 0
    while l < r{
        var sum = nums[l] + nums[r]
        if sum <= value{
            result += (r - l)
            l += 1
        } else {
            r -= 1
        }
    }
    return result
}


func addBinary(_ a: String, _ b: String) -> String {
    var sum = ""
    var carryOver = 0
    var arrA = Array(Array(a).reversed())
    var arrB = Array(Array(b).reversed())
    for i in 0..<max(arrA.count,arrB.count){
        let a = arrA.count > i ? Int("\(arrA[i])")! : 0
        let b = arrB.count > i ? Int("\(arrB[i])")! : 0
        let total = a + b + carryOver
        sum = "\(total%2)\(sum)"
        carryOver = total / 2
        print(carryOver)
    }
    
    if carryOver == 1{
        sum = "1" + sum
    }
    return sum
}

func addToArrayForm(_ num: [Int], _ k: Int) -> [Int] {
    var ans = [Int]()
    var carry = 0
    var start = num.count - 1
    var n = k
    while start >= 0 || n > 0{
        var sum = (start >= 0 ? num[start]:0) + (n > 0 ? n%10:0) + carry
        ans.append(sum%10)
        carry = sum / 10
        start -= 1
        n /= 10
    }
    if carry > 0{
        ans.append(carry)
    }
    return ans.reversed()
}

func searchInsert(_ nums: [Int], _ target: Int) -> Int {
    var length =  nums.count
    var start = 0
    var end = length-1
    while start <= end{
        var mid = start + (end-start)/2
        if target == nums[mid]{
            return mid
        } else if target > nums[mid]{
            start = mid + 1
        } else {
            end = mid - 1
        }
    }
    return start
}

func shipWithinDays(_ weights: [Int], _ days: Int) -> Int {
    var sum = weights.reduce(0, +)
    var low = weights.max()
    var high = sum
    var ans = 0
    while low! <= high{
        var mid = low! + (high - low!)/2
        if checkNumberOfDays(weights,mid,days) {
            high = mid - 1
            ans = mid
        }else{
            low = mid + 1
        }
    }
    return ans
}

func checkNumberOfDays(_ arr: [Int],_ mid: Int,_ days:Int) -> Bool{
    var sum = 0
    var day = 1
    for i in 0..<arr.count{
        if arr[i] + sum <= mid{
            sum += arr[i]
        }else{
            sum = arr[i]
            day += 1
        }
    }
    if day <= days{
        return true
    }
    return false
}

func getMaximumGold(_ grid: [[Int]]) -> Int {
    var ans = 0
    for i in 0..<grid.count{
        for j in 0..<grid[0].count{
            if grid[i][j] != 0{
                ans = max(ans,traverseGridForMaxGold(i,j,grid))
            }
        }
    }
    return ans
}

func traverseGridForMaxGold(_ i: Int,_ j : Int,_ grid : [[Int]]) -> Int{
    var grid = grid
    if i < 0 || i == grid.count || j < 0 || j == grid[0].count || grid[i][j] == 0{
        return 0
    }
    var cur = grid[i][j]
    grid[i][j] = 0
    var ans = cur
    var ans1 = 0
    ans1 = max(ans1, traverseGridForMaxGold(i-1, j, grid))
    ans1 = max(ans1,traverseGridForMaxGold(i+1, j, grid))
    ans1 = max(ans1,traverseGridForMaxGold(i, j-1, grid))
    ans1 = max(ans1,traverseGridForMaxGold(i, j+1, grid))
    ans += ans1
    grid[i][j] = cur
    return ans
    
}

func maxProfit(_ prices: [Int]) -> Int {
    var length = prices.count
    var profit = 0
    var minimum = prices[0]
    for i in 1..<length{
        let cost = prices[i] - minimum
        profit = max(profit, cost)
        minimum = min(minimum,prices[i])
    }
    return profit
}
       

func compress(_ chars: inout [Character]) -> Int {
    var count = chars.count
    var left = 0
    var right = 0
    var result = ""
    while left < count {
        var currOccCount = 0
        while left < count && right < count && chars[left] == chars[right] {
            currOccCount += 1
            right += 1
        }
        result += currOccCount == 1 ? "\(chars[left])" : "\(chars[left])\(currOccCount)"
        left = right
    }
    chars = Array(result)
    return result.count
}

func strStrAgain(_ haystack: String, _ needle: String) -> Int {
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
        var startIndex = haystack.index(haystack.startIndex, offsetBy: start)
        var endIndex = haystack.index(haystack.startIndex,offsetBy: end)
        var subString = haystack[startIndex...endIndex]
        if subString == needle{
            return start
        }
        start += 1
        end += 1
    }
    return -1
}

func findKthPositive(_ arr: [Int], _ k: Int) -> Int {
    var i = 1
    var j = 0
    var res = [Int]()
    while res.count != k{
        if j > arr.count-1  || arr[j] != i{
            res.append(i)
            i+=1
        } else{
            j += 1
            i += 1
        }
    }
    return res.last!
}

func minimumTime(_ time: [Int], _ totalTrips: Int) -> Int {
    var (left,right) = (0,time.max()! * totalTrips)
    var res = 0
    while left <= right{
        let mid = (left + right)/2
        var tripCover = 0
        for i in time{
            tripCover += mid/i
        }
        if tripCover >= totalTrips{
            res = mid
            right = mid-1
        }else{
            left = mid+1
        }
    }
        
    return res
}

func minEatingSpeed(_ piles: [Int], _ h: Int) -> Int {
    var low = 1
    var high = piles.max()!
    var ans = 0
    while low <= high{
        var mid = (low + high)/2
        var time = calculateTime(piles, mid)
        if time <= h{
            ans = mid
            high = mid-1
        }else{
            low = mid + 1
        }
    }
    return ans
}

func calculateTime(_ piles:[Int],_ mid: Int) -> Int {
    var sum = 0
    for i in 0..<piles.count{
        if piles[i]%mid != 0{
            sum += piles[i]/mid + 1
        }else{
            sum += piles[i]/mid
        }
    }
    return sum
}


func maximumCandies(_ candies: [Int], _ k: Int) -> Int {
    var total = candies.reduce(0, +)
    var low = 0
    var ans = 0
    var high = total/k
    if high == 1{
        return 1
    }
    while low <= high{
        var mid = low + (high-low)/2
        var sum = 0
        for i in 0..<candies.count{
            if mid > 0{
                sum += candies[i]/mid
            }
        }
        if sum >= k{
            ans = max(ans, mid)
            low = mid + 1
        }else{
            high = mid - 1
        }
    }
    return ans
}

func vowelStrings(_ words: [String], _ left: Int, _ right: Int) -> Int {
    var vowels = ["a","e","i","o","u"]
    var result = [String]()
    for i in left...right{
        if vowels.contains(String(words[i].first!)) && vowels.contains(String(words[i].last!)){
            result.append(words[i])
        }
    }
    return result.count
}


func maxScore(_ nums: [Int]) -> Int {
    var nums = nums.sorted().reversed()
    var maxScore = 0
    var prefixSum = 0
    for i in nums{
        prefixSum += i
        if prefixSum > 0{
            maxScore += 1
        } else{
            prefixSum = 0
        }
    }
    return maxScore
}


func beautifulSubarrays(_ nums: [Int]) -> Int {
    var x = 0
    var count = 0
    var map = [Int:Int]()
    map[x,default: 0] += 1
    for i in 0..<nums.count{
        x ^= nums[i]
        map[x,default:0] += 1
        count += map[x]! - 1
    }
    return count
}

func evenOddBit(_ n: Int) -> [Int] {
    var n = n
    var arr = [Int]()
    var result = [Int]()
    var i = 0
    while n > 0{
        arr.append(n%2)
        n = n/2
        i+=1
    }
    var even = 0
    var odd = 0
    for i in 0..<arr.count{
        if arr[i] == 1{
           if  i % 2 == 0{
                even += 1
            }else{
                odd += 1
            }
        }
    }
    result.append(even)
    result.append(odd)
    return result
}

func checkValidGrid(_ grid: [[Int]]) -> Bool {
    var board = Array(repeating: Array(repeating: -1, count: grid[0].count), count: grid.count)
    let moveInX = [2,1,-1,-2,-2,-1,1,2]
    let moveInY = [1,2,2,1,-1,-2,-2,-1]
    board[0][0] = 0
    var pos = 1
    return solverKnightBoard(grid,pos,0,0,moveInX,moveInY,&board)
}

func isSafe(_ curX: Int,_ curY:Int,_ board: [[Int]]) -> Bool{
    if curX >= 0 && curY >= 0 && curX < board.count && curY < board[0].count && board[curX][curY] == -1{
        return true
    }
    return false
}

func solverKnightBoard(_ grid : [[Int]],_ pos: Int,_ curX: Int,_ curY:Int,_ moveInX: [Int], _ moveInY: [Int],_ board:inout [[Int]]) -> Bool{
    if pos == grid.count * grid.count{
        return true
    }
    for i in 0..<8{
       var new_x = curX + moveInX[i]
       var new_y = curY + moveInY[i]
        if isSafe(new_x, new_y, board) {
            board[new_x][new_y] = pos
            if solverKnightBoard(grid, pos+1, new_x, new_y, moveInX, moveInY, &board){
                return true
            }
            board[new_x][new_y] = -1
        }
        
    }
    return false
}

func zeroFilledSubarray(_ nums: [Int]) -> Int {
    var count = 1
    var length = 0
    for index in 0..<nums.count{
        if (nums[index] == 0){
            length += count
            count += 1
        } else {
            count = 1
        }
    }
    return length
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
//newJump(5,[30,10,60,10,60,50])
//kthSmallest([[1,5,9],[10,11,13],[12,13,15]],8)
//maxArea(5,4,[1,2,4],[1,3])
//countPoints([[1,3],[3,3],[5,3],[2,2]],[[2,3,1],[4,3,1],[1,1,2]])
//restoreMatrix([3,8],[4,7])
//maxIncreaseKeepingSkyline([[3,0,8,4],[2,4,5,7],[9,2,6,3],[0,3,1,0]])
//groupThePeople([3,3,3,3,3,1,3])
//makeGood("leEeetcode")
//restoreArray([[4,-2],[1,4],[-3,1]])
//numIdenticalPairs([1,2,3,1,1,3])
//buildArray([0,2,1,5,3,4])
//countDistinctIntegers([1,13,10,12,31])
//maxSum([[6,2,1,3],[4,2,1,5],[9,2,8,7],[4,1,2,9]])
//matrixBlockSum([[1,2,3],[4,5,6],[7,8,9]], 1)
//sumSubarrayMins([3,1,2,4])
//kSmallestPairs([1,1,2],[1,2,3],3)
//findWinners([[1,3],[2,3],[3,6],[5,6],[5,7],[4,5],[4,8],[4,9],[10,4],[10,9]])
//wateringPlants([2,2,3,3], 5)
//evaluate("(name)is(age)yearsold", [["name","bob"],["age","two"]])
//combinationSum3(3, 7)
//uniqueOccurrences([1,2,2,1,1,3])
//findDuplicates([4,3,2,7,8,2,3,1])
//peakIndexInMountainArray([0,2,1,0])
//combinationSum([2,3,6,7], 7)
//maxProfitAssignment([2,4,6,8,10],[10,20,30,40,50],[4,5,6,7])
//maxProfitAssignment([85,47,57], [24,66,99], [40,25,25])
//dailyTemperatures([73,74,75,71,69,72,76,73])
//dailyTemperatures([30,40,50,60])
//canVisitAllRooms([[1],[2],[3],[]])
//possibleBipartition(4,[[1,2],[1,3],[2,4]])
//answerQueries([4,5,2,1], [3,10,21])
//canJump([2,3,1,1,4])
//canReach([4,2,3,0,3,1,2], 5)
//minJumps([100,-23,-23,404,100,23,23,23,3,404])
//maximumBags([2,3,4,5], [1,2,4,4], 2)
//minStoneSum([10000],1000)
//nextGreaterElement([7, 12, 1, 20],[7, 12, 1, 20])
//nextGreaterElement(123)
//wordPattern("abba","dog cat cat dog")
//countDigits(121)
//distinctPrimeFactors([2])
//minimumPartition("165462", 60)
//closestPrimes(10, 19)
//detectCapitalUse("FlaG")
//combinationSum([2,3,6,7], 7)
//combinationSum2([10,1,2,7,6,1,5], 8)
//subsetsWithDup([1,2,3])
//permute([1,2,3])
//letterCombinations("")
//minDeletionSize(["cba","daf","ghi"])
//insert([[1,3],[6,9]], [2,5])
//combine(4, 2)
//minimumRounds([2,2,3,3,2,4,4,4,4,4])
//var arr2 = [1,1,1,2,2,3]
//removeDuplicates(&arr2)
//multiply("123", "456")
//restoreIpAddresses("25525511135")
//findMinArrowShots([[10,16],[2,8],[1,6],[7,12]])
//minWindow("ADOBECODEBANC", "ABC")
//maxIceCream([1,3,2,4,1], 7)
//canCompleteCircuit([1,2,3,4,5], [3,4,5,1,2])
//singleNonDuplicate([1,1,2,3,3,4,4,8,8])
//singleNonDuplicate([1,1,2,2,3])
//maximumCount([-2,-1,-1,1,2,3])
//maximumCount([-3,-2,-1,0,0,1,2])
//maximumCount([5])
//maxKelements([1,10,3,3,3], 3)
//maxKelements([10,10,10,10,10], 5)
//isItPossible("ab", "abcc")
//maxPoints([[1,1],[2,2],[3,3]])
//checkValidString("************************************************************")
//numTeams([2,5,3,4,1])
//maxSubarraySumCircular([1,-2,3,-2])
//findSubsequences([4,6,7,7])
//findSubsequences([4,4,3,2,1])
//maxJump([0,2,5,6,7])
//partition("aab")
//fourSumCount([1,2],[-2,-1],[-1,2],[0,2])
//countPrimes(10)
//trailingZeroes(3)
//increasingTriplet([5,4,3,2,1])
//threeSumClosest([-1,2,1,-4], 1)
//canArrange([1,2,3,4,5,10,6,7,8,9],5)
//jump([2,3,1,1,4])
//findTheArrayConcVal([7,52,2,4])
//findTheArrayConcVal([5,14,13,8,12])
//countFairPairs([1,7,9,2,5], 11, 11)
//addBinary("14", "1")
//addToArrayForm([1,2,0,0],34)
//searchInsert([1,3,5,6],5)
//shipWithinDays([1,2,3,4,5,6,7,8,9,10],5)
//getMaximumGold([[0,6,0],[5,8,7],[0,9,0]])
//getMaximumGold([[1,0,7],[2,0,6],[3,4,5],[0,3,0],[9,0,20]])
//maxProfit([7,1,5,3,6,4])
var arr4 = ["a","2","b","2","c","3"]
//compress(&arr4)
//strStrAgain("sadbutsad", "sad")
//getSmallestString([1,3,5,2,7,5],1,5)
//findKthPositive([2,3,4,7,11],5)
//minimumTime([1,2,3], 5)
//minEatingSpeed([3,6,7,11], 8)
//maximumCandies([5,8,6], 3)
//
//vowelStrings(["hey","aeo","mu","ooo","artro"], 1, 4)
//vowelStrings(["are","amy","u"],0,2)
//maxScore([2,-1,0,1,-3,3,-3])
//beautifulSubarrays([4,3,1,2,4])
//evenOddBit(17)
//checkValidGrid([[0,11,16,5,20],[17,4,19,10,15],[12,1,8,21,6],[3,18,23,14,9],[24,13,2,7,22]])
//checkValidGrid([[0,13,1,7,20],[3,8,19,12,15],[18,2,14,21,6],[9,4,23,16,11],[24,17,10,5,22]])
zeroFilledSubarray([1,3,0,0,2,0,0,4])
