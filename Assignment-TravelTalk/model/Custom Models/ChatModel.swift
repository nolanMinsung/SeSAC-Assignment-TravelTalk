//
//  ChatModel.swift
//  Assignment-TravelTalk
//
//  Created by 김민성 on 7/23/25.
//

import Foundation



struct ChatModel {
    
    static func from(dto chat: Chat) throws -> ChatModel {
        let userModel = try UserModel.from(dto: chat.user)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = formatter.date(from: chat.date) else {
            throw ChatError.invalidDateFormat
        }
        
        let chatModel = ChatModel(
            user: userModel,
            date: date,
            message: chat.message
        )
        
        return chatModel
    }
    
    let user: UserModel
    let date: Date
    let message: String
    
    var chatListDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter.string(from: date)
    }
    
    var chatLogDateString: String {
        let formatter = DateFormatter()
        // 예시: 06:40 오후
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: date)
    }
}


