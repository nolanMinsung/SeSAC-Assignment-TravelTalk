//
//  ChatError.swift
//  Assignment-TravelTalk
//
//  Created by 김민성 on 7/23/25.
//

import Foundation


enum ChatError: Error {
    case invalidChatDateFormat
    case userProfileImageNotFound
    case chatRoomImageNotFound
    case duplicateChatRoomID
}
