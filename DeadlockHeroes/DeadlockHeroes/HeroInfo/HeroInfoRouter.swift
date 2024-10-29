//
//  HeroInfoRouter.swift
//  DeadlockHeroes
//
//  Created by Данила Рахманов on 28.10.2024.
//

import Foundation

protocol HeroInfoRouterProtocol {
    var view: HeroInfoViewController? { get set }

    func navigateToHeroes()
}

final class HeroInfoRouter: HeroInfoRouterProtocol {
    var view: HeroInfoViewController?

    func navigateToHeroes() {
        view?.navigationController?.popViewController(animated: true)
    }
}
