//
//  Character.swift
//  GenshinDB
//
//  Created by Ihwan on 05/05/21.
//

import Foundation

struct Character: Codable {
    let name: String
    let vision: String
    let weapon: String
    let nation: String
    let affiliation: String
    let rarity: Int
    let constellation: String
    let birthday: String
    let description: String
    let skillTalents: [SkillTalent]
    let passiveTalents: [PassiveTalent]
    let constellations: [Constellation]
    let vision_key: String
    let weapon_type: String
}

struct SkillTalent: Codable{
    let name: String
    let unlock: String
    let description: String
    let upgrades: [Upgrades]
    let type: String
}

struct Upgrades: Codable{
    let name: String
    let value: String
}

struct PassiveTalent: Codable {
    let name: String
    let unlock: String
    let description: String
    let level: Int
}

struct Constellation: Codable{
    let name: String
    let unlock: String
    let description: String
    let level: Int
}
