//
//  AppFullscreenController.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 15/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import UIKit

class AppFullscreenController: UITableViewController {
   
    private let fullScreenCellId = "fullScreenCellId"
    private let headerId = "headerId"
    
    var dismissHandler: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .white
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.allowsSelection = false
        tableView.separatorStyle = .none

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let headerCell = AppFullscreenHeader()
            headerCell.closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
            return headerCell
        }
        
        let cell = AppFullscreenDescriptionCell()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 450
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    
    @objc fileprivate func handleDismiss(button: UIButton) {
        button.isHidden = true
        dismissHandler?()
    }
}

//extension AppFullscreenController: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let size: CGSize = .init(width: view.frame.width, height: 1000)
//        let dummyCell = AppFullscreenDescriptionCell(frame: .init(origin: .zero, size: size))
//        let attributedText = NSMutableAttributedString(string: "Great Games", attributes: [.foregroundColor: UIColor.black])
//
//        attributedText.append(NSAttributedString(string: " are all about the details, from subtle visual effects to imaginative art styles. In these titles, you're sure to find something to marvel at, whether you're into fantasy worlds or neon-soaked dartboards.", attributes: [.foregroundColor : UIColor.gray]))
//
//        attributedText.append(NSAttributedString(string: " \n\n\nHerois adventure", attributes: [.foregroundColor : UIColor.black]))
//
//        attributedText.append(NSAttributedString(string: "\nBattle in dungeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world.", attributes: [.foregroundColor : UIColor.gray]))
//
//        attributedText.append(NSAttributedString(string: " \n\n\nHerois adventure", attributes: [.foregroundColor : UIColor.black]))
//
//        attributedText.append(NSAttributedString(string: "\nBattle in dungeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world.", attributes: [.foregroundColor : UIColor.gray]))
//        dummyCell.descriptionLabel.attributedText = attributedText
//        dummyCell.layoutIfNeeded()
//
//        let estimatedSize = dummyCell.systemLayoutSizeFitting(size)
//
//        return .init(width: view.frame.width, height: estimatedSize.height)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//
////        let size: CGSize = .init(width: view.frame.width, height: 450)
////        let dummyHeaderCell = AppFullscreenHeader(frame: .init(origin: .zero, size: size))
////        dummyHeaderCell.todayCell = TodayCell()
////        dummyHeaderCell.layoutIfNeeded()
////
////        let estimatedSize = dummyHeaderCell.systemLayoutSizeFitting(size)
//
//        return .init(width: view.frame.width, height: 450)
//    }
//}
