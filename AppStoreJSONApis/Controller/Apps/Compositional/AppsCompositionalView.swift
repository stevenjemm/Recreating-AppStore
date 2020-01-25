//
//  AppsCompositionalView.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 22/01/2020.
//  Copyright © 2020 Steven Jemmott. All rights reserved.
//

import SwiftUI

class CompositionController: UICollectionViewController {
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .black
        aiv.hidesWhenStopped = true
        aiv.startAnimating()
        return aiv
    }()
    
    init() {
        
        let layout = UICollectionViewCompositionalLayout{ (sectionNumber, _) -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case 0:
                return CompositionController.topSection()
            default:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                    heightDimension: .fractionalHeight(1/3)))
                item.contentInsets.bottom = 16
                item.contentInsets.trailing = 16
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.9),
                                                                                 heightDimension: .absolute(240)),
                                                             subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets.leading = 16
                
                let kind = UICollectionView.elementKindSectionHeader
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                            heightDimension: .absolute(50)),
                          elementKind: kind,
                          alignment: .topLeading)
                ]
                
                return section
            }
        }
        
        super.init(collectionViewLayout: layout)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func topSection() -> NSCollectionLayoutSection? {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        item.contentInsets.bottom = 16
        item.contentInsets.trailing = 16
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9),
                                                                         heightDimension: .absolute(300)),
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets.leading = 16
        
        return section
    }
    
    class CompositionalHeader: UICollectionReusableView {
        
        let label = UILabel(text: "Editor's Choice Games", font: .preferredFont(forTextStyle: .title2))
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(label)
            label.fillSuperview()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(CompositionalHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: "smallCellId")
        collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.backgroundColor = .systemBackground
        navigationItem.title = "Apps"
        navigationController?.navigationBar.prefersLargeTitles = true
        
//        fetchApps()
        setupDiffableDatasource()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }
    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        if section == 0 {
//            return self.socialApps.count
//        } else if section == 1 {
//            return games?.feed.results.count ?? 0
//        } else if section == 2 {
//            return topGrossing?.feed.results.count ?? 0
//        } else {
//            return freeApps?.feed.results.count ?? 0
//        }
//    }
    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        switch indexPath.section {
//        case 0:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! AppsHeaderCell
//            let socialApp = socialApps[indexPath.item]
//            cell.titleLabel.text = socialApp.tagline
//            cell.companyLabel.text = socialApp.name
//            cell.imageView.sd_setImage(with: URL(string: socialApp.imageUrl))
//            return cell
//        default:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "smallCellId", for: indexPath) as! AppRowCell
//            let game = games?.feed.results[indexPath.item]
//            cell.nameLabel.text = game?.name
//            cell.companyLabel.text = game?.artistName
//            cell.imageView.sd_setImage(with: URL(string: game?.artworkUrl100 ?? ""))
//
//            return cell
//        }
//    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! CompositionalHeader
        
        var title: String?
        
        switch indexPath.section {
        case 1:
            title = games?.feed.title
        case 2:
            title = topGrossing?.feed.title
        case 3:
            title = freeApps?.feed.title
        default:
            break
        }
        
        header.label.text = title
        return header
    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let appId: String
//
//        if indexPath.section == 0 {
//            appId = socialApps[indexPath.item].id
//
//        } else {
//            appId = games?.feed.results[indexPath.item].id ?? ""
//        }
//
//        let appDetailController = AppDetailController(appId: appId)
//        navigationController?.pushViewController(appDetailController, animated: true)
//    }
    
    var socialApps = [SocialApp]()
    var games: AppGroup?
    var topGrossing: AppGroup?
    var freeApps: AppGroup?
    
    private func fetchApps() {
//        var group1: AppGroup?
//        var group2: AppGroup?
//        var group3: AppGroup?
//
//        let dispatchGroup = DispatchGroup()
//
//        dispatchGroup.enter()
//        Service.shared.fetchGames { (result) in
//
//            dispatchGroup.leave()
//            switch result {
//            case .success(let appGroup):
//
//                group1 = appGroup
//
//            case .failure(let error):
//                print("Failed to fetch games: ", error)
//            }
//        }
//
//        dispatchGroup.enter()
//        Service.shared.fetchTopGrossing { (result) in
//
//            dispatchGroup.leave()
//            switch result {
//            case .success(let appGroup):
//
//                group2 = appGroup
//
//            case .failure(let error):
//                print("Failed to fetch topGrossing apps: ", error)
//            }
//        }
//
//        dispatchGroup.enter()
//        Service.shared.fetchFreeApps { (result) in
//
//            dispatchGroup.leave()
//            switch result {
//            case .success(let appGroup):
//
//                group3 = appGroup
//
//            case .failure(let error):
//                print("Failed to fetch free apps: ", error)
//            }
//        }
//
//        dispatchGroup.enter()
//        Service.shared.fetchSocialApps { (result) in
//            dispatchGroup.leave()
//            switch result {
//            case .success(let apps):
//
//                self.socialApps = apps
////                group3 = objects
//
//            case .failure(let error):
//                print("Failed to fetch social apps: ", error)
//            }
//        }
//
//        // Completion Block for DispatchGroup
//        dispatchGroup.notify(queue: .main) {
//            print("Completed your dispatch group tasks")
//
//            self.activityIndicatorView.stopAnimating()
//
//            if let group = group1 {
//                self.groups.append(group)
//            }
//            if let group = group2 {
//                self.groups.append(group)
//            }
//            if let group = group3 {
//                self.groups.append(group)
//            }
//
//            self.collectionView.reloadData()
//        }
        Service.shared.fetchSocialApps { (results) in
            switch results {
            case .success(let apps):
                self.socialApps = apps
                Service.shared.fetchGames { (gameResults) in
                    switch gameResults {
                    case.success(let games):
                        self.games = games
                        Service.shared.fetchTopGrossing { (topResults) in
                            switch topResults {
                            case .success(let appGroup):
                                self.topGrossing = appGroup
                                Service.shared.fetchFreeApps { (appResults) in
                                    switch appResults {
                                    case .success(let freeApps):
                                        self.freeApps = freeApps
                                        
                                        DispatchQueue.main.async {
                                            self.collectionView.reloadData()
                                        }
                                    case .failure(let error):
                                        print("Error getting Free Apps: ", error)
                                    }
                                }
                            case .failure(let error):
                                print("Error getting Top Grossing Apps: ", error)
                            }
                        }
                    case .failure(let error):
                        print("Error getting Game Apps: ", error)
                    }
                }
            case .failure(let error):
                print("Error getting Social Apps: ", error)
            }
        }
    }
    
    private func setupDiffableDatasource() {
        
    }
}

struct AppsView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<AppsView>) -> UIViewController {
        let controller = CompositionController()
        return UINavigationController(rootViewController: controller)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<AppsView>) {
        
    }
    
    typealias UIViewControllerType = UIViewController
    
}

struct AppsCompositionalView_Previews: PreviewProvider {
    static var previews: some View {
        AppsView()
            .edgesIgnoringSafeArea(.all)
    }
}
