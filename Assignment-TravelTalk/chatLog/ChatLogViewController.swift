//
//  ChatLogViewController.swift
//  Assignment-TravelTalk
//
//  Created by 김민성 on 7/20/25.
//

import UIKit

class ChatLogViewController: UIViewController {
    
    /// `ChatLogViewContorller`에서 사용할 `chatRoom` 의 고유 `Id`
    ///
    /// 채팅 내역은 `ChatList` 구조체의 타입 저장 속성으로 저장됩니다. (전역에서 접근 가능)
    /// 채팅을 보내고 변경된 데이터를 원본 채팅 데이터베이스에 반영하기 위해서는
    /// 이 `ChatList` 구조체의 전역 속성에 직접 접근하여 새 채팅 내역을 추가할 필요가 있다고 생각했습니다.
    /// 실제로는 채팅 내역을 `CoreData` 등에 저장할 것이므로, `ChatList` 혹은 `ChatList`의 전역 변수가
    /// `CoreData`의 역할을 하는 것으로 생각하면 될 것 같습니다.
    /// 여담으로, 데이터베이를 다룰 때, 스레드 안전성을 위해 `actor` 등으로 관리하는 것도 괜찮을 것 같습니다.
    var chatRoomId: Int? = nil
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var sendingMessageInputContainerView: UIView!
    @IBOutlet var sendingMessageInputTextView: UITextView!
    @IBOutlet var sendingMessageButton: UIButton!
    @IBOutlet var textViewPlaceholder: UILabel!
    
    lazy var textViewHeight = sendingMessageInputTextView.heightAnchor.constraint(equalToConstant: 17)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDesign()
        setupLayoutConstraints()
        
        setupTableView()
        setupDelegates()
        
        tableView.reloadData()
        scrollToLastRow()
    }
    
    
    // 메시지를 전송해보자! -> 데이터베이스에 추가해보자! -> ChatList의 타입 속성에 반영해보자!
    @IBAction func sendingMessageButtonDidTap(_ sender: UIButton) {
        guard let chatRoomId else {
            assertionFailure()
            return
        }
        let trimmedText = sendingMessageInputTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let newChatModel = ChatModel(
            user: UserData.me,
            date: Date.now,
            message: trimmedText
        )
        
        // 레거시 코드
//        let newChat = Chat(
//            user: ChatList.me,
//            date: dateFormatter.string(from: .now),
//            message: trimmedText
//        )
//        ChatList.list[chatRoomId-1].chatList.append(newChat)
        ChatData.list?[chatRoomId-1].chatList.append(newChatModel)
        tableView.reloadData()
        scrollToLastRow()
    }
    
}


// Initial Settings

extension ChatLogViewController {
    
    private func setupDesign() {
        sendingMessageButton.tintColor = .systemGray
        sendingMessageInputContainerView.layer.cornerRadius = 5
        sendingMessageInputContainerView.clipsToBounds = true
        
        sendingMessageButton.tintColor = .label
        sendingMessageButton.isEnabled = !sendingMessageInputTextView.text.isEmpty
        sendingMessageInputTextView.textContainerInset = .zero
        sendingMessageInputTextView.textContainer.lineFragmentPadding = 0
    }
    
    private func setupLayoutConstraints() {
        sendingMessageInputContainerView.bottomAnchor.constraint(
            equalTo: view.keyboardLayoutGuide.topAnchor,
            constant: -20
        ).isActive = true
        
        textViewHeight.isActive = true
    }
    
    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        
        // cell 등록
        let userCellNib = UINib(nibName: "ChatMessageCellUser", bundle: .main)
        let otherCellNib = UINib(nibName: "ChatMessageCellOther", bundle: .main)
        
        tableView.register(userCellNib, forCellReuseIdentifier: "ChatMessageCellUser")
        tableView.register(otherCellNib, forCellReuseIdentifier: "ChatMessageCellOther")
    }
    
    private func setupDelegates() {
        tableView.dataSource = self
        
        sendingMessageInputTextView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollToLastRow()
    }
    
}


extension ChatLogViewController {
    
    private func scrollToLastRow() {
        guard let chatRoomId else {
            assertionFailure()
            return
        }
        let chatCount = ChatList.list[chatRoomId-1].chatList.count
        let lastIndexPath = IndexPath(row: chatCount-1, section: 0)
        tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
    }
    
}

// MARK: - UITableViewDataSource

extension ChatLogViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let chatRoomId else { fatalError() }
//        return ChatList.list[chatRoomId-1].chatList.count
        guard ChatData.list != nil else { fatalError("채팅 데이터 생성에 오류가 있습니다.") }
        return ChatData.list![chatRoomId-1].chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let chatRoomId else { fatalError() }
//        let chatItem = ChatList.list[chatRoomId-1].chatList[indexPath.row]
        guard ChatData.list != nil else { fatalError("채팅 데이터 생성에 오류가 있습니다.") }
        let chatModelItem = ChatData.list![chatRoomId-1].chatList[indexPath.row]
        
        let cell: any ChatMessageCell
        if chatModelItem.user == UserData.me {
//        if chatItem.user.name == ChatList.me.name {
            cell = tableView.dequeueReusableCell(withIdentifier: "ChatMessageCellUser") as! ChatMessageCellUser
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "ChatMessageCellOther") as! ChatMessageCellOther
        }
        
        cell.configureData(with: chatModelItem)
        return cell
    }
    
}


// MARK: - UITextViewDelegate

extension ChatLogViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        textViewPlaceholder.isHidden = !textView.text.isEmpty
        sendingMessageButton.isEnabled = !textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        let textHeight = textView.contentSize.height
        switch textHeight {
        case 0..<18:
            textViewHeight.constant = 17
        case 18..<35:
            textViewHeight.constant = 34
        default:
            textViewHeight.constant = 51
        }
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1
        ) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
}
