import UIKit
import Foundation
import CoreFoundation

func updateMatrix(_ mat: [[Int]]) -> [[Int]] {
    
    let row = mat.count
    let col = mat[0].count
    var dp = Array(repeating: Array(repeating: Int.max - 10000, count :col),count: row)
    for i in 0..<row{
        for j in 0..<col{
            if mat[i][j] == 0 {
                dp[i][j] = 0
            } else {
                if i > 0{
                    dp[i][j] = min(dp[i][j], dp[i-1][j]+1)
                }
                if j > 0{
                    dp[i][j] = min(dp[i][j], dp[i][j-1]+1)
                }
            }
        }
    }
    
    for i in (0..<row).reversed(){
        for j in (0..<col).reversed(){
            if mat[i][j] == 0 {
                dp[i][j] = 0
            } else {
                if i < row-1{
                    dp[i][j] = min(dp[i][j], dp[i+1][j]+1)
                }
                if j < col-1{
                    dp[i][j] = min(dp[i][j], dp[i][j+1]+1)
                }
            }
        }
    }
    return dp
}
//updateMatrix([[0,1,1,0],[1,1,0,0],[0,0,1,1]])

updateMatrix([[0,0,0],[0,1,0],[1,1,1]])


//func frogJump(_ n: Int,_ arr: [Int],_ k:Int) -> Int{
//    if n == 0 {
//        return 0
//    }
//    var minStep  = Int.max
//    var right = Int.max
//    var jump = Int.max
//    for j in 1...k{
//        if n >= 0{
//            jump = frogJump(n-j, arr, k) + arr[n] - arr[n-j]
//        }
//    }
//    return jump
//}

//  MARK:  with DP

//func frogJump(_ n: Int,_ arr: [Int],_ k:Int,_ dp :inout [Int:Int]) -> Int{
//
//    if n == 0 {
//        return 0
//    }
//    if let val = dp[n]{
//        return val
//    }
//    var minStep = Int.max
//    for j in 1...k{
//        if n - j >= 0{
//            let jump = frogJump(n-j, arr, k, &dp) + abs(arr[n] - arr[n-j])
//            minStep = min(minStep,jump)
//        }
//    }
//    dp[n] = minStep
//    print(dp)
//    return dp[n] ?? 0
//}
//
//func frogJumpwithDp(_ n: Int,_ arr: [Int],_ k:Int) -> Int  {
//    var dp = [Int:Int]()
//    return frogJump(n-1, arr, k,&dp)
//}
//var height = [30,10,60,10,60,50]
//frogJumpwithDp(height.count, height, 2)


//  MARK:  with Tabulation


func frogJump(_ n: Int,_ arr: [Int],_ k:Int,_ dp :inout [Int:Int]) -> Int{
    dp[0] = 0
    for i in 1...n{
       var  minStep = Int.max
        for j in 1...k{
            if i - j >= 0{
                let jump = dp[i-j]! + abs(arr[i] - arr[i-j])
                minStep = min(minStep,jump)
            }
        }
        dp[i] = minStep
    }
    
    return dp[n] ?? 0
}

func frogJumpwithDp(_ n: Int,_ arr: [Int],_ k:Int) -> Int  {
    var dp = [Int:Int]()
    return frogJump(n-1, arr, k,&dp)
}
// MARK: By DP
//func maxRobbery(_ n: Int,_ nums:[Int],_ dp: inout [Int:Int]) -> Int{
//
//    if let val = dp[n]{
//        return val
//    }
//    if n == 0 {
//        return nums[n]
//    }
//    if n < 0 {
//        return 0
//    }
//    let pick = nums[n] + maxRobbery(n-2,nums, &dp)
//    let notPick = 0 + maxRobbery(n-1, nums, &dp)
//    dp[n] = max(pick, notPick)
//    return dp[n] ?? 0
//}
// MARK: By Tabulation

//func maxRobbery(_ n: Int,_ nums:[Int],_ dp: inout [Int:Int]) -> Int{
//
//    dp[0] = nums[0]
//    if nums.count == 1{
//        return nums[0]
//    }
//    for i in 1...n{
//        var notPick = Int.min
//        var pick = nums[i]
//        if i > 1{
//            pick += dp[i-2]!
//        }
//        notPick = 0 + dp[i-1]!
//        dp[i] = max(pick, notPick)
//    }
//    return dp[n] ?? 0
//}

// MARK: By Tabulation woth memory optimization

//func maxRobbery(_ n: Int,_ nums:[Int],_ dp: inout [Int:Int]) -> Int{
//
//    var prev = nums[0]
//    var prev2 = 0
//    if nums.count == 1{
//        return nums[0]
//    }
//    for i in 1...n{
//        var notPick = Int.min
//        var pick = nums[i]
//        if i > 1{
//            pick += prev2
//        }
//        notPick = 0 + prev
//        var curr = max(pick, notPick)
//        prev2 = prev
//        prev = curr
//    }
//    return prev
//}
//
//func rob(_ nums: [Int]) -> Int {
//    var dp = [Int:Int]()
//    return maxRobbery(nums.count - 1, nums,&dp)
//}

// MARK: - House robber 2 space optimization solution

func maxRobbery(_ n: Int,_ nums:[Int]) -> Int{

    var prev = nums[0]
    var prev2 = 0
    if nums.count == 1{
        return nums[0]
    }
    for i in 1...n{
        var pick = nums[i]
        if i > 1{
            pick += prev2
        }
        let notPick = 0 + prev
        let curr = max(pick, notPick)
        prev2 = prev
        prev = curr
    }
    return prev
}

func rob(_ nums: [Int]) -> Int {
    var temp1 = [Int]()
    var temp2 = [Int]()
    if nums.count == 1{
        return nums[0]
    }
    for i in 0..<nums.count{
        if i != 0{
            temp1.append(nums[i])
        }
        if i != nums.count-1{
            temp2.append(nums[i])
        }
    }
    return max(maxRobbery(temp1.count - 1, temp1),maxRobbery(temp2.count - 1, temp2))
}


//func ninjaTraining(_ n: Int,_ arr: [[Int]],_ last: Int)-> Int{
//    var maxi = 0
//    if n == 0{
//        for i in 0...2{
//            if i != last{
//                maxi = max(maxi,arr[0][i])
//            }
//        }
//        return maxi
//    }
//
//    for i in 0...2{
//        if i != last{
//            let points = arr[n][i] + ninjaTraining(n-1, arr, i)
//            maxi = max(maxi,points)
//        }
//    }
//    return maxi
//}



// MARK: using memoization
//func ninjaTraining(_ n: Int,_ arr: [[Int]],_ last: Int,_ dp : inout [[Int]])-> Int {
//    var maxi = 0
//    if dp[n][last] != -1 {
//        return dp[n][last]
//    }
//
//    if n == 0{
//        for i in 0...2{
//            if i != last{
//                maxi = max(maxi,arr[0][i])
//            }
//        }
//        dp[n][last] = maxi
//        return dp[n][last]
//    }
//
//    for i in 0...2{
//        if i != last{
//            let points = arr[n][i] + ninjaTraining(n-1, arr, i, &dp)
//            maxi = max(maxi,points)
//        }
//    }
//    dp[n][last] = maxi
//    return dp[n][last]
//}

// MARK: using Tabulation

//func ninjaTraining(_ n: Int,_ arr: [[Int]],_ last: Int,_ dp : inout [[Int]])-> Int {
//    if dp[n][last] != -1 {
//        return dp[n][last]
//    }
//
//    dp[0][0] = max(arr[0][1],arr[0][2])
//    dp[0][1] = max(arr[0][2],arr[0][0])
//    dp[0][2] = max(arr[0][0],arr[0][1])
//    dp[0][3] = max(arr[0][1],arr[0][2],arr[0][0])
//    for i in 1...n{
//        for last in 0..<4{
//            for task in 0..<3{
//                if last != task{
//                    let points = arr[i][task] + dp[i-1][task]
//                    dp[i][last] = max(dp[i][last],points)
//                }
//
//            }
//
//        }
//    }
//    return dp[n][3]
//}


// MARK: using Tabulation Space Optimization

func ninjaTraining(_ n: Int,_ arr: [[Int]],_ last: Int,_ dp : inout [Int])-> Int {
    dp[0] = max(arr[0][1],arr[0][2])
    dp[1] = max(arr[0][2],arr[0][0])
    dp[2] = max(arr[0][0],arr[0][1])
    dp[3] = max(arr[0][1],arr[0][2],arr[0][0])
    for i in 1...n{
        var temp = [Int](repeating: 0, count: 4)
        for last in 0..<4{
            for task in 0..<3{
                if last != task{
                    let points = arr[i][task] + dp[task]
                    temp[last] = max(temp[last],points)
                }
            }
            
        }
        dp = temp
    }
    return dp[3]
}


func training(_ arr: [[Int]]) -> Int{
    var dp = [Int](repeating: 0, count: 4)
    return ninjaTraining(arr.count-1, arr, 0,&dp)
}

// MARK: Brute Force Approach
//func path(_ m: Int, _ n: Int) -> Int {
//    if m == 0 && n == 0{
//        return 1
//    }
//    if m < 0 || n < 0{
//        return 0
//    }
//    var up = path(m-1,n)
//    var left = path(m,n-1)
//    return up + left
//}

// MARK: DP with Memoization

//func path(_ m: Int, _ n: Int,_ dp: inout [[Int]]) -> Int {
//    if m == 0 && n == 0{
//        return 1
//    }
//    if m < 0 || n < 0{
//        return 0
//    }
//    if dp[m][n] != -1 {
//        return dp[m][n]
//    }
//    let up = path(m-1,n, &dp)
//    let left = path(m,n-1, &dp)
//    dp[m][n] = up + left
//    return dp[m][n]
//}

// MARK: DP with Tabulation


//func path(_ m: Int, _ n: Int,_ dp: inout [[Int]]) -> Int {
//
//    for i in 0...m{
//        for j in 0...n{
//            if i == 0 && j == 0{
//                dp[i][j] = 1
//            }else{
//                var up = 0
//                var left = 0
//                if i>0{
//                    up = dp[i-1][j]
//                }
//                if j>0{
//                    left = dp[i][j-1]
//                }
//                dp[i][j] = up + left
//            }
//        }
//    }
//    return dp[m][n]
//}

// MARK: DP with Tabulation And Space Optimization


func path(_ m: Int, _ n: Int) -> Int {
    var prev = [Int](repeating: 0, count: n+1)
    for i in 0...m{
        var cur = [Int](repeating: 0, count: n+1)
        for j in 0...n{
            if i == 0 && j == 0{
                cur[j] = 1
            }else{
                var up = 0
                var left = 0
                if i>0{
                    up = prev[j]
                }
                if j>0{
                    left = cur[j-1]
                }
                cur[j] = up + left
            }
        }
        prev = cur
        
    }
    return prev[n]
}
//func uniquePaths(_ row:Int,_ col:Int) -> Int{
//    var dp = Array(repeating: Array(repeating: -1, count: col), count: row)
//    var arr = [Int](repeating: 0, count: col)
//    return path(row-1, col-1)
//}


// MARK: Path with obstacles with DP (memoization)
//func PathsWithObstacles(_ m : Int,_ n: Int,_ obstacleGrid : [[Int]],_ dp:inout [[Int]]) -> Int{
//
//
//    if m >= 0 && n >= 0 && obstacleGrid[m][n] == 1{
//        return 0
//    }
//    if m == 0 && n == 0{
//        return 1
//    }
//
//    if m < 0 || n < 0{
//        return 0
//    }
//    if dp[m][n] != -1{
//        return dp[m][n]
//    }
//    var up = PathsWithObstacles(m-1, n, obstacleGrid, &dp)
//    var left = PathsWithObstacles(m, n-1, obstacleGrid, &dp)
//    dp[m][n] =  up + left
//    return dp[m][n]
//}

// MARK: Path with obstacles with DP (Tabulation)
//func PathsWithObstacles(_ m : Int,_ n: Int,_ obstacleGrid : [[Int]],_ dp:inout [[Int]]) -> Int{
//
//    for i in 0...m{
//        for j in 0...n{
//            if i >= 0 && j >= 0 && obstacleGrid[i][j] == 1{
//                dp[i][j] = 0
//            } else if i == 0 && j == 0{
//                dp[i][j] = 1
//            }else{
//                var up = 0
//                var left = 0
//                if i > 0{
//                    up = dp[i-1][j]
//                }
//                if j > 0{
//                    left = dp[i][j-1]
//                }
//
//                dp[i][j] = up + left
//            }
//        }
//    }
//    return dp[m][n]
//}

// MARK: Path with obstacles with DP (Tabulation and space opimization)
func PathsWithObstacles(_ m : Int,_ n: Int,_ obstacleGrid : [[Int]]) -> Int{
    var prev = [Int](repeating: 0, count: n+1)
    for i in 0...m{
        var curr = [Int](repeating: 0, count: n+1)
        for j in 0...n{
            if i >= 0 && j >= 0 && obstacleGrid[i][j] == 1{
                curr[j] = 0
            } else if i == 0 && j == 0{
                curr[j] = 1
            }else{
                var up = 0
                var left = 0
                if i > 0{
                    up = prev[j]
                }
                if j > 0{
                    left = curr[j-1]
                }
                curr[j] = up + left
            }
        }
        prev = curr
    }
    return prev[n]
}

func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
    let m = obstacleGrid.count
    let n = obstacleGrid[0].count
//    var dp = Array(repeating: Array(repeating: -1, count: n), count: m)
    
    return PathsWithObstacles(m-1, n-1, obstacleGrid)
//    return 0
}

// MARK: min Path Sum by memoization

//func minPath(_ row : Int,_ col:  Int,_ grid: [[Int]],_ dp : inout [[Int]]) -> Int {
//    if row < 0 || col < 0{
//        return Int.max
//    }
//
//    if row == 0 && col == 0{
//        return grid[0][0]
//    }
//    if dp[row][col] != -1{
//        return dp[row][col]
//    }
//    var ans = Int.max
//    if row != 0  {
//        ans = min(grid[row][col] + minPath(row-1, col,grid, &dp),ans)
//
//    }
//    if col != 0{
//        ans = min(grid[row][col] + minPath(row, col-1,grid, &dp),ans)
//    }
//
//    dp[row][col] = ans
//    return dp[row][col]
//}


// MARK: min Path Sum by Tabulation
//func minPath(_ row : Int,_ col:  Int,_ grid: [[Int]],_ dp : inout [[Int]]) -> Int {
//    if row < 0 || col < 0{
//        return Int.max
//    }
//    var up = Int.max
//    var left = Int.max
//    for i in 0...row{
//        for j in 0...col{
//            if i == 0 && j == 0{
//                dp[i][j] = grid[0][0]
//            }else{
//                if i > 0 {
//                    up = grid[i][j] + dp[i-1][j]
//                }else{
//                    up = Int.max
//                }
//                if j > 0{
//                    left = grid[i][j] + dp[i][j-1]
//                } else{
//                    left = Int.max
//                }
//                dp[i][j] = min(up,left)
//            }
//        }
//    }
//    return dp[row][col]
//}

// MARK: min Path Sum by Tabulation with Space Optimization


func minPath(_ row : Int,_ col:  Int,_ grid: [[Int]],_ dp : inout [[Int]]) -> Int {
    if row < 0 || col < 0{
        return Int.max
    }
    var up = Int.max
    var left = Int.max
    var prev = [Int](repeating: 0, count: col+1)
    for i in 0...row{
        var cur = [Int](repeating: 0, count: col+1)
        for j in 0...col{
            if i == 0 && j == 0{
                cur[j] = grid[0][0]
            }else{
                if i > 0 {
                    up = grid[i][j] + prev[j]
                }else{
                    up = Int.max
                }
                if j > 0{
                    left = grid[i][j] + cur[j-1]
                } else{
                    left = Int.max
                }
                cur[j] = min(up,left)
            }
        }
        prev = cur
        print(prev)
    }
    return prev[col]
}

func minPathSum(_ grid:[[Int]]) -> Int{
    let row = grid.count
    let col = grid[0].count
    var dp = Array(repeating: Array(repeating: -1, count: col), count: row)
    return minPath(row-1, col-1,grid,&dp)
}

// MARK: Triangle (DP by memoization)
//func triangle(_ m: Int,_ n: Int,_ arr: [[Int]],_ dp: inout [[Int]]) -> Int{
//
//    if dp[m][n] != -1{
//        return dp[m][n]
//    }
//    if m == arr.count-1{
//        return arr[m][n]
//    }
//    let d = arr[m][n] + triangle(m+1,n,arr,&dp)
//    let dg = arr[m][n] + triangle(m+1,n+1,arr,&dp)
//    dp[m][n] = min(d,dg)
//    return dp[m][n]
//}


// MARK: Triangle (DP by Tabulation)

//func triangle(_ m: Int,_ n: Int,_ arr: [[Int]],_ dp: inout [[Int]]) -> Int{
//    let len = arr.count
//    if arr.count == 1{
//        return arr[0][0]
//    }
//    for j in 0..<len{
//        dp[len-1][j] = arr[len-1][j]
//    }
//    for i in (0...len-2).reversed(){
//        for j in (0...i).reversed(){
//            let d = arr[i][j] + dp[i+1][j]
//            let dg = arr[i][j] + dp[i+1][j+1]
//            dp[i][j] = min(d,dg)
//        }
//    }
//    return dp[0][0]
//}


