//
//  JCBreadCrumbView.m
//  MobileCMS3
//
//  Created by JuneCheng on 2020/9/9.
//  Copyright © 2020 zjhcsoft. All rights reserved.
//

#import "JCBreadCrumbView.h"

#define HORIZONTAL_PADDING 7.0f
#define VERTICAL_PADDING   3.0f
#define LABEL_MARGIN       12.0f
#define BOTTOM_MARGIN      10.0f
#define KBtnTag            1000

#define HEXColor(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

@interface JCBreadCrumbView() {
    CGFloat _KTagMargin;// 左右tag之间的间距
    CGFloat _KBottomMargin;// 上下tag之间的间距
}

@end

@implementation JCBreadCrumbView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        totalHeight = 0;
        self.frame = frame;
        _tagArr = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setTagWithTagArray:(NSArray *)arr {
    previousFrame = CGRectZero;
    totalHeight = 0;
    [self setHight:self andHight:totalHeight];
    [self removeAllSubView];
    [_tagArr removeAllObjects];
    [_tagArr addObjectsFromArray:arr];
    [arr enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL *stop) {
        UIButton *tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tagBtn.frame = CGRectZero;
        
        tagBtn.backgroundColor =_signalTagColor ? _signalTagColor : [UIColor whiteColor];
        [tagBtn setTitleColor:HEXColor(0x818181) forState:UIControlStateNormal];
        tagBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [tagBtn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [tagBtn setTitle:str forState:UIControlStateNormal];
        tagBtn.tag = KBtnTag+idx;
        tagBtn.layer.cornerRadius = 13;
        tagBtn.layer.borderColor = HEXColor(0x818181).CGColor;
        tagBtn.layer.borderWidth = 0.3;
        tagBtn.clipsToBounds = YES;
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:15]};
        CGSize Size_str = [str sizeWithAttributes:attrs];
        Size_str.width += HORIZONTAL_PADDING*3;
        Size_str.height += VERTICAL_PADDING*3;
        CGRect newRect = CGRectZero;
        if (_KTagMargin && _KBottomMargin) {
            if (previousFrame.origin.x + previousFrame.size.width + Size_str.width + _KTagMargin > self.bounds.size.width) {
                newRect.origin = CGPointMake(10, previousFrame.origin.y + Size_str.height + _KBottomMargin);
                totalHeight += Size_str.height + _KBottomMargin;
            } else {
                newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + _KTagMargin, previousFrame.origin.y);
            }
            [self setHight:self andHight:totalHeight + Size_str.height + _KBottomMargin];
        } else {
            if (previousFrame.origin.x + previousFrame.size.width + Size_str.width + LABEL_MARGIN > self.bounds.size.width) {
                newRect.origin = CGPointMake(10, previousFrame.origin.y + Size_str.height + BOTTOM_MARGIN);
                totalHeight += Size_str.height + BOTTOM_MARGIN;
            } else {
                newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + LABEL_MARGIN, previousFrame.origin.y);
            }
            [self setHight:self andHight:totalHeight + Size_str.height + BOTTOM_MARGIN];
        }
        newRect.size = Size_str;
        [tagBtn setFrame:newRect];
        previousFrame = tagBtn.frame;
        [self setHight:self andHight:totalHeight + Size_str.height + BOTTOM_MARGIN];
        [self addSubview:tagBtn];
        
        if (idx != arr.count - 1) {
            CGFloat margin = _KTagMargin ? _KTagMargin : LABEL_MARGIN;
            UIImageView *arrowImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_arrow_right"]];
            // 15*24
            CGSize imgSize = CGSizeMake(7.5, 12);
            arrowImg.frame = CGRectMake(tagBtn.frame.origin.x+tagBtn.frame.size.width+(margin-imgSize.width)*0.5, tagBtn.frame.origin.y+(tagBtn.frame.size.height-imgSize.height)*0.5, imgSize.width, imgSize.height);
            [self addSubview:arrowImg];
        }
    }];
    self.backgroundColor = [UIColor whiteColor];
}

- (void)removeAllSubView {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

#pragma mark - Actions

- (void)tagBtnClick:(UIButton *)button {
    previousFrame = CGRectZero;
    totalHeight = 0;
    self.didselectItemBlock(button.tag - KBtnTag, _tagArr[button.tag - KBtnTag]);
}

#pragma mark - 改变控件高度

- (void)setHight:(UIView *)view andHight:(CGFloat)hight {
    CGRect tempFrame = view.frame;
    tempFrame.size.height = hight;
    view.frame = tempFrame;
}

- (void)setMarginBetweenTagLabel:(CGFloat)margin bottomMargin:(CGFloat)bottomMargin {
    _KTagMargin = margin;
    _KBottomMargin = bottomMargin;
}

@end
