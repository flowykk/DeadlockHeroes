//
//  ViewController.swift
//  DeadlockHeroes
//
//  Created by Данила Рахманов on 27.10.2024.
//

import UIKit
import SnapKit

final class HeroesViewController: UIViewController {
    
    private let tableView = HeroesTableView()
    
    var heroes = [Hero]()
    
    var viewModel: HeroesViewModelDelegate? {
        didSet {
            tableView.viewModel = viewModel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

extension HeroesViewController {
    
    private func configureUI() {
        configureNavigationBar()
        configureTableView()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Heroes"
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
