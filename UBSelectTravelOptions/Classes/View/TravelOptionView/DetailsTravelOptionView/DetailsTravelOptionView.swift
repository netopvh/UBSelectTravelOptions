//
//  DetailsTravelOptionView.swift
//  UberUXClone
//
//  Created by Claudio Madureira Silva Filho on 17/12/18.
//  Copyright © 2018 Claudio Madureira Silva Filho. All rights reserved.
//

import UIKit

class DetailsTravelOptionView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    var label: UILabel = UILabel()
    var padding: CGFloat = 0
    var items: [(String, String)] = []
    var linesColor: UIColor = .clear
    var height: CGFloat {
        return self.cellHeight*2 + self.heightForText
    }
    var heightForText: CGFloat = 75
    var cellHeight: CGFloat = 30
    var width: CGFloat = UIScreen.main.bounds.size.width
    var leftColor: UIColor = .black
    var rightColor: UIColor = .black
    var leftFont: UIFont = .systemFont(ofSize: 14, weight: .regular)
    var rightFont: UIFont = .systemFont(ofSize: 14, weight: .regular)
    
    convenience init() {
        self.init(frame: CGRect())
        self.frame.size = CGSize(width: self.width, height: self.height)
        self.addSubview(self.label)
        self.center.x = self.width/2
        self.setupTableView()
        self.setupLineViews()
        self.tableView.frame.size.height = self.height - self.heightForText
        self.tableView.reloadData()
    }
    
    func setup(padding: CGFloat,
               lineColor: UIColor,
               language: Language,
               textLeftColor: UIColor,
               textRightColor: UIColor,
               textLeftFont: UIFont,
               textRightFont: UIFont) {
        
        self.padding = padding
        self.linesColor = lineColor
        self.leftColor = textLeftColor
        self.rightColor = textRightColor
        self.leftFont = textLeftFont
        self.rightFont = textRightFont
        self.setupTextWithDetails(for: language)
        self.tableView.frame.size.width = self.width - 2*self.padding
        self.tableView.center.x = self.width/2
        self.subviews.forEach({ view in
            if view.restorationIdentifier == "line" {
                view.backgroundColor = lineColor
                view.frame.size.width = self.width - 2*padding
                view.center.x = self.width/2
            }
        })
    }
    
    func setupTableView() {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        let bundle: Bundle = Bundle(for: DetailTravelOptionTableViewCell.self)
        let nib = UINib(nibName: "DetailTravelOptionTableViewCell", bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.frame.size.height = self.height - self.heightForText
        tableView.frame.origin.y = 1
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        self.addSubview(tableView)
        self.tableView = tableView
    }
    
    func setupLineViews() {
        let lineTop = self.getLineView()
        lineTop.frame.origin.y = 0
        self.addSubview(lineTop)
        let lineBottom = self.getLineView()
        lineBottom.frame.origin.y = self.height - self.heightForText + 1
        self.addSubview(lineBottom)
    }
    
    func setupTextWithDetails(for language: Language) {
        let label: UILabel = self.label
        label.frame.origin.x = self.padding
        label.frame.size.width = self.width - 2*self.padding
        label.frame.size.height = self.heightForText
        label.frame.origin.y = self.height - self.heightForText + 1
        label.text = String.descriptionText(language)
        label.numberOfLines = 4
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
    }
    
    func getLineView() -> UIView {
        let view = UIView()
        view.restorationIdentifier = "line"
        view.frame.size = CGSize(width: self.width - 2*self.padding, height: 1)
        view.backgroundColor = self.linesColor
        view.center.x = self.width/2
        return view
    }
    
    func setItems(item: TravelOption, language: Language, currency: String) {
        let priceText: String = String.priceText(language)
//        let timeText: String = String.timeText(language)
        let capacityText: String = String.capacityText(language)
        let text: String = "\(currency)\(item.price == nil ? "--,--" : String(format: "%.2f", item.finalPrice()).replacingOccurrences(of: ".", with: ","))"
        self.items = [(priceText, text),
                      (capacityText, item.capacity)]
        
//        self.items = [(priceText, text),
//        (timeText, item.estimatedArrivalTime),
//        (capacityText, item.capacity)]
//
        guard let tableView = self.tableView else { return }
        tableView.separatorColor = .clear
        tableView.separatorStyle = .none
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeight
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailTravelOptionTableViewCell
        let item = self.items[indexPath.row]
        cell.setInfo(left: item.0, right: item.1)
        cell.setColor(left: self.leftColor, right: self.rightColor)
        cell.setFont(left: self.leftFont, right: self.rightFont)
        return cell
    }
    
}
