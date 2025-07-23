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
        
        do {
            let chatList = try chatRoom.chatList.map({ try ChatModel.from(dto: $0) })
            return ChatRoomModel(
                chatRoomId: chatRoom.chatroomId,
                roomImage: roomImage,
                roomName: chatRoom.chatroomName,
                chatList: chatList
            )
        }
    }
    
    let chatRoomId: Int
    let roomImage: UIImage
    let roomName: String
    var chatList: [ChatModel]
    
    /// 가장 마지막(최근) 채팅 정보. 채팅 내역이 없을 경우 `nil` 반환
    var latestChat: ChatModel? {
        chatList.last
    }
}
