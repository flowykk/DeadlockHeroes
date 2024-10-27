//
//  HeroesViewModel.swift
//  DeadlockHeroes
//
//  Created by Данила Рахманов on 27.10.2024.
//

import Foundation
import NetworkKit
import UIKit

protocol HeroesViewModelDelegate {
    var heroes: [Hero] { get set }
    var didFetchedHeroes: (([Hero]) -> Void)? { get set }
    
    func fetchHeroes()
}

final class HeroesViewModel: HeroesViewModelDelegate {
    
    var heroes = [Hero]() {
        didSet {
            didFetchedHeroes?(heroes)
        }
    }
    var didFetchedHeroes: (([Hero]) -> Void)?
    
    func fetchHeroes() {
        NetworkManager.shared.fetchHeroes() { (result: Result<[Hero], Error>) in
            switch result {
            case .success(let heroes):
                self.heroes = heroes
            case .failure(let error):
                print(error)
            }
        }
    }
}
