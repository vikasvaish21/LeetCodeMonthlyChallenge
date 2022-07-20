import UIKit

class MyLinkedList {
    
    class ListNode {
        let value: Int
        var next: ListNode?
        init(value: Int, next: ListNode? = nil) {
            self.value = value
            self.next = next
        }
    }
    
    var head: ListNode?
    
    init() {
        head = nil
    }
    
    /** Get the value of the index-th node in the linked list. If the index is invalid, return -1. */
    func get(_ index: Int) -> Int {
        guard let node = node(at: index) else {
            return -1
        }
        return node.value
    }
    
    
    
    private func node(at: Int) -> ListNode? {
        guard at > -1, var node = head else {
            return nil
        }
        guard at > 0 else {
            return head
        }
        for _ in 1...at {
            guard let nextNode = node.next else {
                return nil
            }
            node = nextNode
        }
        return node
    }
    
    
    /** Add a node of value val before the first element of the linked list. After the insertion, the new node will be the first node of the linked list. */
    func addAtHead(_ val: Int) {
        let newNode = ListNode(value: val, next: head)
        head = newNode
    }
    
    /** Append a node of value val to the last element of the linked list. */
    func addAtTail(_ val: Int) {
        guard head != nil else {
            head = ListNode(value: val)
            return
        }
        var node = head
        while node?.next != nil {
            node = node?.next
        }
        node?.next = ListNode(value: val)
    }
    
    /** Add a node of value val before the index-th node in the linked list. If index equals to the length of linked list, the node will be appended to the end of linked list. If index is greater than the length, the node will not be inserted. */
    func addAtIndex(_ index: Int, _ val: Int) {
        if index <= 0 {
            addAtHead(val)
            return
        }
        guard let prevNode = node(at: index - 1) else {
            return
        }
        let newNode = ListNode(value: val, next: prevNode.next)
        prevNode.next = newNode
    }
    
    /** Delete the index-th node in the linked list, if the index is valid. */
    func deleteAtIndex(_ index: Int) {
        if index == 0, head != nil {
            head = head?.next
            return
        }
        guard let prevNode = node(at: index - 1) else {
            return
        }
        prevNode.next = prevNode.next?.next
    }
}

extension MyLinkedList: CustomStringConvertible {
    // 2
    public var description: String {
        // 3
        var text = "["
        var node = head
        // 4
        while node != nil {
            text += "\(node!.value)"
            node = node!.next
            if node != nil { text += ", " }
        }
        // 5
        return text + "]"
    }
}

//let linkedList = MyLinkedList()
//linkedList.addAtTail(1)
//linkedList.addAtTail(2)
//linkedList.addAtTail(3)
//linkedList.addAtHead(0)
//print(linkedList)
//print(linkedList)
//linkedList.get(0)
//linkedList.get(1)
//linkedList.get(3)
//linkedList.get(5)
//linkedList.deleteAtIndex(2)
//print(linkedList)
//linkedList.addAtIndex(2, 2)
//print(linkedList)


public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    
    
}

class Solution {
    func middleNode(_ head: ListNode?) -> ListNode? {
        if head == nil {
            return nil
        }
        var slow = head
        var fast = head
        while fast != nil && fast?.next != nil{
            slow = slow!.next
            fast = fast?.next?.next
        }
        return slow
    }
    
    func deleteMiddle(_ head: ListNode?) -> ListNode? {
        if head == nil {
            return nil
        }
        var slow = head
        var fast = head
        var prev : ListNode? = nil
        while fast != nil && fast?.next != nil{
            prev = slow
            slow = slow!.next
            fast = fast?.next?.next
        }
        prev?.next = slow?.next
        return prev == nil ? nil : head
    }
    
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {

        if lists.isEmpty{
            return nil
        } else if lists.count == 1{
            return lists[0]
        }
        return partition(lists,0,lists.count-1)
    }
    
    func partition(_ list: [ListNode?],_ start:Int,_ end:Int) -> ListNode?{
        if start == end{
            return list[start]
        }
        if (start < end){
            let middle = start + (end - start)/2
            let list1 = partition(list, start, middle)
            let list2 = partition(list, middle+1, end)
            return mergeNode(list1, list2, list)
        }
        return nil
    }
    
    func mergeNode(_ list1 : ListNode?,_ list2 : ListNode?,_ lists:[ListNode?]) -> ListNode?{
        var result : ListNode? = nil
        if(list1 == nil) {return list2}
        if(list2 == nil) {return list1}
        if list1!.val <= list2!.val{
            result = list1
            result?.next = mergeNode(list1?.next, list2, lists)
        }else if list1!.val > list2!.val{
            result = list2
            result?.next = mergeNode(list1, list2?.next, lists)
        }
        return result
    }
    
    func firstMissingPositive(_ nums: [Int]) -> Int {
        let nums = Set(nums)
        if nums.isEmpty{
            return 1
        }
        for i in 1...nums.count{
            if !nums.contains(i){
                return i
            }
        }
        return nums.count+1
    }
    
    func findDuplicate(_ nums: [Int]) -> Int {
        var map = [Int:Bool]()
        guard nums.isEmpty == false else{
            return 0
        }
        for i in nums{
            if map[i] == true{
                return i
            }
            map[i] = true
            
        }
        return nums[0]
    }
    
}



var node1 = ListNode(1, ListNode(4, ListNode(5)))
var node2 = ListNode(1, ListNode(3, ListNode(3)))
var node3 = ListNode(2, ListNode(6))
var sol = Solution()
//var result = sol.mergeKLists([node1,node2,node3])
//var result = sol.mergeNode(node1, node2)
sol.firstMissingPositive([3,4,-1,1])
sol.findDuplicate([1,3,4,2,2])
//var arr = [Int]()
//while result != nil{
//    arr.append(result!.val)
//    result = result?.next
//}
//print(arr)

