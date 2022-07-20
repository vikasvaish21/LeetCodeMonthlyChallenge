import Foundation
class Solution {
    func runningSum(_ nums: [Int]) -> [Int] {
        let length = nums.count
        var sum = [Int](repeating: 0, count: nums.count)
        sum[0] = nums[0]
        for i in 1..<length{
            sum[i] = sum[i-1] + nums[i]
        }
        return sum
    }
    
    
    func transpose(_ matrix: [[Int]]) -> [[Int]] {
        if matrix.count == 0{
            return matrix
        }
        var arr = Array(repeating: Array(repeating: 0, count: matrix.count), count: matrix[0].count)
        let col = matrix.count
        let row = matrix[0].count
        for i in 0..<col{
            for j in 0..<row{
                arr[j][i] = matrix[i][j]
            }
        }
        return arr
    }
    
    
    func removePalindromeSub(_ s: String) -> Int {
        let arr = Array(s)
        var length = arr.count - 1
        var i = 0
        while i < length{
            if arr[i] != arr[length]{
                return 2
            }
            length -= 1
            i += 1
        }
        return 1
    }
    
    func lengthOfLongestSubstring(_ s: String) -> Int {
        let length = s.count
        let s = Array(s)
        var arr = [Character]()
        var maxi = 0
        for i in 0..<length{
            if arr.contains(s[i]),let firstIndex = arr.firstIndex(of: s[i]){
                maxi =  max(maxi, arr.count)
                arr.removeSubrange(0...firstIndex)
            }
            arr.append(s[i])
        }
        return max(maxi,arr.count)
    }
    
    
        func minOperations(_ nums: [Int], _ x: Int) -> Int {
            let sum = nums.reduce(0) { return $0 + $1 }
            if sum == x {
                return nums.count
            }
            
            let leftover = sum - x
            
            guard let result = maxSubarrayLength(with: leftover, array: nums) else {
                return -1
            }
            
            return nums.count - result
        }
        
        func maxSubarrayLength(with sum: Int, array: [Int]) -> Int? {
            var result: Int?
            
            var firstSumPositions = [Int : Int]()
            firstSumPositions[0] = -1
            
            var currentSum = 0
            for i in 0 ..< array.count {
                currentSum += array[i]
//                print(firstSumPositions[currentSum - sum])
                if let firstSumPosition = firstSumPositions[currentSum - sum] {
                    if let validResult = result {
                        result = max(validResult, i - firstSumPosition)
                    } else {
//                        print(i,firstSumPosition)
                        result = i - firstSumPosition
//                        print(result)
                    }
                }
                
                firstSumPositions[currentSum] = i
//                print(firstSumPositions)
            }
            
            return result
        }
    
    func minDistance(_ word1: String, _ word2: String) -> Int {
        var dp = Array(repeating: Array(repeating: 0, count: word2.count+1), count: word1.count+1)
        let word1 = Array(word1)
        let word2 = Array(word2)
        let len1 = word1.count
        let len2 = word2.count
        for i in 1...len1{
            for j in 1...len2{
                if i == 0 || j==0 {
                    continue
                }
                if word1[i-1] == word2[j-1]{
                    dp[i][j] = 1 + dp[i-1][j-1]
                } else{
                    dp[i][j] = max(dp[i-1][j],dp[i][j-1])
                }
            }
        }
        let lcsLen = dp[word1.count][word2.count]
        return word1.count - lcsLen + word2.count - lcsLen
    }
    
