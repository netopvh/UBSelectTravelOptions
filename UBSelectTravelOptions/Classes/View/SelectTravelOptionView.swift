//
//  SelectTravelOptionView.swift
//  UXUberClone
//
//  Created by Claudio Madureira Silva Filho on 17/12/18.
//  Copyright © 2018 usemobile. All rights reserved.
//

import UIKit

public enum SelectTravelOptionViewState {
    case big
    case small
    
    public var opposite: SelectTravelOptionViewState {
        return self == .big ? .small : .big
    }
}

public protocol SelectTravelOptionViewDelegate {
    func didTapToSelectCard(_ view: SelectTravelOptionView)
    func didTapToFetchTravelOptionsAgain(_ view: SelectTravelOptionView)
    func didTapToRequestTravel(_ view: SelectTravelOptionView, with option: TravelOption, card: CardDetails?)
    func didChangeSelection(_ view: SelectTravelOptionView, optionSelected: TravelOption)
    func didTapCouponButton(_ view: SelectTravelOptionView)
    func didTapSchedule(_ view: SelectTravelOptionView, on completion: @escaping(ScheduleDateViewModel, ScheduleAddresViewModel) -> Void)
    func didRequestSchedule(_ view: SelectTravelOptionView)
    func didTapEditScheduleDate(_ view: SelectTravelOptionView, on completion: @escaping(ScheduleDateViewModel?) -> Void)
}

public class SelectTravelOptionView: UIView {
    
    // MARK: - Properties
    
    // MARK: Public
    
    public var delegate: SelectTravelOptionViewDelegate?
    
    public var selectedOption: TravelOption? {
        if self._selectedIndex < self._travelOptions.count {
            return self._travelOptions[self._selectedIndex]
        }
        return nil
    }
    
    public var card: CardDetails? {
        return self._card
    }
    
    public var travelOptions: TravelOptions {
        return self._travelOptions
    }
    
    public var state: SelectTravelOptionViewState {
        return self._state
    }
    
    public var language: Language {
        return self._configuration.language
    }
    
    // MARK: Internal
    
    var _state: SelectTravelOptionViewState = .small
    var _animator: UIViewPropertyAnimator?
    var _card: CardDetails?
    var _travelOptions: TravelOptions = TravelOptions() {
        didSet {
            self._couponView.isHidden = self.travelOptions.isEmpty
        }
    }
    var _configuration: SelectTravelOptionViewConfiguration = .defaultConfiguration
    var _selectedIndex: Int = 0
    var _isDragging: Bool = false
    let _topDistanceViewCardDetails: CGFloat = 20
    let _padding: CGFloat = 35
    let _hiddingSpeed: CGFloat = 0.8
    let _hiddenBackButton: CGFloat = 85
    let _showingBackButton: CGFloat = -50
    let _hiddenAlphaBackButton: CGFloat = -0.5
    //    let _smallHeight: CGFloat = 247 + 20 + 5 + 42
    var _smallHeight: CGFloat {
        get {
            return self._configuration.hasPaymentInfo ? (247 + 20 + 5 + 42 + (self.hasDebt ? 42 : 0)) : 220
//            return 247 + 20 + 5 + 42 + (self.hasDebt ? 42 : 0)
        }
    }
    let _bigHeight: CGFloat = 430
    let _smallCollectionHeight: CGFloat = 108 + 5
    var _offsetFinalBack: CGFloat = 0
    var _alphaPageControl: CGFloat = 1
    var _maximumOptionsPerPage: Int = 3
    
    var _smallCellSize: CGSize {
        let count: Int = self._travelOptions.count
        let maximum: Int = self._maximumOptionsPerPage
        return CGSize(width: self._screenWidth/CGFloat(count > maximum ? maximum : count),
                      height: self._smallCollectionHeight - 0.5)
    }
    
    var _bigCellSize: CGSize {
        return CGSize(width: self._screenWidth,
                      height: self._bigHeight - 0.5)
    }
    
    var _screenWidth: CGFloat {
        return self._screenSize.width
    }
    
