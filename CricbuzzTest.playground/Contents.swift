//import UIKit
//import Foundation
//var greeting = "Hello, playground"
//protocol Describable{
//    func describe() -> Void
//}
//
//extension Describable{
//    func describe() -> Void{
//        print("Default Description")
//    }
//}
//
//extension Range:Describable{
//    func describe() -> Void{
//        print("range (start: \(self.lowerBound),end:\(self.upperBound))")
//    }
//}
//let range = (5..<19)
//range.describe()
//(range as Describable).describe()
//
//
//class Schedular{
//    private let queue = DispatchQueue.init(label: "my.Project.queue")
//
//    func run(){
//        print("start")
//
//
//        queue.async {
//            print("task1")
//        }
//        queue.sync {
//            print("task2")
//        }
//        print("end")
//    }
//}
//let schedular = Schedular()
//schedular.run()
//
//
//protocol DogVocalProtocol{
//    func bark() -> Void
//}
//
//extension DogVocalProtocol{
//    func bark() -> Void{
//        print("No barking")
//    }
//}
//final class Dog: DogVocalProtocol{
//    func bark() -> Void{
//        print("woof")
//    }
//}
//class Corgi : Dog{
//    override func bark() -> Void{
//        print("woof woof")
//    }
//}
//let muttface = Corgi()
//muttface.bark()

func maxTrailing(levels: [Int]) -> Int {
    // Write your code here
    let length = levels.count
    var max_diff = levels[1] - levels[0]
    var min_ele = levels[0]
    for i in 0..<length{
        if levels[i] - min_ele > max_diff{
            max_diff = levels[i] - min_ele
        }
        if levels[i]  < min_ele{
            min_ele = levels[i]
        }
    }
    return max_diff
}

maxTrailing(levels: [5,3,6,7,4])


func matchingBraces(braces: [String]) -> [String] {
    var charArray = [Character]()
    var result = [String]()
    for j in braces{
        for ch in j {
            if ch == "(" || ch == "{" || ch == "["{
                charArray.insert(ch, at: 0)
            } else {
                if charArray.isEmpty {
                    result.append("no")
                    return result
                }
                if ch == ")" && charArray.first != "(" || ch == "}" && charArray.first != "{" ||
                    ch == "]" && charArray.first != "["{
                    result.append("no")
                    return result
                }
                charArray.removeFirst()
            }
        }
        if charArray.isEmpty{
            result.append("yes")
            
        } else{
            result.append("no")
        }
    }
    return result
}

matchingBraces(braces: ["[{}]","{[}]"])
