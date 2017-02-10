

import UIKit
import SVProgressHUD

class LFShareButtonView: UIView {
    //图片数组
    let images = ["Share_WeChatTimelineIcon_70x70_", "Share_WeChatSessionIcon_70x70_", "Share_WeiboIcon_70x70_", "Share_QzoneIcon_70x70_", "Share_QQIcon_70x70_", "Share_CopyLinkIcon_70x70_"]
    //标题数组
    let titles = ["微信朋友圈", "微信好友", "微博", "QQ 空间", "QQ 好友", "复制链接"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    //界面设置
    private func setupUI(){
        let maxCols = 3
        
        let buttonW: CGFloat = 70
        let buttonH: CGFloat = buttonW + 30
        let buttonStartX: CGFloat = 20
        let xMargin: CGFloat = (SCREENW-20-2*buttonStartX-CGFloat(maxCols)*buttonW) / CGFloat(maxCols-1)
        
        //创建按钮
        for index in 0..<images.count{
            let button = LFVerticalButton()
            button.tag = index
            button.setImage(UIImage(named: images[index]), forState: .Normal)
            button.setTitle(titles[index], forState: .Normal)
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            button.titleLabel?.font = UIFont.systemFontOfSize(14)
            button.frame.size.width = buttonW
            button.frame.size.height = buttonH
            button.addTarget(self, action: Selector("shareButtonClick:"), forControlEvents: .TouchUpInside)
            //计算X，Y
            let row = Int(index / maxCols)
            let col = index % maxCols
            let buttonX: CGFloat = CGFloat(col) * (xMargin + buttonW) + buttonStartX
            let buttonMaxY: CGFloat = CGFloat(row) * buttonH
            let buttonY = buttonMaxY
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH)
            addSubview(button)
        }
    }
    
    func shareButtonClick(button: UIButton){
        if let sharebuttonType = LFShareButtonType(rawValue: button.tag){
            switch sharebuttonType{
            case .weChatSession:
                SVProgressHUD.showWithStatus("微信好友")
                break
            case .weChatSession:
                SVProgressHUD.showWithStatus("微信朋友圈")
                break
            case .weibo:
                SVProgressHUD.showWithStatus("微博")
                break
            case .QZone:
                SVProgressHUD.showWithStatus("空间")
                break
            case .QQFriends:
                SVProgressHUD.showWithStatus("好友")
                break
            case .CopyLink:
                SVProgressHUD.showWithStatus("复制链接")
                break
            default:
                break
            }
        }
        print(button.titleLabel?.text)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
