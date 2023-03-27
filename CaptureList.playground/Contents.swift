import UIKit

var greeting = "Hello, playground"


func CaptureList(){
    var A = 10
    var B = 20
    let closure = { [A,B]
        in print(A,B)
    }
    closure()
    A = 50
    B = 30
    closure()
}
CaptureList()

//
//DispatchQueue.main.async {
//    print("A")
//    DispatchQueue.main.async {
//        print("B")
//        DispatchQueue.main.async {
//            print("C")
//            DispatchQueue.main.async {
//                print("D")
//            }
//        }
//    }
//}

var queue  = DispatchQueue(label: "myQueue"/*,attributes: .concurrent*/)


DispatchQueue.main.async {
    print("A")
    DispatchQueue.main.async {
        print("B")
        DispatchQueue.main.async {
            print("C")
            DispatchQueue.main.async {
                print("D")
            }
        }
    }
}

//queue.sync{
//    print("A Started")
//    for i in 0...5{
//        print(i)
//    }
//    print("A Ended")
//}
//queue.sync {
//    print("B")
//}
//queue.sync {
//    print("C")
//}
//queue.sync {
//    print("D")
//}