    var _screenSize: CGSize {
        return UIScreen.main.bounds.size
    }
    
    var _lineColor: UIColor {
        return UIColor.black.withAlphaComponent(0.07)
    }
    
    var _colorRight: UIColor {
        return self._configuration.colors.labelTravelOptionDetailsRight
    }
    
    var _colorLeft: UIColor {
        return self._configuration.colors.labelTravelOptionDetailsLeft
    }
    
    var _originYViewCardWithDetails: CGFloat {
        get {
            return self._smallCollectionHeight + self._topDistanceViewCardDetails + 15 + 42 + (self.hasDebt ? 42 : 0)
        }
    }
    
    var _originYPageControl: CGFloat {
        return self._smallCollectionHeight + 10
    }
    
    var _properHeight: CGFloat {
        return self._state == .small ? self._smallHeight : self._bigHeight
    }
    
    var _couponText: String? = nil {
        didSet {
            self._buttonRemoveCoupon.isHidden = self._couponText == nil
        }
    }
    
    var heightViewWithPaymentDetails: CGFloat {
        get {
            return self._configuration.hasPaymentInfo ? (self._showingRequestButtonOriginY - self._smallCollectionHeight - 10 - self._topDistanceViewCardDetails - 15 - 42 - (self.hasDebt ? 42 : 0)) : 0
//            return self._showingRequestButtonOriginY - self._smallCollectionHeight - 10 - self._topDistanceViewCardDetails - 15 - 42 - (self.hasDebt ? 42 : 0)
        }
    }
    
