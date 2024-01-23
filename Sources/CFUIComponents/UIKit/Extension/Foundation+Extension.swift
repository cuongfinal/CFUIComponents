//
//  Foundation+Extension.swift
//  SocialRepost
//
//  Created by Le Quang Tuan Cuong(CuongLQT) on 20/10/2023.
//

import Foundation
import UIKit

public extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}

public extension MutableCollection {
    mutating func mutateEach(_ body: (inout Element) throws -> Void) rethrows {
        for index in self.indices {
            try body(&self[index])
        }
    }
}

public extension RangeReplaceableCollection where Element: Equatable {
    mutating func addOrReplace(_ element: Element) {
        if let index = self.firstIndex(of: element) {
            self.replaceSubrange(index...index, with: [element])
        } else {
            self.append(element)
        }
    }
}

public extension Array {
    subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        
        return self[index]
    }
}

public extension Collection {
    func enumeratedArray() -> Array<(offset: Int, element: Self.Element)> {
        return Array(self.enumerated())
    }
    
    func average<T: BinaryInteger>(_ predicate: (Element) -> T) -> T {
        sum(predicate) / T(count)
    }
    func average<T: BinaryInteger, F: BinaryFloatingPoint>(_ predicate: (Element) -> T) -> F {
        F(sum(predicate)) / F(count)
    }
    func average<T: BinaryFloatingPoint>(_ predicate: (Element) -> T) -> T {
        sum(predicate) / T(count)
    }
    func average(_ predicate: (Element) -> Decimal) -> Decimal {
        sum(predicate) / Decimal(count)
    }
}

public extension Sequence {
    func group<Key>(by keyPath: KeyPath<Element, Key>) -> [Key: [Element]] where Key: Hashable {
        return Dictionary(grouping: self, by: {
            $0[keyPath: keyPath]
        })
    }
    
    func sum<T: AdditiveArithmetic>(_ predicate: (Element) -> T) -> T {
        reduce(.zero) { $0 + predicate($1) }
    }
    func limit(_ max: Int) -> [Element] {
        return Array(prefix(max))
    }
}

public extension CGSize {
    init(lenght: CGFloat) {
        self.init(width: lenght, height: lenght)
    }
}

public extension Double {
    var isInteger: Bool {
        return truncatingRemainder(dividingBy: 1) == 0
    }
    
    func asPercentage(decimalNormalized: Bool = true) -> String {
        decimal(isInteger ? 0 : 2) + "%"
    }
    
    func decimal(_ fractionDigits: Int) -> String {
        String(format: "%.\(fractionDigits)f", self)
    }
    
    func roundedDecimal(to scale: Int = 0, mode: NSDecimalNumber.RoundingMode = .plain) -> Double {
        var decimalValue = Decimal(self)
        var result = Decimal()
        NSDecimalRound(&result, &decimalValue, scale, mode)
        return Double(truncating: result as NSNumber)
    }
}

public extension CGFloat {
    var toFloat: Float {
        Float(self)
    }
    var toInt: Int {
        Int(self)
    }
}
