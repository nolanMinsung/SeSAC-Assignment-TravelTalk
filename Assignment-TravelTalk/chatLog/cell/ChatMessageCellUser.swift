//
//  ChatMessageCellUser.swift
//  Assignment-TravelTalk
//
//  Created by 김민성 on 7/20/25.
//

import UIKit

class ChatMessageCellUser: UITableViewCell, ChatMessageCell {
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var messageContainerView: UIView!
    @IBOutlet var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageContainerView.layer.cornerRadius = 15
        messageContainerView.clipsToBounds = true
        messageContainerView.layer.borderColor = UIColor.systemGray.cgColor
        messageContainerView.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    func configureData(with chat: Chat) {
        messageLabel.text = chat.message
        timeLabel.text = chat.dateStringForChatLog
    }
    
}
