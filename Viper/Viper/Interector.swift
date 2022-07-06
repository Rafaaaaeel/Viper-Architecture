//
//  Interector.swift
//  Viper
//
//  Created by Rafael Oliveira on 05/07/22.
//

import Foundation

protocol AnyInterector{
    var presenter: AnyPresenter? { get set }
    
    func getUsers()
}

class UserInterector: AnyInterector{
    var presenter: AnyPresenter?
    
    func getUsers() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self]data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchUsers(with: .failure(fetchError.failed))
                return
            }
            
            do{
                let entities = try JSONDecoder().decode([User].self, from: data)
                self?.presenter?.interactorDidFetchUsers(with: .success(entities))
            }
            catch{
                self?.presenter?.interactorDidFetchUsers(with: .failure(error))
            }
        }
        task.resume()
    }
    
}
