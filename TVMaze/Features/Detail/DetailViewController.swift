//
//  DetailViewController.swift
//  TVMaze
//
//  Created by Ana Luiza on 3/20/23.
//

import Foundation
import UIKit

final class DetailViewController: UIViewController {
    
    private lazy var logoImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
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
    
    private lazy var showYearLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return view
    }()
    
    private lazy var showGenreLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return view
    }()
    
    private lazy var showDescriptionLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.numberOfLines = 0
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
    
    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.layer.borderColor = UIColor.white.cgColor
        picker.layer.borderWidth = 1
        picker.layer.cornerRadius = 10
        return picker
    }()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    var seasonSelected = 0

    private let viewModel: DetailViewModel


    init(viewModel: DetailViewModel) {
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
        viewModel.getSeasons(id: viewModel.show.id)
    }
    
    func setupUI() {
        let url = URL(string: "\(viewModel.show.image.original)")
        logoImage.kf.setImage(with: url)
        logoImage.contentMode = .scaleToFill
        showNameLabel.text = viewModel.show.name
        showYearLabel.text = "Airs on \(viewModel.show.schedule?.days[0] ?? "") at \(viewModel.show.schedule?.time ?? "")"
        showGenreLabel.text = "Genre: \(viewModel.show.genres?[0] ?? "")"
        showDescriptionLabel.text = updateSummary(viewModel.show.summary)
        
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        
        contentView.addSubview(logoImage)
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(showNameLabel)
        mainStackView.addArrangedSubview(showYearLabel)
        mainStackView.addArrangedSubview(showGenreLabel)
        mainStackView.addArrangedSubview(showDescriptionLabel)
        mainStackView.addArrangedSubview(pickerView)
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
            
            
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 300),
            logoImage.widthAnchor.constraint(equalToConstant: 250),
            logoImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

            mainStackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 12),
            mainStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
            mainStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12),
            showNameLabel.heightAnchor.constraint(equalToConstant: 30),
            showYearLabel.heightAnchor.constraint(equalToConstant: 30),
            showGenreLabel.heightAnchor.constraint(equalToConstant: 30),
            
            pickerView.heightAnchor.constraint(equalToConstant: 80),
            pickerView.widthAnchor.constraint(equalToConstant: 200),
            
            collectionView.heightAnchor.constraint(equalToConstant: 200),
            
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

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !viewModel.episodes.isEmpty {
                return viewModel.episodes[seasonSelected].count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowCollectionViewCell.identifier, for: indexPath) as? ShowCollectionViewCell
        
        cell?.contentView.layer.cornerRadius = 25.0
        cell?.contentView.clipsToBounds = true
        cell?.contentView.layer.borderWidth = 1
        cell?.contentView.layer.borderColor = #colorLiteral(red: 0.4297937751, green: 0.7693057656, blue: 0.7303231955, alpha: 1).cgColor
        for season in 0...viewModel.seasons.count-1 {
            cell?.nameLabel.text = viewModel.episodes[seasonSelected][indexPath.item].name
            if let url = URL(string: "\(viewModel.episodes[seasonSelected][indexPath.item].image?.original ?? "")") {
                cell?.logoImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholdertext.fill"))
                
            }
        }
        
        
        return cell ?? UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 180)
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
                self.viewModel.goToEpisodeDetail(episode: self.viewModel.episodes[self.seasonSelected][indexPath.item])
            }
        }
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func getEpisodes() {
        
        DispatchQueue.main.async {
            self.viewModel.seasons.forEach { season in
                self.viewModel.getEpisodes(id: season.id)
            }
        }
        
    }
    
    func presentEpisodes() {
        DispatchQueue.main.async {
            if self.viewModel.episodes.count == self.viewModel.seasons.count {
                self.collectionView.reloadData()
            }
        }
    }
    
    
}

extension DetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.seasons.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "season \(viewModel.seasons[row].number)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        seasonSelected = row
        collectionView.reloadData()
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: "season \(viewModel.seasons[row].number)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
    
    
}
