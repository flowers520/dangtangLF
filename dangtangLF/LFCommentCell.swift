

import UIKit


class LFCommentCell: UITableViewCell {

    var avatarImageView = UIImageView()
    var lineView = UIView()
    var nicknameLabel = UILabel()
    var timeLabel = UILabel()
    var contentLabel = UILabel()
    
    var comment: LFComment? {
        didSet{
            let user = comment?.user
            let url = user!.avatar_url
            avatarImageView.kf_setImageWithURL(NSURL(string: url!)!, placeholderImage: UIImage(named: "Me_AvatarPlaceholder_75x75_"))
            nicknameLabel.text = user!.nickname
            contentLabel.text = comment!.content
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //界面设置
        setupUI()
    }

    //界面设置
   private func setupUI(){
        
        avatarImageView.frame = CGRectMake(10, 10, 32, 32)
        avatarImageView.image = UIImage(named: "Me_AvatarPlaceholder_75x75_")
        avatarImageView.layer.cornerRadius = 16
        avatarImageView.layer.masksToBounds = true
        addSubview(avatarImageView)
        
        nicknameLabel.frame = CGRectMake(52, 10, SCREENW/2, 17)
        nicknameLabel.text = "绰号"
        nicknameLabel.textColor = UIColor.blackColor()
        nicknameLabel.font = UIFont.systemFontOfSize(14)
        addSubview(nicknameLabel)
        
        contentLabel.frame = CGRectMake(52, 32, SCREENW-52-10, 32)
        contentLabel.text = "内容"
        contentLabel.textColor = UIColor.blackColor()
        contentLabel.font = UIFont.systemFontOfSize(13)
        addSubview(contentLabel)
        
        timeLabel.frame = CGRectMake(SCREENW-10-33, 10, 33, 17)
        timeLabel.text = "时间"
        timeLabel.textColor = UIColor.blackColor()
        timeLabel.font = UIFont.systemFontOfSize(13)
        addSubview(timeLabel)
        
        lineView.frame = CGRectMake(52, 63, SCREENW-52-10, 1)
        lineView.backgroundColor = UIColor.grayColor()
        addSubview(lineView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
