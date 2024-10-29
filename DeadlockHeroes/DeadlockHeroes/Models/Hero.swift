//
//  Hero.swift
//  DeadlockHeroes
//
//  Created by Данила Рахманов on 27.10.2024.
//

import Foundation

// MARK: - Hero
struct Hero: Codable {
    let id: Int?
    let className: String?
    let name: String?
    let description: Description?
    let images: Images?

    enum CodingKeys: String, CodingKey {
        case id
        case className = "class_name"
        case name, description
        case images
    }

    // swiftlint:disable line_length
    static var testHero = Hero(
        id: 1,
        className: "Sniper",
        name: "Soldier: 76",
        description: Description(
            lore: "Like most teenagers; Infernus was wild, rebellious, and impetuous.  Unlike most teenagers, Infernus was a creature from another plane and had a supernatural mastery over fire.  Needless to say:  his youth was filled with no small amount of arson, murder, and evidence disposal.  But that was then.  Now an adult, Infernus has mellowed out considerably.  He’s happy working at a bar with good live music, and talking to interesting people.  That being said when someone at the bar gets belligerent or violent, he’s not afraid to dust off the skills he once honed.",
            role: "Lights up enemies and watches them burn",
            playstyle: "Infernus has many ways to deal damage over time, burning foes before swooping in for the kill. Due to Infernus' blazing speed, his enemies won't be able to escape the flames."
        ),
        images: nil
    )
    // swiftlint:enable line_length
}

// MARK: - Description
struct Description: Codable {
    let lore, role, playstyle: String?
}

// MARK: - Images
struct Images: Codable {
    let iconHeroCard: String?
    let iconHeroCardWebp: String?
    let iconImageSmall: String?
    let iconImageSmallWebp: String?
    let minimapImage: String?
    let minimapImageWebp: String?
    let selectionImage: String?
    let selectionImageWebp: String?
    let topBarImage: String?
    let topBarImageWebp: String?

    enum CodingKeys: String, CodingKey {
        case iconHeroCard = "icon_hero_card"
        case iconHeroCardWebp = "icon_hero_card_webp"
        case iconImageSmall = "icon_image_small"
        case iconImageSmallWebp = "icon_image_small_webp"
        case minimapImage = "minimap_image"
        case minimapImageWebp = "minimap_image_webp"
        case selectionImage = "selection_image"
        case selectionImageWebp = "selection_image_webp"
        case topBarImage = "top_bar_image"
        case topBarImageWebp = "top_bar_image_webp"
    }
}