// MARK: Triangle (DP by Tabulation and space optimization)
func triangle(_ m: Int,_ n: Int,_ arr: [[Int]]) -> Int{
    let len = arr.count
    var front = [Int](repeating: 0, count: len)
    if arr.count == 1{
        return arr[0][0]
    }
    for j in 0..<len{
        front[j] = arr[len-1][j]
    }
    for i in (0...len-2).reversed(){
        var cur = [Int](repeating: 0, count: len)
        for j in (0...i).reversed(){
            let d = arr[i][j] + front[j]
            let dg = arr[i][j] + front[j+1]
            cur[j] = min(d,dg)
        }
        front = cur
    }
    return front[0]
}


func minimumTotal(_ angle: [[Int]]) -> Int {
    let row = 0
    let col = 0
    var dp = Array(repeating: Array(repeating: 0, count: angle.count), count: angle.count)
    return triangle(row, col, angle)
}



//  MARK: minFallingPathSum

//func minFalling(_ i: Int,_ j: Int,_ m: Int,_ n: Int,_ matrix:[[Int]]) -> Int{
//    if j < 0 || j >= n{
//        return Int(1e9)
//    }
//    if i == 0{
//        return matrix[0][j]
//    }
//    let s = matrix[i][j] + minFalling(i-1,j,m,n,matrix)
//    let sl = matrix[i][j] + minFalling(i-1,j-1,m,n,matrix)
//    let sr = matrix[i][j] + minFalling(i-1,j+1,m,n,matrix)
//    var minValue = min(s, min(sl, sr))
//    return minValue
//
//}



 // MARK: minFallingPathSum (Memoization)
//func minFalling(_ i: Int,_ j: Int,_ m: Int,_ n: Int,_ dp: inout [[Int]],_ matrix:[[Int]]) -> Int{
//   if j < 0 || j >= n{
//       return Int(1e9)
//   }
//   if i == 0{
//       return matrix[0][j]
//   }
//   if dp[i][j] != -1{
//       return dp[i][j]
//   }
//   let s = matrix[i][j] + minFalling(i-1,j,m,n,&dp,matrix)
//   let sl = matrix[i][j] + minFalling(i-1,j-1,m,n,&dp,matrix)
//   let sr = matrix[i][j] + minFalling(i-1,j+1,m,n,&dp,matrix)
//   dp[i][j] = min(s, min(sl, sr))
//   return dp[i][j]
//
//}

// MARK: minFallingPathSum (Tabulation)
//func minFalling(_ i: Int,_ j: Int,_ m: Int,_ n: Int,_ dp: inout [[Int]],_ matrix:[[Int]]) -> Int{
//
//    for j in 0..<m{
//        dp[0][j] = matrix[0][j]
//    }
//    for i in 1..<m{
//        for j in 0..<n{
//            let s = matrix[i][j] +  dp[i-1][j]/*minFalling(i-1,j,m,n,&dp,matrix)*/
//            var sl = matrix[i][j]
//            if  j-1 >= 0{
//                sl += dp[i-1][j-1]/*minFalling(i-1,j-1,m,n,&dp,matrix)*/
//            } else{
//                sl += Int(1e9)
//            }
//            var sr = matrix[i][j]
//            if j+1 < m{
//                sr += dp[i-1][j+1]/*minFalling(i-1,j+1,m,n,&dp,matrix)*/
//            } else{
//                sr += Int(1e9)
//            }
//            dp[i][j] = min(s, min(sl, sr))
//        }
//    }
//    return dp[i][j]
//}
// MARK: minFallingPathSum (Tabulation and Space Optimization)

func minFalling(_ i: Int,_ j: Int,_ m: Int,_ n: Int,_ matrix:[[Int]]) -> Int{
    var prev = [Int](repeating: 0, count: m)
    for j in 0..<m{
        prev[j] = matrix[0][j]
    }
    for i in 1..<m{
        var curr = [Int](repeating: 0, count: m)
        for j in 0..<n{
            let s = matrix[i][j] +  prev[j]/*minFalling(i-1,j,m,n,&dp,matrix)*/
            var sl = matrix[i][j]
            if  j-1 >= 0{
                sl += prev[j-1]/*minFalling(i-1,j-1,m,n,&dp,matrix)*/
            } else{
                sl += Int(1e9)
            }
            var sr = matrix[i][j]
            if j+1 < m{
                sr += prev[j+1]/*minFalling(i-1,j+1,m,n,&dp,matrix)*/
            } else{
                sr += Int(1e9)
            }
            curr[j] = min(s, min(sl, sr))
        }
        prev = curr
    }
    return prev[j]
}

func minFallingPathSum(_ matrix: [[Int]]) -> Int {
    let row = matrix.count
    let col = matrix[0].count
    var maxi = Int.max
    var dp = Array(repeating: Array(repeating: -1, count: col), count: row)
    for i in 0..<col{
//       maxi = min(maxi,minFalling(row-1, i,row,col,&dp, matrix))
        maxi = min(maxi,minFalling(row-1, i,row,col, matrix))
    }
    return maxi
}

func helper(_ s1: [Character], _ s2: [Character], _ s3: [Character],_ l1:Int,_ l2:Int,_ l3:Int) -> Bool{
    if l1 < 0 && l2 < 0 && l3 < 0{
        return true
    }
    if l1 >= 0 && s1[l1] == s3[l3] && l2 >= 0 && s2[l2] == s3[l3]{
       return helper(s1,s2,s3,l1-1,l2,l3-1) || helper(s1,s2,s3,l1,l2-1,l3-1)
    } else if l1 >= 0 && s1[l1] == s3[l3]{
        return helper(s1,s2,s3,l1-1,l2,l3-1)
    } else if l2 >= 0 && s2[l2] == s3[l3]{
        return helper(s1,s2,s3,l1,l2-1,l3-1)
    } else{
        return false
    }
}

func isInterleave(_ s1: String, _ s2: String, _ s3: String) -> Bool {
    if s3.count != s1.count + s2.count{
        return false
    }
    return helper(Array(s1),Array(s2),Array(s3),s1.count-1,s2.count-1,s3.count-1)
}
// MARK: CherryPick


/* MARK: 3D Grid rules
 1. explore everyhting in terms (i1,j1) annd (i2,j2)
 2. Explore all the paths
 3. give maximum sum Possible
 */

//MARK: 3D Grid rules
//func helper(_ i: Int,_ j1: Int,_ j2: Int, _ m: Int, _ n: Int, _ grid: [[Int]]) -> Int{
//    if j1 < 0 || j1 > n || j2 < 0 || j2 > n {
//        return Int(-1e9)
//    }
//    if i == m{
//        if j1 == j2{
//            return grid[i][j1]
//        } else{
//            return grid[i][j1] + grid[i][j2]
//        }
//    }
//    var maxi = Int.min
//    for d1 in -1...1{
//        for d2 in -1...1{
//            var ans = 0
//            if j1 == j2{
//                ans = grid[i][j1] + helper(i+1, j1+d1, j2+d2, m, n, grid)
//            } else {
//               ans = grid[i][j1] + grid[i][j2] + helper(i+1, j1+d1, j2+d2, m, n, grid)
//
//            }
//            maxi = max(maxi, ans)
//        }
//    }
//    return maxi
//}


//MARK: 3D Grid rules(DP With Memoization)

//
//func helper(_ i: Int,_ j1: Int,_ j2: Int, _ m: Int, _ n: Int,_ dp:inout [[[Int]]],_ grid: [[Int]]) -> Int{
//    if j1 < 0 || j1 > n || j2 < 0 || j2 > n {
//        return Int(-1e9)
//    }
//    if i == m{
//        if j1 == j2{
//            return grid[i][j1]
//        } else{
//            return grid[i][j1] + grid[i][j2]
//        }
//    }
//    if dp[i][j1][j2] != -1{
//        return dp[i][j1][j2]
//    }
//    var maxi = Int.min
//    for d1 in -1...1{
//        for d2 in -1...1{
//            var ans = 0
//            if j1 == j2{
//                ans = grid[i][j1] + helper(i+1, j1+d1, j2+d2, m, n,&dp, grid)
//            } else {
//               ans = grid[i][j1] + grid[i][j2] + helper(i+1, j1+d1, j2+d2, m, n,&dp, grid)
//
//            }
//            maxi = max(maxi, ans)
//        }
//    }
//    dp[i][j1][j2] = maxi
//    return dp[i][j1][j2]
//}

//MARK: 3D Grid rules(DP With Tabulation)
/*
 1. Base Case
 2. express everything in for loop
 3.
 */
//func helper(_ i: Int,_ j1: Int,_ j2: Int, _ m: Int, _ n: Int,_ dp:inout [[[Int]]],_ grid: [[Int]]) -> Int{
//    if j1 < 0 || j1 > n || j2 < 0 || j2 > n {
//        return Int(-1e9)
//    }
//
//    for j1 in 0...n{
//        for j2 in 0...n{
//            if j1 == j2{
//                dp[m][j1][j2] = grid[m][j1]
//            } else{
//                dp[m][j1][j2] = grid[m][j1] + grid[m][j2]
//            }
//        }
//    }
//
//    for i in (0...m-1).reversed(){
//        for j1 in 0...n{
//            for j2 in 0...n{
//                var maxi = Int.min
//                for d1 in -1...1{
//                    for d2 in -1...1{
//                        var ans = 0
//                        if j1 == j2{
//                            ans = grid[i][j1]
//                        } else {
//                            ans = grid[i][j1] + grid[i][j2]
//                        }
//                        if  ((j1 + d1 < 0 || j1 + d1 > n) || (j2 + d2 < 0 || j2 + d2 > n)){
//                            ans += Int(-1e9)
//                        } else{
//                            ans += dp[i+1][j1+d1][j2+d2]
//                        }
//                        maxi = max(maxi, ans)
//                    }
//                }
//                dp[i][j1][j2] = maxi
//                print(dp[i][j1][j2])
//            }
//        }
//    }
//    return dp[0][0][n]
//}


//MARK: 3D Grid rules(DP With Space Optimization)

func helper(_ i: Int,_ j1: Int,_ j2: Int, _ m: Int, _ n: Int,_ grid: [[Int]]) -> Int{
    if j1 < 0 || j1 > n || j2 < 0 || j2 > n {
        return Int(-1e9)
    }
    var front = Array(repeating: Array(repeating: 0, count: n+1), count: n+1)
    var cur = Array(repeating: Array(repeating: 0, count: n+1), count: n+1)
    for j1 in 0...n{
        for j2 in 0...n{
            if j1 == j2{
                front[j1][j2] = grid[m][j1]
            } else{
                front[j1][j2] = grid[m][j1] + grid[m][j2]
            }
        }
    }
    
    for i in (0...m-1).reversed(){
        for j1 in 0...n{
            for j2 in 0...n{
                var maxi = Int.min
                for d1 in -1...1{
                    for d2 in -1...1{
                        var ans = 0
                        if j1 == j2{
                            ans = grid[i][j1]
                        } else {
                            ans = grid[i][j1] + grid[i][j2]
                        }
                        if  ((j1 + d1 < 0 || j1 + d1 > n) || (j2 + d2 < 0 || j2 + d2 > n)){
                            ans += Int(-1e9)
                        } else{
                            ans += front[j1+d1][j2+d2]
                        }
                        maxi = max(maxi, ans)
                    }
                }
                cur[j1][j2] = maxi
            }
        }
        front = cur
    }
    return front[0][n]
}


func cherryPickup(_ grid: [[Int]]) -> Int {
    let row = grid.count
    let col = grid[0].count
//    var dp = Array(repeating: Array(repeating: Array(repeating: -1, count: col), count: col), count: row)
//    print(dp)
//    return helper(0,0,col-1,row-1,col-1,&dp,grid)
    return helper(0,0,col-1,row-1,col-1,grid)
}


// MARK: Jump Game VI

func maxResult(_ nums: [Int], _ k: Int) -> Int {
    var dp = (0..<nums.endIndex).map {_ in 0}
    var queue = [0] //store indices
    dp[0] = nums[0]
    for i in 1..<nums.endIndex {
        let n = nums[i]
        let curr = dp[queue.first!] + n
        print(curr)
        dp[i] = curr
        while !queue.isEmpty && dp[queue.last!] < curr {
            queue.removeLast()
        }
        queue.append(i)
        if queue.first! == i-k {
            queue.removeFirst()
        }
    }
    return dp.last!
}


// MARK: DP14 Subset sum equal to target

// MARK: P14 Subset sum equal to target  (Naive Approach)
//func mainFunction(_ indx: Int,_ target: Int,_ arr: [Int]) -> Bool{
//    if target == 0 {
//        return true
//    }
//    if indx == 0{
//        return arr[0] == target
//    }
//    let notTake = mainFunction(indx-1, target, arr)
//    let take = mainFunction(indx-1, target-arr[indx],arr)
//
//    return notTake || take
//}



// MARK: P14 Subset sum equal to target (Memoization)

//func mainFunction(_ indx: Int,_ target: Int,_ arr: [Int],_ dp: inout [[Bool]]) -> Bool{
//    if target == 0 {
//        return true
//    }
//    if indx == 0{
//        return arr[0] == target
//    }
//    if dp[indx][target] != false{
//        return dp[indx][target]
//    }
//    let notTake = mainFunction(indx-1, target, arr, &dp)
//    var take = false
//    if arr[indx] < target{
//        take = mainFunction(indx-1, target-arr[indx],arr,&dp)
//    }
//    dp[indx][target] = notTake || take
//    print(dp)
//    return dp[indx][target]
//}
//

// MARK:  P14 Subset sum equal to target (Tabulation)
//func mainFunction(_ indx: Int,_ target: Int,_ arr: [Int],_ dp: inout [[Bool]]) -> Bool{
//
//    for i in 0..<arr.count{
//        dp[i][0] = true
//    }
//
//    if arr[0] <= target{
//        print(target,arr[0])
//        dp[0][arr[0]] = true
//    }
//    for i in 1..<arr.count {
//        for j in 1...target{
//            let notTake = dp[indx-1][j]
//            var take = false
//            if arr[i] <= j{
//                take = dp[i-1][j-arr[i]]
//            }
//            dp[i][j] = notTake || take
//        }
//    }
//    print(dp)
//    return dp[arr.count-1][target]
//}



// MARK: count Subset sum equal to target ( Tabulation )

//func mainFunction(_ indx: Int,_ target: Int,_ arr: [Int],_ dp: inout [[Int]]) -> Int{
//
//    for i in 0..<arr.count{
//       dp[i][0] = 1
//   }
//
//   if arr[0] <= target{
//       dp[0][arr[0]] = 1
//   }
//    for i in 1..<arr.count {
//       for j in 1...target{
//           let notTake = dp[i-1][j]
//           var take = 0
//           if arr[i] <= j{
//               take = dp[i-1][j-arr[i]]
//           }
//           dp[i][j] = notTake + take
//       }
//   }
//    return dp[arr.count-1][target]
//}



//func subSetToK(k: Int,arr: [Int]) -> Bool{
//    var dp = Array(repeating: Array(repeating: false, count: k+1), count: arr.count)
//    return mainFunction(arr.count-1,k,arr, &dp)
//    return true
//}
//func subarraySum(_ nums: [Int], _ k: Int) -> Int {
//    var dp = Array(repeating: Array(repeating: 0, count: k+1), count: nums.count)
//    return mainFunction(nums.count-1,k,nums, &dp)
//}


// MARK: 15 Partition Equal Subset Sum ( Tabulation )

//func mainFunction(_ indx: Int,_ target: Int,_ arr: [Int],_ dp: inout [[Bool]]) -> Bool{
//
//    for i in 0..<arr.count{
//        dp[i][0] = true
//    }
//
//    if arr[0] <= target{
//        print(target,arr[0])
//        dp[0][arr[0]] = true
//    }
//    for i in 1..<arr.count {
//        for j in 1...target{
//            let notTake = dp[i-1][j]
//            var take = false
//            if arr[i] <= j{
//                take = dp[i-1][j-arr[i]]
//            }
//            dp[i][j] = notTake || take
//        }
//    }
//    return dp[arr.count-1][target]
//}
//
//func canPartition(_ nums: [Int]) -> Bool {
//    let sum = nums.reduce(0, +)
//    if sum % 2 != 0{
//        return false
//    }
//    let target = sum/2
//    var dp = Array(repeating: Array(repeating: false, count: target+1), count: nums.count)
//    return mainFunction(nums.count, target, nums, &dp)
//}

