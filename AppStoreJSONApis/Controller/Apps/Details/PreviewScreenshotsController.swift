//
//  PreviewScreenshotsController.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 14/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import UIKit

class PreviewScreenshotsController: HorizontalSnappingController {
    
    private let screenshotCellId = "screenshotCellId"
    
    var app: _Result? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(ScreenshotCell.self, forCellWithReuseIdentifier: screenshotCellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app?.screenshotUrls.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: screenshotCellId, for: indexPath) as! ScreenshotCell
        
        let screenshotUrl = self.app?.screenshotUrls[indexPath.item]
        
        cell.imageView.sd_setImage(with: URL(string: screenshotUrl ?? ""))
        return cell
    }
}

extension PreviewScreenshotsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.height * 9 / 16
        
        return .init(width: width, height: view.frame.height)
    }
}
