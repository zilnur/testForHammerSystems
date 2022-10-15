import Foundation

enum FetchFood {
    
    enum Response {
        case response([NetworkModel])
        case error(Error)
    }
    
    enum SetValues {
        case viewModel(ViewModel)
        case error(Error)
    }
}

struct ViewModel {
    let foods: [[FoodModel]]
}

struct FoodModel {
    let name: String
    let price: Int
    let description: String
    let category: String
}
