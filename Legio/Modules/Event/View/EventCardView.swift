//
//  EventCardView.swift
//  Legio
//
//  Created by Mac on 28.03.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import UIKit

class EventCardView: UIView {
    
    private enum Texts {
        static let title = " "
        static let date = " "
        static let place = " "
    }
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var detailsButton: UIButton!
    
    private var detailUrlString: String = ""
    private var detailsAction: ((String) -> Void)?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    func configure(viewModel: EventViewModel) {
        configureGradient()
        eventImageView.downloaded(
            from: viewModel.imageUrl,
            placeholderImage: viewModel.defaultImage,
            contentMode: .scaleAspectFill)
        
        titleLabel.attributedText = configureTextLabel(string: viewModel.name)
        dateLabel.attributedText = configureTextLabel(string: viewModel.date)
        placeLabel.text = viewModel.place
        
        detailUrlString = viewModel.detailUrlString
        detailsAction = viewModel.action
    }
    
    private func configureGradient() {
        let rectGradient = CGRect(x: eventImageView.bounds.origin.x, y: eventImageView.bounds.origin.y, width: eventImageView.bounds.size.width, height: eventImageView.bounds.size.height / 2)
        eventImageView.addBlackGradientLayerInForeground(frame: rectGradient, colors: [.black, .clear])
    }
    
    @IBAction func detailsButtonTapped(_ sender: Any) {
        detailsAction?(detailUrlString)
    }
    
    
    //MARK: - Private funcs
    
    private func commonInit() {
        Bundle.main.loadNibNamed(self.nibName, owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = frame
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func configureTextLabel(string: String) -> NSAttributedString {
        let textBgColor: UIColor = UIColor.legio.legioBlue
        let attributes = [NSAttributedString.Key.backgroundColor: textBgColor]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        return attributedString
    }
}
