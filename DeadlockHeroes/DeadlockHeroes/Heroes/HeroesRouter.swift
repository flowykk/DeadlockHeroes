//
//  HeroesRouter.swift
//  DeadlockHeroes
//
//  Created by Данила Рахманов on 28.10.2024.
//

import Foundation

protocol HeroesRouterProtocol {
    var view: HeroesViewController? { get set }

    func navigateToHeroInfo(with hero: Hero)
}

final class HeroesRouter: HeroesRouterProtocol {

    weak var view: HeroesViewController?

    func navigateToHeroInfo(with hero: Hero) {
        view?.navigationController?.pushViewController(HeroInfoBuilder.build(with: hero), animated: true)
    }
}
