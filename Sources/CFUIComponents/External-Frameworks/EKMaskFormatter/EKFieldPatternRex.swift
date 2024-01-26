//
//  The MIT License (MIT)
//
//  Copyright (c) 2021 Cuong Le
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
// swiftlint:disable line_length
import UIKit

internal enum EKFieldPatternRex: Character {
    case numberDecimal = "d"
    case nonDecimal    = "D"
    case nonWord       = "W"
    case alphabet      = "a"
    case anyChar       = "."
    var rexValue: String {
        switch self {
        case .numberDecimal   : return "\\d"
        case .nonDecimal      : return "\\D"
        case .nonWord         : return "\\W"
        case .alphabet        : return "[a-zA-Z]"
        default              : return "."
        }
    }
}

final class EKFieldCharacter: CustomStringConvertible {
    // MARK: - Attributes
     var isEditable: Bool
    /// The input value
     var value: Character?
    /// The mask template string that represent current block.
     var patternRex: EKFieldPatternRex
    /// The mask pattern that represent current block.
     var mask: Character
    
    // MARK: - Initializers
    /// Default initialazer
    /// - Parameter isEditable: Editable char flag
    /// - Parameter value: Input char
    /// - Parameter pattern: Rex pattern
    /// - Parameter mask: Replacement symbol to a value
    init(isEditable: Bool, value: Character? = nil, pattern: EKFieldPatternRex?, mask: Character) {
        self.isEditable = isEditable
        self.value = value
        self.patternRex = pattern ?? .anyChar
        self.mask = mask
    }
    
    var description: String {
        return "isPatternEditable:\(isEditable), value:\(String(describing: value)), patternRex:\(patternRex), mask:\(mask)"
    }
}

internal extension Array where Element: EKFieldCharacter {
    func nextEditableElement(index: Int, checker: @escaping ((Element) -> Bool)) -> (index: Int, value: Element)? {
        var index = index
        while index < self.count {
            let element = self[index]
            if checker(element) {
                return (index: index, value: element)
            }
            index += 1
        }
        return nil
    }
    
    func previousEditableElement(index: Int? = nil) -> (index: Int, value: Element)? {
        var index = (index ?? self.count)
        while index >= 0 {
            let element = self[index]
            if element.isEditable && element.value != nil {
                return (index: index, value: element)
            }
            index -= 1
        }
        return nil
    }
    
    var asText: String {
        var str = ""
        self.forEach { str += String($0.value ?? $0.mask) }
        return str
    }
}
