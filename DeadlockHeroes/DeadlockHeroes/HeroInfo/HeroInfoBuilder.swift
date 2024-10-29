//
//  HeroInfoBuilder.swift
//  DeadlockHeroes
//
//  Created by Данила Рахманов on 28.10.2024.
//

import Foundation
import UIKit

final class HeroInfoBuilder {

    static func build(with hero: Hero) -> UIViewController {
        let view = HeroInfoViewController()
        let viewModel = HeroInfoViewModel()
        let imageViewModel = HeroesImageViewModel()
        let router = HeroInfoRouter()

        view.imageViewModel = imageViewModel
        view.viewModel = viewModel

        viewModel.hero = hero
        viewModel.router = router

        router.view = view

        return view
    }
}
