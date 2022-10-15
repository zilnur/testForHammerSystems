import Foundation

protocol FoodResponse {
    func buildData(response: FetchFood.Response)
}

class FoodPresenter: FoodResponse {
    
    var view: FoodViewController?
    
    //Собирает данные
    func buildData(response: FetchFood.Response) {
        switch response {
        case .response(let model):
            let food1 = model.filter {$0.category == "pizza"}.map({ food in
                FoodModel(name: food.name,
                          price: food.price,
                          description: food.description,
                          category: food.category)
            })
            let food2 = model.filter {$0.category == "rolls"}.map({ food in
                FoodModel(name: food.name,
                          price: food.price,
                          description: food.description,
                          category: food.category)
            })
            let food3 = model.filter {$0.category == "drink"}.map({ food in
                FoodModel(             name: food.name,
                                       price: food.price,
                                       description: food.description,
                                       category: food.category)
            })
            let food4 = model.filter{$0.category == "dessert"}.map({ food in
                FoodModel(             name: food.name,
                                       price: food.price,
                                       description: food.description,
                                       category: food.category)
            })
            let viewModel = ViewModel(foods: [food1, food2, food3, food4])
            view?.setValues(FetchFood.SetValues.viewModel(viewModel))
        case .error(let error):
            view?.setValues(FetchFood.SetValues.error(error))
        }
    }
}
