import Foundation

class NetworkService {

    private func url() -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "run.mocky.io"
        components.path = "/v3/dcf056a3-43c2-4fd0-a1e9-ee95f20fa91f"
        return components.url!
    }
    
    private func sessionDataTask(completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        let url = self.url()
        let request = URLRequest(url: url)
        return URLSession.shared.dataTask(with: request) { data, _, error in
            completion(data, error)
        }
    }
    
    private func jsonDecoded<T:Decodable>(type: T.Type, data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data,
              let responce = try? decoder.decode(type.self, from: data) else {
            print("Ooops!")
            return nil
        }
        
        return responce
    }
    
    // Получаем данные по указанным пути и параметрам
    func getData(completion: @escaping (Result<[NetworkModel],Error>) -> Void) {
        let task = self.sessionDataTask() { data, error in
            if error != nil {
                completion(.failure(error!))
            }
            guard let data = data else {
                return
            }
            if let decoded = self.jsonDecoded(type: [NetworkModel].self, data: data) {
             completion(.success(decoded))
            }
        }
        task.resume()
    }
}