//MARK: Dp 16. Partition A Set Into Two Subsets With Minimum Absolute Sum Difference | DP on Subsequences

 
//func minimumDifference(_ nums: [Int]) -> Int {
//    let length = nums.count
//    if length == 2{
//        return abs(nums[0] - nums[1])
//    }else if length == 1{
//        return nums.first!
//    }
//    let sum = nums.reduce(0, +)
//    if sum < 0{
//        return 0
//    }
//    let target = sum
//    var dp = Array(repeating: Array(repeating: false, count: target+1), count: nums.count)
//    for i in 0..<nums.count{
//        dp[i][0] = true
//    }
//
//    if nums[0] <= target{
//        print(target,nums[0])
//        dp[0][nums[0]] = true
//    }
//    for i in 1..<length{
//        for j in 1...target{
//            let notTake = dp[i-1][j]
//            var take = false
//            if nums[i] <= j{
//                take = dp[i-1][j-nums[i]]
//            }
//            dp[i][j] = notTake || take
//        }
//    }
//    var miniNum = Int.max
//    for s1 in 0...sum/2{
//        if dp[length-1][s1] == true{
//            miniNum = min(miniNum,abs((sum - s1) - s1))
//        }
//    }
//    return miniNum
//}
//

func minimumDifference(_ nums: [Int]) -> Int {
    let length = nums.count
    let sum = nums.reduce(0, +)
    let target = sum
    var dp = Array(repeating: false, count: target+1)
    for i in 1..<length{
        for j in (1...target).reversed(){
            dp[0] = true
            if nums[i-1] <= j{
                dp[j] = dp[j] || dp[j-nums[i-1]]
            }
            
        }
    }
    var miniNum = Int.max
    for s1 in 0...sum/2{
        if dp[s1] == true{
            miniNum = min(miniNum,sum-2*s1)
        }
    }
    return miniNum
}


//MARK:  DP 17. Counts Subsets with Sum K | Dp on Subsequences

//MARK: Naive Approcach

//func numOfSubset(_ index: Int,_ num:[Int],_ sum: Int) -> Int{
//    if sum == 0{
//        return 1
//    }
//    if index == 0 {
//        if num[0] == sum{
//            return 1
//        }
//    }
//    let notTake = numOfSubset(index-1, num,sum)
//    var take  = 0
//    if num[index] <= sum{
//        take = numOfSubset(index-1, num,  sum - num[index] )
//    }
//    let total = take + notTake
//    return total
//}


//MARK: Memoization
//func numOfSubset(_ index: Int,_ num:[Int],_ sum: Int,_ dp: inout [[Int]]) -> Int{
//
//    if sum == 0{
//        return 1
//    }
//
//    if index == 0 {
//        if num[index] == sum{
//            return 1
//        }else{
//            return 0
//        }
//
//    }
//    if dp[index][sum] != -1{
//        return dp[index][sum]
//    }
//    let notTake = numOfSubset(index-1, num,sum,&dp)
//    var take = 0
//    if num[index] <= sum{
//        take = numOfSubset(index-1, num,sum - num[index],&dp)
//    }
//
//    dp[index][sum] = notTake + take
//    return dp[index][sum]
//}

//MARK: Tabulation Approach

//func numOfSubset(_ index: Int,_ num:[Int],_ sum: Int,_ dp: inout [[Int]]) -> Int{
//    for i in 0..<num.count{
//        dp[i][0] = 1
//    }
//    if num[index] <= sum{
//        dp[0][num[0]] = 1
//    }
//    for i in 1..<num.count{
//        for j in 0...sum{
//            let notTake =  dp[i-1][j]
//            var take  = 0
//            if num[i] <= j{
//                take = dp[i-1][j-num[i]]
//            }
//            dp[i][j] = take + notTake
//        }
//    }
//    return dp[num.count-1][sum]
//}

//func findWays(_ num: [Int],_ tar: Int) -> Int{
//    var dp = Array(repeating: Array(repeating: -1, count: tar+1), count: num.count)
//    return numOfSubset(num.count-1,num,tar)
//    return numOfSubset(num.count-1,num,tar,&dp)
//}


//MARK: DP 18. Count Partitions With Given Difference | Dp on Subsequences

// MARK: Memoizarion
  
//func numOfSubset(_ index: Int,_ num:[Int],_ sum: Int,_ dp: inout [[Int]]) -> Int{
//
//    if sum == 0{
//        return 1
//    }
//
//    if index == 0 {
//        if sum == 0 && num[0] == 0{
//            return 2
//        } else if  sum == 0 || sum == num[0]{
//            return 1
//        }
//        return 0
//
//    }
//    if dp[index][sum] != -1{
//        return dp[index][sum]
//    }
//    let notTake = numOfSubset(index-1, num,sum,&dp)
//    var take = 0
//    if num[index] <= sum{
//        take = numOfSubset(index-1, num,sum - num[index],&dp)
//    }
//
//    dp[index][sum] = notTake + take
//    return dp[index][sum]
//}
//
//func findWays(_ num: [Int],_ tar: Int) -> Int{
//    var dp = Array(repeating: Array(repeating: -1, count: tar+1), count: num.count)
//    return numOfSubset(num.count-1,num,tar,&dp)
//}
//
//func countPartition(_ n: Int, _ d: Int,_ arr: [Int]) ->Int{
//    var sum = arr.reduce(0, +)
//    if sum - d < 0 || (sum-d) % 2 != 0{
//        return 0
//    }
//    return findWays(arr, (sum-d)/2)
//}


// MARK:  DP: 19  0/1 Knapsack  (naive)


//func helper(_ index: Int,_ num: [Int], _ values: [Int], _ weight : Int) -> Int{
//    if index == 0{
//        if weight >= num[index]{
//            return values[0]
//        } else{
//            return 0
//        }
//    }
//    let notTake = 0 + helper(index-1,num,values,weight)
//    var take = Int.min
//    if num[index] < weight{
//        take = values[index] + helper(index-1,num,values,weight-num[index])
//    }
//    let result = max(notTake, take)
//    return result
//}
//
//func knapSackRobber(_ num: [Int], _ values: [Int], _ weight : Int) -> Int{
//    return helper(num.count-1,num,values,weight)
//}

// MARK:  DP: 19  0/1 Knapsack  (Memoization)

//func helper(_ index: Int,_ num: [Int], _ values: [Int], _ weight : Int,_ dp:inout[[Int]]) -> Int{
//    if index == 0{
//        if weight >= num[index]{
//            return values[0]
//        } else{
//            return 0
//        }
//    }
//    if dp[index][weight] != -1{
//        return dp[index][weight]
//    }
//    let notTake = 0 + helper(index-1,num,values,weight, &dp)
//    var take = Int.min
//    if num[index] < weight{
//        take = values[index] + helper(index-1,num,values,weight-num[index], &dp)
//    }
//    dp[index][weight] = max(notTake, take)
//    return dp[index][weight]
//}
//
//func knapSackRobber(_ num: [Int], _ values: [Int], _ weight : Int) -> Int{
//    var dp = Array(repeating: Array(repeating: -1, count: weight+1), count: num.count)
//    return helper(num.count-1,num,values,weight,&dp)
//}


// MARK:  DP: 19  0/1 Knapsack  (Tabulation)


//func helper(_ index: Int,_ num: [Int], _ values: [Int], _ weight : Int,_ dp:inout[[Int]]) -> Int{
//
//
//    if num[0] > weight{
//        return 0
//    }
//    for i in num[0]...weight{
//        dp[0][i] = values[0]
//    }
//
//    for i in 1..<num.count{
//        for j in 0...weight{
//            let notTake = 0 + dp[i-1][j]
//            var take = Int.min
//            if num[i] <= j{
//                take = values[i] + dp[i-1][j-num[i]]
//            }
//            dp[i][j] = max(notTake, take)
//        }
//    }
//    return dp[num.count-1][weight]
//}
//
//func knapSackRobber( _ values: [Int],_ num: [Int], _ weight : Int) -> Int{
//    var dp = Array(repeating: Array(repeating: 0, count: weight+1), count: num.count)
//    return helper(num.count-1,num,values,weight,&dp)
//}

// MARK: DP 20. Minimum Coins (Naive)
//func countCoin(_ index: Int,_ nums: [Int], _ target: Int) -> Int{
//    if index == 0{
//        if target % nums[index] == 0{
//            return target/nums[index]
//        } else{
//            return Int(1e9)
//        }
//    }
//    var notTake = 0 + countCoin(index-1, nums, target)
//    var take = Int.max
//    if nums[index] <= target{
//        take = 1 + countCoin(index, nums, target-nums[index])
//    }
//    var minimumCoin = min(take, notTake)
//    return minimumCoin
//}
//
//
//func minimumCoin(_ nums: [Int], _ target: Int) -> Int{
//    return countCoin(nums.count-1, nums, target)
//}

// MARK: DP 20. Minimum Coins (memoization)
//func countCoin(_ index: Int,_ nums: [Int], _ target: Int,_ dp : inout [[Int]]) -> Int{
//    if index == 0{
//        if target % nums[index] == 0{
//            return target/nums[index]
//        } else{
//            return Int(1e9)
//        }
//    }
//    if dp[index][target] != -1{
//        return dp[index][target]
//    }
//    var notTake = 0 + countCoin(index-1, nums, target,&dp)
//    var take = Int.max
//    if nums[index] <= target{
//        take = 1 + countCoin(index, nums, target-nums[index],&dp)
//    }
//    dp[index][target] = min(take, notTake)
//    return dp[index][target]
//}
//
//func minimumCoin(_ nums: [Int], _ target: Int) -> Int{
//    var dp = Array(repeating: Array(repeating: -1, count: target+1), count: nums.count)
//    let ans = countCoin(nums.count-1, nums, target,&dp)
//    if ans >= Int(1e9){
//        return -1
//    }
//    return ans
//}
//

// MARK: DP 20. Minimum Coins (Tabulation)

func countCoin(_ index: Int,_ nums: [Int], _ target: Int,_ dp : inout [[Int]]) -> Int{
    for i in 0...target{
        if i % nums[0] == 0{
            dp[0][i] = i / nums[0]
        } else{
            dp[0][i] = Int(1e9)
        }
    }
    for i in 1..<nums.count{
        for j in 0...target{
            let notTake = 0 + dp[i-1][j]
            var take = Int.max
            if nums[i] <= j{
                take = 1 + dp[i][j-nums[i]]
            }
            dp[i][j] = min(take, notTake)
        }
    }
    
    return dp[nums.count-1][target]
}

func minimumCoin(_ nums: [Int], _ target: Int) -> Int{
    var dp = Array(repeating: Array(repeating: -1, count: target+1), count: nums.count)
    let ans = countCoin(nums.count-1, nums, target,&dp)
    if ans >= Int(1e9){
        return -1
    }
    return ans
}

// MARK: DP 21. Target Sum (Memoization)

func numOfSubset(_ index: Int,_ num:[Int],_ sum: Int,_ dp: inout [[Int]]) -> Int{

    if index == 0 {
        if sum == 0 && num[0] == 0{
            return 2
        } else if  sum == 0 || sum == num[0]{
            return 1
        }
        return 0

    }
    if dp[index][sum] != -1{
        return dp[index][sum]
    }
    let notTake = numOfSubset(index-1, num,sum,&dp)
    var take = 0
    if num[index] <= sum{
        take = numOfSubset(index-1, num,sum - num[index],&dp)
    }

    dp[index][sum] = notTake + take
    return dp[index][sum]
}

func findWays(_ num: [Int],_ tar: Int) -> Int{
    var dp = Array(repeating: Array(repeating: -1, count: tar+1), count: num.count)
    return numOfSubset(num.count-1,num,tar,&dp)
}

func countPartition(_ n: Int, _ d: Int,_ arr: [Int]) ->Int{
    var sum = arr.reduce(0, +)
    if sum - d < 0 || (sum-d) % 2 != 0{
        return 0
    }
    return findWays(arr, (sum-d)/2)
}

func findTargetSumWays(_ nums: [Int], _ target: Int) -> Int {
    return countPartition(nums.count, target, nums)
}


//MARK:  DP 22. Coin Change 2 (naive)
//func numberOfWays(_ index: Int,_ target: Int, _ coins: [Int]) -> Int{
//    if index == 0 {
//        if target % coins[0] == 0{
//            return 1
//        } else{
//            return 0
//        }
//    }
//    let notTake = numberOfWays(index-1, target, coins)
//    var take = 0
//    if coins[index] <= target{
//        take = numberOfWays(index, target-coins[index], coins)
//    }
//    return take + notTake
//}
//
//func change(_ amount: Int, _ coins: [Int]) -> Int {
//    return numberOfWays(coins.count-1, amount, coins)
//}

//MARK:  DP 22. Coin Change 2 (memoization)

//func numberOfWays(_ index: Int,_ target: Int, _ coins: [Int],_ dp: inout [[Int]]) -> Int{
//    if index == 0 {
//        if target % coins[0] == 0{
//            return 1
//        } else{
//            return 0
//        }
//    }
//    if dp[index][target] != -1{
//        return dp[index][target]
//    }
//    let notTake = numberOfWays(index-1, target, coins,&dp)
//    var take = 0
//    if coins[index] <= target{
//        take = numberOfWays(index, target-coins[index], coins,&dp)
//    }
//    dp[index][target] = take + notTake
//    return dp[index][target]
//}
//
//func change(_ amount: Int, _ coins: [Int]) -> Int {
//    var dp = Array(repeating: Array(repeating: -1, count: amount+1), count: coins.count)
//    return numberOfWays(coins.count-1, amount, coins,&dp)
//}

//MARK:  DP 22. Coin Change 2 (Tabulation)


//func numberOfWays(_ index: Int,_ target: Int, _ coins: [Int],_ dp: inout [[Int]]) -> Int{
//
//    for i in 0...target{
//        if i % coins[0] == 0{
//            dp[0][i] = 1
//        } else{
//            dp[0][i] = 0
//        }
//    }
//
//    for i in 1..<coins.count{
//        for j in 0...target{
//            let notTake = dp[i-1][j]
//            var take = 0
//            if coins[i] <= j{
//                take = dp[i][j-coins[i]]
//            }
//            dp[i][j] = take + notTake
//        }
//    }
//    return dp[coins.count-1][target]
//}
//
//func change(_ amount: Int, _ coins: [Int]) -> Int {
//    var dp = Array(repeating: Array(repeating: -1, count: amount+1), count: coins.count)
//    return numberOfWays(coins.count-1, amount, coins,&dp)
//}


//MARK:  DP 22. Coin Change 2 (Tabulation + Space Optimization)

func numberOfWays(_ index: Int,_ target: Int, _ coins: [Int],_ dp: inout [[Int]]) -> Int{
    var prev = Array(repeating: 0, count: target+1)
    var curr = Array(repeating: 0, count: target+1)
    for i in 0...target{
        if i % coins[0] == 0{
            prev[i] = 1
        } else{
            prev[i] = 0
        }
    }
    
    for i in 1..<coins.count{
        for j in 0...target{
            let notTake = prev[j]
            var take = 0
            if coins[i] <= j{
                take = curr[j-coins[i]]
            }
            curr[j] = take + notTake
        }
        prev = curr
    }
    return prev[target]
}

func change(_ amount: Int, _ coins: [Int]) -> Int {
    var dp = Array(repeating: Array(repeating: -1, count: amount+1), count: coins.count)
    return numberOfWays(coins.count-1, amount, coins,&dp)
}

//MARK: DP 23. Unbounded Knapsack (Memoization)

//func numberOfWaysForTotal(_ index: Int,_ num: [Int],_ value:[Int], _ target: Int,_ dp : inout [[Int]]) -> Int {
//    if index == 0{
//        return (target / num[0]) * value[0]
//    }
//    if dp[index][target] != -1{
//        return dp[index][target]
//    }
//    let notTake = 0 + numberOfWaysForTotal(index-1, num,value, target, &dp)
//    var take = Int.min
//    if num[index] <= target{
//        take = value[index] + numberOfWaysForTotal(index, num,value, target-num[index], &dp)
//    }
//    dp[index][target] = max(take,notTake)
//    return dp[index][target]
//}
//
//func unboundedKnapsack(_ coins: [Int],_ value: [Int], _ amount: Int) -> Int {
//    var dp = Array(repeating: Array(repeating: -1, count: amount+1), count: coins.count)
//    let totalWays =  numberOfWaysForTotal(coins.count-1, coins,value, amount,&dp)
//    return totalWays
//}
//


//MARK: DP 23. Unbounded Knapsack (Tabulation)

func numberOfWaysForTotal(_ index: Int,_ num: [Int],_ value:[Int], _ target: Int,_ dp : inout [[Int]]) -> Int {
    for i in 0...target{
        dp[0][i] = (i / num[0]) * value[0]
    }
    
    for i in 1..<num.count{
        for j in 0...target{
            let notTake = 0 + dp[i-1][j]
            var take = Int.min
            if num[i] <= j{
                take = value[i] + dp[i][j-num[i]]
            }
            dp[i][j] = max(take, notTake)
        }
    }
    return dp[num.count-1][target]
}

func unboundedKnapsack(_ coins: [Int],_ value: [Int], _ amount: Int) -> Int {
    var dp = Array(repeating: Array(repeating: -1, count: amount+1), count: coins.count)
    let totalWays =  numberOfWaysForTotal(coins.count-1, coins,value, amount,&dp)
    return totalWays
}

//MARK:  DP 24. Rod Cutting Problem (Naive)


