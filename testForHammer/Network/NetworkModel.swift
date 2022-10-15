import Foundation

struct FoodResponce: Codable {
    let food: [NetworkModel]
}

struct NetworkModel: Codable {
    let name: String
    let price: Int
    let description: String
    let category: String
}
