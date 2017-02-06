
import UIKit

class LFHomeViewController: LFBaseViewController {

    var channels = [LFChannel]()
    //标签
    weak var titlesView = UIView()
    //顶部标签显示|隐藏
    var titlesViewBool:Bool = true
    //底部红色指示器
    weak var indexcatorView = UIView()
    weak var contentView = UIScrollView()
    //当前选中的按钮
    weak var selectedButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置导航栏
        setupNav()
        //获取首页顶部选择数据
        LFNetworkTool.shareNetworkTool.loadHomeTopData { [weak self](lf_channels) -> () in
            //初始化子控制器
            for channel in lf_channels{
                let vc = LFTopicViewController()
                vc.title = channel.name!
                vc.type = channel.id!
                self?.addChildViewController(vc)
            }
            //设置顶部标签栏
            self?.setupTitlesView()
            //设置底部ScrollView
            self?.setupContentView()
        }
    }

    
    //选择按钮点击
    func arrowButtonClick(button: UIButton){
        UIView.animateWithDuration(kAnimationDuration) { () -> Void in
            /**
            CGAffineTransformMakeRotation（旋转）
            CGAffineTransformMakeScale（缩放）
            CGAffineTransformMakeTranslation（移动）
            CGAffineTransformMakeTranslation(<#CGFloat tx#>, <#CGFloat ty#>):只能变化一次，因为这种方式的变化始终是以最原始的状态值进行变化的，所以只能变化一次
            CGAffineTransformTranslate(CGAffineTransform t, <#CGFloat tx#>, <#CGFloat ty#>):能够多次变化，每次变化都是以上一次的状态（CGAffineTransform t）进行的变化，所以可以多次变化
            */
            button.imageView?.transform = CGAffineTransformRotate(button.imageView!.transform, CGFloat(M_PI))
        }
        if titlesViewBool{
            UIView.animateWithDuration(kAnimationDuration, animations: { () -> Void in
                self.titlesView!.transform = CGAffineTransformTranslate(self.titlesView!.transform, 0, -self.titlesView!.height)
            })
            titlesViewBool = false
        }else{
            UIView.animateWithDuration(kAnimationDuration, animations: { () -> Void in
                self.titlesView!.transform = CGAffineTransformTranslate(self.titlesView!.transform, 0, self.titlesView!.height)
            })
            titlesViewBool = true
        }
        
    }
    
    //标签上的按钮点击
    func titlesClick(sender: UIButton){
        //修改按钮状态
        selectedButton?.enabled = true
        sender.enabled = false
        selectedButton = sender
        //让标签执行动画
        UIView.animateWithDuration(kAnimationDuration) { () -> Void in
            self.indexcatorView!.width = (self.selectedButton?.titleLabel?.width)!
            self.indexcatorView?.centerX = (self.selectedButton?.centerX)!
        }
        //滚动，切换子控制器
        var offset = contentView?.contentOffset
        offset?.x = CGFloat(sender.tag) * (contentView?.width)!
        contentView?.setContentOffset(offset!, animated: true)
    }
    
    
    //顶部标签栏
   private func setupTitlesView(){
        //顶部背景
        let bgView = UIView()
        bgView.frame = CGRectMake(0, kTitlesViewY, SCREENW, kTitlesViewH)
        view.addSubview(bgView)
        //标签
        let titlesView = UIView()
        titlesView.backgroundColor = LFGlobalColor()
        titlesView.frame = CGRectMake(0, 0, SCREENW - kTitlesViewH, kTitlesViewH)
        bgView.addSubview(titlesView)
        self.titlesView = titlesView
        //底部红色指示器
        let indexcatorView = UIView()
        indexcatorView.backgroundColor = LFGlobalColor()
        indexcatorView.height = kIndicatorViewH
        indexcatorView.y = kTitlesViewH - kIndicatorViewH
        indexcatorView.tag = -1
        self.indexcatorView = indexcatorView

        //选择按钮
        let arrowButton = UIButton()
        arrowButton.frame = CGRectMake(SCREENW - kTitlesViewH, 0, kTitlesViewH, kTitlesViewH)
        arrowButton.setImage(UIImage(named: "arrow_index_down_8x4_"), forState: .Normal)
        arrowButton.addTarget(self, action: Selector("arrowButtonClick:"), forControlEvents: .TouchUpInside)
        arrowButton.backgroundColor = LFGlobalColor()
        bgView.addSubview(arrowButton)
        //内部子标签
        let count = childViewControllers.count
        let width = titlesView.width / CGFloat(count)
        let height = titlesView.height
        
        for index in 0..<count{
            let button = UIButton()
            button.height = height
            button.width = width
            button.x = CGFloat(index) * width
            button.tag = index
            let vc = childViewControllers[index]
            button.titleLabel?.font = UIFont.systemFontOfSize(14)
            button.setTitle(vc.title, forState: .Normal)
            button.setTitleColor(UIColor.grayColor(), forState: .Normal)
            button.setTitleColor(LFGlobalRedColor(), forState: .Disabled)
            button.addTarget(self, action: Selector("titlesClick:"), forControlEvents: .TouchUpInside)
            titlesView.addSubview(button)
            //默认点击第一个按钮
            if index == 0{
                button.enabled = false
                selectedButton = button
                //让按钮内部的Label根据文字来计算内容
                button.titleLabel?.sizeToFit()
                indexcatorView.width = button.titleLabel!.width
                indexcatorView.centerX = button.centerX
            }
            
        }
        //底部红色指示器
        titlesView.addSubview(indexcatorView)
    }
    
    //底部的scrollView
    private func setupContentView(){
        //不要自动调整inset
        automaticallyAdjustsScrollViewInsets = false
        
        let contentView = UIScrollView()
        contentView.frame = view.bounds
        contentView.backgroundColor = view.backgroundColor
        contentView.delegate = self
        contentView.contentSize = CGSizeMake((contentView.width) * CGFloat(childViewControllers.count), 0)
        contentView.pagingEnabled = true
        view.insertSubview(contentView, atIndex: 0)
        self.contentView = contentView
        //添加第一个控制器View
        scrollViewDidEndScrollingAnimation(contentView)
    }
    
    //设置导航栏
    private func setupNav(){
        view.backgroundColor = UIColor.whiteColor()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Feed_SearchBtn_18x18_"), style: .Plain, target: self, action: Selector("homeRightBBClick"))
    
    }
    //主页面右端按钮点击
    func homeRightBBClick(){
        let searchBarVC = LFSearchViewController()
        navigationController?.pushViewController(searchBarVC, animated: true)
    }

}

extension LFHomeViewController: UIScrollViewDelegate{
    //MARK: - UIScrollViewDelegate
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        //添加子控制器 view
        //当前索引
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        //取出子控制器
        let vc = childViewControllers[index]
        vc.view.x = scrollView.contentOffset.x
        //设置控制器的y值为0（默认为20）
        vc.view.y = 0
        //设置控制器的view的height值为整个屏幕的高度（默认是比屏少20）
        vc.view.height = scrollView.height
        scrollView.addSubview(vc.view)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
        //当前索引
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        //点击 Button
        let button = titlesView!.subviews[index] as! UIButton
        titlesClick(button)
    }
}
