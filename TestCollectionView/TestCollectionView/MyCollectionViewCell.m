//
//  MyCollectionViewCell.m
//  TestCollectionView
//
//  Created by 崔兵兵 on 16/6/1.
//  Copyright © 2016年 医联通. All rights reserved.
//

#import "MyCollectionViewCell.h"

@interface MyCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@property (nonatomic, weak) UILongPressGestureRecognizer *longPressGesture;

@end

@implementation MyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGes:)];
    longPress.minimumPressDuration = 2;
    self.longPressGesture = longPress;
    [self.contentView addGestureRecognizer:self.longPressGesture];
}

- (void)setCellItemWithName:(NSString *)strName
{
    self.valueLabel.text = strName;
}

#pragma mark - 长按手势响应
- (void)longPressGes:(UILongPressGestureRecognizer *)longPressGes
{
    if (longPressGes.state == UIGestureRecognizerStateBegan) {      //  开始移动手势
        if ([self.delegate respondsToSelector:@selector(ylt_gestureBegan:withSelectIndex: withFromType:)]) {
            [self.delegate ylt_gestureBegan:longPressGes withSelectIndex:self.selectIndex withFromType:self.strType];
        }
    }
    
    if (longPressGes.state == UIGestureRecognizerStateChanged) {    //  手势拖动
        if ([self.delegate respondsToSelector:@selector(ylt_gestureChange:withSelectIndex:withFromType:)]) {
            [self.delegate ylt_gestureChange:longPressGes withSelectIndex:self.selectIndex withFromType:self.strType];
        }
    }
    
    if (longPressGes.state == UIGestureRecognizerStateCancelled ||
        longPressGes.state == UIGestureRecognizerStateEnded){       //  手势取消或者结束
        if ([self.delegate respondsToSelector:@selector(ylt_gestureEndOrCancle:withSelectIndex:withFromType:)]) {
            [self.delegate ylt_gestureEndOrCancle:longPressGes withSelectIndex:self.selectIndex withFromType:self.strType];
        }
    }
}



@end
