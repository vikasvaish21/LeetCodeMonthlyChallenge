func findMissing(_ arr: [Int]) -> Int{
    if arr.isEmpty{
        return 0
    }
    var arr = arr
    let sum = arr.reduce(0,+)
    arr = arr.sorted()
    let first = arr[0]
    let last = arr[arr.count-1]
    var total = 0
    var missingElement = 0
    for i in first...last{
        total+=i
    }
    missingElement = total - sum
    return missingElement
}

var arr = [Int]()
findMissing(arr)


