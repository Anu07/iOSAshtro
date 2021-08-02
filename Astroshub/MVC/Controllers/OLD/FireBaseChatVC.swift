////
////  FireBaseChatVC.swift
////  Astroshub
////
////  Created by PAWAN KUMAR on 30/05/20.
////  Copyright © 2020 Bhunesh Kahar. All rights reserved.
////
//
//import Foundation
//import Firebase
//import MessageKit
//import FirebaseFirestore
//import InputBarAccessoryView
//
//@available(iOS 13.0, *)
//final class ChatVC : MessagesViewController {
//    
//    private let user: User
//    private let channel: Channel
//    private var messages: [Messagejj] = []
//    private var messageListener: ListenerRegistration?
//    private let db = Firestore.firestore()
//    private var reference: CollectionReference?
//    
//    init(user: User, channel: Channel) {
//        self.user = user
//        self.channel = channel
//        super.init(nibName: nil, bundle: nil)
//        
//        title = channel.astrologer_name
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    deinit {
//      messageListener?.remove()
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        guard let id = channel.id else {
//            navigationController?.popViewController(animated: true)
//            return
//        }
//        
//        reference = db.collection(["\(user_id)", id, "thread"].joined(separator: "/"))
//        
//        messageListener = reference?.addSnapshotListener { querySnapshot, error in
//            guard let snapshot = querySnapshot else {
//                print("Error listening for channel updates: \(error?.localizedDescription ?? "No error")")
//                return
//            }
//            
//            snapshot.documentChanges.forEach { change in
//                self.handleDocumentChange(change)
//            }
//        }
//        
//        
//        messageInputBar.delegate = self
//        messagesCollectionView.messagesDataSource = self
//        messagesCollectionView.messagesLayoutDelegate = self
//        messagesCollectionView.messagesDisplayDelegate = self
//        
//        navigationItem.largeTitleDisplayMode = .never
//        
//        maintainPositionOnKeyboardFrameChanged = true
//        messageInputBar.inputTextView.tintColor = .blue
//        messageInputBar.sendButton.setTitleColor(.blue, for: .normal)
//    }
//    
//    private func save(_ message: Messagejj) {
//      reference?.addDocument(data: message.representation) { error in
//        if let e = error {
//          print("Error sending message: \(e.localizedDescription)")
//          return
//        }
//        
//        self.messagesCollectionView.scrollToBottom()
//      }
//    }
//    
//    // MARK: - Helpers
//
//    private func insertNewMessage(_ message: Messagejj) {
//      guard !messages.contains(message) else {
//        return
//      }
//      
//      messages.append(message)
//      messages.sort()
//      
////        _ = messages.firstIndex(of: message) == (messages.count - 1)
//      messagesCollectionView.reloadData()
//      
//        DispatchQueue.main.async {
//          self.messagesCollectionView.scrollToBottom(animated: true)
//        }
//    }
//    
//    private func handleDocumentChange(_ change: DocumentChange) {
//       guard let message = Messagejj(document: change.document) else {
//         return
//       }
//
//       switch change.type {
//       case .added:
//         insertNewMessage(message)
//
//       default:
//         break
//       }
//     }
//    
//}
//
//// MARK: - MessagesDisplayDelegate
//@available(iOS 13.0, *)
//extension ChatVC: MessagesDisplayDelegate {
//  
//  func backgroundColor(for message: MessageType, at indeypexPath: IndexPath,
//    in messagesCollectionView: MessagesCollectionView) -> UIColor {
//    
//    // 1
//    return isFromCurrentSender(message: message) ? .blue : .black
//  }
//
//  func shouldDisplayHeader(for message: MessageType, at indexPath: IndexPath,
//    in messagesCollectionView: MessagesCollectionView) -> Bool {
//
//    // 2
//    return false
//  }
//
//  func messageStyle(for message: MessageType, at indexPath: IndexPath,
//    in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
//
//    let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
//
//    // 3
//    return .bubbleTail(corner, .curved)
//  }
//}
//
//
//// MARK: - MessagesLayoutDelegate
//@available(iOS 13.0, *)
//extension ChatVC: MessagesLayoutDelegate {
//
//  func avatarSize(for message: MessageType, at indexPath: IndexPath,
//    in messagesCollectionView: MessagesCollectionView) -> CGSize {
//
//    // 1
//    return .zero
//  }
//
//  func footerViewSize(for message: MessageType, at indexPath: IndexPath,
//    in messagesCollectionView: MessagesCollectionView) -> CGSize {
//
//    // 2
//    return CGSize(width: 0, height: 8)
//  }
//
//  func heightForLocation(message: MessageType, at indexPath: IndexPath,
//    with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
//
//    // 3
//    return 0
//  }
//}
//
//
//// MARK: - MessagesDataSource
//@available(iOS 13.0, *)
//extension ChatVC: MessagesDataSource {
//    func currentSender() -> SenderType {
//        return Sender(id: Auth.auth().currentUser!.uid, displayName: Auth.auth().currentUser?.displayName ?? "Name not found")
//    }
//    
//    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
//         return messages.count
//    }
//    
//
//  // 1
////  func currentSender() -> Sender {
////    return Sender(id: user.uid, displayName: "" )
////  }
////
////    func currentSender() -> SenderType {
////
////        return Sender(id: Auth.auth().currentUser!.uid, displayName: Auth.auth().currentUser?.displayName ?? "Name not found")
////
////    }
//    
//  // 2
//  func numberOfMessages(in messagesCollectionView: MessagesCollectionView) -> Int {
//    return messages.count
//  }
//
//  // 3
//  func messageForItem(at indexPath: IndexPath,
//    in messagesCollectionView: MessagesCollectionView) -> MessageType {
//
//    return messages[indexPath.section]
//  }
//
//  // 4
//  func cellTopLabelAttributedText(for message: MessageType,
//    at indexPath: IndexPath) -> NSAttributedString? {
//
//    let name = message.sender.displayName
//    return NSAttributedString(
//      string: name,
//      attributes: [
//        .font: UIFont.preferredFont(forTextStyle: .caption1),
//        .foregroundColor: UIColor(white: 0.3, alpha: 1)
//      ]
//    )
//  }
//}
//
//
//// MARK: - MessageInputBarDelegate
//@available(iOS 13.0, *)
//extension ChatVC: InputBarAccessoryViewDelegate {
////    func messageInputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
////
////        // 1
////        let message = Messagejj(user: user, content: text)
////
////        // 2
////        save(message)
////
////        // 3
////        inputBar.inputTextView.text = ""
////    }
//    
//    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
//        
//        let message = Messagejj(user: user, content: text)
//        
//        // 2
//        save(message)
//        
//        // 3
//        inputBar.inputTextView.text = ""
//    }
//    
//    
//}
//
//
