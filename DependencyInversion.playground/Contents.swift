import UIKit

var greeting = "Hello, playground"


struct Order{
    let amount : Double
    let description: String
    let tax : Double
    let created_By: String
}

protocol OrderStorage{
    func saveOrder(order: Order)
}
class Handler{
    private let _orderStorage:OrderStorage
    
    init(storage: OrderStorage) {
        _orderStorage = storage
    }
    
    func saveOrder(order:Order) {
        guard order.amount != 0 else{
            debugPrint("Save operation failed,Order amount should be greater thsn 0")
            return
        }
        // Save order to database
        _orderStorage.saveOrder(order:order)
    }
}


class OrderDatabaseOperations:OrderStorage{
    func saveOrder(order:Order){
        debugPrint("Order: \(order.description) of amount \(order.amount) was saved")
    }
}
class OrderAPIOperations:OrderStorage{
    func saveOrder(order:Order){
        debugPrint("Order: \(order.description) of amount \(order.amount) was saved")
    }
}

let objHandler = Handler(storage: OrderAPIOperations())
objHandler.saveOrder(order: Order(amount: 300, description: "Order description", tax: 2, created_By: "codecat15"))
