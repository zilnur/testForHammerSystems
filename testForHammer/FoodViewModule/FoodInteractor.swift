import Foundation

protocol FoodRequest {
    func makeRequest()
}

class FoodInteractor: FoodRequest {
    
    let network = NetworkService()
    
    var presenter: FoodPresenter?
    
    //Запрос в сеть
    func makeRequest() {
        network.getData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.presenter?.buildData(response: FetchFood.Response.response(model))
            case .failure(let error):
                self.presenter?.buildData(response: FetchFood.Response.error(error))
            }
        }
    }
}
