//
//  TodayController.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 15/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import UIKit

class TodayController: BaseListController {
    
//    fileprivate let todayCellId = "todayCellId"
//    fileprivate let multipleAppCellId = "multipleAppCellId"
    var startingFrame: CGRect?
    static let cellSize: CGFloat = 450
    
    var appFullscreenController: AppFullscreenController!
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    var anchoredConstraint: AnchoredConstraints?
    
    var items = [TodayItem]()
    
    let activityIndicatorview: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .darkGray
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicatorview)
        activityIndicatorview.centerInSuperview()
        
        fetchData()
        collectionView.backgroundColor = #colorLiteral(red: 0.9555082917, green: 0.9493837953, blue: 0.9556146264, alpha: 1)
        collectionView.delaysContentTouches = false
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        tabBarController?.tabBar.superview?.setNeedsLayout()
    }
    
    fileprivate func fetchData() {
        
        let dispatchGroup = DispatchGroup()
        
        var topGrossingGroup: AppGroup?
        var gamesGroup: AppGroup?
        
        dispatchGroup.enter()
        Service.shared.fetchTopGrossing { (result: Result<AppGroup, Error>) in
            switch result {
            case .success(let appGroup):
                print("We have data: ", appGroup.feed.results)
                topGrossingGroup = appGroup
                dispatchGroup.leave()
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//                }
            case .failure(let error):
                print("Error fetching data: ", error.localizedDescription)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        Service.shared.fetchGames { (result: Result<AppGroup, Error>) in
            switch result {
            case .success(let appGroup):
                print("We have games: ", appGroup.feed.results)
                gamesGroup = appGroup
                dispatchGroup.leave()
                //                DispatchQueue.main.async {
                //                    self.collectionView.reloadData()
            //                }
            case .failure(let error):
                print("Error fetching data: ", error.localizedDescription)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue:.main) { [weak self] in
            print("Finished fetching the apps")
            self?.activityIndicatorview.stopAnimating()
            
            self?.items = [
                TodayItem.init(category: "Life Hack", title: "All the tools", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organise your life the right way.", backgroundColor: .white, apps: [], cellType: .single),
                TodayItem(category: "Daily List", title: topGrossingGroup?.feed.title ?? "", image: UIImage(), description: "", backgroundColor: .white, apps: topGrossingGroup?.feed.results ?? [], cellType: .multiple),
                TodayItem(category: "Daily List", title: gamesGroup?.feed.title ?? "", image: UIImage(), description: "", backgroundColor: .white, apps: gamesGroup?.feed.results ?? [], cellType: .multiple),
                TodayItem.init(category: "Holidays", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "All the tools and apps you need to intelligently organise your life the right way.", backgroundColor: #colorLiteral(red: 0.9853100181, green: 0.9683170915, blue: 0.7212222219, alpha: 1), apps: [], cellType: .single)
            ]
            
            self?.collectionView.reloadData()
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = items[indexPath.item].cellType.rawValue
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
        cell.todayItem = items[indexPath.item]
        
        (cell as? TodayMultipleAppCell)?.multipleAppsController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMultipleAppsTap(gesture:))))
//        (cell as? TodayMultipleAppCell)?.multipleAppsController.collectionView.isUserInteractionEnabled = false     // Allows touchdown animation to occur on embedded collectionView
        
        return cell
        
    }
    
    fileprivate func showDailyListFullScreen(_ indexPath: IndexPath) {
        let fullController = TodayMultipleAppsController(mode: .fullscreen)
        fullController.apps = self.items[indexPath.item].apps
        fullController.view.backgroundColor = .red
        present(BackEnabledNavigationController(rootViewController: fullController), animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Animate full Screen")
        
        switch items[indexPath.item].cellType {
        case .multiple:
            showDailyListFullScreen(indexPath)
        case .single:
            showSingleAppFullscreen(indexPath)
        }
        
    }
    
    fileprivate func setupSingleAppFullscreenController(_ indexPath: IndexPath) {
        let appFullscreenController = AppFullscreenController(todayItem: items[indexPath.item])
        appFullscreenController.dismissHandler = {
            self.handleRemoveAppFullscreen()
        }
        
        appFullscreenController.view.layer.cornerRadius = 16
        self.appFullscreenController = appFullscreenController
    }
    
    fileprivate func setupStartingCellFrame(_ indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        
        // Get the absolute coordinates of cell
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        
        self.startingFrame = startingFrame
    }
    
    fileprivate func setupAppFullscreenStartingPosition(_ indexPath: IndexPath) {
        let fullscreenView = appFullscreenController.view!
        fullscreenView.clipsToBounds = true
        view.addSubview(fullscreenView)
        
        addChild(appFullscreenController)
        
        self.collectionView.isUserInteractionEnabled = false
        
        setupStartingCellFrame(indexPath)
        
        guard let startingFrame = startingFrame else { return }
        
        self.anchoredConstraint = fullscreenView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: startingFrame.origin.y, left: startingFrame.origin.x, bottom: 0, right: 0), size: .init(width: startingFrame.width, height: startingFrame.height))
        
        self.view.layoutIfNeeded()
    }
    
    fileprivate func beginAppFullscreenAnimation() {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.anchoredConstraint?.top?.constant = 0
            self.anchoredConstraint?.leading?.constant = 0
            self.anchoredConstraint?.width?.constant = self.view.frame.width
            self.anchoredConstraint?.height?.constant = self.view.frame.height
            self.view.layoutIfNeeded()
            
            self.appFullscreenController.view.layer.cornerRadius = 0
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            
            guard let cell = self.appFullscreenController.tableView.cellForRow(at: [0, 0]) as? AppFullscreenHeader else { return }
            let height = UIApplication.shared.statusBarFrame.height
            
            cell.todayCell.topConstraint.constant = height + 24
            cell.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    fileprivate func showSingleAppFullscreen(_ indexPath: IndexPath) {
        
        setupSingleAppFullscreenController(indexPath)

        setupAppFullscreenStartingPosition(indexPath)
        
        beginAppFullscreenAnimation()
    }
    
    @objc func handleMultipleAppsTap(gesture: UIGestureRecognizer) {
        let collectionView = gesture.view
        
        var superView = collectionView?.superview
        
        while superView != nil {
            if let cell = superView as? TodayMultipleAppCell {
                guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
                
                let apps = self.items[indexPath.item].apps
                let fullController = TodayMultipleAppsController(mode: .fullscreen)
                fullController.apps = apps
                present(BackEnabledNavigationController(rootViewController: fullController), animated: true, completion: nil)
                return
                
            }
            
            superView = superView?.superview
        }
        
    }
    
    @objc func handleRemoveAppFullscreen() {
        
        guard let startingFrame = self.startingFrame else { return }
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.appFullscreenController.tableView.contentOffset = .zero       // Scrolls cell back to the top for animation aesthetics
            
            self.anchoredConstraint?.top?.constant = startingFrame.origin.y
            self.anchoredConstraint?.leading?.constant = startingFrame.origin.x
            self.anchoredConstraint?.width?.constant = startingFrame.width
            self.anchoredConstraint?.height?.constant = startingFrame.height
            
            self.view.layoutIfNeeded()
            
            self.appFullscreenController.view.layer.cornerRadius = 16
            self.tabBarController?.tabBar.transform = CGAffineTransform.identity
            
            guard let cell = self.appFullscreenController.tableView.cellForRow(at: [0, 0]) as? AppFullscreenHeader else { return }
            
            cell.todayCell.topConstraint.constant = 24
            cell.layoutIfNeeded()
            
        }, completion: { _ in
            self.appFullscreenController.view.removeFromSuperview()
            self.appFullscreenController.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true     // Small bug where collection view in cell was still scrollable
        })
    }
}

extension TodayController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let item = items[indexPath.item]
        let cellWidth = view.frame.width - (Constants.leftRightPadding * 2)
        
        switch item.cellType {
        case .single:
            return .init(width: cellWidth, height: 450)
        case.multiple:
            return .init(width: cellWidth, height: TodayController.cellSize)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.leftRightPadding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: Constants.leftRightPadding, left: 0, bottom: Constants.leftRightPadding, right: 0)
    }
}