//func numberOfWaysToCutRod(_ index: Int,target: Int,num: [Int]) -> Int{
//    if index == 0{
//        return target * num[0]
//    }
//    var notTake = 0 + numberOfWaysToCutRod(index-1, target: target, num: num)
//    var take = Int.min
//    var rodeLength = index + 1
//    if rodeLength <= target{
//        take = num[index] + numberOfWaysToCutRod(index, target: target-rodeLength, num: num)
//    }
//    var result = max(take, notTake)
//    return result
//}
//
//func rodCutting(target: Int,num: [Int]) -> Int{
//    numberOfWaysToCutRod(num.count-1, target: target, num: num)
//}

//MARK:  DP 24. Rod Cutting Problem (Memoization)
//
//func numberOfWaysToCutRod(_ index: Int,_ target: Int,_ num: [Int],_ dp: inout [[Int]]) -> Int{
//    if index == 0{
//        return target * num[0]
//    }
//    if dp[index][target] != -1{
//        return dp[index][target]
//    }
//    var notTake = 0 + numberOfWaysToCutRod(index-1,  target,  num,&dp)
//    var take = Int.min
//    var rodeLength = index + 1
//    if rodeLength <= target{
//        take = num[index] + numberOfWaysToCutRod(index,  target-rodeLength,  num,&dp)
//    }
//    dp[index][target] = max(take, notTake)
//    return dp[index][target]
//}
//
//func rodCutting(target: Int,num: [Int]) -> Int{
//    var dp = Array(repeating: Array(repeating: -1, count: target+1), count: num.count)
//    return numberOfWaysToCutRod(num.count-1, target, num,&dp)
//}

//MARK:  DP 24. Rod Cutting Problem (Tabulization)


func numberOfWaysToCutRod(_ index: Int,_ target: Int,_ num: [Int],_ dp: inout [[Int]]) -> Int{
    if index == 0{
        return target * num[0]
    }
    for i in 0...target{
        dp[0][i] = i * num[0]
    }
    if dp[index][target] != -1{
        return dp[index][target]
    }
    
    for i in 1..<num.count{
        for j in 0...target{
            let notTake = 0 + numberOfWaysToCutRod(i-1,  j,  num,&dp)
            var take = Int.min
            let rodeLength = i + 1
            if rodeLength <= j{
                take = num[i] + numberOfWaysToCutRod(i,  j-rodeLength,  num,&dp)
            }
            dp[i][j] = max(take, notTake)
        }
    }
    
    return dp[num.count-1][target]
}

func rodCutting(target: Int,num: [Int]) -> Int{
    var dp = Array(repeating: Array(repeating: -1, count: target+1), count: num.count)
    return numberOfWaysToCutRod(num.count-1, target, num,&dp)
}

// MARK: Dp 25. Longest Common Subsequence (Naive)

//func CommonSubsequence(_ index1: Int,_ index2:Int,_ text1: [Character],_ text2:[Character]) -> Int{
//    if index1 < 0 || index2 < 0{
//        return 0
//    }
//    if text1[index1] == text2[index2]{
//        return 1 + CommonSubsequence(index1-1,index2-1,text1,text2)
//    }
//    let result = max(CommonSubsequence(index1-1,index2,text1,text2), CommonSubsequence(index1,index2-1,text1,text2))
//    return result
//}
//
//func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
//    let text1 = Array(text1)
//    let text2 = Array(text2)
//    return CommonSubsequence(text1.count-1, text2.count-1, text1, text2)
//}

// MARK: Dp 25. Longest Common Subsequence (Memoization)
//func CommonSubsequence(_ index1: Int,_ index2:Int,_ text1: [Character],_ text2:[Character],_ dp:inout [[Int]]) -> Int{
//    if index1 < 0 || index2 < 0{
//        return 0
//    }
//    if dp[index1][index2] != -1{
//        dp[index1][index2]
//    }
//    if text1[index1] == text2[index2]{
//        return 1 + CommonSubsequence(index1-1,index2-1,text1,text2,&dp)
//    }
//    dp[index1][index2] = max(CommonSubsequence(index1-1,index2,text1,text2,&dp), CommonSubsequence(index1,index2-1,text1,text2,&dp))
//    return dp[index1][index2]
//}
//
//func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
//    let text1 = Array(text1)
//    let text2 = Array(text2)
//    var dp  = Array(repeating: Array(repeating: -1, count: text2.count+1), count: text1.count+1)
//    return CommonSubsequence(text1.count-1, text2.count-1, text1, text2,&dp)
//}
// MARK: Dp 25. Longest Common Subsequence (Tabulation)
func CommonSubsequence(_ index1: Int,_ index2:Int,_ text1: [Character],_ text2:[Character],_ dp:inout [[Int]]) -> Int{
    for k in 0...index1{
        dp[k][0] = 0
    }
    for l in 0...index2{
        dp[0][l] = 0
    }

    for i in 1...index1{
        for j in 1...index2{
            if text1[i-1] == text2[j-1]{
                dp[i][j] = 1 + dp[i-1][j-1]
            }else{
                dp[i][j] = max(dp[i-1][j], dp[i][j-1])
            }
        }
    }
    return dp[index1][index2]
}

func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
    let text1 = Array(text1)
    let text2 = Array(text2)
    var dp = Array(repeating: Array(repeating: 0, count: text2.count+1), count: text1.count+1)
    return CommonSubsequence(text1.count, text2.count, text1, text2,&dp)
}

// MARK: Dp 26. Print Longest Common Subsequence (Tabulation)

func printlongestCommonSubsequence(_ text1: String, _ text2: String) -> String {
    let text1 = Array(text1)
    let text2 = Array(text2)
    var dp = Array(repeating: Array(repeating: 0, count: text2.count+1), count: text1.count+1)
    let value =  CommonSubsequence(text1.count, text2.count, text1, text2,&dp)
    var index = value - 1
    var i =  text1.count
    var j = text2.count
    var result = Array("$$$")
    while i > 0 && j > 0{
        if text1[i-1] == text2[j-1]{
            result.insert(text1[i-1], at: index)
            index-=1
            i-=1
            j-=1
        }else if dp[i-1][j] >  dp[i][j-1] {
            i-=1
        } else{
            j-=1
        }
    }
    result = result.filter{$0 != "$"}
    return String(result)
}


// MARK: DP 27. Longest Common Substring | DP on Strings(Tabulation)

//func longestSubsting(_ index1: Int,_ index2:Int,_ text1: [Character],_ text2:[Character],_ dp:inout [[Int]]) -> Int{
//    for k in 0...index1{
//        dp[k][0] = 0
//    }
//    for l in 0...index2{
//        dp[0][l] = 0
//    }
//    var ans = 0
//    for i in 1...index1{
//        for j in 1...index2{
//            if text1[i-1] == text2[j-1]{
//                dp[i][j] = 1 + dp[i-1][j-1]
//                ans = max(ans, dp[i][j])
//            }else{
//                dp[i][j] = 0
//            }
//        }
//    }
//    return ans
//}
//
//func longestCommonSubstring(_ text1: String, _ text2: String) -> Int {
//    let text1 = Array(text1)
//    let text2 = Array(text2)
//    var dp = Array(repeating: Array(repeating: 0, count: text2.count+1), count: text1.count+1)
//    return longestSubsting(text1.count, text2.count, text1, text2,&dp)
//}

// MARK: DP 27. Longest Common Substring | DP on Strings( Tabulation + Space optimization )

func longestSubsting(_ index1: Int,_ index2:Int,_ text1: [Character],_ text2:[Character],_ dp:inout [[Int]]) -> Int{
    var prev = Array(repeating: 0, count: text2.count+1)
    var curr = Array(repeating: 0, count: text2.count+1)
    var ans = 0
    for i in 1...index1{
        for j in 1...index2{
            if text1[i-1] == text2[j-1]{
                curr[j] = 1 + prev[j-1]
                ans = max(ans, curr[j])
            }else{
                curr[j] = 0
            }
        }
        prev = curr
    }
    return ans
}

func longestCommonSubstring(_ text1: String, _ text2: String) -> Int {
    let text1 = Array(text1)
    let text2 = Array(text2)
    var dp = Array(repeating: Array(repeating: 0, count: text2.count+1), count: text1.count+1)
    return longestSubsting(text1.count, text2.count, text1, text2,&dp)
}

//MARK: DP 28. Longest Palindromic substring (Tabulation)



func printLongestPallendromicSubstring(_ text1: String, _ text2: String) -> String {
    let text1 = Array(text1)
    let text2 = Array(text2)
    var dp = Array(repeating: Array(repeating: 0, count: text2.count+1), count: text1.count+1)
    let value =  CommonSubsequence(text1.count, text2.count, text1, text2,&dp)
    var index = value - 1
    var i =  text1.count
    var j = text2.count
    print(text1,text2)
    var result = Array("$$$")
    while i > 0 && j > 0{
        if text1[i-1] == text2[j-1]{
            result[index] = text1[i-1]
            index-=1
            i-=1
            j-=1
        }
    }
    print(result)
    result = result.filter{$0 != "$"}
    return String(result)
}


func longestPalindrome(_ s: String) -> Int{
    let s1 = s
    let s2 = s.reversed()
    return longestCommonSubsequence(s1, String(s2))
    
}

//MARK: -  DP 28. Longest Palindromic Subsequence (Tabulation)


func longestPalindromeSubseq(_ s: String) -> Int {
    let s1 = s
    let s2 = s.reversed()
    return longestCommonSubsequence(s1, String(s2))
}


//MARK: - DP 29. Minimum Insertion Steps to Make a String Palindrome
func minInsertions(_ s: String) -> Int {
    return s.count - longestPalindromeSubseq(s)
}
//MARK: - DP 30. Minimum Insertions/Deletions to Convert String A to String B
func minDistance(_ word1: String, _ word2: String) -> Int {
    return word1.count + word2.count - 2 * (longestCommonSubsequence(word1, word2))
}

//MARK: - DP 31. Shortest Common Supersequence | DP on Strings
func shortestCommonSupersequence(_ str1: String, _ str2: String) -> String {
    let str1 = Array(str1)
    let str2 = Array(str2)
    let index1 = str1.count
    let index2 = str2.count
    var dp = Array(repeating: Array(repeating: 0, count: index2+1), count: index1+1)
    for k in 0...index1{
        dp[k][0] = 0
    }
    for l in 0...index2{
        dp[0][l] = 0
    }
    var ans = 0
    for i in 1...index1{
        for j in 1...index2{
            if str1[i-1] == str2[j-1]{
                dp[i][j] = 1 + dp[i-1][j-1]
            }else{
                dp[i][j] = max(dp[i-1][j], dp[i][j-1])
            }
        }
    }
    var result = ""
    var i = index1
    var j = index2
    while i > 0 && j > 0{
        if str1[i-1] == str2[j-1]{
            result.append(str1[i-1])
            i-=1
            j-=1
        } else if dp[i-1][j] > dp[i][j-1]{
            result.append(str1[i-1])
            i-=1
        } else {
            result.append(str2[j-1])
            j-=1
        }
    }
    while i > 0{
        result.append(str1[i-1])
        i-=1
    }
    while j > 0{
        result.append(str2[j-1])
        j-=1
    }
    return String(result.reversed())
}
//MARK: - DP 32. Distinct Subsequences | 1D Array Optimisation Technique (Memoization)

//func distinctSubsequences(_ index1: Int,_ index2: Int,_ str1: inout [Character],_ str2: inout [Character],_ dp : inout [[Int]]) -> Int{
//    if index2 < 0 {
//        return 1
//    }
//    if index1 < 0 {
//        return 0
//    }
//    if dp[index1][index2] != -1 {
//        return dp[index1][index2]
//    }
//
//    if str1[index1] == str2[index2]{
//        dp[index1][index2] = distinctSubsequences(index1-1, index2-1, &str1, &str2, &dp) + distinctSubsequences(index1-1, index2, &str1, &str2, &dp)
//        return dp[index1][index2]
//    }
//    dp[index1][index2] = distinctSubsequences(index1-1, index2, &str1, &str2, &dp)
//    return dp[index1][index2]
//}
//
//func numDistinct(_ s: String, _ t: String) -> Int {
//    var s = Array(s)
//    var t = Array(t)
//    var dp = Array(repeating: Array(repeating: -1, count: t.count), count: s.count)
//    return distinctSubsequences(s.count-1,t.count-1,&s,&t,&dp)
//}

//MARK: - DP 32. Distinct Subsequences | 1D Array Optimisation Technique (Tabulation)


func distinctSubsequences(_ index1: Int,_ index2: Int,_ str1: inout [Character],_ str2: inout [Character],_ dp : inout [[Int]]) -> Int{
    
    let mod = 1e9+7
    var prev = Array(repeating: 0, count: index2+1)
    var curr = Array(repeating: 0, count: index2+1)
    prev[0] = 1
    curr[0] = 1
    for i in 1...index1 {
        for j in 1...index2 {
            if str1[i-1] == str2[j-1] {
                curr[j] = (prev[j-1] + prev[j])%Int(mod)
            } else {
                curr[j] = prev[j]
            }
        }
        prev = curr
    }
    return prev[index2]
}

func numDistinct(_ s: String, _ t: String) -> Int {
    var s = Array(s)
    var t = Array(t)
    var dp = Array(repeating: Array(repeating: 0, count: t.count+1), count: s.count+1)
    return distinctSubsequences(s.count,t.count,&s,&t,&dp)
}

//func numDistinct(_ A: inout String, _ B: inout String) -> Int {
//    var s = Array(A)
//    var t = Array(B)
//    var dp = Array(repeating: Array(repeating: -1, count: t.count), count: s.count)
//    return distinctSubsequences(s.count-1,t.count-1,&s,&t,&dp)
//}

//MARK: - DP 41. Longest Increasing Subsequence | Memoization


//func longestIncreasingSubsequence(_ index: Int,_ prevIndex: Int,_ nums: [Int],_ n: Int,_ dp: inout [[Int]]) -> Int{
//
//    if index == n{
//        return 0
//    }
//    if dp[index][prevIndex+1] != -1{
//        return dp[index][prevIndex+1]
//    }
//    var len = 0 + longestIncreasingSubsequence(index+1,prevIndex,nums, n,&dp)
//    if prevIndex == -1 || nums[index] > nums[prevIndex]{
//        len = max(len,1 + longestIncreasingSubsequence(index+1,index,nums, n,&dp))
//    }
//    dp[index][prevIndex+1] = len
//    return dp[index][prevIndex+1]
//}
//
//func lengthOfLIS(_ nums: [Int]) -> Int {
//    let length = nums.count
//    var dp = Array(repeating: Array(repeating: -1, count: length+1), count: length)
//    return longestIncreasingSubsequence(0,-1,nums,length,&dp)
//}

//MARK: - DP 41. Longest Increasing Subsequence | Tabulation
 
//func longestIncreasingSubsequence(_ index: Int,_ prevIndex: Int,_ nums: [Int],_ n: Int,_ dp: inout [[Int]]) -> Int{
//    for i in (0..<n).reversed(){
//        for j in (-1..<i).reversed(){
//            var len = 0 + dp[i+1][j+1]
//            if j == -1 || nums[i] > nums[j]{
//                len = max(len,1 + dp[i+1][i+1])
//            }
//            dp[i][j+1] = len
//        }
//    }
//    return dp[0][-1+1]
//}
//
//func lengthOfLIS(_ nums: [Int]) -> Int {
//    let length = nums.count
//    var dp = Array(repeating: Array(repeating: 0, count: length+1), count: length+1)
//    return longestIncreasingSubsequence(0,-1,nums,length,&dp)
//}


//MARK: - DP 41. Longest Increasing Subsequence | Tabulation(space Optimization)

//func longestIncreasingSubsequence(_ index: Int,_ prevIndex: Int,_ nums: [Int],_ n: Int,_ curr: inout [Int], _ next: inout [Int]) -> Int{
//    for i in (0..<n).reversed(){
//        for j in (-1..<i).reversed(){
//            var len = 0 + next[j+1]
//            if j == -1 || nums[i] > nums[j]{
//                len = max(len,1 + next[i+1])
//            }
//            curr[j+1] = len
//        }
//        next = curr
//    }
//    return next[-1+1]
//}
//
//func lengthOfLIS(_ nums: [Int]) -> Int {
//    let length = nums.count
//    var curr = Array(repeating: 0, count: length+1)
//    var next = Array(repeating: 0, count: length+1)
//    return longestIncreasingSubsequence(0,-1,nums,length,&curr,&next)
//}




// MARK: - Longest Increasing Path in a Matrix

//func longestPath(_ matrix:[[Int]],_ dp:inout [[Int]],_ i : Int,_ j: Int,_ prev: Int) -> Int {
//    guard i >= 0 && i < matrix.count && j >= 0 && j < matrix[i].count && matrix[i][j] > prev else {
//        return 0
//    }
//    if dp[i][j] != -1{
//        return dp[i][j]
//    }
//    let down = longestPath(matrix, &dp, i+1, j, matrix[i][j])
//    let right = longestPath(matrix, &dp, i, j+1, matrix[i][j])
//    let up = longestPath(matrix, &dp, i-1, j, matrix[i][j])
//    let left = longestPath(matrix, &dp, i, j-1, matrix[i][j])
//
//    dp[i][j] = 1 + max(down, max(right, max(up, left)))
//    return dp[i][j]
//}

