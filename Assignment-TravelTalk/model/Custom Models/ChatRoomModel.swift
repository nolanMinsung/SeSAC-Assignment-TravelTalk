//
//  ChatRoomModel.swift
//  Assignment-TravelTalk
//
//  Created by 김민성 on 7/23/25.
//

import UIKit


struct ChatRoomModel {
    
    static var activeChatRoomIdList: Set<Int> = []
    
    static func from(dto chatRoom: ChatRoom) throws -> ChatRoomModel {
        guard let roomImage = UIImage(named: chatRoom.chatroomImage) else {
            throw ChatError.chatRoomImageNotFound
        }
        guard !ChatRoomModel.activeChatRoomIdList.contains(chatRoom.chatroomId) else {
            throw ChatError.duplicateChatRoomID
        }
        
        return ChatRoomModel(chatRoomId: chatRoom.chatroomId, roomImage: roomImage, roomName: chatRoom.chatroomName)
    }
    
    let chatRoomId: Int
    let roomImage: UIImage
    let roomName: String
    var chatList: [Chat] = []
}
