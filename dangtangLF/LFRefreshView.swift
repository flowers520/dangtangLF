

import UIKit
import SVProgressHUD

class LFRefreshView: UIView {

    var tipView = UIView()
    var arrowIcon = UIImageView()
    var downRefreshingL = UILabel()
    var isRefreshingView = UIView()
    var loadingView = UIImageView()
    
    var labels: Array<UILabel> = []
    var labelsArray = ["正","在","加","载",".",".","."]
    var isAnimatingLabel = false
    var currentColorIndex = 0
    var currentLabelIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    //设置界面
    private func setupUI(){
        //正在刷新视图
        isRefreshingView = UILabel(frame: CGRectMake(0,14,SCREENW,32))
        addSubview(isRefreshingView)
        //正在刷新转圈图片
        loadingView.frame = CGRectMake(16, 0, 32, 32)
        loadingView.image = UIImage(named: "tableview_loading")
        isRefreshingView.addSubview(loadingView)
        //正在刷新Label
        let LabelWidth:CGFloat = 20
        let LabelHeight: CGFloat = LabelWidth
        let LabelInterval:CGFloat = 5
        for index in 0..<labelsArray.count{
            let label = UILabel()
            label.x = CGFloat(index) * (LabelWidth + LabelInterval) + 56
            label.y = 6
            label.height = LabelHeight
            label.width = LabelWidth
            label.text = "\(labelsArray[index])"
            label.tag = index
            isRefreshingView.addSubview(label)
            labels.append(label)
        }
        //下拉刷新视图
        tipView.frame = CGRectMake(0, 0, 170, 60)
        addSubview(tipView)
        //下拉刷新
        arrowIcon.frame = CGRectMake(10, 14, 32, 32)
        arrowIcon.image = UIImage(named: "tableview_pull_refresh")
        tipView.addSubview(arrowIcon)
        
        downRefreshingL.frame = CGRectMake(47, 20, 123, 20)
        downRefreshingL.text = "下 拉 刷 新"
        downRefreshingL.textColor = UIColor.blackColor()
        downRefreshingL.font = UIFont.systemFontOfSize(14)
        downRefreshingL.textAlignment = .Left
        tipView.addSubview(downRefreshingL)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //旋转箭头
    func rotationArrowIcon(flag: Bool){
        var angle = M_PI
        angle += flag ? -0.01 : 0.01
        UIView.animateWithDuration(kAnimationDuration) { () -> Void in
            //旋转
            self.arrowIcon.transform = CGAffineTransformRotate(self.arrowIcon.transform, CGFloat(angle))
        }
    }
    
    //开始转圈动画
    func startLoadingViewAnimation(){
        isRefreshingView.hidden = true
        tipView.hidden = true
        //创建动画
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = 2 * M_PI
        animation.duration = 1
        animation.repeatCount = MAXFLOAT
        animation.removedOnCompletion = false
        loadingView.layer.addAnimation(animation, forKey: nil)
    }
    //停止动画
    func stopLoadingViewAnimation(){
        isRefreshingView.hidden = false
        tipView.hidden = true
        loadingView.layer.removeAllAnimations()
        isRefreshingView.layer.removeAllAnimations()
    }
    
}