    func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        var arr = Array(repeating: Array(repeating: 0, count: text2.count+1),count: text1.count+1)
        let text1 = Array(text1)
        let text2 = Array(text2)
        for i in 1...text1.count{
            for j in 1...text2.count{
                if i == 0 || j == 0 {
                    continue
                }
                if text1[i-1] == text2[j-1]{
                    arr[i][j] = 1 + arr[i-1][j-1]
                } else{
                    arr[i][j] = max(arr[i][j-1], arr[i-1][j])
                }
            }
        }
        let lcsLen = arr[text1.count][text2.count]
        return lcsLen
    }
    
    var vowel = ["a","e","i","o","u"]
    func countVowelStrings(_ n: Int) -> Int {
        var result = 0
        for i in vowel{
            result += countVowel(n-1, i)
        }
        return result
    }
    
    func countVowel( _ n: Int,_ lastElement: String) -> Int{
        if n == 0{
            return 1
        }
        var temp = 0
        for i in vowel{
            if lastElement >= i{
                temp+=countVowel(n-1, i)
            }
        }
        return temp
    }
    
    func minimumLengthEncoding(_ words: [String]) -> Int {
        var words = words
        words.sort(by: {$0.count > $1.count})
        var encoded = ""
        for i in 0..<words.count{
            if !encoded.contains(words[i]+"#"){
                encoded += words[i] + "#"
            }
        }
        print(encoded)
        return encoded.count
    }
    
    func minDeletions(_ s: String) -> Int {
        var map = [Character:Int]()
        var setArr = Set<Int>()
        var result = 0
        for i in s{
            map[i,default: 0] += 1
        }
        for (key,value) in map{
            if setArr.contains(value){
                var count = value - 1
                while count > 0{
                    if setArr.contains(count) == false{
                        break
                    }
                    count -= 1
                    
                }
                result += value - count
                setArr.insert(count)
            }else{
                setArr.insert(value)
            }
        }
        return result
    }
    
    
    func reconstructQueue(_ people: [[Int]]) -> [[Int]] {
        let length = people.count
        var people = people
//    MARK: -   1. First Sort the Array on the basis of first element of inside Array
        people = people.sorted{return $0[0] < $1[0]}
//    MARK: -   2. Create Result Array to store the Sequence
        var result = Array(repeating: Array(repeating: -1, count: 2), count: length)
//    MARK: -   3. First loop to triverse the second element of inside Array
        for i in 0..<length{
//    MARK: -   4. Store the second element Value in Count
            var count = people[i][1]
            for j in 0..<length{
                //    MARK: - 4. check the result Array to carries value or not And Count is 0 then value of inside array used to be stored on current index
                if result[j][0] == -1 && count == 0{
                    result[j][0] = people[i][0]
                    result[j][1] = people[i][1]
                    break
                    //    MARK: - 4. If result array current index not carry any value or people array current index which used be height if that height is less than or equal to result current index height that count decrease by -1
                } else if result[j][0] == -1  || people[i][0] <= result[j][0]{
                    count -= 1
                }
            }
        }
        //    MARK: - 4. return result array
        return result
    }
    
    // MARK: Brute force
//
//    func minMoves2(_ nums: [Int]) -> Int {
//        var arr = [Int]()
//        for i in nums{
//            var totalSteps = 0
//            for j in nums{
//                totalSteps += abs(i-j)
//            }
//            arr.append(totalSteps)
//        }
//        return arr.min()!
//    }
    
    // MARK: Two pointer
    func minMoves2(_ nums: [Int]) -> Int {
        let nums = nums.sorted()
        var start = 0
        var sum = 0
        var end = nums.count-1
        while start < end{
            sum += nums[end] - nums[start]
            start+=1
            end-=1
        }
        return sum
    }
    
}



var sol = Solution()
//sol.runningSum([1,2,3,4])
//sol.transpose([[1,2,3],[4,5,6]])
//sol.removePalindromeSub("abb")
//sol.lengthOfLongestSubstring("pwwkew")
//sol.minOperations([1,1,4,2,3],5)
//sol.minDistance("sea","eat")
//sol.longestCommonSubsequence("abcde", "ace")
//sol.countVowelStrings(2)
//sol.minimumLengthEncoding(["feipyxx","e"])
//sol.minDeletions("aaabbbcc")
//sol.reconstructQueue([[7,0],[4,4],[7,1],[5,0],[6,1],[5,2]])
sol.minMoves2([1,10,2,9])
