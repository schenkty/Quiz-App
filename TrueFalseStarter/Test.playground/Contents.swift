//: Playground - noun: a place where people can play

import Foundation

enum UIBarButtonStyle {
    case Done
    case Plain
    case Bordered
}

class UIBarButtonItem {
    
    var title: String?
    let style: UIBarButtonStyle
    var target: AnyObject?
    var action: Selector
    
    init(title: String?, style: UIBarButtonStyle, target: AnyObject?, action: Selector) {
        self.title = title
        self.style = style
        self.target = target
        self.action = action
    }
}

enum Button {
    case Done(String)
    case Edit(String)
    
    func toUIBarButtonItem() -> UIBarButtonItem {
        switch self {
        case .Done:
            return UIBarButtonItem(title: "Done", style: UIBarButtonStyle.Done, target: nil, action: nil)
        case .Edit:
            return UIBarButtonItem(title: "Edit", style: UIBarButtonStyle.Plain, target: nil, action: nil)
        }
    }
}

let done = Button.Done("Done")

let doneButton = UIBarButtonItem.init(title: "Done", style: UIBarButtonStyle.Done, target: nil, action: nil)