//
//  ChatLogViewController.swift
//  Assignment-TravelTalk
//
//  Created by 김민성 on 7/20/25.
//

import UIKit

class ChatLogViewController: UIViewController {
    
    var chatLog: [Chat] = []
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var sendingMessageInputContainerView: UIView!
    @IBOutlet var sendingMessageInputTextView: UITextView!
    @IBOutlet var sendingMessageButton: UIButton!
    
    lazy var textViewHeight = sendingMessageInputTextView.heightAnchor.constraint(equalToConstant: 17)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDesign()
        setupLayoutConstrainst()
        
        setupTableView()
        setupDelegates()
        
        tableView.reloadData()
    }
    
    @IBAction func sendingMessageButtonDidTap(_ sender: UIButton) {
        
    }
    
}


// Initial Settings

extension ChatLogViewController {
    
    private func setupDesign() {
        sendingMessageInputContainerView.layer.cornerRadius = 5
        sendingMessageInputContainerView.clipsToBounds = true
        
        sendingMessageInputTextView.textContainerInset = .zero
        sendingMessageInputTextView.textContainer.lineFragmentPadding = 0
    }
    
    private func setupLayoutConstrainst() {
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
        tableView.delegate = self
        tableView.dataSource = self
        
        sendingMessageInputTextView.delegate = self
    }
    
}

// MARK: - UITableViewDataSource

extension ChatLogViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatLog.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatItem = chatLog[indexPath.row]
        
        let cell: any ChatMessageCell
        if chatItem.user.name == ChatList.me.name {
            cell = tableView.dequeueReusableCell(withIdentifier: "ChatMessageCellUser") as! ChatMessageCellUser
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "ChatMessageCellOther") as! ChatMessageCellOther
        }
        
        cell.configureData(with: chatItem)
        return cell
    }
    
}


// MARK: - UITableViewDelegate

extension ChatLogViewController: UITableViewDelegate {
    
    
}


// MARK: - UITextViewDelegate

extension ChatLogViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        print("textView.contentSize: \(textView.contentSize)")
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