//func longestIncreasingPath(_ matrix: [[Int]]) -> Int {
//    if (matrix.count == 0){
//        return 0
//    }
//    var dp = Array(repeating: Array(repeating: -1, count: matrix[0].count), count: matrix.count)
//    var maxLength = 0
//    let prev = Int.min
//    for i in 0..<matrix.count{
//        for j in 0..<matrix[i].count{
//            if dp[i][j] == -1{
//                dp[i][j] = longestPath(matrix, &dp, i, j, prev)
//                maxLength = max(maxLength,dp[i][j])
//            }
//        }
//    }
//    return maxLength
//}
//   MARK: - DP 33. Edit Distance | Recursive to 1D Array Optimised Solution (memoization)


//func distanceCovered(_ index1: Int,_ index2:Int,_ word1: [Character],_ word2: [Character],_ dp: inout [[Int]]) -> Int {
//
//    if index1 < 0{
//       return index2+1
//    }
//    if index2 < 0{
//        return index1+1
//    }
//    if dp[index1][index2] != -1{
//        return dp[index1][index2]
//    }
//    if word1[index1] == word2[index2] {
//        dp[index1][index2] = distanceCovered(index1-1, index2-1, word1, word2,&dp)
//        return dp[index1][index2]
//    }
//    dp[index1][index2] = 1 + min(distanceCovered(index1-1, index2, word1, word2,&dp),min(distanceCovered(index1, index2-1, word1, word2,&dp),distanceCovered(index1-1, index2-1, word1, word2, &dp)))
//    return dp[index1][index2]
//
//}
//
//func editDistance(_ word1: String, _ word2: String) -> Int {
//    let word1 = Array(word1)
//    let word2 = Array(word2)
//    var dp = Array(repeating: Array(repeating: -1, count: word2.count), count: word1.count)
//    return distanceCovered(word1.count-1, word2.count-1, word1, word2,&dp)
//}

//   MARK: - DP 33. Edit Distance | Recursive to 1D Array Optimised Solution(Tabulation)


//func distanceCovered(_ index1: Int,_ index2:Int,_ word1: [Character],_ word2: [Character],_ dp: inout [[Int]]) -> Int {
//    if index1 == 0 && index2 == 0{ return 0 }
//    if index1 > 0 && index2 == 0{ return word1.count }
//    if index2 > 0 && index1 == 0 { return word2.count }
//    for k in 0...index1{
//        dp[k][0] = k
//    }
//
//    for l in 0...index2{
//        dp[0][l] = l
//    }
//
//    for i in 1...index1{
//        for j in 1...index2{
//            if word1[i-1] == word2[j-1] {
//                dp[i][j] = dp[i-1][j-1]
//            } else{
//                dp[i][j] = 1 + min(dp[i-1][j],min(dp[i][j-1],dp[i-1][j-1]))
//            }
//        }
//    }
//    return dp[index1][index2]
//}
//
//func editDistance(_ word1: String, _ word2: String) -> Int {
//    let word1 = Array(word1)
//    let word2 = Array(word2)
//    var dp = Array(repeating: Array(repeating: 0, count: word2.count+1), count: word1.count+1)
//    return distanceCovered(word1.count, word2.count, word1, word2,&dp)
//}

//   MARK: - DP 33. Edit Distance | Recursive to 1D Array Optimised Solution(Tabulation + space optimization)

func distanceCovered(_ index1: Int,_ index2:Int,_ word1: [Character],_ word2: [Character],_ dp: inout [[Int]]) -> Int {
    if index1 == 0 && index2 == 0{ return 0 }
    if index1 > 0 && index2 == 0{ return word1.count }
    if index2 > 0 && index1 == 0 { return word2.count }
    
    var prev = Array(repeating: 0, count: word2.count+1)
    var curr = Array(repeating: 0, count: word2.count+1)
   
    
    for l in 0...index2{
        prev[l] = l
    }
   
    for i in 1...index1{
        curr[0] = i
        for j in 1...index2{
            if word1[i-1] == word2[j-1] {
                curr[j] = prev[j-1]
            } else{
                curr[j] = 1 + min(prev[j],min(curr[j-1],prev[j-1]))
            }
        }
        prev = curr
    }
    return prev[index2]
}

func editDistance(_ word1: String, _ word2: String) -> Int {
    let word1 = Array(word1)
    let word2 = Array(word2)
    var dp = Array(repeating: Array(repeating: 0, count: word2.count+1), count: word1.count+1)
    return distanceCovered(word1.count, word2.count, word1, word2,&dp)
}


// MARK:  DP 34. Wildcard Matching (memoization)
//func wildcardPatternMatching(_ index1: Int,_ index2:Int,_ s: [Character],_ p: [Character],_ dp:inout [[Bool?]]) -> Bool{
//    if index1 < 0 && index2 < 0 {
//        return true
//    }
//    if index2 < 0 && index1 >= 0 {
//        return false
//    }
//    if index2 >= 0 && index1 < 0 {
//        for i in 0...index2{
//            if p[i] != "*"{
//                return false
//            }
//        }
//        return true
//    }
//
//    if dp[index1][index2] != nil{
//        return dp[index1][index2]!
//    }
//    var match = false
//    if p[index2] == s[index1] || p[index2] == "?"{
//        match =  wildcardPatternMatching(index1-1, index2-1, s, p,&dp)
//    }
//    if p[index2] == "*"{
//        match =  wildcardPatternMatching(index1, index2-1, s, p,&dp) || wildcardPatternMatching(index1-1, index2, s, p,&dp)
//    }
//    dp[index1][index2] = match
//    return dp[index1][index2]!
//}
//
//func isMatch(_ s: String, _ p: String) -> Bool {
//    let s = Array(s)
//    let p = Array(p)
//    var dp: [[Bool?]] = Array(repeating: Array(repeating: nil, count: p.count), count: s.count)
//    return  wildcardPatternMatching(s.count-1, p.count-1, s, p,&dp)
//}

// MARK:  DP 34. Wildcard Matching (Tabulation)
func wildcardPatternMatching(_ index1: Int,_ index2:Int,_ s: [Character],_ p: [Character],_ dp: inout [[Bool]]) -> Bool{
    dp[0][0] = true
    
    for l in 1...index1{
        dp[l][0] = false
    }
    for k in 1...index2{
        var flag = true
        for j in (1...k).reversed(){
            if p[j-1] != "*"{
                flag = false
                break
            }
        }
        dp[0][k] = flag
    }
    
    for i in 1...index1{
        for j in 1...index2{
            if p[j-1] == s[i-1] || p[j-1] == "?"{
                dp[i][j] =  dp[i-1][j-1]
                
            }else if p[j-1] == "*"{
                dp[i][j] =  dp[i][j-1] || dp[i-1][j]
            } else{
                dp[i][j] = false
            }
        }
    }
    
    return dp[index1][index2]
}

func isMatch(_ s: String, _ p: String) -> Bool {
    let s = Array(s)
    let p = Array(p)
    var dp: [[Bool]] = Array(repeating: Array(repeating: false, count: p.count+1), count: s.count+1)
    return  wildcardPatternMatching(s.count, p.count,s, p, &dp)
}
// MARK: -  DP 35.  Buy and Sell Stock - I
//func maxProfit(_ prices: [Int]) -> Int {
//    var mini = prices[0]
//    var profit = 0
//    for i in 1..<prices.count{
//        var cost = prices[i] - mini
//        profit = max(profit,cost)
//        mini = min(mini,prices[i])
//    }
//    return profit
//}
// MARK: -  DP 36.  Buy and Sell Stock - II (Memoization)

//func stockBuying(_ index: Int,_ buy: Int, _ profit: [Int],_ dp: inout [[Int]]) -> Int{
//
//    if index == profit.count{
//        return 0
//    }
//    if dp[index][buy] != -1{
//        return dp[index][buy]
//    }
//    var maxProfit = 0
//
//    if buy != 0 {
//        maxProfit = max((-profit[index] + stockBuying(index+1, 0, profit,&dp)),(0 + stockBuying(index+1, 1, profit,&dp)))
//    } else{
//        maxProfit = max((profit[index] + stockBuying(index+1, 1, profit,&dp)),(0 + stockBuying(index+1, 0, profit,&dp)))
//    }
//    dp[index][buy]  = maxProfit
//    return dp[index][buy]
//}

//func maxProfit(_ prices: [Int]) -> Int {
//    var dp = Array(repeating: Array(repeating: -1, count: 2),count: prices.count)
//    return stockBuying(0,1, prices,&dp)
//}

// MARK: -  DP 36.  Buy and Sell Stock - II (Tabulation)

func stockBuying(_ index: Int,_ buy: Int, _ profit: [Int],_ dp: inout [[Int]]) -> Int{

    dp[profit.count][0] = 0
    dp[profit.count][1] = 0
    for i in (0...profit.count-1).reversed(){
        for j in 0..<2{
            var maxProfit = 0
            if j != 0 {
                maxProfit = max(-profit[i] + dp[i+1][0],0 + dp[i+1][1])
            } else{
                maxProfit = max(profit[i] + dp[i+1][1],0 + dp[i+1][0])
            }
            dp[i][j] = maxProfit
        }
    }
    print(dp)
    return dp[0][1]
}
//func maxProfit(_ prices: [Int]) -> Int {
//    var dp = Array(repeating: Array(repeating: 0, count: 2),count: prices.count+1)
//    return stockBuying(0,1, prices,&dp)
//}

// MARK: -  DP 37.  Buy and Sell Stock - III (Memoization)

//
//func calculateMaxProfit(_ index: Int,_ prices: [Int],_ buy: Int,_ cap: Int,_ dp : inout [[[Int]]]) -> Int {
//    if cap == 0{
//        return 0
//    }
//    if index == prices.count{
//        return 0
//    }
//    if dp[index][buy][cap] != -1{
//        return dp[index][buy][cap]
//    }
//    if buy == 1{
//        dp[index][buy][cap] =  max((-prices[index] + calculateMaxProfit(index+1,prices,0,cap, &dp)),(0  + calculateMaxProfit(index+1,prices,1,cap, &dp)))
//        return dp[index][buy][cap]
//    }
//    dp[index][buy][cap] =  max((prices[index] + calculateMaxProfit(index+1,prices,1,cap-1, &dp)),(0  + calculateMaxProfit(index+1,prices,0,cap, &dp)))
//    return dp[index][buy][cap]
//}
//
//func maxProfit(_ prices: [Int]) -> Int {
//    var dp = Array(repeating: Array(repeating: Array(repeating: -1, count: 3), count: 2), count: prices.count)
//    return calculateMaxProfit(0,prices,1,2,&dp)
//}

// MARK: -  DP 37.  Buy and Sell Stock - III (Tabulation)
//func calculateMaxProfit(_ index: Int,_ prices: [Int],_ buy: Int,_ cap: Int,_ after : inout [[Int]],_ curr : inout [[Int]]) -> Int {
//
//
//    for i in (0..<prices.count).reversed(){
//        for j in 0..<2{
//            for k in 1...2{
//                if j == 1{
//                    curr[j][k] =  max((-prices[i] + after[0][k]),(0  + after[1][k]))
//                }else{
//                    curr[j][k] =  max((prices[i] + after[1][k-1]),(0  + after[0][k]))
//                }
//            }
//        }
//        after = curr
//    }
//    return after[buy][cap]
//}

//func maxProfit(_ prices: [Int]) -> Int {
//    var dp = Array(repeating: Array(repeating: Array(repeating: 0, count: 3), count: 2), count: prices.count+1)
//    var after = Array(repeating: Array(repeating: 0, count: 3), count: 2)
//    var curr =  Array(repeating: Array(repeating: 0, count: 3), count: 2)
//    return calculateMaxProfit(0,prices,1,2,&after,&curr)
//}

// MARK: -  DP 38.  Buy and Sell Stock - IV (Memoization)

//func calculateMaxProfit(_ index: Int,_ prices: [Int],_ buy: Int,_ cap: Int,_ after : inout [[Int]],_ curr : inout [[Int]]) -> Int {
//    if cap <= 0{
//        return 0
//    }
//
//    for i in (0..<prices.count).reversed(){
//        for j in 0..<2{
//            for k in 1...cap{
//                if j == 1{
//                    curr[j][k] =  max((-prices[i] + after[0][k]),(0  + after[1][k]))
//                }else{
//                    curr[j][k] =  max((prices[i] + after[1][k-1]),(0  + after[0][k]))
//                }
//            }
//        }
//        after = curr
//    }
//    return after[buy][cap]
//}
//
//
//func maxProfit(_ k: Int, _ prices: [Int]) -> Int {
//    var after = Array(repeating: Array(repeating: 0, count: k+1), count: 2)
//    var curr =  Array(repeating: Array(repeating: 0, count: k+1), count: 2)
//    return calculateMaxProfit(0,prices,1,k,&after,&curr)
//}

// MARK: -  DP 39.  Buy and Sell Stock - coll down (Memoization)


//func calculateMaxProfit(_ index: Int,_ prices: [Int],_ buy: Int,_ dp : inout [[Int]]) -> Int {
//    if index >= prices.count{
//        return 0
//    }
//    if dp[index][buy] != -1{
//        return dp[index][buy]
//    }
//    if buy == 1{
//        dp[index][buy] =  max((-prices[index] + calculateMaxProfit(index+1,prices,0, &dp)),(0  + calculateMaxProfit(index+1,prices,1, &dp)))
//        return dp[index][buy]
//    }
//    dp[index][buy] =  max((prices[index] + calculateMaxProfit(index+2,prices,1, &dp)),(0  + calculateMaxProfit(index+1,prices,0, &dp)))
//    return dp[index][buy]
//}
//
//func maxProfit(_ prices: [Int]) -> Int {
//    var dp = Array(repeating: Array(repeating: -1, count: 2), count: prices.count)
//    return calculateMaxProfit(0, prices, 1, &dp)
//}

// MARK: -  DP 39.  Buy and Sell Stock - coll down (Memoization)


//func calculateMaxProfit(_ index: Int,_ prices: [Int],_ buy: Int,_ dp : inout [[Int]]) -> Int {
//    for i in (0..<prices.count).reversed(){
//        for j in 0...1{
//            if j == 1{
//                dp[i][j] =  max((-prices[i] + dp[i+1][0]),(0  + dp[i+1][1]))
//            }else{
//                dp[i][j] = max((prices[i] + dp[i+2][1]),(0  + dp[i+1][0]))
//            }
//        }
//    }
//    return dp[index][buy]
//}
//
//func maxProfit(_ prices: [Int]) -> Int {
//    var dp = Array(repeating: Array(repeating: 0, count: 2), count: prices.count+2)
//    return calculateMaxProfit(0, prices, 1, &dp)
//}

//MARK: - DP 40. Buy and Sell Stocks With Transaction Fee


func calculateMaxProfit(_ index: Int,_ prices: [Int],_ buy: Int,_ fee: Int,_ dp : inout [[Int]]) -> Int {
    for i in (0..<prices.count).reversed(){
        for j in 0...1{
            if j == 1{
                dp[i][j] =  max((-prices[i] - fee + dp[i+1][0]),(0  + dp[i+1][1]))
            }else{
                dp[i][j] = max((prices[i] + dp[i+1][1]),(0  + dp[i+1][0]))
            }
        }
    }
    return dp[index][buy]
}

func maxProfit(_ prices: [Int], _ fee: Int) -> Int {
    var dp = Array(repeating: Array(repeating: 0, count: 2), count: prices.count+2)
    return calculateMaxProfit(0, prices, 1,fee, &dp)
}


// MARK: - DP 42. printing Longest Increasing Subsequence (another Solution for printing Sequence)

func longestIncreasingSubsequence(_ nums: [Int],_ dp : inout [Int],_ hash : inout [Int]) -> Int{
    var maxi = 1
    var lastIndex = 0
    for i in 0..<nums.count{
        for prev in 0..<i{
            if nums[i] > nums[prev] && dp[i] < 1 + dp[prev]{
                dp[i] = 1 + dp[prev]
                hash[i] = prev
            }
        }
        if dp[i] > maxi{
            maxi = dp[i]
            lastIndex = i
        }
    }
   
    var list = [Int]()
    list.append(nums[lastIndex])
    while hash[lastIndex] != lastIndex{
        lastIndex = hash[lastIndex]
        list.append(nums[lastIndex])
    }
    list = list.reversed()
//    print(list)
    return maxi
}

func lengthOfLIS(_ nums: [Int]) -> Int {
    var dp = Array(repeating: 1, count: nums.count)
    var hash = Array(repeating: 1 ,count: nums.count)
    for i in 0..<nums.count{
        hash[i] = i
    }
//    print(hash)
    return longestIncreasingSubsequence(nums, &dp,&hash)
}
//MARK: - DP 44. Largest Divisible Subset (algorithmic)


