//
//  NewsCell.m
//  01-新闻-YCC
//
//  Created by sunny on 15/7/2.
//  Copyright (c) 2015年 sunny. All rights reserved.
//

#import "NewsCell.h"
#import "News.h"
#import <UIImageView+AFNetworking.h>
//AFN针对UIImageView 的分类

@interface NewsCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *digestLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *extraImageViews;



@end

@implementation NewsCell

- (void)setNews:(News *)news {
    _news = news;
    
    self.titleLabel.text = news.title;
    self.digestLabel.text = news.digest;
    self.replyLabel.text = [NSString stringWithFormat:@"%d", news.replyCount];
    
    // 设置图像 - AFN的图像分类不支持 GIF，绝大多数还是应该用 SDWebImage
    [self.iconView setImageWithURL:[NSURL URLWithString:news.imgsrc]];
    
    //判断 news模型中是否有多图
    if (news.imgextra.count == 2) {
        int index = 0;
        for (UIImageView *iv in self.extraImageViews) {
            NSString *urlString = news.imgextra[index][@"imgsrc"];
            NSURL *url = [NSURL URLWithString:urlString];
            
            //设置图像
            [iv setImageWithURL:url];
            index++;
        }
    }

}

+ (NSString *)cellIdentifier:(News *)news{
    if (news.imgextra.count == 2) {
        return @"imagesCell";
    }
    return @"NewsCell";
}
- (void)awakeFromNib {
    // 设置换行宽度
    
    
    self.digestLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - CGRectGetMaxX(self.iconView.frame) - 16;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}



@end
