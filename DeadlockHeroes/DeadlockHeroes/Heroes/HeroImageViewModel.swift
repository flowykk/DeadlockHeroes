//
//  HeroImageViewModel.swift
//  DeadlockHeroes
//
//  Created by Данила Рахманов on 27.10.2024.
//

import Foundation
import NetworkKit
import UIKit

protocol HeroesImageViewModelDelegate {
    var image: UIImage? { get set }
    var didFetchedHeroImage: ((UIImage) -> Void)? { get set }
    
    func fetchHeroImage(for imageName: String)
}

final class HeroesImageViewModel: HeroesImageViewModelDelegate {
    var image: UIImage? {
        didSet {
            didFetchedHeroImage?(image ?? UIImage(named: "placeholder")!)
        }
    }
    
    var didFetchedHeroImage: ((UIImage) -> Void)?
    
    func fetchHeroImage(for imageName: String) {
        NetworkManager.shared.fetchHeroImage(for: imageName) { result in
            switch result {
            case .success(let data):
                self.image = UIImage(data: data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
