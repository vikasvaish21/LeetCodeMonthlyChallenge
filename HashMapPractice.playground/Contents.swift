import UIKit
import Foundation
func convert(string : String) -> Int{
    let valueMap = ["1" as Character:1,"3":3,"7":7,]
    var total = 0
    for (index,value) in string.enumerated() {
        let exponent  = string.count - index - 1
        if let value  = valueMap[value]{
            total += value*(10^exponent)
        }
            
    }
    string.forEach{
        (c) in
        print(c)
    }
    return total
}

func solveLetterCombination(_ digits: String,_ index:Int,_ letters: [String],_ ans:inout [String], _ result: inout String) {
    if index >= digits.count{
        print(result)
        ans.append(result)
        
        return
    }
    let digit:[Int] = digits.compactMap{Int(String($0))}
    let number  = digit[index]
    let value  = Array(letters[number])
    for i in 0..<value.count{
        result.append(String(value[i]))
        solveLetterCombination(digits, index+1, letters, &ans ,&result)
        result.popLast()
    }
}

func letterCombinations(_ digits: String) -> [String] {
    if digits.isEmpty{
        return []
    }
    let index = 0
    var ans = [String]()
    var result = String()
    let letters = ["","","abc","def","ghi","jkl","mno","pqrs","tuv","wxyz"]
    solveLetterCombination(digits,index,letters,&ans,&result)
    return ans
}


func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    
    var x:Double = 0.0
    var y:Double = 0.0
    let left = nums1
    let right = nums2
    let orderedArray = merge(left, right)
    if orderedArray.count % 2 == 0 {
        x = Double(orderedArray[orderedArray.count / 2])
        y = Double(orderedArray[(orderedArray.count / 2) - 1])
        return (x + y) / 2.0
    } else {
        return Double(orderedArray[orderedArray.count / 2])
    }
}

