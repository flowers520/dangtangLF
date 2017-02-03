
// UITableView 扩展

import UIKit

public extension UITableView{
    func tableView(message: String, image: String, cellCount: Int){
        if cellCount == 0{
            //没有数据，显示图片
            let button = LFVerticalButton()
            button.setTitleColor(LFColor(200, g: 200, b: 200, a: 1.0), forState: .Normal)
            button.setTitle(message, forState: .Normal)
            button.titleLabel?.font = UIFont.systemFontOfSize(15)
            button.setImage(UIImage(named: image), forState: .Normal)
            button.addTarget(self, action: Selector("emptyBUttonClick"), forControlEvents: .TouchUpInside)
            backgroundView = button
            separatorStyle = .None
        }else{
            backgroundView = nil
            separatorStyle = .SingleLine
        }
    }
    
    func emptyButtonClick(){
        print("我是空空")
    }
}
