import UIKit

final class ProductCell: UICollectionViewCell {
    static var identifier: String { "\(Self.self)" }
    
    var onIncrease: (() -> Void)?
    var onDecrease: (() -> Void)?
    
    private var plusAction: UIAction?
    private var minusAction: UIAction?
    
    private var plusBtnCenterConstraint: NSLayoutConstraint?
    private var plusBtnRightConstraint: NSLayoutConstraint?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let counterContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let minusBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("-", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let plusBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("+", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        countLabel.text = nil
        
        if let plusAction {
            plusBtn.removeAction(plusAction, for: .touchUpInside)
        }
        if let minusAction {
            minusBtn.removeAction(minusAction, for: .touchUpInside)
        }
    }
    
    func configure(name: String, quantity: Int) {
        nameLabel.text = name
        setQuantity(quantity, animated: false)
        
        plusAction = UIAction { [weak self] _ in
            self?.onIncrease?()
        }
        minusAction = UIAction { [weak self] _ in
            self?.onDecrease?()
        }
        
        if let plusAction {
            plusBtn.addAction(plusAction, for: .touchUpInside)
        }
        if let minusAction {
            minusBtn.addAction(minusAction, for: .touchUpInside)
        }
    }
    
    func setQuantity(_ quantity: Int, animated: Bool) {
        countLabel.text = "\(quantity)"
        animateControls(isAdded: quantity > 0, animated: animated)
    }
    
    private func configUI() {
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.05
        layer.shadowRadius = 6
        layer.shadowOffset = .init(width: 0, height: 2)
        clipsToBounds = false
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(counterContainer)
        
        counterContainer.addSubview(minusBtn)
        counterContainer.addSubview(countLabel)
        counterContainer.addSubview(plusBtn)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            counterContainer.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            counterContainer.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            counterContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            counterContainer.heightAnchor.constraint(equalToConstant: 33),
            
            minusBtn.leftAnchor.constraint(equalTo: counterContainer.leftAnchor),
            minusBtn.centerYAnchor.constraint(equalTo: counterContainer.centerYAnchor),
            minusBtn.widthAnchor.constraint(equalToConstant: 40),
            
            countLabel.centerXAnchor.constraint(equalTo: counterContainer.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: counterContainer.centerYAnchor),
            countLabel.widthAnchor.constraint(equalToConstant: 100),
            
            plusBtn.centerYAnchor.constraint(equalTo: counterContainer.centerYAnchor),
            plusBtn.widthAnchor.constraint(equalToConstant: 40),
        ])
        
        plusBtnCenterConstraint = plusBtn.centerXAnchor.constraint(equalTo: counterContainer.centerXAnchor)
        plusBtnRightConstraint = plusBtn.rightAnchor.constraint(equalTo: counterContainer.rightAnchor)
        plusBtnCenterConstraint?.isActive = true
    }
    
    private func animateControls(isAdded: Bool, animated: Bool) {
        plusBtnCenterConstraint?.isActive = !isAdded
        plusBtnRightConstraint?.isActive = isAdded
        
        let changes = {
            self.minusBtn.alpha = isAdded ? 1 : 0
            self.countLabel.alpha = isAdded ? 1 : 0
            self.contentView.layoutIfNeeded()
        }
        
        if animated {
            UIView.animate(withDuration: 0.3, animations: changes)
        } else {
            changes()
        }
    }
}
