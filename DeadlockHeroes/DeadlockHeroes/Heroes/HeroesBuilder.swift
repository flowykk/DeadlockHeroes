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
        
        view.viewModel = viewModel
        
        return view
    }
}
