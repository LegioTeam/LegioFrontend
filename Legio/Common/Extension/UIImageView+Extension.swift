//
//  UIImageView+Extension.swift
//  Legio
//
//  Created by Mac on 20.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func downloaded(
        from url: URL?,
        placeholderImage: UIImage? = nil,
        contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        
        contentMode = mode
        
        guard let url = url else {
            self.image = placeholderImage
            return
            
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    DispatchQueue.main.async() {
                        self?.image = placeholderImage
                    }
                    return
                    
            }
            DispatchQueue.main.async() {
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
