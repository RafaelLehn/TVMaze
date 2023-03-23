//
//  EpisodeViewController.swift
//  TVMaze
//
//  Created by Ana Luiza on 3/21/23.
//

import Foundation
import UIKit
import SwiftUI

final class EpisodeViewController: UIViewController {
    
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
        view.alignment = .center
        return view
    }()
    
    private lazy var episodeNameLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = #colorLiteral(red: 0.4297937751, green: 0.7693057656, blue: 0.7303231955, alpha: 1)
        return view
    }()
    
    private lazy var episodeNumberLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return view
    }()
    
    private lazy var episodeSeasonLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return view
    }()
    
    private lazy var episodeDescriptionLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    var seasonSelected = 0
    
    private let viewModel: EpisodeViewModel
    
    
    init(viewModel: EpisodeViewModel) {
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
    
    func setupUI() {
        if let url = URL(string: "\(viewModel.episode.image?.original ?? "")") {
            logoImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholdertext.fill"))
        }
        logoImage.contentMode = .scaleToFill
        
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 22)]
        let attributedString = NSMutableAttributedString(string:viewModel.episode.name ?? "", attributes:attrs)
        episodeNameLabel.attributedText = attributedString
        
        episodeNumberLabel.text = "episode number: \(viewModel.episode.number ?? 0)"
        episodeSeasonLabel.text = "season: \(viewModel.episode.season ?? 0)"
        episodeDescriptionLabel.text = updateSummary(viewModel.episode.summary ?? "")
        mainStackView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(episodeNameLabel)
        mainStackView.addArrangedSubview(logoImage)
        mainStackView.addArrangedSubview(episodeNumberLabel)
        mainStackView.addArrangedSubview(episodeSeasonLabel)
        mainStackView.addArrangedSubview(episodeDescriptionLabel)
        
        
        NSLayoutConstraint.activate([
            
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            mainStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
            mainStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            logoImage.heightAnchor.constraint(equalToConstant: 300),
            
            episodeNameLabel.heightAnchor.constraint(equalToConstant: 30),
            episodeNumberLabel.heightAnchor.constraint(equalToConstant: 30),
            episodeSeasonLabel.heightAnchor.constraint(equalToConstant: 30),
            
            
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

extension EpisodeViewController: EpisodeViewModelDelegate {
    
}
