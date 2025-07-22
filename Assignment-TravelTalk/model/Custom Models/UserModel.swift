//
//  UserModel.swift
//  Assignment-TravelTalk
//
//  Created by 김민성 on 7/23/25.
//

import UIKit


struct UserModel {
    
    static func from(dto user: User) throws -> UserModel {
        guard let image = UIImage(named: user.image) else {
            throw ChatError.userProfileImageNotFound
        }
        
        return .init(name: user.name, image: image)
    }
    
    let name: String
    let image: UIImage
}
