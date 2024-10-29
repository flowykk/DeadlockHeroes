//
//  HeroInfoViewController.swift
//  DeadlockHeroes
//
//  Created by Данила Рахманов on 28.10.2024.
//

import Foundation
import UIKit
import SnapKit

final class HeroInfoViewController: UIViewController {

    var hero: Hero?

    private let scrollView: UIScrollView = UIScrollView()
    private let contentView: UIView = UIView()

    private let activityIndicator = UIActivityIndicatorView()
    private let heroImageView = UIImageView()
    private let heroNameLabel = UILabel()
    private let heroRoleLabel = UILabel()

    private var playStyleSection = HeroSubInfoView()
    private var loreSection = HeroSubInfoView()

    private let loreSectionLabel = UILabel()
    private let heroLoreLabel = UILabel()

    var viewModel: HeroInfoViewModelDelegate? {
        didSet {
            viewModel?.didGotHero = { [weak self] hero in
                self?.hero = hero

                self?.playStyleSection = HeroSubInfoView(
                    section: "Play Style", info: hero.description?.playstyle ?? "No information"
                )
                self?.loreSection = HeroSubInfoView(
                    section: "Lore", info: hero.description?.lore ?? "No information"
                )

                self?.imageViewModel?.fetchHeroImage(for: hero.images?.iconHeroCard ?? "")
            }
        }
    }

    var imageViewModel: HeroesImageViewModelDelegate? {
        didSet {
            activityIndicator.startAnimating()
            imageViewModel?.didFetchedHeroImage = { [weak self] image in
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.heroImageView.image = image
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
}

extension HeroInfoViewController {

    @objc
    private func backButtonTapped() {
        viewModel?.backButtonTapped()
    }
}

extension HeroInfoViewController {

    private func configureUI() {
        view.backgroundColor = .systemBackground

        configureBackButton()

        configureActivityIndicator()
        configureHeroImageView()
        configureHeroNameLabel()
        configureHeroRoleLabel()

        configurePlayStyleSection()
        configureLoreSection()

        configureScrollView()
        configureContentView()
    }

    private func configureBackButton() {
        let largeFont     = UIFont.systemFont(ofSize: 16, weight: .black)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image         = UIImage(systemName: "chevron.left", withConfiguration: configuration)

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = Colors.accentColor
    }

    private func configureScrollView() {
        scrollView.delaysContentTouches = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .systemBackground

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func configureContentView() {

        let expectedHeight =
        10 + 150 + // heroImageView
        playStyleSection.getSectionHeight() + 20 +
        loreSection.getSectionHeight() +
        20 // bottom offset

        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(expectedHeight)
            make.width.equalToSuperview()
        }
    }

    private func configureActivityIndicator() {
        contentView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(20)
            make.top.equalTo(contentView).offset(10)
            make.height.equalTo(150)
            make.width.equalTo(110)
        }
    }

    private func configureHeroImageView() {
        heroImageView.layer.cornerRadius = 10
        heroImageView.layer.masksToBounds = true
        heroImageView.contentMode = .scaleAspectFill

        contentView.addSubview(heroImageView)
        heroImageView.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(20)
            make.top.equalTo(contentView).offset(10)
            make.height.equalTo(150)
            make.width.equalTo(110)
        }
    }

    private func configureHeroNameLabel() {
        heroNameLabel.text = hero?.name
        heroNameLabel.font = .systemFont(ofSize: .init(30), weight: .bold)
        heroNameLabel.numberOfLines = 1
        heroNameLabel.textAlignment = .center
        heroNameLabel.textColor = Colors.textColor

        contentView.addSubview(heroNameLabel)
        heroNameLabel.snp.makeConstraints { make in
            make.left.equalTo(heroImageView.snp.right).offset(20)
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
        }
    }

    private func configureHeroRoleLabel() {
        heroRoleLabel.text = hero?.description?.role
        heroRoleLabel.font = .systemFont(ofSize: .init(16), weight: .medium)
        heroRoleLabel.textColor = .secondaryLabel
        heroRoleLabel.numberOfLines = 0

        contentView.addSubview(heroRoleLabel)
        heroRoleLabel.snp.makeConstraints { make in
            make.left.equalTo(heroImageView.snp.right).offset(20)
            make.right.equalTo(contentView).offset(-20)
            make.top.equalTo(heroNameLabel.snp.bottom).offset(5)
        }
    }

    private func configurePlayStyleSection() {
        contentView.addSubview(playStyleSection)
        playStyleSection.snp.makeConstraints { make in
            make.top.equalTo(heroImageView.snp.bottom).offset(20)
        }
    }

    private func configureLoreSection() {
        contentView.addSubview(loreSection)
        loreSection.snp.makeConstraints { make in
            make.top.equalTo(playStyleSection.snp.bottom).offset(20)
        }
    }

    func getLoreHeight() -> CGFloat {
        let maxWidth = UIScreen.main.bounds.width - 30
        let expectedSize = heroLoreLabel.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude))

        return expectedSize.height
    }
}
