//
//  ViewController.swift
//  UberUXClone
//
//  Created by Claudio Madureira Silva Filho on 17/12/18.
//  Copyright © 2018 Claudio Madureira Silva Filho. All rights reserved.
//

import UIKit

import UBSelectTravelOptions

class ViewController: UIViewController, SelectTravelOptionViewDelegate {
    
    var viewOptions: SelectTravelOptionView!
    var options: TravelOptions = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let colors: SelectTravelOptionViewColors = .default
        colors.progress = .green
        colors.scheduleMainColor = .orange
        colors.scheduleSecondaryColor = .black
        
        let config = SelectTravelOptionViewConfiguration(animationDuration: 0.3,
                                                         language: .es,
                                                         imagePlaceholderForOption: nil,
                                                         imageForNoCardSelected: nil,
                                                         imageInfo: nil,
                                                         imageNoOptions: nil,
                                                         imageClose: #imageLiteral(resourceName: "close"),
                                                         currency: "R$",
                                                         fonts: .default,
                                                         colors: colors,
                                                         hasSchedule: true
        )
//        config.hasDetails = false
//        config.hasPaymentInfo = false
        
        let view = SelectTravelOptionView.instance(with: config)
        
        let option0 = TravelOption(
            objectId: "AKSNDL",
            type: "Comum",
            price: 12.45,
            discount: 3.45,
            capacity: "1-4",
            estimatedArrivalTime: "12:45",
            imageNameOrURL: "Comum",
            selectedImageNameOrURL: "https://scontent.fcnf1-1.fna.fbcdn.net/v/t1.0-9/11071167_859956407395184_2973522312521098613_n.jpg?_nc_cat=111&_nc_ht=scontent.fcnf1-1.fna&oh=07c709c48fc3cb7841220ed0712b5d87&oe=5CCA8B29"
        )
        
        let option1 = TravelOption(
            objectId: "ASDKAM",
            type: "VIP",
            price: 22.5,
            discount: 1.5,
            capacity: "1-4",
            estimatedArrivalTime: "12:12",
            imageNameOrURL: "VIP",
            selectedImageNameOrURL: "VIP-selected"
        )
        
        let option2 = TravelOption(
            objectId: "AKSDBJ",
            type: "Moto",
            price: 32.80,
            discount: 4,
            capacity: "1",
            estimatedArrivalTime: "12:57",
            imageNameOrURL: "Moto",
            selectedImageNameOrURL: "Moto-selected"
        )
        
        let option3 = TravelOption(
            objectId: "AKSDBJ",
            type: "Bicicleta",
            price: 5.80,
            discount: nil,
            capacity: "1",
            estimatedArrivalTime: "13:37",
            imageNameOrURL: "Moto",
            selectedImageNameOrURL: "Moto-selected"
        )
        
        let option4 = TravelOption(
            objectId: "AKSDBJ",
            type: "Uber",
            price: 132.80,
            discount: 0,
            capacity: "1-4",
            estimatedArrivalTime: "20:57",
            imageNameOrURL: "Comum",
            selectedImageNameOrURL: "Comum-selected"
        )
        
        let options = [option0, option1, option2, option3, option4]
        self.options = options
        view.delegate = self
        self.view.addSubview(view)
        self.viewOptions = view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewOptions.startProgress()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.viewOptions.stopProgressWith(newOptions: [])
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self.viewOptions.setTravelOptionsAnimated(self.options)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                    self.viewOptions.setTravelOptionsAnimated([])
                })
            })
        })
    }
    
    // MARK: - SelectTravelOptionViewDelegate
    
    func didTapToSelectCard(_ view: SelectTravelOptionView) {
        let card = CardDetails.init(objectId: "ÄSDNASOD", numberCrip: "•••• 4499", image: UIImage(named: "MASTERCARD")!)
        view.setCard(with: card)
    }
    
    func didTapToFetchTravelOptionsAgain(_ view: SelectTravelOptionView) {
        view.startProgress()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.viewOptions.stopProgressWith(newOptions: self.options, debtValue: 9.42)
        })
    }
    
    func didTapToRequestTravel(_ view: SelectTravelOptionView, with option: TravelOption, card: CardDetails?) {
        view.startProgress()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            view.stopProgressWith(newOptions: [])
        })
    }
    
    func didChangeSelection(_ view: SelectTravelOptionView, optionSelected: TravelOption) {
        
    }
    
    func didTapSchedule(_ view: SelectTravelOptionView, on completion: @escaping (ScheduleDateViewModel, ScheduleAddresViewModel) -> Void) {
        self.presentDatePicker { (dateViewModel) in
            if let _dateViewModel = dateViewModel {
                completion(_dateViewModel, ScheduleAddresViewModel(originStreet: "Avenida João Paulo Magalhães 1234",
                                                             originNeighborhood: "São Cristóvão - Teresina",
                                                             destinyStreet: "Avenida Brasil, 213",
                                                             destinyNeighborhood: "São Gabriel - Teresina"))
            }
        }
    }
    
    func didRequestSchedule(_ view: SelectTravelOptionView) {
        
    }
    
    func didTapEditScheduleDate(_ view: SelectTravelOptionView, on completion: @escaping (ScheduleDateViewModel?) -> Void) {
        self.presentDatePicker(completion: completion)
    }
    
    func presentDatePicker(completion: @escaping (ScheduleDateViewModel?) -> Void) {
        DPPickerManager.shared.showPicker(title: "Agendamento", picker: { (picker) in
            picker.datePickerMode = .dateAndTime
        }) { (date, cancel) in
            if cancel {
                completion(nil)
            } else {
                if let _date = date {
                    completion(ScheduleDateViewModel(date: _date))
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    @objc func closePicker() {
        
    }
    
    @objc func confirmPicker() {
        
    }
    
    var test: String? = nil
    
    func didTapCouponButton(_ view: SelectTravelOptionView) {
        self.bCouponPressed()
    }
    
    @objc func bCouponPressed() {
        
        
        let alertScreen = UIAlertController(title: "Código Promocional", message: "Insira seu código promocional e aproveite seu desconto", preferredStyle: .alert)
        
        alertScreen.addTextField(configurationHandler: self.configureTextField)
        
        alertScreen.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: nil))
        
        alertScreen.addAction(UIAlertAction(title: "Usar", style: .default, handler: self.addPromotionalCode))
        
        
        self.present(alertScreen, animated: true, completion: nil)
    }
    
    func addPromotionalCode(alertView: UIAlertAction!) {
        guard let coupon = self.textField.text, !coupon.isEmpty else { return }
        self.viewOptions?.setCoupon(coupon)
//        self.checkCoupon()
    }
    
    var couponName: String? = nil
    var textField = UITextField()
    
    func configureTextField(textField: UITextField!) {
        textField.placeholder = "Digite seu código"
        textField.text = self.couponName == nil ? "" : self.couponName
        if (textField) != nil {
            self.textField = textField
        }
    }

    
}

