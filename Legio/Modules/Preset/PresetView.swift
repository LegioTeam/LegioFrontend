//
//  PresetView.swift
//  Legio
//
//  Created by Марат Нургалиев on 10/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol PresetViewProtocol {
    func setupViews()
    func updateViews(preset: PresetEntity)
}

class PresetView: UIViewController {
    
    @IBOutlet var nerdyPercent: UILabel!
    @IBOutlet var partyPercent: UILabel!
    @IBOutlet var presetSlider: PresetSlider!
    @IBOutlet var emojiNerdy: UILabel!
    @IBOutlet var emojiParty: UILabel!
    @IBOutlet var nextButton: UIButton!
    
    var presenter: PresetPresenterProtocol!
    
    //private let titleText = "Preset"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    @IBAction func presetSliderAction(_ sender: Any) {
        let value = presetSlider.value
        //print(value.convertToPercent())
        
        guard presenter != nil else { return }
        presenter.updateData(percents: value.convertToPercent())
        
    }
    
}

//MARK: - Scale by percents
extension PresetView: PresetViewProtocol{
    
    func setupViews() {
        
        emojiNerdy.text = "🤓"
        emojiParty.text = "🥳"
        
        nextButton.layer.cornerRadius = 8
        nextButton.clipsToBounds = true
        
        presetSlider.setThumbImage(UIImage(named:"OvalPreset"), for: .normal)
    }
    
    func updateViews(preset: PresetEntity) {
        if(preset.typePreset == .Party){
            emojiParty.font = UIFont(name:"ArialRoundedMTBold" , size: CGFloat(preset.size))
            partyPercent.font = UIFont(name:"ArialRoundedMTBold" , size: CGFloat(preset.size))
            partyPercent.text = "\(preset.percent)%\nвеселее"
        }else{
            emojiNerdy.font = UIFont(name:"ArialRoundedMTBold" , size: CGFloat(preset.size))
            nerdyPercent.font = UIFont(name:"ArialRoundedMTBold" , size: CGFloat(preset.size))
            nerdyPercent.text = "\(preset.percent)%\nумнее"
        }
    }
}

//MARK: - Actions
extension PresetView {
    
    @IBAction func buttonNextTapped(_ sender: Any) {
        presenter.showEventTypesTapped()
    }
    
}

extension UINavigationController {
    func addCustomBackButton(title: String = "Back") {
        let backButton = UIBarButtonItem()
        backButton.title = title
        navigationBar.topItem?.backBarButtonItem = backButton
    }
}



