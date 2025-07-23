//
//  ChatRoomListViewController.swift
//  Assignment-TravelTalk
//
//  Created by 김민성 on 7/20/25.
//

import UIKit

class ChatRoomListViewController: UIViewController {
    
//    private(set) var allChatRoomList = ChatList.list
//    private(set) lazy var filteredChatRoomList: [ChatRoom] = allChatRoomList
    private(set) var allChatRoomList = ChatData.list
    private(set) lazy var filteredChatRoomList: [ChatRoomModel]? = allChatRoomList
    
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupDelegates()
        navigationController?.navigationBar.tintColor = .label
    }
    
}

// Initial Settings

private extension ChatRoomListViewController {
    
    func setupCollectionView() {
        // cell registrering
        let nib = UINib(nibName: "FriendListCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "FriendListCell")
        
        // setting layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView.collectionViewLayout = flowLayout
    }
    
    func setupDelegates() {
        searchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}


// MARK: - UICollectionViewDataSource

extension ChatRoomListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredChatRoomList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let filteredChatRoomList else {
            fatalError("채팅방 리스트 생성에 오류가 있습니다.")
        }
        let chatRoomModel = filteredChatRoomList[indexPath.item]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "FriendListCell",
            for: indexPath
        ) as! FriendListCell
        cell.configureData(chatRoom: chatRoomModel)
        return cell
    }
    
}


// MARK: - UICollectionViewDelegate

extension ChatRoomListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let filteredChatRoomList else {
            fatalError("채팅방 리스트 생성에 오류가 있습니다.")
        }
        let chatRoomData = filteredChatRoomList[indexPath.item]
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChatLogViewController") as! ChatLogViewController
        vc.title = chatRoomData.roomName
        vc.chatRoomId = chatRoomData.chatRoomId
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


// MARK: - UISearchBarDelegate

extension ChatRoomListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let trimmedText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedText.isEmpty {
            filteredChatRoomList = allChatRoomList
            collectionView.reloadData()
        } else {
            guard filteredChatRoomList != nil else {
                fatalError("채팅방 리스트 생성에 오류가 있습니다.")
            }
            filteredChatRoomList = allChatRoomList?.filter {
                $0.roomName.lowercased().contains(trimmedText.lowercased())
            }
            collectionView.reloadData()
        }
    }
    
}
