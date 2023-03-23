//
//  FavoriteTableViewCell.swift
//  TVMaze
//
//  Created by Ana Luiza on 3/22/23.
//

import Foundation
import UIKit
import Kingfisher

class FavoriteTableViewCell: UITableViewCell {
    static let identifier: String = "FavoriteTableViewCell"
    
    lazy var logoImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = .white
        
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = .white
        view.numberOfLines = 0
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.addSubview(logoImage)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.backgroundColor = .black
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 6),
            logoImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            logoImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 6),
            logoImage.widthAnchor.constraint(equalToConstant: 180),
            
            nameLabel.leadingAnchor.constraint(equalTo: self.logoImage.trailingAnchor, constant: 6),
            nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: -6),
            nameLabel.heightAnchor.constraint(equalToConstant: 60),
            
            descriptionLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 6),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.logoImage.trailingAnchor, constant: 6),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -6),
            
        ])
    }
    
    func update(with movie: Show?) {
        guard let movie = movie else {return}
        KF.url(URL(string: movie.imageUrl)).set(to: logoImage)
        nameLabel.text = movie.name
        descriptionLabel.text = updateSummary(movie.summary)
    }
    
    func updateSummary(_ summary: String) -> String {
        let replaced1 = summary.replacingOccurrences(of: "<b>", with: "")
        let replaced2 = replaced1.replacingOccurrences(of: "</b>", with: "")
        let replaced3 = replaced2.replacingOccurrences(of: "<p>", with: "")
        let replaced4 = replaced3.replacingOccurrences(of: "</p>", with: "")
        return replaced4
    }
}
