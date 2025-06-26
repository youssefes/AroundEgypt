
import Foundation
struct ExperiencesData : Codable, Equatable {
	let id : String
	let title : String?
	let coverPhoto : String?
	let description : String?
	let viewsNo : Int?
	let likesNo : Int?
	let recommended : Int?
    let isLiked : Int?
    let address: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case coverPhoto = "cover_photo"
        case description = "description"
        case viewsNo = "views_no"
        case likesNo = "likes_no"
        case recommended = "recommended"
        case isLiked = "is_liked"
        case address = "address"
    }
    
    func mapToPlaceCardModel() -> PlaceCardModel {
        return PlaceCardModel(
            id: self.id,
            name: self.title ?? "",
            image: self.coverPhoto ?? "",
            seenNumber: self.viewsNo ?? 0,
            likeCount: self.likesNo ?? 0,
            isRecommended: (self.recommended ?? 0) == 1,
            isliked: (self.isLiked ?? 0) == 1,
            address: self.address ?? "",
            description: self.description ?? ""
        )
    }
}
