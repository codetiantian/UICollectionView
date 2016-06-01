//
//  ViewController.m
//  TestCollectionView
//
//  Created by 崔兵兵 on 16/6/1.
//  Copyright © 2016年 医联通. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewCell.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, MyCollectionViewCellDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView1;

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView2;

@property (strong, nonatomic) NSMutableArray *array1;
@property (strong, nonatomic) NSMutableArray *array2;

/**
 *  创建的view
 */
@property (nonatomic, weak) UIView *tempMoveCell;

@property (nonatomic, assign) CGPoint lastPoint;

@end

@implementation ViewController

- (NSMutableArray *)array1
{
    if (!_array1) {
        _array1 = [NSMutableArray arrayWithObjects:@"1-1", @"1-2", @"1-3", @"1-4", @"1-5", @"1-6", @"1-7", @"1-8", nil];
    }
    
    return _array1;
}

- (NSMutableArray *)array2
{
    if (!_array2) {
        _array2 = [NSMutableArray arrayWithObjects:@"2-1", @"2-2", @"2-3", @"2-4", @"2-5", @"2-6", @"2-7", @"2-8", nil];
    }
    
    return _array2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self.myCollectionView1 registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"myCollectionViewCellIndex"];
    
    [self.myCollectionView2 registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"myCollectionViewCellIndex"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag == 1) {
        return self.array1.count;
    } else {
        return self.array2.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCollectionViewCellIndex" forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *myCell = (MyCollectionViewCell *)cell;
    myCell.selectIndex = indexPath;
    myCell.delegate = self;
    if (collectionView.tag == 1) {
        [myCell setCellItemWithName:self.array1[indexPath.row]];
        myCell.strType = @"1";
    } else {
        [myCell setCellItemWithName:self.array2[indexPath.row]];
        myCell.strType = @"2";
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 20, 10, 20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 12;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 1) {
        NSLog(@"-------点击了%@", self.array1[indexPath.row]);
    } else {
        NSLog(@"-------点击了%@", self.array2[indexPath.row]);
    }
}

#pragma mark - 开始移动手势
- (void)ylt_gestureBegan:(UILongPressGestureRecognizer *)longPressGesture withSelectIndex:(NSIndexPath *)selectIndex withFromType:(NSString *)strType
{
    if ([strType integerValue] == 1) {
        MyCollectionViewCell *cell = (MyCollectionViewCell *)[self.myCollectionView1 cellForItemAtIndexPath:selectIndex];
        UIView *tempMoveCell = [cell snapshotViewAfterScreenUpdates:NO];
        cell.hidden = YES;
        
        CGPoint viewPoint = [longPressGesture locationInView:self.view];
        
        self.tempMoveCell = tempMoveCell;
        self.tempMoveCell.frame = CGRectMake(viewPoint.x - cell.frame.size.width / 2.0, viewPoint.y - cell.frame.size.height / 2.0, cell.frame.size.width, cell.frame.size.height);
        [self.view addSubview:self.tempMoveCell];
        
        self.lastPoint = [longPressGesture locationOfTouch:0 inView:longPressGesture.view];
        
    } else {
        MyCollectionViewCell *cell = (MyCollectionViewCell *)[self.myCollectionView2 cellForItemAtIndexPath:selectIndex];
        UIView *tempMoveCell = [cell snapshotViewAfterScreenUpdates:NO];
        cell.hidden = YES;
        
        CGPoint viewPoint = [longPressGesture locationInView:self.view];
        
        self.tempMoveCell = tempMoveCell;
        self.tempMoveCell.frame = CGRectMake(viewPoint.x - cell.frame.size.width / 2.0, viewPoint.y - cell.frame.size.height / 2.0, cell.frame.size.width, cell.frame.size.height);
        [self.view addSubview:self.tempMoveCell];
        
        self.lastPoint = [longPressGesture locationOfTouch:0 inView:longPressGesture.view];
    }
}

#pragma mark - 手势拖动
- (void)ylt_gestureChange:(UILongPressGestureRecognizer *)longPressGesture withSelectIndex:(NSIndexPath *)selectIndex withFromType:(NSString *)strType
{
    CGFloat tranX = [longPressGesture locationOfTouch:0 inView:longPressGesture.view].x - self.lastPoint.x;
    CGFloat tranY = [longPressGesture locationOfTouch:0 inView:longPressGesture.view].y - self.lastPoint.y;
    
    self.tempMoveCell.center = CGPointApplyAffineTransform(self.tempMoveCell.center, CGAffineTransformMakeTranslation(tranX, tranY));
    self.lastPoint = [longPressGesture locationOfTouch:0 inView:longPressGesture.view];
}

#pragma mark - 手势取消或者结束
- (void)ylt_gestureEndOrCancle:(UILongPressGestureRecognizer *)longPressGesture withSelectIndex:(NSIndexPath *)selectIndex withFromType:(NSString *)strType
{
    CGRect rect1 = self.myCollectionView1.frame;
    CGRect rect2 = self.myCollectionView2.frame;
    
    self.view.userInteractionEnabled = NO;
    
    //  当前手指所在的位置
    CGPoint currentPoint = [longPressGesture locationInView:self.view];
    
    if ([strType integerValue] == 1) {      //  从第一个collectionView中拖的cell
        
        MyCollectionViewCell *cell = (MyCollectionViewCell *)[self.myCollectionView1 cellForItemAtIndexPath:selectIndex];
        cell.hidden = NO;
        
        //  判断当前是否处于CollectionView2
        if ((currentPoint.x >= rect2.origin.x && currentPoint.x <= rect2.origin.x + rect2.size.width) && (currentPoint.y >= rect2.origin.y && currentPoint.y <= rect2.origin.y + rect2.size.height)) {
            
            //  获取当前位置的对象
            NSString *strName = self.array1[selectIndex.row];
            [self.array1 removeObjectAtIndex:selectIndex.row];
            [self.array2 addObject:strName];
        }
    } else {                                //  从第二个collectionView中拖得cell
        
        MyCollectionViewCell *cell = (MyCollectionViewCell *)[self.myCollectionView2 cellForItemAtIndexPath:selectIndex];
        cell.hidden = NO;
        
        //  判断当前是否处于CollectionView2
        if ((currentPoint.x >= rect1.origin.x && currentPoint.x <= rect1.origin.x + rect1.size.width) && (currentPoint.y >= rect1.origin.y && currentPoint.y <= rect1.origin.y + rect1.size.height)) {
            
            //  获取当前位置的对象
            NSString *strName = self.array2[selectIndex.row];
            [self.array2 removeObjectAtIndex:selectIndex.row];
            [self.array1 addObject:strName];
        }
    }
    
    [self.myCollectionView1 reloadData];
    [self.myCollectionView2 reloadData];
    [self.tempMoveCell removeFromSuperview];
    self.tempMoveCell = nil;
    self.view.userInteractionEnabled = YES;
}

@end
