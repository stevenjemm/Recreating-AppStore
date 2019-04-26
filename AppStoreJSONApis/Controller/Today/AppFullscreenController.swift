//
//  AppFullscreenController.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 15/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import UIKit

class AppFullscreenController: UIViewController {
   
    private let fullScreenCellId = "fullScreenCellId"
    private let headerId = "headerId"
    var tableView = UITableView(frame: .zero, style: .plain)
    fileprivate let todayItem: TodayItem!
    
    let closeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        btn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return btn
    }()
    
    var dismissHandler: (() -> ())?
    
    var floatingContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
//
//    init(todayItem: TodayItem) {
//        self.todayItem = todayItem
//    }
    init(todayItem: TodayItem) {
        self.todayItem = todayItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.clipsToBounds = true
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.dataSource = self
        tableView.delegate = self
        
        setupCloseButton()
        
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        let height = UIApplication.shared.statusBarFrame.height
        tableView.contentInset = .init(top: 0, left: 0, bottom: height, right: 0)
        
        setupFloatingControls()

    }
    
    fileprivate func setupFloatingControlSubviews(_ floatingContainerView: UIView) {
        // add our subviews
        let imageView = UIImageView(cornerRadius: 16)
        imageView.image = todayItem.image
        imageView.constrainHeight(constant: 68)
        imageView.constrainWidth(constant: 68)
        
        let getButton = UIButton(title: "GET")
        getButton.setTitleColor(.white, for: .normal)
        getButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        getButton.backgroundColor = .darkGray
        getButton.layer.cornerRadius = 16
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 32)
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            VerticalStackView(arrangedSubviews: [
                UILabel(text: "Life Hack", font: .boldSystemFont(ofSize: 16)),
                UILabel(text: "Utilizing your Time", font: .systemFont(ofSize: 14))
                ], spacing: 4),
            getButton
            ], customSpacing: 16)
        stackView.alignment = .center
        
        floatingContainerView.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    fileprivate func setupFloatingControls() {
        
        self.floatingContainerView = UIView()
        view.addSubview(floatingContainerView)
//        let bottomPadding = UIApplication.shared.statusBarFrame.height
        floatingContainerView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: -100, right: 16), size: .init(width: 0, height: 90))
        
        let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        floatingContainerView.addSubview(blurVisualEffectView)
        blurVisualEffectView.fillSuperview()
        
        setupFloatingControlSubviews(floatingContainerView)
    }
    
    fileprivate func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 12), size: .init(width: 80, height: 40))
    }
    
    @objc fileprivate func handleDismiss(button: UIButton) {
        button.isHidden = true
        dismissHandler?()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableView && tableView.contentOffset.y < 0 {
            tableView.isScrollEnabled = false
            tableView.isScrollEnabled = true    // Not the best solution
        }
        
        let bottomPadding = -UIApplication.shared.statusBarFrame.height
        let transform: CGAffineTransform = tableView.contentOffset.y > 100 ? CGAffineTransform(translationX: 0, y: -90 + bottomPadding) : .identity
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.floatingContainerView.transform = transform
        }, completion: nil)
    }
}


extension AppFullscreenController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let headerCell = AppFullscreenHeader()
            headerCell.todayCell.todayItem = todayItem
            headerCell.todayCell.backgroundView?.layer.cornerRadius = 0
            headerCell.clipsToBounds = true
            return headerCell
        }
        
        let cell = AppFullscreenDescriptionCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            let cellType = todayItem.cellType
            
            switch cellType {
            case .single:
                return 450
            case.multiple:
                return TodayController.cellSize
            }
        }
        
        return UITableView.automaticDimension
    }
}
