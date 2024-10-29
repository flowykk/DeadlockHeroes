//
//  HeroesBuilder.swift
//  DeadlockHeroes
//
//  Created by Данила Рахманов on 27.10.2024.
//

import Foundation
import UIKit

final class HeroesBuilder {
    static func build() -> UIViewController {
        let viewModel = HeroesViewModel()
        let view = HeroesViewController()
        let router = HeroesRouter()

        view.viewModel = viewModel

        viewModel.router = router

        router.view = view

        return view
    }
}
