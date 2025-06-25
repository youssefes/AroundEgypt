
import Foundation
struct RecommendedExperiencesData : Codable {
	let id : String?
	let title : String?
	let coverPhoto : String?
	let description : String?
	let viewsNo : Int?
	let likesNo : Int?
	let recommended : Int?
	let isLiked : String?
	let reviews : [Reviews]?
	let reviewsNo : Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case coverPhoto = "cover_photo"
        case description = "description"
        case viewsNo = "views_no"
        case likesNo = "likes_no"
        case recommended = "recommended"
        case isLiked = "is_liked"
        case reviews = "reviews"
        case reviewsNo = "reviews_no"
    }
}
