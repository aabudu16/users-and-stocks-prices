

import UIKit

//Error handler

enum userError:Error{
    case noDataAvailable
    case cantProcessData
    case urlCanNotBeConverted
}

struct UserAPIClient{
    //singleton Method
    static let shared = UserAPIClient()
    
    let userURLString = "https://randomuser.me/api/?results=50"
    
    func fetchData(completion: @escaping (Result<[Person],userError>)-> ()){
        
        guard let url = URL(string: userURLString) else {completion(.failure(.urlCanNotBeConverted))
            return}
        
        URLSession.shared.dataTask(with: url) {data, _, _ in
            
            //            if err != nil {
            //                completion(.failure(.cantProcessData))
            //                return
            //            }
            
            guard let retrievedData = data else {completion(.failure(.noDataAvailable))
                return}
            
            do {
                let userResponse = try JSONDecoder().decode(ResultWrapper.self, from: retrievedData)
                let user = userResponse.results
                completion(.success(user))
            }catch {
                completion(.failure(.cantProcessData))
            }
            }.resume()
    }
}
