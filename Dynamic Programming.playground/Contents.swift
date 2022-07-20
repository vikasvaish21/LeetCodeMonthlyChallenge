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
func uniquePaths(_ row:Int,_ col:Int) -> Int{
//    var dp = Array(repeating: Array(repeating: -1, count: col), count: row)
    var arr = [Int](repeating: 0, count: col)
    return path(row-1, col-1)
}


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

var dp = [Int:Int]()
var height = [30,10,60,10,60,50]
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
maxResult([1,-1,-2,4,-7,3],2)
