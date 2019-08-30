

import UIKit

struct UserAPIClient{
   static let shared = UserAPIClient()
    
    let userURLString = "https://randomuser.me/api/?results=50"
    
    func fetchData(completion: @escaping (Result<ResultWrapper,Error>)-> ()){
        
        guard let url = URL(string: userURLString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            if let err = err {
                completion(.failure(err))
                return
            }
            
            guard let retrievedData = data else {return}
            
            do {
                let user = try JSONDecoder().decode(ResultWrapper.self, from: retrievedData)
                completion(.success(user))
            }catch let jsonError{
                completion(.failure(jsonError))
            }
        }
    }
}
