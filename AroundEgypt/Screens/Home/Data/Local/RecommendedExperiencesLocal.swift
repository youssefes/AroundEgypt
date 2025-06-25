//
//  RecommendedExperiencesLocal.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 25/06/2025.
//

import Foundation
class RecommendedExperiencesLocal {
    private let fileName = "recommendedExperiencesLocal.json"
    private var fileURL: URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            .first?.appendingPathComponent(fileName)
    }

    func save(data: Data) {
        guard let url = fileURL else { return }
        try? data.write(to: url)
    }

    func loadData() -> Data? {
        guard let url = fileURL else { return nil }
        return try? Data(contentsOf: url)
    }

    func exists() -> Bool {
        guard let url = fileURL else { return false }
        return FileManager.default.fileExists(atPath: url.path)
    }

}
