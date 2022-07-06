//
//  Presenter.swift
//  Viper
//
//  Created by Rafael Oliveira on 05/07/22.
//

import Foundation


enum fetchError: Error{
    case failed
}

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInterector? { get set }
    var view: AnyView? { get set }
    
    func interactorDidFetchUsers(with result: Result<[User],Error>)
}

class UserPresenter: AnyPresenter{

    var router: AnyRouter?
    
    var interactor: AnyInterector? {
        didSet{
            interactor?.getUsers()
        }
    }
    
    var view: AnyView?
    

    
    func interactorDidFetchUsers(with result: Result<[User], Error>) {
        switch result{
        case .success(let users):
            view?.updade(with: users)
        case .failure:
            view?.update(with: "Something went wrong")
        }
    }
    
}
