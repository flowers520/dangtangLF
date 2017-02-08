

import UIKit
import SnapKit

class LFSearchViewController: LFBaseViewController {
    //搜索结果列表
    var results = [LFSearchResult]()
    var productID: LFProduct?
    weak var collectionView: UICollectionView?
    var searchBar = UISearchBar()
    
    //搜索记录view
    var searchRecordView = LFSearchRecordView()
    var sortTableView = LFSortTableView()
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        searchBar.becomeFirstResponder()
//    }
//    override func viewWillDisappear(animated: Bool) {
//        super.viewDidDisappear(animated)
//        searchBar.resignFirstResponder()
//    }
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置界面
        setupUI()

    }

    //设置collectionView
    private func setupCollectionView(){
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        collectionView.backgroundColor = view.backgroundColor
        collectionView.dataSource = self
        collectionView.registerClass(LFCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "searchCollectionCellID")
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }
    //界面设置
    private func setupUI(){
        searchRecordView.backgroundColor = LFGlobalColor()
        searchRecordView.frame = CGRectMake(0, 64, SCREENW, SCREENH - 64)
        view.addSubview(searchRecordView)

        //导航栏
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        searchBar.placeholder = "搜索商品，专题"
        //LFSearchrecord闭包
        searchRecordView.cloureBack = ({(hotWords: String) -> Void in
            self.searchBar.text = hotWords
            self.SearchKeywordResult()
            
        })

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: .Plain, target: self, action: Selector("navigationBackClick"))

        
    }
    
    ////根据搜索添加进行搜索
    func SearchKeywordResult(){
        
        setupCollectionView()
        //返回
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "checkUserType_backward_9x15_"), style: .Plain, target: self, action: Selector("navigationBackClick"))
        //排序
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_sort_21x21_"), style: .Plain, target: self, action: Selector("sortButtonClick"))

        LFNetworkTool.shareNetworkTool.loadSearchResult(searchBar.text!, sort: "") { [weak self] (results) -> () in
            self?.results = results
            self!.collectionView!.reloadData()
        }
    }
    
    //搜索条件点击
    func sortButtonClick(){
//        let sortView = LFSortTableView()
//        view.addSubview(sortView)
//        sortView.snp_makeConstraints { (make) -> Void in
//            make.top.equalTo(self.view).offset(60)
//            make.right.equalTo(self.view)
//            make.size.equalTo(CGSizeMake(120, 126))
//        }
        LFSortTableView.show()
    }
    
    //返回按钮、取消按钮点击
    func navigationBackClick(){
        navigationController?.popViewControllerAnimated(true)
//        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}

extension LFSearchViewController: UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,LFCollectionViewCellDelegate,LFSortTableViewDelegate{
    
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        //设置collectionView
        setupCollectionView()
        return true
    }
    //搜索按钮点击(searchBarSearchButtonClicked)
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        //根据搜索添加进行搜索
        SearchKeywordResult()
    }
    
    //MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count ?? 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("searchCollectionCellID", forIndexPath: indexPath) as! LFCollectionViewCell
        cell.result = results[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    //MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        let tempValueID:Int = results[indexPath.item].id!
        LFNetworkTool.shareNetworkTool.loadProductDataID(tempValueID) { [weak self](productID) -> () in
            self!.productID = productID
        }

        let productDetailVC = LFProductDetailViewController()
        productDetailVC.title = "商品详情"
        productDetailVC.type = String(self)
        productDetailVC.result = results[indexPath.item]
        productDetailVC.product = productID
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.mainScreen().bounds.width - 20) / 2
        let height: CGFloat = 245
        return CGSizeMake(width, height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    // MARK: - YMCollectionViewCellDelegate
    func collectionViewCellDidClickedLikeButton(button: UIButton) {
        if !NSUserDefaults.standardUserDefaults().boolForKey(isLogin) {
            let loginVC = LFLoginViewController()
            loginVC.title = "登录"
            let nav = LFNavigationController(rootViewController: loginVC)
            presentViewController(nav, animated: true, completion: nil)
        } else {
            
        }
    }
    
        // MARK: - YMSortTableViewDelegate
        func sortView(sortView: LFSortTableView, didSelectSortAtIndexPath sort: String) {
    
            /// 根据搜索条件进行搜索
            let keyword = searchBar.text
            LFNetworkTool.shareNetworkTool.loadSearchResult(keyword!, sort: sort) { [weak self] (results) -> Void in
                sortView.dismiss()
                self!.results = results
                self!.collectionView!.reloadData()
            }
        }
    

    
}
