//
//  UserData.swift
//  Assignment-TravelTalk
//
//  Created by 김민성 on 7/23/25.
//

import UIKit

struct UserData {
    
    static let me = UserModel(name: "김새싹", image: UIImage(named: "Me") ?? UIImage())
    static let hue = UserModel(name: "Hue", image: UIImage(named: "Hue") ?? UIImage())
    static let bran = UserModel(name: "Bran", image: UIImage(named: "Bran") ?? UIImage())
    static let jack = UserModel(name: "Jack", image: UIImage(named: "Jack") ?? UIImage())
    static let den = UserModel(name: "Den", image: UIImage(named: "Den") ?? UIImage())
    static let finn = UserModel(name: "Finn", image: UIImage(named: "Finn") ?? UIImage())
    static let other_friend = UserModel(name: "Other Friend", image: UIImage(named: "Other") ?? UIImage())
    static let simsim = UserModel(name: "심심이", image: UIImage(named: "Simsim") ?? UIImage())
    
}
