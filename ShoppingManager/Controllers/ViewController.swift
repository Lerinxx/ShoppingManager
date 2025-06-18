import UIKit

final class ViewController: UIViewController {
    private let store = StoreRepository.getCurrentStore()
    private let basket = Basket()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.estimatedItemSize = .zero
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identifier)
        
        return collectionView
    }()
    
    private let totalView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let totalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        updateTotalLabel()
    }
    
    private func configUI() {
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(collectionView)
        view.addSubview(totalView)
        totalView.addSubview(totalLabel)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            totalView.leftAnchor.constraint(equalTo: view.leftAnchor),
            totalView.rightAnchor.constraint(equalTo: view.rightAnchor),
            totalView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            totalView.heightAnchor.constraint(equalToConstant: 80),
            
            totalLabel.centerXAnchor.constraint(equalTo: totalView.centerXAnchor),
            totalLabel.topAnchor.constraint(equalTo: totalView.topAnchor, constant: 20),
            totalLabel.widthAnchor.constraint(equalTo: totalView.widthAnchor)
        ])
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
    }
    
    private func updateTotalLabel() {
        let total = basket.totalQuantity()
        totalLabel.text = total > 0 ? "Total products: \(total)" : "Basket is empty"
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.getProducts().count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = store.getProducts()[indexPath.item]
        let quantity = basket.find(product) ?? 0
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(name: product, quantity: quantity)
        
        cell.onIncrease = { [weak self] in
            guard let self else { return }
            self.basket.add(product: product)
            let newQuantity = self.basket.find(product) ?? 0
            cell.setQuantity(newQuantity, animated: true)
            self.updateTotalLabel()
        }
        
        cell.onDecrease = { [weak self] in
            guard let self else { return }
            self.basket.remove(product: product)
            let newQuantity = self.basket.find(product) ?? 0
            cell.setQuantity(newQuantity, animated: true)
            self.updateTotalLabel()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        
        let totalHorizontalSpacing = layout.sectionInset.left
        + layout.sectionInset.right
        + layout.minimumInteritemSpacing
        
        let itemWidth = (collectionView.bounds.width - totalHorizontalSpacing) / 2
        return CGSize(width: itemWidth, height: itemWidth)
    }
}
