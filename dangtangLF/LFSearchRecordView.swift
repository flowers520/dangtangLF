

import UIKit
import SVProgressHUD
////协议传值
//protocol LFSearchRecordViewDelegate: NSObjectProtocol{
//    func  sethotWordsButton(hotWords: String)
//}

//闭包传值
typealias LFSearchRecordViewCloureBack = (hotWord: String) -> Void

class LFSearchRecordView: UIView {

    //关键字
    var words = [String]()
    
//    //定义协议
//    weak var delegate: LFSearchRecordViewDelegate?
    //定义闭包
    var cloureBack: LFSearchRecordViewCloureBack?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        //搜索界面数据获取热搜关键字
        weak var weakSelf = self
        LFNetworkTool.shareNetworkTool.loadHotWords { (hot_words) -> () in
            weakSelf!.words = hot_words
            weakSelf!.setupUI()
        }
    }
    
    //界面设置
    private func setupUI(){
        //大家都在搜
        let topView = UIView()
        topView.frame = CGRectMake(0, 0, SCREENW, 400)
        addSubview(topView)
        
        let hotLabel = setupLabel("大家都在搜")
        hotLabel.frame = CGRectMake(10, 20, 200, 20)
        topView.addSubview(hotLabel)
        
        //历史记录
        let bottomView = UIView()
        addSubview(bottomView)
        
        //历史按钮
        let count = words.count
        let width = (SCREENW-10*5)/4
        let height:CGFloat = 30
        let buttonH: CGFloat = 10
        
        for index in 0..<count{
            let button = UIButton()
            button.height = height
            button.width = width
            button.x = CGFloat(index % 4) * (width + 10) + 10
            //rows and columns 行和列
            let rows = CGFloat(index / 4)
            button.y = rows * (height + buttonH) + 60
            
            button.tag = index
            button.addTarget(self, action: Selector("hotWords:"), forControlEvents: .TouchUpInside)
            button.titleLabel?.font = UIFont.systemFontOfSize(13)
            button.backgroundColor = LFColor(0, g: 0, b: 0, a: 0.1)
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            button.setTitleColor(UIColor.redColor(), forState: .Disabled)
            button.setTitle(words[index], forState: .Normal)
            topView.addSubview(button)
        }

    }
    
    //热词点击
    func hotWords(sender: UIButton){
//        SVProgressHUD.showInfoWithStatus(words[sender.tag])
        let hotWords:String = words[sender.tag]
//        self.delegate?.sethotWordsButton(hotWords)
        cloureBack!(hotWord: hotWords)
        
    }
    
    func setupLabel(title: String)->UILabel{
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFontOfSize(13)
        label.textColor = LFColor(0, g: 0, b: 0, a: 0.6)
        return label
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
