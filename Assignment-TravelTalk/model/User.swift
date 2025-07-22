//
//  User.swift
//  SeSAC7Step1Remind
//
//  Created by Jack on 7/18/25.
//
  
import UIKit

struct User {
    let name: String //유저 닉네임
    /// 이미지 리소스 이름
    let image: String //유저 프로필
    
    var profileImage: UIImage? {
        UIImage(named: self.image)
    }
}
