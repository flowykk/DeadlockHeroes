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
