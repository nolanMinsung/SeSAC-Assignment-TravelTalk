//
//  ChatMessageCellOther.swift
//  Assignment-TravelTalk
//
//  Created by 김민성 on 7/20/25.
//

import UIKit

class ChatMessageCellOther: UITableViewCell, ChatMessageCell {
    
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messageContainerView: UIView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        
        messageContainerView.layer.cornerRadius = 15
        messageContainerView.clipsToBounds = true
        messageContainerView.layer.borderColor = UIColor.systemGray.cgColor
        messageContainerView.layer.borderWidth = 1
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func configureData(with chat: Chat) {
        profileImageView.image = chat.user.profileImage
        nameLabel.text = chat.user.name
        messageLabel.text = chat.message
        timeLabel.text = chat.dateStringForChatLog
    }
    
}