func longestDivisibleSubsequence(_ nums: [Int],_ dp : inout [Int],_ hash : inout [Int]) -> [Int]{
    var maxi = 1
    var lastIndex = 0
    var nums = nums
    nums = nums.sorted(by: <)
    for i in 0..<nums.count{
        for prev in 0..<i{
            if nums[i]%nums[prev] == 0 && dp[i] < 1 + dp[prev]{
                dp[i] = 1 + dp[prev]
                hash[i] = prev
            }
        }
        if dp[i] > maxi{
            maxi = dp[i]
            lastIndex = i
        }
    }
   
    var list = [Int]()
    list.append(nums[lastIndex])
    while hash[lastIndex] != lastIndex{
        lastIndex = hash[lastIndex]
        list.append(nums[lastIndex])
    }
    list = list.reversed()
    return list
}


func largestDivisibleSubset(_ nums: [Int]) -> [Int] {
    var dp = Array(repeating: 1, count: nums.count)
    var hash = Array(repeating: 1 ,count: nums.count)
    for i in 0..<nums.count{
        hash[i] = i
    }
    return longestDivisibleSubsequence(nums, &dp,&hash)
}

//MARK: - DP 45. Longest String Chain

func compareString(_ str1: String, _ str2: String) -> Bool {
    let str1 = Array(str1)
    let str2 = Array(str2)
    if str1.count != str2.count + 1{
        return false
    }
    var first = 0
    var second = 0
   
    while first < str1.count{
        if second < str2.count && str1[first] == str2[second]{
            first+=1
            second+=1
        }else{
            first+=1
        }
    }
    if first == str1.count && second == str2.count{
        return true
    }
    return false
    
}
func longestStringSubsequence(_ nums: [String],_ dp : inout [Int]) -> Int{
    let nums = nums.sorted(by: {$0.count < $1.count})
    var maxi = 1
    for i in 0..<nums.count{
        for prev in 0..<i{
            if compareString(nums[i], nums[prev]) && dp[i] < 1 + dp[prev]{
                dp[i] = 1 + dp[prev]
            }
        }
        if dp[i] > maxi{
            maxi = dp[i]
        }
    }
    return maxi
}


func longestStrChain(_ words: [String]) -> Int{
    var dp = Array(repeating: 1, count: words.count)
    return longestStringSubsequence(words, &dp)
}



//MARK: -  DP 46. Longest Bitonic Subsequence

func BitonicSubsequence(_ nums: [Int],_ dp1 : inout [Int],_ dp2: inout [Int]) -> Int{
    var maxi = 0
    for i in 0..<nums.count{
        for prev in 0..<i{
            if nums[i] > nums[prev] && dp1[i] < 1 + dp1[prev]{
                dp1[i] = 1 + dp1[prev]
            }
        }
    }
    
    for i in (0..<nums.count).reversed(){
        for prev in (i+1..<nums.count).reversed(){
            if nums[i] > nums[prev] && dp2[i] < 1 + dp2[prev]{
                dp2[i] = 1 + dp2[prev]
            }
        }
        if dp1[i] > 1 && dp2[i] > 1{
            maxi = max(maxi, dp1[i] + dp2[i] - 1)
        }
    }
    return nums.count - maxi
}

func minimumMountainRemovals(_ nums: [Int]) -> Int{
    var dp1 = Array(repeating: 1, count: nums.count)
    var dp2 = Array(repeating: 1, count: nums.count)
    return BitonicSubsequence(nums, &dp1,&dp2)
}


//MARK: -  DP 47. Number of Longest Increasing Subsequences
func numberOfLIS(_ nums: [Int],_ dp : inout [Int],_ count : inout [Int]) -> Int{
    var maxi = 1
    for i in 0..<nums.count{
        for prev in 0..<i{
            if nums[i] > nums[prev] && dp[i] < 1 + dp[prev]{
                dp[i] = 1 + dp[prev]
                // inherit
                count[i] = count[prev]
            } else if nums[i] > nums[prev] && dp[i] == 1 + dp[prev]{
                // increase  the count
                count[i] += count[prev]
            }
        }
        maxi = max(maxi, dp[i])
    }
    
    var nos = 0
    for i in 0..<nums.count {
        if dp[i] == maxi{
            nos += count[i]
        }
    }
    return nos
}


func findNumberOfLIS(_ nums: [Int]) -> Int {
    var dp1 = Array(repeating: 1, count: nums.count)
    var count = Array(repeating: 1, count: nums.count)
    return numberOfLIS(nums, &dp1,&count)
}
//MARK: -  DP 48. Matrix Chain Multiplication(Memoization)

//func chainMultiplication(_ i: Int,_ j : Int,_ arr: [Int],_ dp: inout [[Int]]) -> Int{
//    var mini = Int.max
//    if i == j{
//        return 0
//    }
//    if dp[i][j] != -1{
//        return dp[i][j]
//    }
//    for k in i..<j{
//        let step = arr[i-1] * arr[k] * arr[j] + chainMultiplication(i, k, arr, &dp) +  chainMultiplication(k+1, j, arr,&dp)
//        if step < mini{
//            mini = step
//        }
//    }
//    dp[i][j] = mini
//    return dp[i][j]
//}
//
//
//func matrixChainMultiplication(_ arr: [Int]) -> Int {
//    var length  = arr.count
//    var dp = Array(repeating: Array(repeating: -1, count: arr.count), count: arr.count)
//    return chainMultiplication(1, length-1, arr,&dp)
//}

//MARK: -  DP 49. Matrix Chain Multiplication(Tabulation)
func chainMultiplication(_ arr: [Int],_ dp: inout [[Int]]) -> Int{
    
    for i in 0..<arr.count{
        dp[i][i] = 0
    }

    for i in (1...arr.count-1).reversed(){
        for j in i+1..<arr.count{
            var mini = Int.max
            for k in i..<j{
                let step = arr[i-1] * arr[k] * arr[j] + dp[i][k] +  dp[k+1][j]
                if step < mini{
                    mini = step
                }
                
            }
            dp[i][j] = mini
        }
    }
    return dp[1][arr.count-1]
}


func matrixChainMultiplication(_ arr: [Int]) -> Int {
    var dp = Array(repeating: Array(repeating: -1, count: arr.count), count: arr.count)
    return chainMultiplication(arr,&dp)
}

//MARK: -  DP 50. Minimum Cost to Cut the Stick( memoization)


//func costToCut(_ i: Int,_ j : Int,_ arr:[Int], _ dp : inout [[Int]]) -> Int{
//    if i > j {
//        return 0
//    }
//    if dp[i][j] != -1{
//        return dp[i][j]
//    }
//    var mini = Int.max
//    for ind in i...j{
//        let minCost = (arr[j+1] - arr[i-1]) + costToCut(i, ind-1, arr,&dp) + costToCut(ind+1, j, arr,&dp)
//        dp[i][j] = min(mini, minCost)
//        mini = min(mini, minCost)
//    }
//    return mini
//}
//
//
//func minCost(_ n: Int, _ cuts: [Int]) -> Int {
//    var newCuts = cuts
//
//    newCuts.insert(0, at: 0)
//    newCuts.append(n)
//    newCuts = newCuts.sorted()
//    var dp = Array(repeating: Array(repeating: -1, count: cuts.count+1), count: cuts.count+1)
//    return costToCut(1,cuts.count,newCuts,&dp)
//}


//MARK: -  DP 50. Minimum Cost to Cut the Stick (Tabulation)
func costToCut(_ c : Int,_ arr:[Int], _ dp : inout [[Int]]) -> Int{


    for i in (1...c).reversed(){
        for j in 1...c{
            if i > j {
                continue
            }
            var mini = Int.max
            for index in i...j{
                let minCost = (arr[j+1] - arr[i-1]) + dp[i][index-1] + dp[index+1][j]
                mini = min(mini, minCost)
            }
            dp[i][j] = mini
        }
    }
    return dp[1][c]
}


func minCost(_ n: Int, _ cuts: [Int]) -> Int {
    var newCuts = cuts

    newCuts.insert(0, at: 0)
    newCuts.append(n)
    newCuts = newCuts.sorted()
    let noOfCuts = cuts.count
    var dp = Array(repeating: Array(repeating: 0, count: noOfCuts+2), count: noOfCuts+2)
    return costToCut(noOfCuts,newCuts,&dp)
}


//MARK: -  DP 51 Burst Balloons (Memoization)
//
//func countpoint(_ i: Int,_ j: Int, _ arr: [Int],_ dp : inout [[Int]]) -> Int{
//
//    if i > j{
//        return 0
//    }
//    if dp[i][j] != -1 {
//        return dp[i][j]
//    }
//    var maxi = Int.min
//    for ind in i...j{
//        let cost = arr[i-1] * arr[ind] * arr[j+1] + countpoint(i, ind-1, arr,&dp) + countpoint(ind+1, j, arr,&dp)
//        maxi = max(maxi, cost)
//
//    }
//    dp[i][j] = maxi
//    return dp[i][j]
//}
//
//
//func maxCoins(_ nums: [Int]) -> Int {
//    let length = nums.count
//    var newNum = nums
//    newNum.append(1)
//    newNum.insert(1, at: 0)
//    var dp = Array(repeating: Array(repeating: -1, count: length+1), count: length+1)
//    return countpoint(1, length, newNum, &dp)
//}

//MARK: -  DP 51 Burst Balloons (Tabulation)

func countpoint(_ l: Int, _ arr: [Int],_ dp : inout [[Int]]) -> Int{
    for i in (1...l).reversed(){
        for j in 1...l{
            if i > j{
                continue
            }
            var maxi = Int.min
            for ind in i...j{
                let cost = arr[i-1] * arr[ind] * arr[j+1] + dp[i][ind-1] + dp[ind+1][j]
                maxi = max(maxi, cost)
            }
            dp[i][j] = maxi
        }
    }
    return dp[1][l]
}


func maxCoins(_ nums: [Int]) -> Int {
    let length = nums.count
    var newNum = nums
    newNum.append(1)
    newNum.insert(1, at: 0)
    var dp = Array(repeating: Array(repeating: 0, count: length+2), count: length+2)
    return countpoint(length, newNum, &dp)
}

//MARK: - DP 52. Evaluate Boolean Expression to True



func calculateBoolean(_ i: Int,_ j: Int ,_ isTrue: Int,_ arr: [Character],_ dp : inout [[[Int]]]) -> Int {
    if i > j {
        return 0
    }
    if i == j {
        if isTrue == 1{
            if arr[i] == "T"{
                return 1
            }else{
                return 0
            }
        }else{
            if arr[i] == "F"{
                return 1
            } else{
                return 0
            }
        }
    }
    
    if dp[i][j][isTrue] != -1{
        return dp[i][j][isTrue]
    }
    
    var ways = 0
    let mod = 10^9+7
    for ind in stride(from: i+1, through: j-1,by: 2){
        print(ind)
        let leftTrue = calculateBoolean(i,ind-1,1,arr,&dp)
        let leftFalse = calculateBoolean(i,ind-1,0,arr,&dp)
        let rightTrue = calculateBoolean(ind+1,j,1,arr,&dp)
        let rightFalse = calculateBoolean(ind+1,j,0,arr,&dp)
        if arr[ind] == "&" {
            if isTrue == 1 {
                ways = (ways + (leftTrue * rightTrue)%mod)%mod
            }else{
                ways = (ways + (rightTrue * leftFalse)%mod + (rightFalse * leftTrue)%mod + (leftFalse * rightFalse)%mod)%mod
            }
        } else if arr[ind] == "|"{
            if isTrue == 1 {
                ways = (ways + (leftTrue * rightTrue)%mod + (leftTrue * rightFalse)%mod + (leftFalse * rightTrue)%mod)%mod
            } else {
                ways = (ways + (leftFalse * rightFalse)%mod)%mod
            }
        } else{
            if isTrue == 1{
                ways = (ways + (leftFalse * rightTrue)%mod + (leftTrue * rightFalse)%mod)%mod
            } else {
                ways = (ways + (leftFalse * rightFalse)%mod + (leftTrue * rightTrue)%mod)%mod
            }
        }
    }
    dp[i][j][isTrue] = ways
    return dp[i][j][isTrue]
}




func cnttrue(_ A: inout String) -> Int {
    let str = Array(A)
    var dp = Array(repeating: Array(repeating: Array(repeating: -1, count: 2), count: str.count), count: str.count)
    return calculateBoolean(0,str.count-1, 1,str,&dp)
}

func evaluateBooleanExpression(_ str: String) -> Int{
    let str = Array(str)
    var dp = Array(repeating: Array(repeating: Array(repeating: -1, count: 2), count: str.count), count: str.count)
    return calculateBoolean(0,str.count-1, 1,str,&dp)
}




// MARK: - DP 53. Palindrome Partitioning - II(memoization)

//
//func isPallindrome(_ i: Int,_ j: Int,_ arr: [Character]) -> Bool{
//    var i = i
//    var j = j
//    while i < j{
//        if arr[i] != arr[j]{
//            return false
//        }
//        i += 1
//        j -= 1
//    }
//    return true
//}
//func costMin(_ i :Int, _ n: Int,_ arr: [Character],_ dp:inout [Int]) -> Int{
//    if  i == n{
//        return 0
//    }
//    if dp[i] != -1{
//        return dp[i]
//    }
//    var minCost = Int.max
//    for j in i..<n{
//        if isPallindrome(i,j,arr){
//            var cost = 1 + costMin(j+1, n, arr,&dp)
//            minCost = min(minCost, cost)
//        }
//    }
//    dp[i] = minCost
//    return dp[i]
//}
//
//func minCut(_ s: String) -> Int {
//    var s = Array(s)
//    var n = s.count
//    var dp = Array(repeating: -1, count: n)
//    return costMin(0, n, s,&dp) - 1
//}
// MARK: - DP 53. Palindrome Partitioning - II(Tabuation)

func isPallindrome(_ i: Int,_ j: Int,_ arr: [Character]) -> Bool{
    var i = i
    var j = j
    while i < j{
        if arr[i] != arr[j]{
            return false
        }
        i += 1
        j -= 1
    }
    return true
}
func costMin(_ i :Int, _ n: Int,_ arr: [Character],_ dp:inout [Int]) -> Int{
    
    for ind in (0..<n).reversed(){
        var minCost = Int.max
        for j in ind..<n{
            if isPallindrome(ind,j,arr){
                let cost = 1 + dp[j+1]
                minCost = min(minCost, cost)
            }
        }
        dp[ind] = minCost
    }

    return dp[0]
}

func minCut(_ s: String) -> Int {
    var s = Array(s)
    var n = s.count
    var dp = Array(repeating: 0, count: n+1)
    return costMin(0, n, s,&dp) - 1
}




// MARK: - DP 54. Partition Array for Maximum Sum (memoization)

//func afterPartitioning(_ i: Int,_ n : Int,_ arr: [Int], _ k: Int,_ dp : inout [Int]) -> Int {
//    if i == n{
//        return 0
//    }
//
//
//    if dp[i] != -1{
//        return dp[i]
//    }
//    var len = 0
//    var maxi = Int.min
//    var maxAns = Int.min
//
//    for ind in i..<min(i+k,n){
//        len += 1
//        maxi = max(maxi, arr[ind])
//        let sum = len * maxi + afterPartitioning(ind+1, n, arr, k,&dp)
//        maxAns = max(maxAns,sum)
//    }
//    dp[i] = maxAns
//    return dp[i]
//}
//
//
//func maxSumAfterPartitioning(_ arr: [Int], _ k: Int) -> Int {
//    let length = arr.count
//    var dp = Array(repeating: -1, count: length)
//    return afterPartitioning(0,length, arr,k,&dp)
//}


// MARK: - DP 54. Partition Array for Maximum Sum (Tabulation)

func afterPartitioning(_ n : Int,_ arr: [Int], _ k: Int,_ dp : inout [Int]) -> Int {
    for index in (0..<n).reversed(){
        var len = 0
        var maxi = Int.min
        var maxAns = Int.min
        for ind in index..<min(index+k,n){
            len += 1
            maxi = max(maxi, arr[ind])
            let sum = len * maxi + dp[ind+1]
            maxAns = max(maxAns,sum)
        }
        dp[index] = maxAns
    }
    return dp[0]
}


func maxSumAfterPartitioning(_ arr: [Int], _ k: Int) -> Int {
    let length = arr.count
    var dp = Array(repeating: 0, count: length+1)
    return afterPartitioning(length, arr,k,&dp)
}


// MARK: - Area of the Histogram

func largestRectangleArea(_ heights: [Int]) -> Int {
    var heights = heights + [Int.min]
    var stack = [Int]()
    var left = [Int]()
    var maxArea = 0
    var length = heights.count
    for i in 0..<length{
        var newLeft = i
        while stack.count > 0 && stack.last! > heights[i] {
            newLeft = left.last!
            let area = (i - left.removeLast()) * stack.removeLast()
            maxArea = max(maxArea,area)
        }
        left.append(newLeft)
        stack.append(heights[i])
    }
    return maxArea
}

// MARK: - DP 55. Maximum Rectangle Area with all 1's

func maximalRectangle(_ matrix: [[Character]]) -> Int {
    var maxArea = 0
    var height = Array(repeating: 0, count: matrix[0].count)
    for i in 0..<matrix.count{
        for j in 0..<matrix[0].count{
            if matrix[i][j] == "1"{
                height[j] += 1
            }else{
                height[j] = 0
            }
        }
        let area = largestRectangleArea(height)
        maxArea = max(maxArea, area)
    }
    return maxArea
}

