//
//  EventsContainerView.swift
//  Legio
//
//  Created by Mac on 28.03.2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import UIKit

private enum AnimateDirection {
    case left
    case right
}

/// Протокол, уведомляющий об окончании предоставленных событий
protocol EventsContainerViewDelegate {
    
    /// Метод, который сообщает, что все ивенты были показаны
    func allEventsShowed()
}

class EventsContainerView: UIView {
    
    @IBOutlet var containerView: UIView!
    
    var delegate: EventsContainerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func configure(viewModels: [EventViewModel]) {
        
        viewModels.forEach {
            if $0.isLast {
                let eventCardView = EmptyEventCardView(frame: bounds)
                addSubview(eventCardView)
                eventCardView.configure(viewModel: $0)
                
            } else {
                let eventCardView = EventCardView(frame: bounds)
                addSubview(eventCardView)
                eventCardView.configure(viewModel: $0)
            }
        }
        
        layoutIfNeeded()
        sendAllEventsShowedIfNeeded()
    }
    
    func likeHandled() {
        prepareChangeEvent(direction: .left)
    }
    
    func dislikeHandled() {
        prepareChangeEvent(direction: .right)
    }
    
    
    //MARK: - Private funcs
    
    private func prepareChangeEvent(direction: AnimateDirection) {
        
        guard let subview = subviews.last else { return }
        
        animateChangeSubview(
            view: subview,
            direction: direction)
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(self.nibName, owner: self, options: nil)
    }
    
   
    
    private func animateChangeSubview(
        view: UIView,
        direction: AnimateDirection) {
        
        let endXPosition: CGFloat = direction == .left
            ? -frame.width
            : frame.width
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: .curveEaseIn,
            animations: {
                
                view.frame = CGRect(
                    x: endXPosition,
                    y: view.frame.origin.y,
                    width: view.frame.width,
                    height: view.frame.height)
        }, completion: { [weak self] _ in
            view.removeFromSuperview()
            self?.sendAllEventsShowedIfNeeded()
        })
        
    }
    
    /// Проверяем, является ли крайнее сабвью заглушкой об окончании событий,
    /// если да, то сообщаем об этом делегату
    private func sendAllEventsShowedIfNeeded() {
        
        guard let subview = subviews.last,
            let _ = subview as? EmptyEventCardView else {
                return
        }
        
        delegate?.allEventsShowed()
    }
}
