//
//  ActorsDetailViewController.swift
//  TVMaze
//
//  Created by Ana Luiza on 3/22/23.
//


import Foundation
import UIKit
import Kingfisher

final class ActorsDetailViewController: UIViewController {
    
    private lazy var logoImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 12
        return view
    }()
    
    
    private lazy var showNameLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return view
    }()
    
    private lazy var showSeriesLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .none
        collectionView.register(ShowCollectionViewCell.self, forCellWithReuseIdentifier: ShowCollectionViewCell.identifier)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    var seasonSelected = 0

    private let viewModel: ActorsDetailViewModel


    init(viewModel: ActorsDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        viewModel.delegate = self
        setupUI()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getActors(id: viewModel.actor.id ?? 1)
    }
    
    func setupUI() {
        if let url = URL(string: "\(viewModel.actor.image?.original ?? "")") {
            logoImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholdertext.fill"))
            
        }
        logoImage.contentMode = .scaleToFill
        showNameLabel.text = viewModel.actor.name
        
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)]
        let attributedString = NSMutableAttributedString(string:"Related shows", attributes:attrs)
        showSeriesLabel.attributedText = attributedString
        
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(logoImage)
        mainStackView.addArrangedSubview(showNameLabel)
        mainStackView.addArrangedSubview(showSeriesLabel)
        contentView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
            mainStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12),
            showNameLabel.heightAnchor.constraint(equalToConstant: 30),
            showSeriesLabel.heightAnchor.constraint(equalToConstant: 50),
            
            collectionView.heightAnchor.constraint(equalToConstant: 300),
            
            logoImage.heightAnchor.constraint(equalToConstant: 300),
            logoImage.widthAnchor.constraint(equalToConstant: 250),
            
            collectionView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            
        ])
    }
    
    func updateSummary(_ summary: String) -> String {
        let replaced1 = summary.replacingOccurrences(of: "<b>", with: "")
        let replaced2 = replaced1.replacingOccurrences(of: "</b>", with: "")
        let replaced3 = replaced2.replacingOccurrences(of: "<p>", with: "")
        let replaced4 = replaced3.replacingOccurrences(of: "</p>", with: "")
        return replaced4
    }
    
}

extension ActorsDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !viewModel.showActor.isEmpty {
            return viewModel.showActor.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowCollectionViewCell.identifier, for: indexPath) as? ShowCollectionViewCell
        
        cell?.contentView.layer.cornerRadius = 25.0
        cell?.contentView.clipsToBounds = true
        cell?.contentView.layer.borderWidth = 1
        cell?.contentView.layer.borderColor = #colorLiteral(red: 0.4297937751, green: 0.7693057656, blue: 0.7303231955, alpha: 1).cgColor
        cell?.nameLabel.text = viewModel.showActor[indexPath.item].embedded?.show?.name
        if let url = URL(string: "\(viewModel.showActor[indexPath.item].embedded?.show?.image.original ?? "")") {
            cell?.logoImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholdertext.fill"))
        }
        return cell ?? UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        UIView.animate(withDuration: 0.3) {
            cell?.contentView.alpha = 0.5
            UIView.animate(withDuration: 0.3) { // for animation effect
                cell?.contentView.alpha = 1.0
            } completion: { _ in
                let myURL = URL(string: self.viewModel.showActor[indexPath.item].embedded?.show?.url ?? "")
                UIApplication.shared.open(myURL!, options: [:], completionHandler: nil)
            }
        }
    }
}

extension ActorsDetailViewController: ActorsDetailViewModelDelegate {
    func presentShows() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
