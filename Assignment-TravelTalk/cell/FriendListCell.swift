//
//  FriendListCell.swift
//  Assignment-TravelTalk
//
//  Created by 김민성 on 7/20/25.
//

import UIKit

class FriendListCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var chatRoomNameLabel: UILabel!
    
    @IBOutlet var latestChatLabel: UILabel!
    
    @IBOutlet var latestChatDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        
        let cellWidth: CGFloat
        if UIDevice.current.userInterfaceIdiom == .phone {
            cellWidth = UIScreen.main.bounds.width
        } else {
            cellWidth = 320
        }
        contentView.widthAnchor.constraint(equalToConstant: cellWidth).isActive = true
    }
    
    func configureData(chatRoom: ChatRoom) {
        imageView.image = try? chatRoom.getImage()
        chatRoomNameLabel.text = chatRoom.chatroomName
        latestChatLabel.text = chatRoom.latestChat!.message + chatRoom.latestChat!.message
        latestChatDateLabel.text = chatRoom.latestChat!.dateStringForUI
    }
    
}
