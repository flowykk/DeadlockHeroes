//
//  HeroCell.swift
//  DeadlockHeroes
//
//  Created by Данила Рахманов on 27.10.2024.
//

import UIKit

class HeroCell: UITableViewCell {

    private let activityIndicator = UIActivityIndicatorView()
    private let heroImageView = UIImageView()
    private let heroNameLabel = UILabel()
    private let chevronImageView = UIImageView()

    var viewModel: HeroesImageViewModelDelegate? {
        didSet {
            activityIndicator.startAnimating()
            viewModel?.didFetchedHeroImage = { [weak self] image in
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.heroImageView.image = image
                }
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(with hero: Hero) {
        heroNameLabel.text = hero.name

        guard tag == hero.id! else { return }
        viewModel?.fetchHeroImage(for: hero.images?.iconHeroCard ?? "")
    }
}

extension HeroCell {

    private func configureUI() {
        configureSelf()

        configureActivityIndicator()
        configureHeroImageView()

        configureHeroNameLabel()
        configureChevronImageView()
    }

    private func configureSelf() {
        selectionStyle = .none
    }

    private func configureActivityIndicator() {
        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.width.equalTo(90)
            make.height.equalTo(90)
            make.left.equalTo(self).offset(20)
            make.centerY.equalTo(self)
        }
    }

    private func configureHeroImageView() {
        heroImageView.contentMode = .scaleAspectFill
        heroImageView.clipsToBounds = true
        heroImageView.layer.cornerRadius = 10

        addSubview(heroImageView)
        heroImageView.snp.makeConstraints { make in
            make.width.equalTo(90)
            make.height.equalTo(90)
            make.left.equalTo(self).offset(20)
            make.centerY.equalTo(self)
        }
    }

    private func configureHeroNameLabel() {
        heroNameLabel.textAlignment = .center
        heroNameLabel.textColor = Colors.textColor
        heroNameLabel.font = .systemFont(ofSize: 20, weight: .medium)

        addSubview(heroNameLabel)
        heroNameLabel.snp.makeConstraints { make in
            make.left.equalTo(heroImageView.snp.right).offset(20)
            make.centerY.equalTo(self)
        }
    }

    private func configureChevronImageView() {
        addSubview(chevronImageView)
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false

        chevronImageView.contentMode = .scaleAspectFit
        let font = UIFont.systemFont(ofSize: 16, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: font)
        let image = UIImage(systemName: "chevron.right", withConfiguration: configuration)
        chevronImageView.image = image
        chevronImageView.tintColor = Colors.accentColor

        chevronImageView.snp.makeConstraints { make in
            make.right.equalTo(self).offset(-1 * 20)
            make.centerY.equalTo(self)
        }
    }
}