    lazy var _panGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.onDrag(_:)))
        gesture.delegate = self
        return gesture
    }()
    
    lazy var _panGesture2: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.onDrag(_:)))
        gesture.delegate = self
        return gesture
    }()
    
    var _smallOriginY: CGFloat {
        get {
            return self._screenSize.height - (self._smallHeight) - (2 * (UIApplication.shared.keyWindow?.subviews.first?.frame.origin.y ?? 0))
        }
    }
    
    var _bigOriginY: CGFloat {
        get {
            return self._screenSize.height - (self._bigHeight) - (2 * (UIApplication.shared.keyWindow?.subviews.first?.frame.origin.y ?? 0))
        }
    }
    
    var _showingRequestButtonOriginY: CGFloat {
        get {
            let paddingBottom: CGFloat = UIDevice.isInfinteScreen ? 15 : 0
            return self._smallHeight - 60 - paddingBottom
        }
    }
    
    var _hiddingOriginYViewCardWithDetails: CGFloat {
        get {
            return self._bigHeight + (self._showingRequestButtonOriginY - self._smallHeight)
        }
    }
    
    var _hiddingOriginYPageControl: CGFloat {
        get {
            return self._hiddingOriginYViewCardWithDetails - 15
        }
    }
    
    var _hiddingOriginYFakeBackButton: CGFloat {
        get {
            return self._smallHeight + 80
            
        }
    }
    var _showingOriginYFakeBackButton: CGFloat {
        get {
            let paddingBottom: CGFloat = UIDevice.isInfinteScreen ? 10 : 0
            return self._bigHeight - paddingBottom - 15 - 50
        }
    }
    
    var _hiddingFakeViewDetailsTravelOptionOriginY: CGFloat {
        get {
            return self._bigHeight - 120 - 100
        }
    }
    
    var _showingFakeViewDetailsTravelOptionOriginY: CGFloat {
        get {
            return self._bigHeight - 120 - 120
        }
    }
    
    // Views
    
    var _darkViewBack: UIView = UIView(frame: UIScreen.main.bounds)
    var _fakeBackButton: FakeBackButtonLabel = FakeBackButtonLabel()
    var _pageControl: UIPageControl = UIPageControl()
    var _viewWithPaymentDetails: UIView = UIView()
    var _imageViewCardBrand: UIImageView = UIImageView()
    var _imageViewArrowDown: UIImageView = UIImageView()
    var _viewNoOptions: UIView = UIView()
    var _labelCardNumberCrip: UILabel = UILabel()
    var _buttonSelectCard: UIButton = UIButton()
    var _buttonRequestTravel: UIButton = UIButton()
    var _buttonScheduleTravel: UIButton = UIButton(type: .system)
    var _collectionView: UICollectionView!
    var _fakeCollectionView: UIView = UIView()
    var _fakeTravelOptionViews: [TravelOptionView] = []
    var _fakeTravelOptionViewRectsSmall: [CGRect] = []
    var _fakeTravelOptionViewRectsBig: [CGRect] = []
    var _fakeViewDetailsTravelOption: DetailsTravelOptionView = .init()
    var _couponView: UIView = UIView()
    var _buttonCoupon: UIButton = UIButton()
    var _buttonRemoveCoupon: UIButton = UIButton()
    var labelStopMessage = UILabel()
    var scheduleView: ScheduleView?
    var memoryTravelOptions: TravelOptions?
    var hideCreditCard: Bool = false
    
    lazy var _viewProgress: UIView = {
        let size: CGSize = CGSize(width: self._screenWidth, height: 1.35)
        let rect: CGRect = CGRect(origin: .zero, size: size)
        let viewProgress: UIView = UIView(frame: rect)
        viewProgress.backgroundColor = .clear
        return viewProgress
    }()
    
    var _debtView = UIView()
    var _debtLabel = UILabel()
    var _debtValueLabel = UILabel()
    var hasDebt: Bool = false
    
    var debtViewHeight: CGFloat {
        get {
            return self._configuration.hasPaymentInfo && self.hasDebt ? 42 : 0
        }
    }
    
    
    // MARK: - Lifecycle
    
    public class func instance(with configuration: SelectTravelOptionViewConfiguration = .defaultConfiguration) -> SelectTravelOptionView {
        let view = SelectTravelOptionView()
        view._configuration = configuration
        view.setup()
        return view
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview == nil {
            NotificationCenter.default.removeObserver(self)
        } else {
            NotificationCenter.default.addObserver(self, selector: #selector(self.appWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        }
        super.willMove(toSuperview: newSuperview)
    }
    
    // MARK: - Public Functions
    
    public func setCard(with details: CardDetails?) {
        let selectedOption: TravelOption? = self.selectedOption
        self.setLabelCardNumberCrip(normalText: details?.numberCrip ?? self.textForNoCard, discount: selectedOption?.discount)
        self._imageViewCardBrand.image = details?.image ?? self._configuration.imageForNoCardSelected
        self._card = details
    }
    
    public func setTravelOptions(_ travelOptions: TravelOptions) {
        self._travelOptions.removeAll()
        self._collectionView.reloadData()
        self._selectedIndex = self._selectedIndex <= travelOptions.count - 1 ? self._selectedIndex : 0
        self._travelOptions = travelOptions
        self.setPageControlFor(travelOptions: travelOptions)
        self.setupFakeCollectionView()
        self.setupFakeTravelOptionViews()
        self.setButtonRequestTitle(selectedIndex: self._selectedIndex)
        if self._selectedIndex < self._travelOptions.count {
            let travelOption: TravelOption = travelOptions[self._selectedIndex]
            self.updateLabelCardNumberCripWith(discount: travelOption.discount)
        } else {
            self.updateLabelCardNumberCripWith(discount: nil)
        }
        self._collectionView.collectionViewLayout.invalidateLayout()
        self._collectionView.reloadData()
        self.calculateRects()
    }
    
    public func setTravelOptionsAnimated(_ travelOptions: TravelOptions, completion: ((SelectTravelOptionView) -> Void)? = nil) {
         self.memoryTravelOptions = travelOptions
        var hasChanged: Bool = self._travelOptions.count != travelOptions.count
        if !hasChanged {
            for (index, item) in self._travelOptions.enumerated() {
                if item.type != travelOptions[index].type {
                    hasChanged = true
                    break
                }
            }
        }
        if self._travelOptions.isEmpty {
            if self._viewNoOptions.alpha == 1 {
//                UIView.animate(withDuration: 0.15, animations: {
                    self._collectionView.alpha = 0
                    self._pageControl.alpha = -2
                    self._viewNoOptions.alpha = 0
//                }, completion: { _ in
                    self.setTravelOptions(travelOptions)
//                    UIView.animate(withDuration: 0.2, animations: {
                        self._collectionView.alpha = travelOptions.isEmpty ? 0 : 1
                        self._viewNoOptions.alpha = travelOptions.isEmpty ? 1 : 0
                        self._pageControl.alpha = travelOptions.isEmpty ? -2 : (self._state == .big ? -2 : 1)
//                    }, completion: { _ in
                        self._collectionView.reloadData()
                        self.setupFakeCollectionView()
                        self.setupFakeTravelOptionViews()
                        completion?(self)
//                    })
//                })
            } else {
                self._collectionView.alpha = 0
                self._pageControl.alpha = -2
                self.setTravelOptions(travelOptions)
//                UIView.animate(withDuration: 0.2, animations: {
                    self._collectionView.alpha = travelOptions.isEmpty ? 0 : 1
                    self._viewNoOptions.alpha = travelOptions.isEmpty ? 1 : 0
                    self._pageControl.alpha = travelOptions.isEmpty ? -2 : (self._state == .big ? -2 : 1)
//                }, completion: { _ in
                    self._collectionView.reloadData()
                    self.setupFakeCollectionView()
                    self.setupFakeTravelOptionViews()
                    completion?(self)
//                })
            }
        } else if hasChanged {
//            UIView.animate(withDuration: 0.15, animations: {
                self._collectionView.alpha = 0
                self._pageControl.alpha = -2
//            }, completion: { _ in
                self.setTravelOptions(travelOptions)
//                UIView.animate(withDuration: 0.15, animations: {
                    self._collectionView.alpha = travelOptions.isEmpty ? 0 : 1
                    self._viewNoOptions.alpha = travelOptions.isEmpty ? 1 : 0
                    self._pageControl.alpha = travelOptions.isEmpty ? -2 : (self._state == .big ? -2 : 1)
//                }, completion: { _ in
                    self._collectionView.reloadData()
                    self.setupFakeCollectionView()
                    self.setupFakeTravelOptionViews()
                    completion?(self)
//                })
//            })
        } else {
            for (index, option) in travelOptions.enumerated() {
                if let _cell = self.cell(for: index) {
                    if _cell == self._collectionView.visibleCells.last {
                        _cell.view.setTravelOptionAnimated(option, completion: {
                            self.setTravelOptions(travelOptions)
                        })
                    } else {
                        _cell.view.setTravelOptionAnimated(option)
                    }
                }
            }
            
        }
    }
    
    public func setSelectedTravelOption(at index: Int) {
        self._selectedIndex = index
        self.updateSelectionToAllOptions(collectionView: self._collectionView, newSelectedIndex: index)
    }
    
    public func animate(to state: SelectTravelOptionViewState) {
        guard self._configuration.hasDetails else { return }
        self.animateIfNeeded(to: state)
        self._animator?.startAnimation()
    }
    
    public func setCoupon(_ coupon: String? = nil) {
        self._couponText = coupon
        if let _coupon = coupon {
            _buttonCoupon.setAttributedTitle(nil, for: .normal)
            _buttonCoupon.setTitle(_coupon, for: .normal)
        } else {
            self._travelOptions.forEach { $0.discount = nil}
            self.travelOptions.forEach { $0.discount = nil}
            self.setTravelOptions(self.travelOptions)
            _buttonCoupon.setTitle(nil, for: .normal)
            let attributedTitle = NSAttributedString(string: String.addCoupon(language), attributes: [NSAttributedString.Key.font : _configuration.fonts.buttonCouponTitle, NSAttributedString.Key.foregroundColor: _configuration.colors.buttonCouponTitleColor, NSAttributedString.Key.underlineStyle: 1, NSAttributedString.Key.underlineColor: _configuration.colors.buttonCouponTitleColor])
            _buttonCoupon.setAttributedTitle(attributedTitle, for: .normal)
        }
    }
    
    // MARK: - Internal Functions
    
    func setup() {
        let height: CGFloat = self._properHeight
        let size: CGSize = CGSize(width: self._screenWidth, height: height)
        let rect: CGRect = CGRect(origin: .zero, size: size)
        self.frame = rect
        self.center.x = self._screenWidth/2
        self.frame.origin.y = self._state == .small ? self._smallOriginY : self._bigOriginY
        self.backgroundColor = .white
        self.layer.masksToBounds = true
        self.layoutIfNeeded()
        self.setupLineDetailOnTop()
        self.setupProgress()
        self.setupViewDark()
        self.setupFakeBackButton()
        self.setupCollectionView()
        self.setupPageControl()
        self.setupViewWithCardDetails()
        self.setupButtonRequest()
        self.setupButtonSchedule()
        self.setupFakeViewDetailsTravelOption()
        self.setupNoOptionsView()
        self.addCouponView()
        self.addDebtView()
    }
    
    func reloadDebtView(hasDebt: Bool, debtValue: Double? = nil) {
        guard self._configuration.hasPaymentInfo else {
            self._debtView.frame.size.height = 0
            return
        }
        if let _debtValue = debtValue {
            self._debtValueLabel.text = "R$ " + String(format: "%.2f", _debtValue).replacingOccurrences(of: ".", with: ",")
        } else {
            self._debtValueLabel.text = nil
        }
        self.hasDebt = hasDebt
        UIView.animate(withDuration: 0.5, animations: {
            self.frame.size.height = self._properHeight
            self.frame.origin.y = self._state == .small ? self._smallOriginY : self._bigOriginY
            self._debtView.frame.size.height = self.hasDebt ? 42 : 0
            self._couponView.frame.origin.y = self.coupontViewYPosition
            self._viewWithPaymentDetails.frame.origin.y = self._originYViewCardWithDetails
            self._viewWithPaymentDetails.frame.size.height = self.heightViewWithPaymentDetails
            self._buttonRequestTravel.frame.origin.y = self._showingRequestButtonOriginY
            self._buttonScheduleTravel.frame.origin.y = self._buttonRequestTravel.frame.origin.y
        }) { _ in
            
        }
    }
    
    func addDebtView() {
        let y = self._smallCollectionHeight + self._topDistanceViewCardDetails + 15
        let debtView = UIView(frame: .init(x: 0, y: y, width: _screenWidth, height: self.debtViewHeight))
        debtView.clipsToBounds = true
        debtView.backgroundColor = .clear
        
        let font = UIFont.systemFont(ofSize: _screenWidth >= 375 ? 14 : 11)
        
        let debtLabel = UILabel(frame: .init(x: 40, y: 0, width: _screenWidth - 140, height: 42))
        debtLabel.textColor = .red
        debtLabel.textAlignment = .left
        debtLabel.text = .cancelValue(language)
        debtLabel.font = font
        
        let debtValueLabel = UILabel(frame: .init(x: _screenWidth - 140, y: 0, width: 100, height: 42))
        debtValueLabel.textColor = .red
        debtValueLabel.textAlignment = .right
        debtValueLabel.text = "R$ 10,00"
        debtValueLabel.font = font
        
        let debtBorder = UIView(frame: CGRect(x: 40, y: 0, width: _screenWidth - 80, height: 1))
        debtBorder.backgroundColor = self._lineColor
        
        
        self.addSubview(debtView)
        debtView.addSubview(debtLabel)
        debtView.addSubview(debtValueLabel)
        debtView.addSubview(debtBorder)
        
        self._debtView = debtView
        self._debtLabel = debtLabel
        self._debtValueLabel = debtValueLabel
    }
    
    var coupontViewYPosition: CGFloat {
        get {
            return self._smallCollectionHeight + self._topDistanceViewCardDetails + 15 + (self.hasDebt ? 42 : 0)
        }
    }
    
    func addCouponView() {
        let frame = CGRect(x: 0, y: self.coupontViewYPosition, width: _screenWidth, height: (self._configuration.hasPaymentInfo ? 42 : 0))
        let couponView = UIView(frame: frame)
        couponView.clipsToBounds = true
        
        let lineView: UIView = UIView()
        lineView.backgroundColor = self._lineColor
        lineView.frame.size = CGSize(width: self._screenWidth - (2*self._padding), height: 1)
        lineView.center = CGPoint(x: self._screenWidth/2, y: 0)
        
        let btnCoupon = UIButton(frame: .init(x: 40, y: 1, width: _screenWidth - 120, height: 40))
        btnCoupon.setTitleColor(_configuration.colors.buttonCouponSelectedColor, for: .normal)
        btnCoupon.titleLabel?.font = _configuration.fonts.buttonCouponSelected
        btnCoupon.contentHorizontalAlignment = .left
        let attributedTitle = NSAttributedString(string: String.addCoupon(language), attributes: [NSAttributedString.Key.font : _configuration.fonts.buttonCouponTitle, NSAttributedString.Key.foregroundColor: _configuration.colors.buttonCouponTitleColor, NSAttributedString.Key.underlineStyle: 1, NSAttributedString.Key.underlineColor: _configuration.colors.buttonCouponTitleColor])
        btnCoupon.setAttributedTitle(attributedTitle, for: .normal)
        btnCoupon.addTarget(self, action: #selector(btnCouponPressed), for: .touchUpInside)
        self._buttonCoupon = btnCoupon
        
        let btnRemoveCoupon = UIButton(frame: .init(x: self._screenWidth - 80, y: 1, width: 40, height: 40))
        btnRemoveCoupon.setImage((_configuration.imageClose ?? UIImage.getFrom(customClass: SelectTravelOptionView.self, nameResource: "iconClose"))?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnRemoveCoupon.tintColor = .black
        btnRemoveCoupon.addTarget(self, action: #selector(self.btnRemoveCouponPressed), for: .touchUpInside)
        btnRemoveCoupon.isHidden = self._couponText == nil
//        btnRemoveCoupon.backgroundColor = .purple
        self._buttonRemoveCoupon = btnRemoveCoupon
        couponView.isHidden = true
        self.addSubview(couponView)
        couponView.addSubview(lineView)
        couponView.addSubview(btnCoupon)
        couponView.addSubview(btnRemoveCoupon)
        
        self._couponView = couponView
    }
    
    func setupLineDetailOnTop() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.withAlphaComponent(0.2).cgColor
    }
    
    func setupViewDark() {
        self._darkViewBack.backgroundColor = self._configuration.colors.darkViewBackground
        self._darkViewBack.alpha = 0
    }
    
    func setupPageControl() {
        let config: SelectTravelOptionViewConfiguration = self._configuration
        self._pageControl.pageIndicatorTintColor = config.colors.pageControlPageIndicator
        self._pageControl.currentPageIndicatorTintColor = config.colors.pageControlCurrentPage
        self._pageControl.frame.size = CGSize(width: self._screenWidth, height: 20)
        self._pageControl.center.x = self._screenWidth/2
        self._pageControl.frame.origin.y = self._originYPageControl
        self.addSubview(self._pageControl)
    }
    
    func setupFakeViewDetailsTravelOption() {
        let view = DetailsTravelOptionView()
        view.setup(padding: self._padding,
                   lineColor: self._lineColor,
                   language: self._configuration.language,
                   textLeftColor: self._colorLeft,
                   textRightColor: self._colorRight,
                   textLeftFont: self._configuration.fonts.travelOptionDetailsLeft,
                   textRightFont: self._configuration.fonts.travelOptionDetailsRight)
        view.center.x = self._screenWidth/2
        view.frame.origin.y = self._state == .big ? self._showingFakeViewDetailsTravelOptionOriginY : self._hiddingFakeViewDetailsTravelOptionOriginY
        view.alpha = self._state == .small ? self._hiddenAlphaBackButton : 1
        self.addSubview(view)
        self._fakeViewDetailsTravelOption = view
    }
    
    func setupNoOptionsView() {
        let view = self._viewNoOptions
        view.frame.size = CGSize(width: self.frame.width * 0.9, height: 140)
        view.center.x = self.frame.width/2
        view.frame.origin.y = 20
        view.alpha = 0
        
        let label = UILabel()
        label.frame.size = CGSize(width: view.frame.width, height: 52)
        label.center.x = view.frame.width/2
        label.frame.origin.y = view.frame.height - label.frame.height
        label.font = self._configuration.fonts.noOptions
        label.textColor = self._configuration.colors.noOptions
        label.textAlignment = .center
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.text = String.noOptions(self.language)
        self.labelStopMessage = label
        view.addSubview(label)
        
        let imageView = UIImageView()
        let dimension = view.frame.height - label.frame.height - 20
        imageView.frame.size = CGSize(width: dimension, height: dimension)
        imageView.center.x = view.frame.width/2
        imageView.frame.origin.y = 10
        imageView.contentMode = .scaleAspectFit
        imageView.image = self._configuration.imageNoOptions ?? UIImage.getFrom(customClass: SelectTravelOptionView.self, nameResource: "world")
        view.addSubview(imageView)
        
        self.addSubview(view)
    }
    
    func setupFakeBackButton() {
        let label: UILabel = self._fakeBackButton
        let config: SelectTravelOptionViewConfiguration = self._configuration
        label.textColor = config.colors.buttonBackTitleAndBorderColor
        label.backgroundColor = config.colors.buttonBackBackground
        let text: String = String.backText(self.language)
        label.text = text
        let size: CGSize = CGSize(width: self._screenWidth - 2*self._padding + 25, height: 50)
        label.frame.size = size
        let isBigState = self._state == .big
        label.frame.origin.y = isBigState ? self._showingOriginYFakeBackButton : self._hiddingOriginYFakeBackButton
        label.center.x = self._screenWidth/2
        label.alpha = isBigState ? 1 : self._hiddenAlphaBackButton
        label.textAlignment = .center
        self.addSubview(label)
    }
    
    func setupFakeCollectionView() {
        let height = self._properHeight
        self._fakeCollectionView.frame.origin = .zero
        self._fakeCollectionView.frame.size = CGSize(width: self._screenWidth, height: height)
        guard self._fakeCollectionView.superview != self else { return }
        self._fakeCollectionView.backgroundColor = .clear
        self._fakeCollectionView.alpha = 0
        self._fakeCollectionView.addGestureRecognizer(self._panGesture2)
        self.addSubview(self._fakeCollectionView)
    }
    
    func setupFakeTravelOptionViews() {
        self._fakeTravelOptionViews.forEach({ view in view.removeFromSuperview() })
        self._fakeTravelOptionViews.removeAll()
        let state: SelectTravelOptionViewState = self._state
        let selectedIndex: Int = self._selectedIndex
        let config = self._configuration
        self._travelOptions.enumerated().forEach({ (index, option) in
            let size: CGSize = state == .small ? self._smallCellSize : self._bigCellSize
            let x: CGFloat = CGFloat(index)*size.width
            let origin: CGPoint = CGPoint(x: x, y: 0)
            let rect: CGRect = CGRect(origin: origin, size: size)
            let view: TravelOptionView = TravelOptionView.instance(frame: rect)
            view.setup(frame: rect,
                       originYViewDetails: self._showingFakeViewDetailsTravelOptionOriginY,
                       selected: index == selectedIndex,
                       state: state,
                       index: index, option: option,
                       padding: self._padding,
                       lineColor: self._lineColor,
                       configuration: config)
            self._fakeCollectionView.addSubview(view)
            self._fakeTravelOptionViews.append(view)
        })
    }
    
    func calculateRects() {
        self._fakeTravelOptionViewRectsSmall.removeAll()
        self._fakeTravelOptionViewRectsBig.removeAll()
        self._travelOptions.enumerated().forEach({ (index, option) in
            let xSmall: CGFloat = CGFloat(index)*self._smallCellSize.width
            let xBig: CGFloat = CGFloat(index)*self._bigCellSize.width
            let originSmall: CGPoint = CGPoint(x: xSmall, y: 0)
            let rectSmall: CGRect = CGRect(origin: originSmall, size: self._smallCellSize)
            self._fakeTravelOptionViewRectsSmall.append(rectSmall)
            let originBig: CGPoint = CGPoint(x: xBig, y: 0)
            let rectBig: CGRect = CGRect(origin: originBig, size: self._bigCellSize)
            self._fakeTravelOptionViewRectsBig.append(rectBig)
        })
    }
    
    func setSelectedOptionDetailsToFakeView() {
        guard let selectedOption = self.selectedOption else { return }
        self._fakeViewDetailsTravelOption.setItems(item: selectedOption,
                                                   language: self._configuration.language,
                                                   currency: self._configuration.currency)
    }
    
    func updateFakeCollectionLayout(to state: SelectTravelOptionViewState) {
        self._fakeTravelOptionViews.forEach({ (view) in
            let rect = state == .big ? self._fakeTravelOptionViewRectsBig[view.index] : self._fakeTravelOptionViewRectsSmall[view.index]
            view.frame.size = rect.size
            view.frame.origin.x = rect.origin.x
            view.setLayoutTo(state: state, selected: view.index == self._selectedIndex)
        })
    }
    
    func setButtonRequestTitle(selectedIndex index: Int) {
        if self.isProgressAnimating {
            let loadingText: String = String.searchingText(self.language)
            self._buttonRequestTravel.setTitle(loadingText, for: .normal)
            self._buttonRequestTravel.isEnabled = false
            self._buttonScheduleTravel.isEnabled = false
            return
        }
        if index < self._travelOptions.count {
            let travelOption = self._travelOptions[index]
            let confirm: String = String.confirmText(self.language)
            self._buttonRequestTravel.setTitle("\(confirm) \(travelOption.type.uppercased())", for: .normal)
            self._buttonRequestTravel.isEnabled = true
            self._buttonScheduleTravel.isEnabled = true
        } else {
            let title: String = String.tryAgain(self.language)
            self._buttonRequestTravel.setTitle(title.uppercased(), for: .normal)
            self._buttonRequestTravel.isEnabled = true
            self._buttonScheduleTravel.isEnabled = true
        }
    }
    
    func calculateSmallRects() {
        let selectedIndex: Int = self._selectedIndex
        let width: CGFloat = self._smallCellSize.width
        let count: Int = self._travelOptions.count
        for index in (0..<count) {
            let center = (self._screenWidth - width)/2
            var x: CGFloat = center + CGFloat(index - selectedIndex)*width
            if selectedIndex == 0 {
                x -= width
            } else if selectedIndex == count - 1 {
                x += width
            }
            self._fakeTravelOptionViewRectsSmall[index].origin.x = x
        }
    }
    
    func calculateBigRects() {
        let selectedIndex: Int = self._selectedIndex
        for index in (0..<self._travelOptions.count) {
            let x: CGFloat = CGFloat(index - selectedIndex)*self._screenWidth
            self._fakeTravelOptionViewRectsBig[index].origin.x = x
        }
    }
    
    func setPageControlFor(travelOptions: TravelOptions) {
        let numberOfPages: Int = Int(ceil(Double(travelOptions.count)/Double(self._maximumOptionsPerPage)))
        self._pageControl.numberOfPages = numberOfPages
        self._pageControl.currentPage = 0
        let finalAlpha: CGFloat = numberOfPages == 1 ? -2 : 1
        self._pageControl.alpha = self._state == .big ? 0 : finalAlpha
        self._alphaPageControl = finalAlpha
    }
    
    // MARK: - Objc Functions
    
    @objc func appWillResignActive() {
        guard self._state == .big else { return }
        self.animate(to: .small)
    }
    
    @objc func btnCouponPressed() {
        self.delegate?.didTapCouponButton(self)
    }
    
    @objc func btnRemoveCouponPressed() {
        self.setCoupon(nil)
    }
    
}
