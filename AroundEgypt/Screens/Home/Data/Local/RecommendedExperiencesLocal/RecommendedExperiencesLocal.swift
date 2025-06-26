//
//  RecommendedExperiencesLocal.swift
//  AroundEgypt
//
//  Created by Asset's Macbook Pro on 26/06/2025.
//

import Foundation
import CoreData

final class RecommendedExperiencesLocal: ExperiencesLocalProtocol {
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: EntityName.recommendedExperienceEntity.rawValue)
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data failed: \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    func save(experiences: [ExperiencesData]) throws {
        // Add new data
        for exp in experiences {
            let request: NSFetchRequest<RecommendedExperienceEntity> = RecommendedExperienceEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", exp.id)
            if (try context.fetch(request).first) == nil {
                let entity = RecommendedExperienceEntity(context: context)
                entity.id = exp.id
                entity.title = exp.title
                entity.des = exp.description
                entity.address = exp.address
                entity.viewsNo = Int64(exp.viewsNo ?? 0)
                entity.likesNo = Int64(exp.likesNo ?? 0)
                entity.recommended = Int64(exp.recommended ?? 0)
                entity.coverPhoto = exp.coverPhoto
                entity.isLiked = Int64(exp.isLiked ?? 0)
            }
        }

        try context.save()
    }

    func loadExperiences() throws -> [ExperiencesData] {
        
        let request: NSFetchRequest<RecommendedExperienceEntity> = RecommendedExperienceEntity.fetchRequest()
        let result = try context.fetch(request)

        return result.map {
            ExperiencesData(id: $0.id ?? "", title: $0.title, coverPhoto: $0.coverPhoto, description: $0.des, viewsNo: Int($0.viewsNo), likesNo: Int($0.likesNo), recommended: Int($0.recommended), isLiked: Int($0.isLiked), address: $0.address)
        }
    }
    
    func updateExperiences(experience: ExperiencesData) throws {
        let request: NSFetchRequest<RecommendedExperienceEntity> = RecommendedExperienceEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", experience.id)
        request.fetchLimit = 1

        if let entity = try context.fetch(request).first {
            // 🔁 Update the fields
            entity.isLiked = Int64(experience.isLiked ?? 0)
            entity.likesNo = Int64(experience.likesNo ?? 0)

            try context.save()
            print("✅ Experience \(experience.id) updated in Core Data.")
        } else {
            print("⚠️ No matching ExperienceEntity found for id: \(experience.id)")
        }
    }
}
