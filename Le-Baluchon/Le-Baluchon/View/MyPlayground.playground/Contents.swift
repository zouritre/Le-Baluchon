import UIKit

protocol SomeProtocolDelegate: AnyObject {
    func someFunc(value: String)
}

class SourceClass {
    weak var delegate: SomeProtocolDelegate?
    func anyFunc() {
        delegate.someFunc(value: "ValueToSend")
    }
}


extension TargetClass: SomeProtocolDelegate {
    func someFunc(value: String) {
        //Do something with the value retrieved
    }
}
class TargetClass {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? TargetClass {
            destination.delegate = self
        }
    }
}
