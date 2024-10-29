//
//  HeroInfoViewModel.swift
//  DeadlockHeroes
//
//  Created by Данила Рахманов on 28.10.2024.
//

import Foundation

protocol HeroInfoViewModelDelegate: AnyObject {
    var hero: Hero? { get set }
    var router: HeroInfoRouterProtocol? { get set }

    var didGotHero: ((Hero) -> Void)? { get set }

    func backButtonTapped()
}

final class HeroInfoViewModel: HeroInfoViewModelDelegate {

    var router: HeroInfoRouterProtocol?
    var hero: Hero? {
        didSet {
            didGotHero?(hero!)
        }
    }

    var didGotHero: ((Hero) -> Void)?

    func backButtonTapped() {
        router?.navigateToHeroes()
    }
}
