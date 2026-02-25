//
//  QuizStorage.swift
//  iQuiz
//
//  Created by Hanna Pan on 2/24/26.
//

import Foundation

struct QuizStorage {
    
    static func getFileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return urls.appendingPathComponent("quizzes.json")
    }
    
    static func save(data: Data) throws {
        try data.write(to: getFileURL())
    }
    
    static func load() throws -> Data {
        let url = getFileURL()
        return try Data(contentsOf: url)
    }
}
