//
//  HeroSubInfoView.swift
//  DeadlockHeroes
//
//  Created by Данила Рахманов on 28.10.2024.
//

import UIKit
import SnapKit

class HeroSubInfoView: UIView {

    private let sectionLabel = UILabel()
    private let infoLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(section: String, info: String) {
        super.init(frame: .zero)
        
        sectionLabel.text = section
        infoLabel.text = info
        
        configureUI()
    }
}

extension HeroSubInfoView {
    
    private func configureUI() {
        configureSectionLabel()
        configureInfoLabel()
        
        configureSelf()
    }
    
    private func configureSelf() {
        self.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(getSectionHeight())
        }
    }
    
    private func configureSectionLabel() {
        sectionLabel.font = .systemFont(ofSize: .init(25), weight: .bold)
        sectionLabel.textColor = Colors.accentColor
        
        addSubview(sectionLabel)
        sectionLabel.snp.makeConstraints { make in
            make.left.equalTo(self).offset(20)
            make.top.equalTo(self)
        }
    }
    
    private func configureInfoLabel() {
        infoLabel.font = .systemFont(ofSize: .init(16), weight: .medium)
        infoLabel.numberOfLines = 0
        infoLabel.textColor = Colors.textColor
        
        addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(sectionLabel.snp.bottom).offset(5)
        }
    }
    
    func getSectionHeight() -> CGFloat {
        let maxWidth = UIScreen.main.bounds.width - 30
        let expectedSize = infoLabel.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
        
        return expectedSize.height + 25 + 5
    }
}
