
//MARK: - 754. Reach a Number
func reachNumber(_ target: Int) -> Int {
    var target = abs(target)
    var position = 0,step = 0
    while position < target{
        step += 1
        position+=step
    }
    while (position - target) % 2 == 1{
        step += 1
        position+=step
    }
    return step
}

//MARK: - 74. Search a 2D Matrix

//func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
//    var row = matrix.count
//    var col = matrix[0].count
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
    if matrix.count == 0 || matrix[0].count == 0{
        return false
    }
    var row = matrix.count
    var col = matrix[0].count
    var startIndex = 0
    var endIndex = (row * col)-1
    while startIndex <= endIndex{
        var midIndex =  startIndex + (endIndex-startIndex)/2
        var midValue = matrix[midIndex/col][midIndex%col]
        if midValue == target{
            return true
        } else if  midValue < target{
            startIndex = midIndex + 1
        } else if midValue > target {
            endIndex = midIndex - 1
        }
    }
    return false
}

//MARK: - 81. Search in Rotated Sorted Array II
func search(_ nums: [Int], _ target: Int) -> Bool {
    var start = 0
    var end = nums.count - 1
    while start <= end{
        if nums[start] == target || nums[end] == target {
            return true
        } else if nums[start] < target{
            while start < end && nums[start+1] == nums[start]{
                start = start + 1
            }
            start = start + 1
        } else if nums[end] > target{
            while start < end && nums[end-1] == nums[end]{
                end = end - 1
            }
            end = end - 1
        } else{
            break
        }
    }
    return false
}

//MARK: - 209. Minimum Size Subarray Sum

func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
    var end = nums.count-1
    var sum = 0
    var cur = 0
    var prev = 0
    var result = Int.max
    
    while cur <= end{
        sum += nums[cur]
        while sum >= target{
            sum -= nums[prev]
            result = min(result, cur-prev)
            prev+=1
        }
        cur+=1
    }
    return result == Int.max ? 0 : result+1
}

reachNumber(3)
searchMatrix([[1,3,5,7],[10,11,16,20],[23,30,34,60]], 13)
search([2,5,6,0,0,1,2], 0)
minSubArrayLen(7, [2,3,1,2,4,3])
