import Foundation
//
//class Solution {
//
//    func numTilePossibilities(_ tiles: String) -> Int {
//           var count = 0
//           for i in 1...tiles.count{
//               count+=Solve(tiles, i)
//           }
//           return count
//       }
//
//    func Solve(_ tiles: String,_ n :Int) -> Int{
//           guard n > 0 else{
//               return 1
//           }
//           var visited = Set<Character>()
//           var count = 0
//           for i in 0..<tiles.count{
//               let index = tiles.index(tiles.startIndex,offsetBy: i)
//               let char = tiles[index]
//               guard !visited.contains(char) else{continue}
//               visited.insert(char)
//               var newTiles = tiles
//               newTiles.remove(at: index)
//               count += Solve(newTiles, n-1)
//
//           }
//        return count
//       }
//
//
//    var result = [String]()
//    var max = 0
//    var stack = [Character]()
//    func generateParenthesis(_ n: Int) -> [String] {
//        max = n
//        backtrack(0,0)
//        return result
//    }
//
//    func backtrack(_ openN:Int,_ CloseN:Int)  {
//        guard stack.count < 2*max else {
//            result.append(String(stack))
//            return
//        }
//
//        if openN < max{
//            stack.append("(")
//            backtrack(openN+1, CloseN)
//            stack.removeLast()
//        }
//        if CloseN < openN{
//            stack.append(")")
//            backtrack(openN, CloseN+1)
//            stack.removeLast()
//        }
//    }
//
//    func letterCombinations(_ digits: String) -> [String] {
//
//    }
//
//}
//
//var sol = Solution()
//sol.numTilePossibilities("AAB")
//sol.generateParenthesis(3)


//DispatchQueue.main.async{
//    print("A is working")
//    DispatchQueue.main.async{
//        print("B is working")
//        DispatchQueue.main.async{
//            print("C is working")
//            DispatchQueue.main.sync{
//                print("D is working")
//            }
//        }
//    }
//}
//func deadLock() {
//    let myQueue = DispatchQueue(label: "myLabel", attributes: .concurrent)
//    myQueue.async {
//        myQueue.sync {
//            print("Inner block called")
//        }
//        print("Outer block called")
//    }
//}
//deadLock()

var q = [[String]]()
func solveNQueens(_ n: Int) -> Int {
    var result = [[String]]()
    q = Array(repeating: Array(repeating:".",count:n),count:n)
    solve(0,n,&result)
    return result.count
}

func solve(_ col: Int,_ n: Int,_ result: inout [[String]]) -> Bool{
    if col == n{
        result.append(q.map{$0.joined()})
    } else{
        for row in 0..<n{
            if isSafe(row,col,n: n){
                q[row][col] = "Q"
                if solve(col+1,n,&result){
                    return true
                }
                q[row][col] = "."
            }
        }
    }
    return false
}

func isSafe(_ row: Int,_ col:Int,n:Int) -> Bool{
    var i = row
    var j = col
    while j>=0 && i>=0{
        if q[i][j] == "Q"{
            return false
        }
        i-=1
        j-=1
    }

    i = row
    j = col
    while j >= 0{
        if q[i][j] == "Q"{
            return false
        }
        j-=1
    }
    i = row
    j = col
    while i<n && j>=0{
        if q[i][j] == "Q"{
            return false
        }
        i+=1
        j-=1
    }
    return true
}

solveNQueens(4)
