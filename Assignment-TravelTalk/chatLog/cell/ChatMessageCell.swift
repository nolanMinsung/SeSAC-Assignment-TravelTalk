//
//  ChatMessageCell.swift
//  Assignment-TravelTalk
//
//  Created by 김민성 on 7/20/25.
//

import UIKit


protocol ChatMessageCell: UITableViewCell {
    
    func configureData(with chat: Chat)
    
}
