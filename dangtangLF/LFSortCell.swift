

import UIKit

class LFSortCell: UITableViewCell {

    var viewCell =  UIView()
    var titleLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    //界面设置
    func setupUI(){
        
        viewCell.frame = CGRectMake(0, 29, SCREENW, 1)
        viewCell.backgroundColor = LFGlobalColor()
        addSubview(viewCell)
        
        titleLabel.frame = CGRectMake(10, 0, SCREENW-10-10, 29)
        titleLabel.text = "Label"
        titleLabel.textColor = UIColor.whiteColor()
        addSubview(titleLabel)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
