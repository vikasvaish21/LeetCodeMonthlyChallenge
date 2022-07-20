import UIKit

let f = {(x: Int) -> Int
    in return x+42
    
}
f(9)
let closure = [f,
               {(x:Int) -> Int in return x*2},
               {x in return x-8},
               {x in x*x},
               {$0 * 42}
            ]

for i in closure{
    i(42)
}
let deepThought = { (question: String)  in "The answer to \"\(question)\" is \(7 * 6)!" }

deepThought("how old are you")


func foo(x:Int) -> Int{
    return 42 + x
}

let bar = {(x:Int) ->Int in
    42+x
}
func curly(n:Int) -> Int{
    return n*n
}
func larry(x:Int) -> Int{
    return x * (x+1)
}
func moe(m:Int) -> Int {
    return m * (m-1) * (m-2)
}

func baz(x:Int) -> Double{
    return Double(x)/42
}

var stooges = [curly,larry,moe,bar,foo]
for stooge in stooges{
    stooge(42)
}

typealias integer = Int
let z: integer = 42
let zz : Int = 42
typealias InttoInt = (Int) -> Int
typealias IntMaker = () -> Int
 // Capture varible


func makeCounter() -> IntMaker{
    var n = 0
    func adder() -> Int{
        n = n + 1
        return n
    }
    return adder
}
let counter1 = makeCounter()
let counter2 = makeCounter()
counter1()
counter1()
counter1()
//let q = DispatchQueue.global(qos: .userInteractive)
//
//q.async { () -> Void in
//    print("tic")
//}
//
//print("tac")


//DispatchQueue.global().async {
//    sleep(2)
//    print("aSync: Inside")
//}
//print("aSync: outside")

//DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(5)) {
//    print("first Delay of 5 second")
//}
//DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
//    print("first Delay of 2 second")
//}

func isPalindrome(_ x: Int) -> Bool {
    
    let x = String(x)
    let arr = Array(x)
    var length = arr.count - 1
    var i = 0
    while i<=length {
        if arr[i] == arr[length] {
            i+=1
            length-=1
        }else{
            return false
        }
    }
    return true
}
func letterCombinations(_ digits: String) -> [String] {
    var letters = ["abc","def","ghi","jkl","mno","pqrs","tuv","wxyz"]
    var number = ["2","3","4","5","6","7","8","9"]
    for (key,value) in digits.enumerated(){
        number
    }
}
isPalindrome(121)
