//
//  MyCollectionViewCell.h
//  TestCollectionView
//
//  Created by 崔兵兵 on 16/6/1.
//  Copyright © 2016年 医联通. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyCollectionViewCellDelegate <NSObject>

//  开始移动手势
- (void)ylt_gestureBegan:(UILongPressGestureRecognizer *)longPressGesture withSelectIndex:(NSIndexPath *)selectIndex withFromType:(NSString *)strType;

//  手势拖动
- (void)ylt_gestureChange:(UILongPressGestureRecognizer *)longPressGesture withSelectIndex:(NSIndexPath *)selectIndex withFromType:(NSString *)strType;

//  手势取消或者结束
- (void)ylt_gestureEndOrCancle:(UILongPressGestureRecognizer *)longPressGesture withSelectIndex:(NSIndexPath *)selectIndex withFromType:(NSString *)strType;

@end

@interface MyCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) id<MyCollectionViewCellDelegate> delegate;

@property (strong, nonatomic) NSIndexPath *selectIndex;

@property (copy, nonatomic) NSString *strType;

- (void)setCellItemWithName:(NSString *)strName;

@end
