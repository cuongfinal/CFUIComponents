//
//  RealmServiceProtocol.swift
//  TeacherAssistant
//
//  Created by Le Quang Tuan Cuong(CuongLQT) on 06/06/2022.
//

import RealmSwift
import UIKit

typealias SortDescriptor = RealmSwift.SortDescriptor

protocol RealmRepresentable: Object {
    var uid: Int { get }
}

protocol RealmServiceProtocol {
    associatedtype Entity
    
    func queryAll() -> [Entity]
    func query(with predicate: NSPredicate, sortDescriptors: [SortDescriptor]) -> [Entity]
    
    func save(entity: Entity) -> Bool
    func save(entities: [Entity]) -> Bool
    
    func delete(entity: Entity) -> Bool
    func delete(entities: [Entity]) -> Bool
    func deleteAll() -> Bool
}
