//
//  OptionWithoutPriceCell.swift
//  UBSelectTravelOptions
//
//  Created by Usemobile on 27/08/19.
//

import UIKit

class OptionWithoutPriceCell: UICollectionViewCell {
    
    lazy var carView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        return view
    }()
    
    lazy var imvCar: ImageView = {
        let imageView = ImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.clipsToBounds = true
        self.carView.addSubview(imageView)
        return imageView
    }()
    
    lazy var lblCar: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.minimumScaleFactor = 0.6
        label.font = UIFont.systemFont(ofSize: 14)
        
        self.carView.addSubview(label)
        return label
    }()
    
    var travelOption: TravelOption? {
        didSet {
            self.lblCar.text = self.travelOption?.type
            print("Index: ", index)
            print("Selected: ", _selected)
            self.setImage(selected: self._selected)
        }
    }
    var imagePlaceholder: UIImage?
    var _selected: Bool = false
    var index: Int = 0
    let proportionSelected: CGFloat = 1.25
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        self.setupCarViewConstraints()
        self.setupImvCarConstraints()
        self.setupLblCarConstraints()
    }
    
    private func setupCarViewConstraints() {
        self.carView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.carView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10).isActive = true
        self.carView.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor).isActive = true
        self.carView.heightAnchor.constraint(lessThanOrEqualTo: self.heightAnchor).isActive = true
        let heightAnchor = self.carView.heightAnchor.constraint(equalToConstant: 0)
        heightAnchor.priority = UILayoutPriority(rawValue: 250)
        heightAnchor.isActive = true
        let widthAnchor = self.carView.widthAnchor.constraint(equalToConstant: 0)
        widthAnchor.priority = UILayoutPriority(rawValue: 250)
        widthAnchor.isActive = true
    }
    
    private func setupImvCarConstraints() {
        self.imvCar.topAnchor.constraint(equalTo: self.carView.topAnchor).isActive = true
        self.imvCar.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        self.imvCar.widthAnchor.constraint(equalTo: self.imvCar.heightAnchor, multiplier: 1).isActive = true
        self.imvCar.centerXAnchor.constraint(equalTo: self.carView.centerXAnchor).isActive = true
        let leftAnchor = self.imvCar.leftAnchor.constraint(equalTo: self.carView.leftAnchor)
        leftAnchor.priority = .defaultLow
        leftAnchor.isActive = true
        let rightAnchor = self.imvCar.rightAnchor.constraint(equalTo: self.carView.rightAnchor)
        rightAnchor.priority = .defaultLow
        rightAnchor.isActive = true
    }
    
    private func setupLblCarConstraints() {
        self.lblCar.topAnchor.constraint(equalTo: self.imvCar.bottomAnchor, constant: 12).isActive = true
        self.lblCar.leftAnchor.constraint(equalTo: self.carView.leftAnchor).isActive = true
        self.lblCar.rightAnchor.constraint(equalTo: self.carView.rightAnchor).isActive = true
        self.lblCar.bottomAnchor.constraint(equalTo: self.carView.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func setImage(selected: Bool) {
        let option = self.travelOption!
        let nameOrURL = selected ? option.selectedImageNameOrURL : option.imageNameOrURL
        if self.validateUrl(urlString: nameOrURL),
            let url = URL(string: nameOrURL) {
            self.imvCar.castImage(from: url, with: self.imagePlaceholder)
        } else {
            let image = UIImage(named: nameOrURL)
            self.imvCar.image = image ?? self.imagePlaceholder
        }
        self.imvCar.transform = selected ? CGAffineTransform(scaleX: proportionSelected, y: proportionSelected) : CGAffineTransform.identity
    }
    
    func animateSelected(_ selected: Bool, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.15, animations: {
            self.setImage(selected: selected)
        }, completion: { _ in
            completion?()
        })
    }
    
    func validateUrl(urlString: String) -> Bool {
        guard urlString.count > 5 else { return false }
        var aux = ""
        let array = Array(urlString)
        for i in 0..<5 {
            aux.append(array[i])
        }
        return aux.contains("http")
    }
}
