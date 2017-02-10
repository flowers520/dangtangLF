

import UIKit

private let reuseIdentifier = "Cell"

class LFNewfeatureViewController: UICollectionViewController {
    //布局对象
    private var layout: UICollectionViewFlowLayout = LFNewfeatureLayout()
    
    init(){
        super.init(collectionViewLayout: layout)
        collectionView?.showsHorizontalScrollIndicator = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }




    // MARK: UICollectionViewDataSource


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return kNewFeatureCount ?? 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! LFNewfeatureCell
    
        cell.imageIndex = indexPath.item
    
        return cell
    }
    //完全显示一个cell之后的调用
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        let path = collectionView.indexPathsForVisibleItems().last!
        if path.item == (kNewFeatureCount - 1){
            let cell = collectionView.cellForItemAtIndexPath(path) as! LFNewfeatureCell
            cell.startBtnAnimation()
        }
    }

}
//LFNewfeatureCell
private class LFNewfeatureCell: UICollectionViewCell{
    private lazy var iconView = UIImageView()
    private lazy var startButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "btn_begin"), forState: .Normal)
        btn.addTarget(self, action: Selector("startButtonClick"), forControlEvents: .TouchUpInside)
        btn.layer.masksToBounds = true
        btn.hidden = true
        return btn
    }()
    
    private var imageIndex: Int?{
        didSet{
            iconView.image = UIImage(named: "walkthrough_\(imageIndex! + 1)")
        }
    }
    
    func startBtnAnimation(){
        startButton.hidden = false
        //执行动画
        startButton.transform = CGAffineTransformMakeScale(0.0, 0.0)
        startButton.userInteractionEnabled = false
        
        //UIViewAnimationOptions(rawValue: 0) == OC knilOption
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            //清空形变
            self.startButton.transform = CGAffineTransformIdentity
            }) { (_) -> Void in
                self.startButton.userInteractionEnabled = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    //
    private func setupUI(){
        contentView.addSubview(iconView)
        contentView.addSubview(startButton)
        
        iconView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView)
        }
        startButton.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(contentView.snp_bottom).offset(-50)
            make.size.equalTo(CGSizeMake(150, 40))
            make.centerX.equalTo(0)
        }
        
    }
    //开始按钮
    @objc func startButtonClick(){
       UIApplication.sharedApplication().keyWindow?.rootViewController = LFTabBarController()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//新特征布局
private class LFNewfeatureLayout: UICollectionViewFlowLayout{
    //准备布局
    private override func prepareLayout() {
        //设置layout 布局
        itemSize = UIScreen.mainScreen().bounds.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .Horizontal
        //contentView属性
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.bounces = false
        collectionView?.pagingEnabled = true
    }
}