func merge(_ left:[Int],_ right:[Int]) -> [Int] {
    var orderedArray = [Int]()
    var leftIndex = 0
    var rightIndex = 0
    while leftIndex < left.count && rightIndex < right.count{
        if left[leftIndex] <= right[rightIndex]{
            orderedArray.append(left[leftIndex])
            leftIndex+=1
        } else if left[leftIndex] >= right[rightIndex]{
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
let dict :[Character:Int] = ["I":1,"V":5,"X":10,"L":50,"C":100,"D":500,"M":1000]
func romanToInt(_ s: String) -> Int {
    var prev = 0
    var out = 0
    for i in s{
        let val = dict[i] ?? 0
        out += val <= prev ? prev : -prev
        prev = val
        print(prev)
    }
    out += prev
    return out
}

func spiralOrder(_ matrix: [[Int]]) -> [Int] {
    
    guard  !matrix.isEmpty else {
            return []
        }
    var top = 0
    var right = matrix[0].count - 1
    var bottom = matrix.count - 1
    var leftBottom = 0
    var direction = 0
    var arr = [Int]()
    while top <= bottom && leftBottom <= right {
        if direction == 0{
            for i in top...right {
                arr.append(matrix[top][i])
            }
            top += 1
        }
        if direction == 1{
            for j in top...bottom {
                arr.append(matrix[j][right])
            }
            right -= 1
        }
        if direction == 2{
            for l in stride(from: right, to: leftBottom-1, by: -1) {
                arr.append(matrix[bottom][l])
            }
            bottom -= 1
        }
        if direction == 3{
            for k in stride(from: bottom, to: top-1, by: -1) {
                arr.append(matrix[k][leftBottom])
            }
            leftBottom += 1
        }
        direction = (direction+1)%4
    }
    return arr
}

func islandPerimeter(_ grid: [[Int]]) -> Int {
    var row = grid.count
    var col = grid[0].count
    var parimeter = 0
    for i in 0..<row{
        for j in 0..<col{
            if grid[i][j]==1{
                parimeter += 4
                if i>0 && grid[i-1][j] == 1{
                    parimeter -= 2
                }
                if j>0 && grid[i][j-1] == 1{
                    parimeter -= 2
                }
            }
        }
    }
    return parimeter
}


var dictionary: [String:String] = [:]
dictionary["FirstName"] = "Steve"

func naiveHash(_ string: String) -> Int {
    let unicodeScalers = string.unicodeScalars.map{$0.value}
    return Int(unicodeScalers.reduce(0,+))
}


func findTwoSumHash(inputArray: [Int],sum:Int) {
    var dict : [Int:Int] = [:]
    var result = [Int]()
    for i in inputArray{
        let difference = sum - i
        print(dict)
        if difference < i{
        if let _ = dict[difference]{
            print("(\(i), \(difference))")
        }
        dict[i] = i
        }
    }
}

func arrayChange(_ nums: [Int], _ operations: [[Int]]) -> [Int] {
    var map: [Int:Int] = [:]
    var nums = nums
    for element in 0..<nums.count{
        map[nums[element]] = element
    }
    print(map)
    for i in operations{
        nums[map[i[0]] ?? 0] = i[1]
        map[i[1]] =  map[i[0]]
    }
    print(map)
    return nums
}
//
func setZeroes(_ matrix: inout [[Int]]) {
    let row = matrix.count
    let col = matrix[0].count
    var rowCache = [Int:Bool]()
    var colCache = [Int:Bool]()
    if row == 0 || col == 0 {
        return
    }
    
    for i in 0..<row{
        for j in 0..<col{
            if matrix[i][j] == 0{
                rowCache[i] = true
                colCache[j] = true
            }
        }
    }

    for i in 0..<row{
        for j in 0..<col{
            if rowCache[i] == true || colCache[j] == true{
                matrix[i][j] = 0
            }
        }
    }
}



//func setZeroes(_ matrix: inout [[Int]]) {
//        if matrix.count == 0 || matrix.first!.count == 0 {
//            return
//        }
//
//        var rowCache = [Int:Bool]()
//        var colCache = [Int:Bool]()
//
//        for i in 0..<matrix.count {
//            for j in 0..<matrix.first!.count {
//                if matrix[i][j] == 0 {
//                    rowCache[i] = true
//                    colCache[j] = true
//                }
//            }
//        }
//        for i in 0..<matrix.count {
//            for j in 0..<matrix.first!.count {
//                if rowCache[i] == true || colCache[j] == true {
//                    matrix[i][j] = 0
//                }
//            }
//        }
//
//    }

class WordFilter {
    var dict = [[String]:Int]()
    init(_ words: [String]) {
        for (index,word) in words.enumerated(){
            var word = Array(word)
            for i in 0..<word.count{
                let prefix = String(word[0...i])
                for j in 0..<word.count{
                    let suffix = String(word[j..<word.count])
                    dict[[prefix,suffix]] = index
                    
                }
            }
        }
        
    }
    
    func f(_ prefix: String, _ suffix: String) -> Int {
        if let index = dict[[prefix,suffix]]{
            return index
        }
        return -1
    }
}
                           
                           
                           
                           
//convert(string: "1337")
//letterCombinations("23")
//findMedianSortedArrays([1,3], [2])
//romanToInt("LVIII")
//spiralOrder([[1,2,3,4],[5,6,7,8],[9,10,11,12]])
//spiralOrder([[1,2,3],[4,5,6],[7,8,9]])
//islandPerimeter([[0,1,0,0],[1,1,1,0],[0,1,0,0],[1,1,0,0]])
//naiveHash("bac")
//findTwoSumHash(inputArray: [0,0,3,4], sum: 0)
//arrayChange([1,2,4,6],[[1,3],[4,7],[6,1]])
//var words = ["apple","appe"]
//let obj = WordFilter(words)
//let ret_1: Int = obj.f("a", "e")
var arr = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]
setZeroes(&arr)
