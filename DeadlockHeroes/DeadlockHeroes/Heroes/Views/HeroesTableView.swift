//
//  HeroesTableView.swift
//  DeadlockHeroes
//
//  Created by Данила Рахманов on 27.10.2024.
//

import UIKit

final class HeroesTableView: UITableView {
    
    var heroes = [Hero]()
    
    var viewModel: HeroesViewModelDelegate? {
        didSet {
            viewModel?.didFetchedHeroes = { [weak self] heroes in
                self?.heroes = heroes
                
                DispatchQueue.main.async { [weak self] in
                    self?.reloadData()
                }
            }
            viewModel?.fetchHeroes()
        }
    }

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        delegate = self
        dataSource = self
        register(HeroCell.self, forCellReuseIdentifier: "heroCell")
        rowHeight = 120
    }
}

extension HeroesTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "heroCell") as! HeroCell
        
        let hero = heroes[indexPath.row]
        cell.tag = hero.id!
        cell.viewModel = HeroesImageViewModel()
        cell.set(with: hero)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.heroDidTapped(for: indexPath.row)
    }
}
