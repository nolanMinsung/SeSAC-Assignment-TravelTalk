//
//  FriendListViewController.swift
//  Assignment-TravelTalk
//
//  Created by 김민성 on 7/20/25.
//

import UIKit

class FriendListViewController: UIViewController {
    
    private(set) var chatRoomList = ChatList.list + ChatList.list
    
    @IBOutlet var serarchBar: UISearchBar!
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupDelegates()
    }
    
}

// Initial Settings

extension FriendListViewController {
    
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
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}


// MARK: - UICollectionViewDataSource

extension FriendListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        chatRoomList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let chatRoom = chatRoomList[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendListCell", for: indexPath) as! FriendListCell
        cell.configureData(chatRoom: chatRoom)
        return cell
    }
    
}


// MARK: - UICollectionViewDelegate

extension FriendListViewController: UICollectionViewDelegate {
    
}
