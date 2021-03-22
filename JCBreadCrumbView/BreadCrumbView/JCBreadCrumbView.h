//
//  JCBreadCrumbView.h
//  MobileCMS3
//
//  Created by JuneCheng on 2020/9/9.
//  Copyright © 2020 zjhcsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCBreadCrumbView : UIView {
    CGRect previousFrame;
    int totalHeight;
    NSMutableArray *_tagArr;
}
/** 设置单一颜色 */
@property (nonatomic) UIColor *signalTagColor;
/** 回调统计选中tag */
@property (nonatomic, copy) void (^didselectItemBlock)(NSInteger index, NSString *tagName);

/** 标签文本赋值 */
- (void)setTagWithTagArray:(NSArray *)arr;
/** 设置tag之间的距离 */
- (void)setMarginBetweenTagLabel:(CGFloat)margin bottomMargin:(CGFloat)bottomMargin;

@end
