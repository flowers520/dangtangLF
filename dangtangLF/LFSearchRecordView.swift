

import UIKit
import SVProgressHUD
////协议传值
//protocol LFSearchRecordViewDelegate: NSObjectProtocol{
//    func  sethotWordsButton(hotWords: String)
//}

//闭包传值
typealias LFSearchRecordViewCloureBack = (hotWord: String) -> Void

var searchs = [String]()

class LFSearchRecordView: UIView {

    //关键字
    var words = [String]()
    
    var topView = UIView()
    var bottomView = UIView()
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
        
        addSubview(topView)
        
        //历史记录
        
        addSubview(bottomView)
        
        let hotLabel = setupLabel("大家都在搜")
        hotLabel.frame = CGRectMake(10, 20, 200, 20)
        topView.addSubview(hotLabel)
        
        //历史按钮
        let count = words.count
        let buttonH: CGFloat = 30
        var buttonX: CGFloat = 0
        var buttonY: CGFloat = 45
        
        for index in 0..<count{
            let button = UIButton()
            //计算文字大小
            
            //button length

            let buttonL = words[index].boundingRectWithSize(CGSize(width: SCREENW-10-10, height: SCREENH), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.boldSystemFontOfSize(13)], context: nil).size.width
            button.frame = CGRectMake(10 + buttonX, buttonY, buttonL + 15, buttonH)
            if (10+buttonX+buttonL+15) > (SCREENW-10-10){
                buttonX = 0
                buttonY = buttonY + button.height + 10
                button.frame = CGRectMake(10 + buttonX, buttonY, buttonL + 15, buttonH)
            }
            buttonX = button.frame.width + button.frame.origin.x

//            button.height = height
//            button.width = width
//            button.x = CGFloat(index % 4) * (width + 10) + 10
//            //rows and columns 行和列
//            let rows = CGFloat(index / 4)
//            button.y = rows * (height + buttonH) + 60
            
            button.tag = index
            button.backgroundColor = UIColor.clearColor()
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.grayColor().CGColor
            button.clipsToBounds = true
            button.setTitleColor(UIColor.grayColor(), forState: .Normal)
            button.setTitle(" \(words[index]) ", forState: .Normal)
            button.titleLabel?.font = UIFont.systemFontOfSize(13)
            button.addTarget(self, action: Selector("hotWords:"), forControlEvents: .TouchUpInside)
            topView.addSubview(button)
        }
        
        //判断书组数否为空
        let newSearchs = Set(searchs)
        searchs = Array(newSearchs)
        if searchs.count != 0{
        
        let searchCount = searchs.count
        let labelH: CGFloat = 30
        let labelX: CGFloat = 0
        let labelY: CGFloat = buttonY+buttonH+20+20+10
        
        searchHistory(searchCount, labelH: labelH, labelX: labelX, labelY: labelY)
        }
            
    }
    //搜索历史
    func searchHistory(count: Int, labelH: CGFloat, var labelX: CGFloat, var labelY: CGFloat){
        //搜索历史
        let searchLabel = setupLabel("搜索历史")
        searchLabel.frame = CGRectMake(10, labelY-30, 200, 20)
        bottomView.addSubview(searchLabel)
        
        for index in 0..<count{
            let label = UILabel()
            
            let  labelL = searchs[index].boundingRectWithSize(CGSize(width: SCREENW-10-10, height: SCREENH), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.boldSystemFontOfSize(13)], context: nil).size.width
            label.frame = CGRectMake(10 + labelX, labelY, labelL + 15, labelH)
            if (10+labelX+labelL+15) > (SCREENW-10-10){
                labelX = 0
                labelY = labelY + label.height + 10
                label.frame = CGRectMake(10 + labelX, labelY, labelL + 15, labelH)
            }
            labelX = label.frame.width + label.frame.origin.x
            
            label.text = " \(searchs[index]) "
            label.textAlignment = .Center
            label.font = UIFont.systemFontOfSize(13)
            label.textColor = UIColor.grayColor()
            label.layer.borderWidth = 0.5
            label.layer.borderColor = UIColor.grayColor().CGColor
            label.clipsToBounds = true
            bottomView.addSubview(label)
        }
        //删除历史按钮
        let lineViewY:CGFloat = labelY + labelH + 20
        let lineView = UIView()
        lineView.backgroundColor = UIColor.grayColor()
        lineView.frame = CGRectMake(0,lineViewY,SCREENW,1)
        bottomView.addSubview(lineView)
        
        let rmButton = UIButton()
        rmButton.frame = CGRectMake(0,lineViewY+1,SCREENW,20)
        rmButton.setImage(UIImage(named: "hotSearch_icon_clear_11x11_"), forState: .Normal)
        rmButton.setTitle("清除搜索历史", forState: .Normal)
        rmButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
        rmButton.titleLabel?.font = UIFont.systemFontOfSize(13)
        rmButton.titleLabel?.textAlignment = .Center
        rmButton.addTarget(self, action: Selector("rmButtonClick"), forControlEvents: .TouchUpInside)
        bottomView.addSubview(rmButton)

    }
    //热词点击
    func hotWords(sender: UIButton){
//        SVProgressHUD.showInfoWithStatus(words[sender.tag])
        let hotWords:String = words[sender.tag]
        //记录加入到搜索历史中
        searchs.append(hotWords)
//        self.delegate?.sethotWordsButton(hotWords)
        cloureBack!(hotWord: hotWords)
        
    }
    
    func rmButtonClick(){
        searchs = []
        setupUI()
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
