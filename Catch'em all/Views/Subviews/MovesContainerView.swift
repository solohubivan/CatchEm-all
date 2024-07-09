//
//  MovesContainerView.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 05.07.2024.
//

import UIKit

class MovesContainerView: UIView {
    
    private var titleLabel = UILabel()
    private var movesInfoTextView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Public Method
    
    func updateMovesInfoTextView(with moves: [String]) {
        movesInfoTextView.text = moves.joined(separator: ", ").capitalized
    }

    // MARK: - Setup UI
    
    private func setupUI() {
        self.backgroundColor = .clear
        setupTitleLabel()
        setupMovesInfoTextView()
        setupConstraints()
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "\(AppConstants.MovesContainerView.titleLabelText):"
        titleLabel.font = UIFont(name: AppConstants.Fonts.latoSemibold, size: 18)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        
        self.addSubview(titleLabel)
    }
    
    private func setupMovesInfoTextView() {
        movesInfoTextView.overrideUserInterfaceStyle = .light
        movesInfoTextView.isEditable = false
        movesInfoTextView.font = UIFont(name: AppConstants.Fonts.latoRegular, size: 15)
        movesInfoTextView.textAlignment = .justified
        movesInfoTextView.textColor = .gray

        self.addSubview(movesInfoTextView)
    }
}

// MARK: - Setup Constraints

extension MovesContainerView {
    private func setupConstraints() {
        titleLabel.addConstraints(to_view: self, [
            .top(anchor: self.topAnchor, constant: 20),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: self.trailingAnchor, constant: 16),
            .height(constant: 20)
        ])
        movesInfoTextView.addConstraints(to_view: self, [
            .top(anchor: titleLabel.bottomAnchor, constant: 8),
            .bottom(anchor: self.bottomAnchor, constant: 20),
            .trailing(anchor: self.trailingAnchor, constant: 16),
            .leading(anchor: self.leadingAnchor, constant: 16)
        ])
    }
}
