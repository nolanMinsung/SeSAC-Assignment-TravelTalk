//
//  ChatRoomListViewController.swift
//  Assignment-TravelTalk
//
//  Created by 김민성 on 7/20/25.
//

import UIKit

class ChatRoomListViewController: UIViewController {
    
    private(set) var allChatRoomList = ChatList.list
    private(set) lazy var filteredChatRoomList: [ChatRoom] = allChatRoomList
    
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupDelegates()
    }
    
}

// Initial Settings

extension ChatRoomListViewController {
    
    private func setupCollectionView() {
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
    
    private func setupDelegates() {
        searchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}


// MARK: - UICollectionViewDataSource

extension ChatRoomListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredChatRoomList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let chatRoom = filteredChatRoomList[indexPath.item]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "FriendListCell",
            for: indexPath
        ) as! FriendListCell
        cell.configureData(chatRoom: chatRoom)
        return cell
    }
    
}


// MARK: - UICollectionViewDelegate

extension ChatRoomListViewController: UICollectionViewDelegate {
    
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
            filteredChatRoomList = allChatRoomList.filter {
                $0.chatroomName.lowercased().contains(trimmedText.lowercased())
            }
            collectionView.reloadData()
        }
    }
    
}
