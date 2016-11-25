//
//  EssenceTextCell.m
//  百思不得姐
//
//  Created by ZL on 16/11/22.
//  Copyright © 2016年 ZL. All rights reserved.
//

#import "EssenceTextCell.h"
#import "BDJEssenceModel.h"


@interface EssenceTextCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *clikMoreBtn;
@property (weak, nonatomic) IBOutlet UILabel *descLable;



@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;


//神评高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentViewHCons;
//神评的Top距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentViewYCons;


@end


@implementation EssenceTextCell

+ (EssenceTextCell *)textCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexpath withModel:(BDJEssenceDetail *)detailModel {
    
    static NSString *cellId = @"textCellId";
    
    EssenceTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EssenceTextCell" owner:nil options:nil] lastObject];
    }
    
    //数据
    cell.detailModel = detailModel;
    
    return cell;
}

-(void)setDetailModel:(BDJEssenceDetail *)detailModel {
    _detailModel = detailModel;
    //1.用户图标
    NSString *headerString = [detailModel.u.header firstObject];
    NSURL *url = [NSURL URLWithString:headerString];
    [self.userImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"post_placeholderImage"]];
    
    //2.用户名
    self.userNameLabel.text = detailModel.u.name;
    
    //3.时间
    self.passTimeLabel.text = detailModel.passtime;
    
    //4.描述文字
    self.descLable.text = detailModel.text;
    
    //8.神评文字
    if (detailModel.top_comments.count > 0) {
    BDJEssenceComment *comment = [detailModel.top_comments firstObject];
    self.commentLabel.text = comment.content;
    }else {
        self.commentLabel.text = nil;
    }

    //强制cell布局一次
    [self layoutIfNeeded];
    
    //修改评论视图的约束
    if (detailModel.top_comments.count > 0) {

        self.commentViewYCons.constant = 10;
        self.commentViewHCons.constant = self.commentLabel.frame.size.height + 10 +10;
        
    }else {
        //没有神评
        self.commentViewHCons.constant = 0;
        self.commentViewYCons.constant = 0;
    }
    
    //9.标签
    NSMutableString *tagString = [NSMutableString string];
    for (NSInteger i=0;i<detailModel.tags.count;i++) {
        BDJEssenceTag *tag = detailModel.tags[i];
        [tagString appendFormat:@"%@ ",tag.name];
    }
    self.tagLabel.text = tagString;
    
    //10.顶、踩、分享、评论的数量
    [self.dingButton setTitle:detailModel.up forState:UIControlStateNormal];
    [self.caiButton setTitle:[detailModel.down stringValue] forState:UIControlStateNormal];
    [self.shareButton setTitle:[detailModel.forward stringValue] forState:UIControlStateNormal];
    [self.commentButton setTitle:detailModel.comment forState:UIControlStateNormal];
    
    //强制刷新一次
    [self layoutIfNeeded];
    
    //获取cell的高度
    detailModel.cellHeight = @(CGRectGetMaxY(self.dingButton.frame) + 10 + 10);
    
    
}


//更多
- (IBAction)clickMoreBtn:(id)sender {
}

//顶
- (IBAction)dingAction:(id)sender {
}
//踩
- (IBAction)caiAction:(id)sender {
}
//分享
- (IBAction)shareAction:(id)sender {
}
//评论
- (IBAction)commentAction:(id)sender {
}





- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
