//
//  ChatRoom.swift
//  SeSAC7Step1Remind
//
//  Created by Jack on 7/18/25.
//

import UIKit

enum ChatRoomError: Error {
    case roomImageNotFound
}

//트래블톡 화면에서 사용할 데이터 구조체
struct ChatRoom {
    let chatroomId: Int //채팅방 고유 ID
    let chatroomImage: String //채팅방 이미지
    let chatroomName: String //채팅방 이름
    var chatList: [Chat] = [] //채팅 화면에서 사용할 데이터
    
    func getImage() throws -> UIImage {
        let image = UIImage(named: self.chatroomImage)
        if let image {
            return image
        } else {
            throw ChatRoomError.roomImageNotFound
        }
    }
    
    /// 가장 마지막(최근) 채팅 정보. 채팅 내역이 없을 경우 `nil` 반환
    var latestChat: Chat? {
        chatList.last
    }
    
}
