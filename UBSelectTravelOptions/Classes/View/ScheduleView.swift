//
//  ScheduleView.swift
//  UBSelectTravelOptions
//
//  Created by Usemobile on 23/09/19.
//

import UIKit

class ScheduleView: UIView {
    
    lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 20, width: 320, height: 21)
        label.center.x = self.center.x
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    lazy var lblOriginStreet: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.frame = CGRect(x: self.addressX, y: 64, width: self.addressWidth, height: 18)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    lazy var lblOriginNeighborhood: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.frame = CGRect(x: self.addressX, y: 86, width: self.addressWidth, height: 16)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = #colorLiteral(red: 0.6470588235, green: 0.6470588235, blue: 0.6470588235, alpha: 1)
        return label
    }()
    
    lazy var lblDestinyStreet: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.frame = CGRect(x: self.addressX, y: 116, width: self.addressWidth, height: 18)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    lazy var lblDestinyNeighborhood: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.frame = CGRect(x: self.addressX, y: 138, width: self.addressWidth, height: 16)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = #colorLiteral(red: 0.6470588235, green: 0.6470588235, blue: 0.6470588235, alpha: 1)
        return label
    }()
    
    lazy var imvOption: ImageView = {
        let imageView = ImageView()
        imageView.frame = CGRect(x: self.paddingX, y: 63, width: 64, height: 68)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var lblOption: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = self.travelOption?.type.capitalized
        label.frame = CGRect(x: 0, y: 135, width: 80, height: 16)
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .black
        label.center.x = self.imvOption.center.x
        return label
    }()
    
    lazy var imvOrigin: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 118, y: 74, width: 11, height: 11)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage.getFrom(customClass: ScheduleView.self, nameResource: "circle")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = self.mainColor
        return imageView
    }()
    
    lazy var imvDots: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 87, width: 4, height: 45)
        imageView.center.x = self.imvOrigin.center.x
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage.getFrom(customClass: ScheduleView.self, nameResource: "dots")
        return imageView
    }()
    
    lazy var imvPin: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 132, width: 11, height: 15)
        imageView.center.x = self.imvDots.center.x
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage.getFrom(customClass: ScheduleView.self, nameResource: "pin")
        return imageView
    }()
    
    lazy var viewDate: UIView = {
        let view = UIView()
        let paddingX: CGFloat = 25.5
        let width = self.screenSize.width - (2 * paddingX)
        view.frame = CGRect(x: paddingX, y: 175, width: width, height: 42)
        view.addBorder(edges: [.top, .bottom], color: #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1))
        return view
    }()
    
    lazy var btnDay: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 42)
        let attributedTitle = NSMutableAttributedString(string: "12/07/2019",
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                     NSAttributedString.Key.underlineStyle: 1,
                                                                     NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(self.editDataPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var btnHour: UIButton = {
        let button = UIButton(type: .system)
        let width: CGFloat = 60
        let x = self.viewDate.frame.width - width
        button.frame = CGRect(x: x, y: 0, width: width, height: 42)
        let attributedTitle = NSMutableAttributedString(string: "14:30",
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                     NSAttributedString.Key.underlineStyle: 1,
                                                                     NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(self.editDataPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var btnBack: UIButton = {
        let button = UIButton(type: .system)
        let title = NSMutableAttributedString(string: "Voltar", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .black),
                                                                             NSAttributedString.Key.foregroundColor: self.mainColor])
        button.setAttributedTitle(title, for: .normal)
        button.addTarget(self, action: #selector(self.backPressed), for: .touchUpInside)
        button.frame = CGRect(x: 26, y: 240, width: self.screenSize.width/2 - 36, height: 54)
        button.setTitleColor(self.mainColor, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 27
        button.layer.borderColor = self.mainColor.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = self.secondaryColor
        return button
    }()
    
    lazy var btnSchedule: UIButton = {
        let button = UIButton(type: .system)
        let title = NSMutableAttributedString(string: "Agendar", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .black),
                                                                             NSAttributedString.Key.foregroundColor: self.secondaryColor])
        button.setAttributedTitle(title, for: .normal)
        button.addTarget(self, action: #selector(self.schedulePressed), for: .touchUpInside)
        let width = self.screenSize.width/2 - 36
        let x = self.screenSize.width - width - 26
        button.frame = CGRect(x: x, y: 240, width: width, height: 54)
        button.setTitleColor(self.secondaryColor, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 27
        button.backgroundColor = self.mainColor
        return button
    }()
    
    public var mainColor: UIColor
    public var secondaryColor: UIColor
    public var dateViewModel: ScheduleDateViewModel? {
        didSet {
            let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                             NSAttributedString.Key.underlineStyle: 1,
                                                             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)]
            let attributedDay = NSMutableAttributedString(string: self.dateViewModel?.day ?? "",
                                                          attributes: attributes)
            
            let attributedTime = NSMutableAttributedString(string: self.dateViewModel?.time ?? "",
                                                           attributes: attributes)
            self.btnDay.setAttributedTitle(attributedDay, for: .normal)
            self.btnHour.setAttributedTitle(attributedTime, for: .normal)
        }
    }
    public var scheduleViewModel: ScheduleAddresViewModel? {
        didSet {
            self.lblOriginStreet.text = self.scheduleViewModel?.originStreet
            self.lblOriginNeighborhood.text = self.scheduleViewModel?.originNeighborhood
            self.lblDestinyStreet.text = self.scheduleViewModel?.destinyStreet
            self.lblDestinyNeighborhood.text = self.scheduleViewModel?.destinyNeighborhood
        }
    }
    public var language: Language = .pt {
        didSet {
            self.lblTitle.text = .scheduleTravel(self.language)
        }
    }
    
    public var backAction: (() -> Void)?
    public var scheduleAction: (() -> Void)?
    public var editDateAction: (() -> Void)?
    
    let screenSize = UIScreen.main.bounds
    let paddingX: CGFloat = 35
    let addressX: CGFloat = 150
    var addressWidth: CGFloat {
        return self.screenSize.width - self.addressX - self.paddingX
    }
    var travelOption: TravelOption?
    
    init(frame: CGRect,
         travelOption: TravelOption?,
         mainColor: UIColor,
         secondaryColor: UIColor) {
        self.travelOption = travelOption
        self.mainColor = mainColor
        self.secondaryColor = secondaryColor
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        self.mainColor = .blue
        self.secondaryColor = .white
        super.init(coder: coder)
        self.setup()
    }
    
    private func setup() {
        self.backgroundColor = .white
        self.addSubviews()
        self.setImage()
    }
    
    private func addSubviews() {
        self.addSubview(self.lblTitle)
        self.addSubview(self.lblOriginStreet)
        self.addSubview(self.lblOriginNeighborhood)
        self.addSubview(self.lblDestinyStreet)
        self.addSubview(self.lblDestinyNeighborhood)
        self.addSubview(self.imvPin)
        self.addSubview(self.imvDots)
        self.addSubview(self.imvOrigin)
        self.addSubview(self.imvOption)
        self.addSubview(self.lblOption)
        self.addSubview(self.viewDate)
        self.viewDate.addSubview(self.btnDay)
        self.viewDate.addSubview(self.btnHour)
        self.addSubview(self.btnBack)
        self.addSubview(self.btnSchedule)
        
    }
    
    func setImage() {
        let option = self.travelOption
        let nameOrURL = option?.selectedImageNameOrURL ?? ""
        if self.validateUrl(urlString: nameOrURL),
            let url = URL(string: nameOrURL) {
            self.imvOption.castImage(from: url, with: nil)
        } else {
            let image = UIImage(named: nameOrURL)
            self.imvOption.image = image
        }
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
    
    @objc func backPressed() {
        self.backAction?()
    }
    
    @objc func schedulePressed() {
        self.scheduleAction?()
    }
    
    @objc func editDataPressed() {
        self.editDateAction?()
    }

}
