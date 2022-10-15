import UIKit

protocol FoodViewLogic {
    func setValues(_ viewModel: FetchFood.SetValues)
}

class FoodViewController: UIViewController {
    
    //MARK: - Properties
    
    enum Cells: String {
        case table
        case banner
        case category
    }
    
    private var viewModel: ViewModel = ViewModel(foods: [])
    var interactor: FoodInteractor?
    
    private let refresh = UIRefreshControl()
    
    private lazy var fooTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.refreshControl = refresh
        view.register(FoodTableViewCell.self, forCellReuseIdentifier: Cells.table.rawValue)
        view.delegate = self
        view.dataSource = self
        view.automaticallyAdjustsScrollIndicatorInsets = false
        return view
    }()
    
    private lazy var bannersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.register(BannersCollectionViewCell.self, forCellWithReuseIdentifier: Cells.banner.rawValue)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private lazy var categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: Cells.category.rawValue)
        view.backgroundColor = fooTableView.backgroundColor
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private lazy var leftButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Moscow ˅", for: .normal)
        view.setTitleColor(.black, for: .normal)
        return view
    }()
    
    private lazy var leftButtonItem: UIBarButtonItem = {
       let view = UIBarButtonItem(customView: leftButton)
        return view
    }()
    
    //MARK: - Methods
    
    override func viewWillAppear(_ animated: Bool) {
        interactor?.makeRequest()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        refresh.beginRefreshing()
        setup()
    }
    
    //Собирает модуль
    private func setup() {
        let interactor = FoodInteractor()
        let presenter = FoodPresenter()
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.view = self
        
    }
    
    //Добавляет дочерние View и верстет
    private func setupViews() {
        navigationItem.leftBarButtonItem = leftButtonItem
        view.backgroundColor = .white
        view.addSubview(fooTableView)
        fooTableView.anchors(top: view.safeAreaLayoutGuide.topAnchor,
                             leading: view.leadingAnchor,
                             bottom: view.bottomAnchor,
                             trailing: view.trailingAnchor)
    }
}

//MARK: - Extensions

extension FoodViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let qwe = viewModel.foods.count + 1
        return qwe
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0
        default:
            return viewModel.foods[section - 1].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.table.rawValue, for: indexPath) as? FoodTableViewCell
        for i in 1...tableView.numberOfSections - 2 {
            if indexPath.section == i && indexPath.item == 0 {
                cell?.configCorners(position: Position.first)
            } else if indexPath.section == i && indexPath.item == viewModel.foods[i].count - 1 {
                cell?.configCorners(position: Position.last)
            }
        }
        switch indexPath.section {
        case 0:
            return UITableViewCell()
        default:
            cell?.setValues(model: viewModel.foods[indexPath.section - 1][indexPath.item])
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return bannersCollectionView
        case 1:
            return categoriesCollectionView
        default:
            return nil
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 100
        case 1:
            return 100
        default:
            return 0
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerCell = fooTableView.cellForRow(at: IndexPath(item: 0, section: 1))
        guard headerCell == nil || (headerCell!.frame.origin.y < self.fooTableView.contentOffset.y + 100) else {
            categoriesCollectionView.isHidden = false
            return
        }
        let hdr = categoriesCollectionView
        hdr.isHidden = false
        hdr.frame = CGRect(x: 0, y: fooTableView.contentOffset.y, width: hdr.frame.size.width, height: hdr.frame.size.height)
        if !fooTableView.subviews.contains(hdr) {
            fooTableView.addSubview(hdr)
        }
        fooTableView.bringSubviewToFront(hdr)
    }
}

extension FoodViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case bannersCollectionView:
            return 2
        case categoriesCollectionView:
            return viewModel.foods.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case bannersCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.banner.rawValue, for: indexPath) as? BannersCollectionViewCell
            return cell ?? UICollectionViewCell()
        case categoriesCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.category.rawValue, for: indexPath) as? CategoryCollectionViewCell
            cell?.setValues(model: viewModel.foods[indexPath.item][0])
            return cell ?? UICollectionViewCell()
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case bannersCollectionView:
            return CGSize(width: 300, height: 112)
        case categoriesCollectionView:
            return CGSize(width: 88, height: 32)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoriesCollectionView {
            fooTableView.scrollToRow(at: IndexPath(item: 0, section: indexPath.item + 1), at: .middle, animated: true)
        }
    }
}


extension FoodViewController: FoodViewLogic {
    
    //Устанавливает значения дочерних View
    func setValues(_ viewModel: FetchFood.SetValues) {
        switch viewModel {
        case .viewModel(let model):
            self.viewModel = model
        DispatchQueue.main.async {
            self.fooTableView.reloadData()
            self.bannersCollectionView.reloadData()
            self.categoriesCollectionView.reloadData()
            self.refresh.endRefreshing()
        }
        case .error(let error):
            let actionController = UIAlertController(title: "Ошибка", message: "Ошибка: \(error)", preferredStyle: .alert)
            let alert = UIAlertAction(title: "Ok", style: .default)
            actionController.addAction(alert)
            self.present(actionController, animated: true)
        }
    }
}
