//
//  Chat.swift
//  SeSAC7Step1Remind
//
//  Created by Jack on 7/18/25.
//

import Foundation

enum ChatError: Error {
    case invalidDateFormat
}

//채팅 화면에서 사용할 데이터 구조체
struct Chat {
    let user: User
    let date: String
    var dateStringForChatListView: String { (try? getDateStringForChatListView()) ?? "" }
    var dateStringForChatLog: String { (try? getDateStringForChatLog()) ?? "" }
    let message: String
    
    private func getDate() throws -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let date = formatter.date(from: date) {
            return date
        } else {
            throw ChatError.invalidDateFormat
        }
    }
    
    private func getDateStringForChatListView() throws -> String {
        guard let date = try? getDate() else { throw ChatError.invalidDateFormat }
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter.string(from: date)
    }
    
    private func getDateStringForChatLog() throws -> String {
        guard let date = try? getDate() else { throw ChatError.invalidDateFormat }
        let formatter = DateFormatter()
        // 예시: 06:40 오후
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: date)
    }
    
}
