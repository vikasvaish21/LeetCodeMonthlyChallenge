import UIKit
import Foundation

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
longestCommonSubsequence("abcde", "ace")
//longestCommonSubsequence("abc", "def" )
printlongestCommonSubsequence("abcde","bdgek")