// MARK: - DP 56. Count Square Submatrices with All Ones
func countSquares(_ matrix: [[Int]]) -> Int {
    var dp = Array(repeating: Array(repeating: 0, count: matrix[0].count), count: matrix.count)
    for j in 0..<matrix[0].count{
        dp[0][j] = matrix[0][j]
    }
    for i in 0..<matrix.count{
        dp[i][0] = matrix[i][0]
    }
    for i in 1..<matrix.count{
        for j in 1..<matrix[0].count{
            if matrix[i][j] == 0{
                dp[i][j] = 0
            } else{
                dp[i][j] = 1 + min(dp[i][j-1],min(dp[i-1][j], dp[i-1][j-1]))
            }
        }
    }
    var sum = 0
    for i in 0..<matrix.count{
        for j in 0..<matrix[0].count{
            sum += dp[i][j]
        }
    }
    return sum
}

// MARK: - 131. Palindrome Partitioning
 
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
func pallindromePartition(_ str: [Character],_ start : Int,_ subString : inout [String],_ allSubString: inout [[String]]){
    if start == str.count{
        allSubString.append(subString)
    } else {
        var partialStr = ""
        for index in start..<str.count{
            partialStr.append(str[index])
            if isPallindrome(str, start, index) == true {
                subString.append(partialStr)
                print(subString)
                pallindromePartition(str, index+1, &subString, &allSubString)
                subString.removeLast()
            }
        }
        
    }
}

func partition(_ s: String) -> [[String]] {
    var arr = Array(s)
    var subString = [String]()
    var allSubString = [[String]]()
    pallindromePartition(arr, 0, &subString, &allSubString)
    return allSubString
}


//MARK: - 221. Maximal Square ( Tabulation )

//func countMaximumSquare(_ matrix:[[Character]],_ dp: inout [[Int]]) -> Int{
//    let row = matrix.count
//    let col = matrix[0].count
//    var ans = Int.min
//    for i in 0..<row{
//        for j in 0..<col{
//            if i == 0 || j == 0{
//                if matrix[i][j] == "1"{
//                    dp[i][j] = 1
//                }
//            }else{
//                if matrix[i][j] == "1"{
//                    dp[i][j] =  1 + min(dp[i][j-1], min(dp[i-1][j], dp[i-1][j-1]))
//                }
//            }
//            ans = max(ans,dp[i][j])
//        }
//    }
//    return ans * ans
//}


//func maximalSquare(_ matrix: [[Character]]) -> Int {
//    var dp = Array(repeating: Array(repeating: 0, count: matrix[0].count), count: matrix.count)
//    return countMaximumSquare(matrix, &dp)
//}
//MARK: - 221. Maximal Square ( Tabulation + space optimization)

func countMaximumSquare(_ matrix:[[Character]]) -> Int{
    let row = matrix.count
    let col = matrix[0].count
    var prev = Array(repeating: 0, count: matrix[0].count + 1)
    var ans = Int.min
    for i in 0..<row{
        var curr = Array(repeating: 0, count: matrix[0].count + 1)
        for j in 0..<col{
            if i == 0 || j == 0{
                if matrix[i][j] == "1"{
                    curr[j] = 1
                }
            }else{
                if matrix[i][j] == "1"{
                    curr[j] =  1 + min(curr[j-1], min(prev[j], prev[j-1]))
                }
            }
            ans = max(ans,curr[j])
        }
        prev = curr
    }
    return ans * ans
}


func maximalSquare(_ matrix: [[Character]]) -> Int {
    
    return countMaximumSquare(matrix)
}

//MARK: - 2002. Maximum Product of the Length of Two Palindromic Subsequences

func maxProduct(_ s: String) -> Int {
    let arr = Array(s)
    var maxi = Int.min
    var n = arr.count
    print(1<<n)
    for i in 1..<(1<<n)-1{
        var stringArr1 = [Character]()
        var stringArr2 = [Character]()
        for j in 0..<n{
            if (i & (1<<j)) != 0 {
                stringArr1.append(arr[j])
            } else{
                stringArr2.append(arr[j])
            } 
        }
        let newRes1 = longestPalindromeSubseq(String(stringArr1))
        let newRes2 = longestPalindromeSubseq(String(stringArr2))
        maxi = max(maxi,newRes1*newRes2)
    }
   
    return maxi
}

//MARK: - 392. Is Subsequence
func checkIsSubsequence(_ s: [Character], _ t: [Character],_ m:Int,_ n:Int,_ dp : [[Bool]]) -> Bool{
    if m==0{
        return true
    }
    if n==0{
        return false
    }
    if dp[m][n] != false{
        return dp[m][n]
    }
    if s[m-1] == t[n-1]{
        return checkIsSubsequence(s, t, m-1, n-1, dp)
    }
    return checkIsSubsequence(s, t, m, n-1, dp)
}
func isSubsequence(_ s: String, _ t: String) -> Bool {
    var s = Array(s)
    var t = Array(t)
    var dp = Array(repeating: Array(repeating: false, count: t.count+1), count: s.count+1)
    return checkIsSubsequence(s, t,s.count,t.count,dp)
}

//MARK: - 1884. Egg Drop With 2 Eggs and N Floors

func minTwoEggDrop(_ n: Int,_ egg : Int,_ dp : inout [[Int]]) -> Int {
    if n == 0 {
        return 0
    }
    if egg == 1 {
        return n
    }
    var ans = Int.max
    if dp[n][egg] != -1{
        return dp[n][egg]
    }
    for i in 1...n{
        ans = min(ans, 1 + max(minTwoEggDrop(i-1, egg-1, &dp), minTwoEggDrop(n-i, egg, &dp)))
    }
    dp[n][egg] = ans
    return dp[n][egg]
}


func twoEggDrop(_ n: Int) -> Int {
    var dp = Array(repeating: Array(repeating: -1, count: 3), count: n+1)
    return minTwoEggDrop(n, 2, &dp)
}


//MARK: - 877. Stone Game
var dp = Array(repeating: Array(repeating: -1, count: 501), count: 501)
func countStoneGame(_ i: Int,_ n : Int,_ piles: inout [Int],_ dp : inout [[Int]]) -> Int{
    if i > n{
        return 0
    }
    if dp[i][n] != -1 {
        return dp[i][n]
    }
    dp[i][n] = max(piles[i]-countStoneGame(i+1, n, &piles, &dp), piles[n] - countStoneGame(i, n-1, &piles, &dp))
    return dp[i][n]
}

func stoneGame(_ piles: [Int]) -> Bool {
    var piles = piles
    var n = piles.count
    return countStoneGame(0,n-1, &piles, &dp) > 0 ? true : false
}

//MARK: - 1140. Stone Game II

func helper(_ i : Int,_ arr: [Int],_ dp: inout [Int]) -> Int{
    if i >= arr.count{
        return 0
    }
    if dp[i] != -1{
        return dp[i]
    }
    var ans = Int.min
    ans = max(ans, arr[i] - helper(i+1, arr, &dp))
    if i+1 < arr.count{
        ans = max(ans, arr[i] + arr[i+1] - helper(i+2, arr, &dp))
    }
    if i+2 < arr.count{
        ans = max(ans, arr[i] + arr[i+1] + arr[i+2] - helper(i+3, arr, &dp))
    }
    dp[i] = ans
    return dp[i]
}

func stoneGameIII(_ stoneValue: [Int]) -> String {
    var dp = Array(repeating: -1, count: 5001)
    var alice = helper(0, stoneValue,&dp)
    if alice > 0{
        return "Alice"
    }else if alice == 0{
        return "Tie"
    }else{
        return "Bob"
    }
}


func calculateMinLeafSum(_ start: Int,_ end: Int,_ dp: inout [[Int]],_ arr: [Int]) -> Int{
    if start == end{
        return 0
    }
    
    if dp[start][end] != -1{
        return dp[start][end]
    }
    var ans = Int.max
    for i in start..<end{
        var left = calculateMinLeafSum(start,  i, &dp,arr)
        var right = calculateMinLeafSum(i+1, end, &dp,arr)
        var maxLeft = 0
        var maxRight = 0
        for j in start...i{
            maxLeft = max(maxLeft, arr[j])
        }
        for k in i+1...end{
            maxRight = max(maxRight, arr[k])
        }
        ans = min(ans, left + right + (maxLeft * maxRight))
    }
    dp[start][end] = ans
    return dp[start][end]
}

func mctFromLeafValues(_ arr: [Int]) -> Int {
    var len = arr.count
    var dp = Array(repeating: Array(repeating: -1, count: len), count: len)
    return calculateMinLeafSum(0,len-1, &dp,arr)
}

func calculateDistributeCookies(_ start:Int,_ k: Int,_ cookies: [Int],_ dp : inout [Int],_ ans:inout Int) {
    if start == cookies.count{
        var maxCoookies = Int.min
        for i in 0..<k{
            maxCoookies = max(maxCoookies, dp[i])
        }
        ans = min(ans,maxCoookies)
        return
    }
    
    for i in 0..<k{
        dp[i] += cookies[start]
        calculateDistributeCookies(start+1, k, cookies, &dp, &ans)
        dp[i] -= cookies[start]
    }
    
}


func distributeCookies(_ cookies: [Int], _ k: Int) -> Int {
    var ans = Int.max
    var dp = Array(repeating: 0, count: k)
    calculateDistributeCookies(0,k, cookies,&dp,&ans)
    return ans
}


func numTilings(_ n: Int) -> Int {
    var mod = 1000000007
    if n == 1 {
        return 1
    }
    if n == 2 {
        return 2
    }
    var dp = Array(repeating: -1, count: n+1)
    dp[0] = 1
    dp[1] = 1
    dp[2] = 2
    for i in 3...n{
        dp[i] = (dp[i-1] * 2 + dp[i-3]) % mod
    }
    return dp[n]
}


func calculateLis(_ index: Int,_ prev: Int,_ A: [Int],_ dp : inout [[Int]]) -> Int {
    if index == A.count{
        return 0
    }
    if dp[index][prev+1] != -1{
        return dp[index][prev+1]
    }
    var notPick = 0 + calculateLis(index+1, prev, A, &dp)
    var pick = Int.min
    if prev == -1 || A[prev] < A[index] {
        pick = 1 + calculateLis(index+1, index, A, &dp)
    }
    dp[index][prev+1] = max(notPick,pick)
    return dp[index][prev+1]
    
}

func lis(_ A: [Int]) -> Int {
    var dp = Array(repeating: Array(repeating: -1, count: A.count+1), count: A.count)
    return calculateLis(0,-1,A,&dp)
}


func largeRectArea(_ arr: [Int]) -> Int{
    var length = arr.count
    var stack = [Int]()
    var leftSmall = Array(repeating: -1, count: length)
    var rightSmall = Array(repeating: -1, count: length)
    for i in 0..<length{
        while !stack.isEmpty && arr[stack.last!] >= arr[i] {
            stack.popLast()
        }
        if stack.isEmpty {
            leftSmall[i] = 0
        }else{
            leftSmall[i] = stack.last! + 1
        }
        stack.append(i)
    }
    stack.removeAll()
    for i in (0..<length).reversed(){
        while !stack.isEmpty && arr[stack.last!] >= arr[i] {
            stack.popLast()
        }
        if stack.isEmpty {
            rightSmall[i] = length-1
        }else{
            rightSmall[i] = stack.last! - 1
        }
        stack.append(i)
    }
    
    var maxArea = 0
    for i in 0..<length{
        maxArea = max(maxArea, arr[i] * (rightSmall[i] - leftSmall[i] + 1))
    }
    return maxArea
}

func maximalRectangle(_ A: inout [[Int]]) -> Int {
    var maxArea = 0
    var height = Array(repeating: 0, count: A[0].count)
    for i in 0..<A.count{
        for j in 0..<A[0].count{
            if A[i][j] == 1{
                height[j] += 1
            }else{
                height[j] = 0
            }
        }
        var area = largeRectArea(height)
        maxArea = max(maxArea, area)
    }
    return maxArea
}




func maxProduct(_ A: [Int]) -> Int {
    var ans  = A[0]
    var maxNum = ans
    var minNum = ans
    var length = A.count
    for i in 1..<length{
        if A[i] < 0{
            swap(&maxNum, &minNum)
        }
        maxNum = max(A[i], A[i] * maxNum)
        minNum = min(A[i], A[i] * minNum)
        ans = max(ans, maxNum)
    }
    return ans
}

func calculateNumDecoding(_ index:Int,_ arr: [Character],_ dp : inout [Int]) -> Int{
    
    if index > arr.count{
        return 0
    }
    if index == arr.count{
        return 1
    }
    
    if dp[index] != -1{
        return dp[index]
    }
    var choice1 = 0
    var choice2 = 0
    var notCombine = Int(String(arr[index])) ?? 0
    if notCombine > 0 {
        choice1 = calculateNumDecoding(index+1, arr, &dp)
        if index + 1 < arr.count{
            let combine =  Int(String(arr[index...index+1])) ?? 0
            if combine > 0 && combine <= 26{
                choice2 = calculateNumDecoding(index+2, arr, &dp)
            }
        }
    }
    dp[index] = choice1 + choice2
    return dp[index]
}

func numDecodings(_ A: inout String) -> Int {
    var arr = Array(A)
    var dp = Array(repeating: -1, count: A.count+1)
    return calculateNumDecoding(0, arr, &dp)
}

func calculateMaxProfit(_ index: Int,_ price: [Int],_ cap: Int,_ buy:Int, _ dp : inout [[[Int]]]) -> Int{
    if cap == 0{
        return 0
    }
    
    if index == price.count{
        return 0
    }
    
    if dp[index][cap][buy] != -1 {
        return dp[index][cap][buy]
    }
    
    if buy == 1{
        dp[index][cap][buy] =  max((-price[index] + calculateMaxProfit(index+1, price, cap, 0, &dp)),(0 + calculateMaxProfit(index+1, price, cap, 1, &dp)))
        return dp[index][cap][buy]
    }
    dp[index][cap][buy] = max((price[index] + calculateMaxProfit(index+1, price, cap-1, 1, &dp)),(0 + calculateMaxProfit(index+1, price, cap, 0, &dp)))
    return dp[index][cap][buy]
}

func maxProfit(_ A: [Int]) -> Int {
    var dp =  Array(repeating: Array(repeating: Array(repeating: -1, count: 2), count: 3), count: A.count+1)
    return calculateMaxProfit(0, A, 2, 1, &dp)
}


func calculateScrambleString(_ A:[Character],_ B: [Character],_ dp: inout [String:Bool]) -> Bool {
    let key = String(A) + "-" + String(B)
    if let value = dp[key]{
        return value
    }
    if A.count == 1{
        return A[0] == B[0]
    }
    var n = A.count
    for i in 1..<n{
        if (calculateScrambleString(Array(A[0..<i]),Array(B[0..<i]),&dp) && calculateScrambleString(Array(A[i..<n]), Array(B[i..<n]), &dp))  || (calculateScrambleString(Array(A[0..<i]),Array(B[i..<n]),&dp) && calculateScrambleString(Array(A[i..<n]), Array(B[0..<i]), &dp)) {
            dp[key] = true
            return dp[key]!
        }
    }
    dp[key] = false
    return dp[key]!
    
    
}


func isScramble(_ A: String, _ B: String) -> Bool {
    var dp : [String:Bool] = [:]
    var A = Array(A)
    var B = Array(B)
    return calculateScrambleString(A, B, &dp)
}




func solve(_ A: inout [[Int]]) -> Int {
    var n =  A.count
    var dp = Array(repeating: Array(repeating: -1, count: 3), count: n)
    dp[0][0] = A[0][0]
    dp[0][1] = A[0][1]
    dp[0][2] = A[0][2]
    
    for i in 1..<n{
        dp[i][0] =  A[i][0] + min(dp[i-1][1], dp[i-1][2])
        dp[i][1] =  A[i][1] + min(dp[i-1][0], dp[i-1][2])
        dp[i][2] =  A[i][2] + min(dp[i-1][0], dp[i-1][1])
    }
    return min(dp[n-1][0],min(dp[n-1][1], dp[n-1][2]))
    
    
}




func calculateLip(_ matrix: [[Int]],_ row: Int,_ col: Int,_ dp :inout [[Int]],_ pos: inout Bool) -> Int{
    var curMax = 1
    if row < 0 || col < 0 || row >= matrix.count || col >= matrix[0].count{
        return 0
    }
    
    if row == matrix.count-1 && col == matrix[0].count-1{
        pos = true
        return 1
    }
    
    if dp[row][col] != -1{
        return dp[row][col]
    }
    if row+1 >= 0 && row+1 < matrix.count && matrix[row+1][col] > matrix[row][col]{
        curMax = max(curMax,1+calculateLip(matrix, row+1, col, &dp, &pos))
    }
    if col+1 >= 0 && col+1 < matrix[0].count && matrix[row][col+1] > matrix[row][col]{
        curMax = max(curMax,1+calculateLip(matrix, row, col+1, &dp, &pos))
    }
    if col-1 >= 0 && col-1 < matrix[0].count && matrix[row][col-1] > matrix[row][col]{
        curMax = max(curMax,1+calculateLip(matrix, row, col-1, &dp,&pos))
    }
    if row-1 >= 0 && row-1 < matrix.count && matrix[row-1][col] > matrix[row][col]{
        curMax = max(curMax,1+calculateLip(matrix, row-1, col, &dp,&pos))
    }
    dp[row][col] = curMax
    return dp[row][col]
}

