//
//  StorageService.swift
//  TicTacToeApp
//
//  Created by Alexander Vagin on 08.08.2023.
//

import Foundation

public enum StorageKeys: String {
    case records
}

protocol StorageServiceProtocol: AnyObject {
    /// Writing
    func set<T: Encodable>(object: T?, forKey key: StorageKeys)
    func append<T: Codable>(object: T, forKey key: StorageKeys)
    /// Read
    func decodableData<T: Decodable>(forKey key: StorageKeys) -> T?
}

final class StorageService {
    
    static let shared = StorageService()
    private let storage = UserDefaults.standard
    
    private init() {}
    
    private func store(_ object: Any?, key: String) {
        storage.set(object, forKey: key)
    }
    
    private func restore(for key: String) -> Any? {
        storage.object(forKey: key)
    }
}

extension StorageService: StorageServiceProtocol {
    
    func set<T: Encodable>(object: T?, forKey key: StorageKeys) {
        let jsonData = try? JSONEncoder().encode(object)
        store(jsonData, key: key.rawValue)
    }
    
    func append<T: Codable>(object: T, forKey key: StorageKeys) {
        if var array: [T] = decodableData(forKey: key) {
            array.append(object)
            set(object: array, forKey: key)
        } else {
            let newArray: [T] = [object]
            set(object: newArray, forKey: key)
        }
    }
    
    func decodableData<T: Decodable>(forKey key: StorageKeys) -> T? {
        guard let data = restore(for: key.rawValue) as? Data else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