func lipSolve(_ A: inout [[Int]]) -> Int {
    var pos = false
    var row = A.count
    var col = A[0].count
    var dp = Array(repeating: Array(repeating: -1, count: col), count: row)
    var curMax = 0
    for i in 0..<row{
        for j in 0..<col{
            curMax = max(curMax, calculateLip(A, i, j, &dp,&pos))
        }
    }
    return pos ? curMax : -1
}

func canCross(_ stones: [Int]) -> Bool {
    if stones.isEmpty || stones[1] - stones[0] > 1{return false}
    var stonePosition = [Int: Int]()
    for i in 0..<stones.count{
        stonePosition[stones[i],default: 0] += i
    }
    var dp : [Set<Int>] = Array(repeating: [], count: stones.count)
    dp[0].insert(0)
    
    for i in 0..<stones.count{
        for k in dp[i]{
            let nextJump = [k,k-1,k+1].filter({$0 > 0})
            for jump in nextJump {
                let afterJumpPosition = jump + stones[i]
                if let index = stonePosition[afterJumpPosition]{
                    dp[index].insert(jump)
                }
            }
        }
    }
    return !dp[dp.count-1].isEmpty
}

//func minimumJumps(_ forbidden: [Int], _ a: Int, _ b: Int, _ x: Int) -> Int {
//    var queue = [((Int,Int),Int)]()
//    var forbiddenMap = [Int: Int]()
//    for i in forbidden{
//        forbiddenMap[i,default:0] += 1
//    }
//    queue.append(((0,0),0))
//    var visitedArr = Array(repeating: Array(repeating: 0, count: 2), count: 6001)
//    visitedArr[0][0] = 1
//    while !queue.isEmpty{
//        var position = queue.first!.0.0
//        var move = queue.first!.0.1
//        var noOfStep = queue.first!.1
//        queue.removeFirst()
//        if position == x{
//            return noOfStep
//        }
//        if position + a < 6001 && !forbidden.contains(position+a) && visitedArr[position+a][0] == 0{
//            queue.append(((position+a,0),noOfStep+1))
//            visitedArr[position+a][0] = 1
//        }
//
//        if position - b >= 0 && move == 0 && !forbidden.contains(position-b) && visitedArr[position-b][1] == 0{
//            queue.append(((position-b,1),noOfStep+1))
//            visitedArr[position-b][1] = 1
//        }
//    }
//    return -1
//}

// MARK: - Minimum Jumps to Reach Home


func calculateMinimumJumps(_ pos : Int,_ move:Int,_ forbidden: [Int], _ a: Int, _ b: Int, _ x: Int,_ dp: inout [[Int]]) -> Int{
    if pos == x{
        return 0
    }
    if pos < 0 || pos > 6001 || forbidden.contains(pos){
        return Int(1e9)
    }
    if dp[pos][move] != -1{
        return dp[pos][move]
    }
    dp[pos][move] =  1 + calculateMinimumJumps(pos+a, 0, forbidden, a, b, x, &dp)
    if move == 0{
        dp[pos][move] = min(dp[pos][move],1 + calculateMinimumJumps(pos-b, 1, forbidden, a, b, x, &dp))
    }
    return dp[pos][move]
    
}
func minimumJumps(_ forbidden: [Int], _ a: Int, _ b: Int, _ x: Int) -> Int {
    
    var dp = Array(repeating: Array(repeating: -1, count: 2), count: 7001)
    var steps = calculateMinimumJumps(0,0, forbidden, a, b, x, &dp)
    if steps >= Int(1e7){
        return -1
    }
    return steps
}


// MARK: - 1937. Maximum Number of Points with Cost

func maxPoints(_ points: [[Int]]) -> Int {
    var row = points.count
    var col = points[0].count
    var dp = Array(repeating: 0, count:col)
    var left = Array(repeating: 0, count:col)
    var right = Array(repeating: 0, count:col)
    for i in 0..<col{
        dp[i] = points[0][i]
    }
    
    for i in 1..<row{
        for j in 0..<col{
            if j == 0{
                left[j] = dp[j]
            }else{
                left[j] = max(dp[j],left[j-1]-1)
            }
            
        }
//        print(left)
        for k in (0..<col).reversed(){
            if k == col-1{
                right[k] = dp[k]
            }else{
                right[k] = max(dp[k],right[k+1]-1)
            }
        }
//        print(right)
        for c in 0..<col{
            dp[c] = points[i][c] + max(left[c],right[c])
        }
    }
    return dp.max()!
}



func calculateTicketCost(_ index: Int,_ days: [Int], _ costs: [Int],_ dp: inout [Int]) -> Int{
    if index >= days.count{
        return 0
    }
    if dp[index] != -1 {
        return dp[index]
    }
    var option1 = costs[0] + calculateTicketCost(index+1,days,costs,&dp)
    var ticket2 = index
    while ticket2 < days.count{
        if days[ticket2] < days[index]+7{
            ticket2+=1
        }
        else{
            break
        }
    }
    var option2 = costs[1] + calculateTicketCost(ticket2,days,costs,&dp)
    
    
    var ticket3 = index
    while ticket3 < days.count{
        if days[ticket3] < days[index]+30{
            ticket3+=1
        }
        else{
            break
        }
    }
    var option3 = costs[2] + calculateTicketCost(ticket3,days,costs,&dp)
    dp[index] = min(option1, min(option2, option3))
    return dp[index]
}


func mincostTickets(_ days: [Int], _ costs: [Int]) -> Int {
    var dp = Array(repeating: -1, count: 366)
    return calculateTicketCost(0,days,costs,&dp)
}


// MARK: - 740. Delete and Earn


func deleteAndEarn(_ nums: [Int]) -> Int {
    var dp = Array(repeating: 0, count: 10001)
    var map = Array(repeating: 0, count: 10001)
    for i in nums{
        map[i] += i
    }
    dp[1] = map[1]
    for i in 2..<10001{
        dp[i] = max(dp[i-1], dp[i-2] + map[i])
    }
    return dp[10000]
}

func minFlipsMonoIncr(_ s: String) -> Int {
    var arr = Array(s)
    var m = 0
    for i in 0..<arr.count{
        if arr[i] == "0"{
            m += 1
        }
    }
    var ans = m
    for i in 0..<arr.count{
        if arr[i] == "0"{
            m -= 1
            ans = min(ans, m)
        }else {
            m += 1
        }
    }
    return ans
}

func nthUglyNumber(_ n: Int) -> Int {
    var dp = Array(repeating:0, count: n)
    
    dp[0] = 1
    var pointer1 = 0
    var pointer2 = 0
    var pointer3 = 0
    for i in 1..<n{
        var twoMultiple = dp[pointer1] * 2 // 1*2
        var threeMultiple  = dp[pointer2] * 3
        var fiveMultiple = dp[pointer3] * 5
        dp[i] = min(twoMultiple,min(threeMultiple, fiveMultiple))
        
        if dp[i] == twoMultiple {
            pointer1+=1
        }
        if dp[i] == threeMultiple {
            pointer2+=1
        }
        if dp[i] == fiveMultiple {
            pointer3+=1
        }
    }
    return dp[n-1]
}

func maxProductPath(_ grid: [[Int]]) -> Int {
    var row = grid.count
    var col = grid[0].count
    var dpMax = Array(repeating: Array(repeating: -1, count: col), count: row)
    var dpMin = Array(repeating: Array(repeating: -1, count: col), count: row)
    for i in 0..<row{
        if i == 0 {
            dpMax[0][0] = grid[0][0]
            dpMin[0][0] = grid[0][0]
        }else{
            dpMax[i][0] = grid[i][0] * dpMax[i-1][0]
            dpMin[i][0] = grid[i][0] * dpMin[i-1][0]
        }
    }
    
    for i in 1..<col{
        dpMax[0][i] = grid[0][i] * dpMax[0][i-1]
        dpMin[0][i] = grid[0][i] * dpMin[0][i-1]
    }
    
    for i in 1..<row{
        for j in 1..<col{
            if grid[i][j] >= 0{
                dpMax[i][j] = max(dpMax[i-1][j],dpMax[i][j-1]) * grid[i][j]
                dpMin[i][j] = min(dpMin[i-1][j],dpMin[i][j-1]) * grid[i][j]
            }else{
                dpMax[i][j] = min(dpMin[i-1][j],dpMin[i][j-1]) * grid[i][j]
                dpMin[i][j] = max(dpMax[i-1][j],dpMax[i][j-1]) * grid[i][j]
            }
        }
    }
    print(dpMax)
    print(dpMin)
    var result = max(dpMax[row-1][col-1], dpMin[row-1][col-1]) % 1000000007
    return result < 0 ? -1 : result
}

func lastStoneWeightII(_ stones: [Int]) -> Int {
    var total = stones.reduce(0, +)
    var maxSum = 0
    let targetSum = total >> 1
    var dp = Array(repeating: false, count: targetSum+1)
    dp[0] = true
    for stone in stones where stone <= targetSum {
        for sum in (stone...targetSum).reversed() {
            dp[sum] = (dp[sum] || dp[sum-stone])
            if dp[sum] {
                maxSum = max(maxSum,sum)
                if maxSum == total/2 {
                    return total - maxSum*2
                }
            }
        }
    }
    return total - maxSum*2
}

var result = 0
func countArrangement(_ n: Int) -> Int {
    var arr = [Int]()
    for i in 0..<n{
        arr.append(i+1)
    }
    checkCountArrangement(&arr, 0,result)
    return result
}

func checkCountArrangement(_ arr: inout [Int],_ j: Int,_ count: Int)  {
    if j == arr.count{
        result += 1
    }
    for i in j..<arr.count{
        arr.swapAt(i, j)
        if arr[j] % (j + 1) == 0 || (j + 1) % arr[j] == 0{
            checkCountArrangement(&arr, j+1, result)
        }
        arr.swapAt(i, j)
    }
}
var newdp = Array(repeating: Array(repeating: Array(repeating: -1, count: 101), count: 101), count: 101)
func removeBoxes(_ boxes: [Int]) -> Int {
//    var dp = Array(repeating: Array(repeating: Array(repeating: -1, count: length+1), count: length+1), count: length+1)
    return calculateRemoveBoxes(0,boxes.count-1, boxes,0)
}


func calculateRemoveBoxes(_ start: Int,_ end : Int,_ boxes: [Int],_ streak: Int) -> Int{
    var start = start
    var streak = streak
    if start > end{
        return 0
    }
    while start + 1 <= end && boxes[start] == boxes[start+1]{
        start += 1
        streak += 1
    }
    if newdp[start][end][streak] != -1 {
        return newdp[start][end][streak]
    }
    var maxi = (streak + 1) * (streak + 1) + calculateRemoveBoxes(start+1, end, boxes, 0)
    for i in start+1...end{
        if boxes[start] == boxes[i]{
            maxi = max(maxi,calculateRemoveBoxes(start+1, i-1, boxes, 0) + calculateRemoveBoxes(i, end, boxes, streak + 1))
        }
    }
    newdp[start][end][streak] = maxi
    return newdp[start][end][streak]
}


//var dp = [Int:Int]()
//var height = [30,10,60,10,60,50]
//frogJumpwithDp(height.count, height, 2)
//frogJump(height.count, height, 2,)
//rob([1,2,3,1])
//training([[1,2,5],[3 ,1 ,1],[3,3,3]])
//uniquePaths(3,7)
//uniquePathsWithObstacles([[0,0,0],[0,1,0],[0,0,0]])
//uniquePathsWithObstacles([[0,0,0],[0,1,0],[0,0,0]])
//var arr = [[1,3,1],[1,5,1],[4,2,1]]
//minPathSum(arr)
//minimumTotal([[2],[3,4],[6,5,7],[4,1,8,3]])
//minFallingPathSum([[2,1,3],[6,5,4],[7,8,9]])
//isInterleave("aabcc","dbbca", "aadbbcbcac")
//cherryPickup([[3,1,1],[2,5,1],[1,5,5],[2,1,1]])
//maxResult([1,-1,-2,4,-7,3],2)
//subSetToK(k: 3,arr: [1,2,3,4])
//subarraySum([ 68, 35, 1, 70, 25, 79, 59, 63, 65, 6, 46 ],282)
//canPartition([1,5,11,5])
//minimumDifference([1,3,7])
//findWays([1,2,2,3], 3)
//countPartition(, , )
//knapSackRobber([ 96, 43, 28, 37, 92, 5, 3, 54, 93 ],[ 359, 963, 465, 706, 146, 282, 828, 962, 492 ],383)
//minimumCoin([1,2,3], 7)
//findTargetSumWays([1,0], 1)
//change(10, [10])
//unboundedKnapsack([2,4,6],[5,11,13], 10)
//rodCutting(target: 5, num: [2, 5, 7 ,8 ,10])
//longestCommonSubsequence("abcde", "ace")
//longestCommonSubsequence("abc", "def" )
//printLongestCommonSubsequence("abcde","bdgek")
//longestCommonSubstring("abcde","bdgek")
//longestPalindromeSubseq("bbbab")
//minInsertions("leetcode")
//minDistance("sea","eat")
//shortestCommonSupersequence("abac","cab")
//numDistinct("babgbag","bag")
//lengthOfLIS([0,8,4,12,2,10,6,14,1,9,5,13,3,11,7,15])
//longestIncreasingPath([[9,9,4],[6,6,8],[2,1,1]])
//editDistance("horse", "ros")
//editDistance("", "")
//isMatch("aa", "*")
//isMatch("zacabz","*a?b*")
//isMatch("", "******")
//maxProfit([1,2,3,0,2])
//maxProfit([1,3,2,8,4,9],2)
//largestDivisibleSubset([1,2,3])
//longestStrChain(["a","b","ba","bca","bda","bdca"])
//minimumMountainRemovals([2,1,1,5,6,2,3,1])
//minimumMountainRemovals([9,8,1,7,6,5,4,3,2,1])
//findNumberOfLIS([2,2,2,2,2])
//matrixChainMultiplication([1, 2, 3, 4, 3])
//minCost(7,[1,3,4,5])
//maxCoins([3,1,5,8])
//evaluateBooleanExpression("T^T^T^F|F&F^F|T^F^T")
//var str = "F|T^T&F"
//cnttrue(&str)
//minCut("aab")
//maxSumAfterPartitioning([1,15,7,9,2,5,10], 3)
//largestRectangleArea([2,4])
//maximalRectangle([["1","0","1","0","0"],["1","0","1","1","1"],["1","1","1","1","1"],["1","0","0","1","0"]])
//countSquares([[0,1,1,1],[1,1,1,1],[0,1,1,1]])
//partition("aab")
//maximalSquare([["1","0","1","0","0"],["1","0","1","1","1"],["1","1","1","1","1"],["1","0","0","1","0"]])
//maxProduct("accbcaxxcxx")
//maxProduct("bb")
//maxProduct("leetcodecom")
//isSubsequence("abc", "ahbgdc")
//twoEggDrop(100)
//stoneGame([1,2,3,7])
//stoneGameIII([1,2,3,-9])
//findAllConcatenatedWordsInADict(["cat","cats","catsdogcats","dog","dogcatsdog","hippopotamuses","rat","ratcatdogcat"])
//mctFromLeafValues([6,2,4])
//distributeCookies([8,15,10,20,8], 2)
//numTilings(3)
//lis([0,8,4,12,2,10,6,14,1,9,5,13,3,11,7,15])
//largeRectArea([2,1,5,6,2,3,1])
//var arr = [["1","1","1"],["0","1","1"],["1","0","0"]]
//maximalRectangle(&arr)
//maxProduct( [2, 3, -2, 4])
//var arr = [[35, 1, 70, 25, 79, 59, 63, 65],[6, 46, 82, 28, 62, 92, 96, 43]]
//numDecodings(&arr)
//maxProfit([3,3,5,0,0,3,1,4])
//isScramble("phqtrnilf","ilthnqrpf")
//solve(&arr)
//longestIncreasingPath(arr)
//lipSolve(&arr)
//canCross([0,1,3,5,6,8,12,17])
//numberOfArithmeticSlices([1,2,3,4])
//minimumJumps([14,4,18,1,15],3,15,9)
//maxPoints([[1,2,3],[1,5,1],[3,1,1]])
//maxPoints([[10]])
//mincostTickets([1,4,6,7,8,20],[2,7,15])
//deleteAndEarn([2,2,3,3,3,4])
//minFlipsMonoIncr("00110")
//nthUglyNumber(10)
//kConcatenationMaxSum([1,2],3)
//maxProductPath([[-1,-2,-3],[-2,-3,-3],[-3,-3,-2]])
//lastStoneWeightII([2,7,4,1,8,1])
//countArrangement(2)
removeBoxes([1,3,2,2,2,3,4,3,1])
