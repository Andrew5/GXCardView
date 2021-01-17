//
//  ViewController.m
//  GXCardViewDemo
//
//  Created by Gin on 2018/7/31.
//  Copyright © 2018年 gin. All rights reserved.
//

#import "ViewController.h"
#import "GXCardView.h"
#import "GXCardItemDemoCell.h"
#import "GradientButton.h"

@interface ViewController ()<GXCardViewDataSource, GXCardViewDelegate, UITableViewDelegate>{
    int abc;
}
@property (nonatomic, weak) IBOutlet GXCardView *cardView;
@property (nonatomic, assign) NSInteger cellCount;
@property (nonatomic, strong) GradientButton *hateBtn;
@property (nonatomic, strong) GradientButton *likeBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    self.cellCount = 10;
    
    self.cardView.dataSource = self;
    self.cardView.delegate = self;
    self.cardView.visibleCount = 2;
    self.cardView.lineSpacing = 0.0;
    self.cardView.interitemSpacing = 0.0;
    self.cardView.maxAngle = 15.0;
    self.cardView.maxRemoveDistance = 100.0;
//    self.cardView.isRepeat = YES; // 新加入
    [self.cardView registerNib:[UINib nibWithNibName:NSStringFromClass([GXCardItemDemoCell class]) bundle:nil] forCellReuseIdentifier:@"GXCardViewCell"];
    [self.cardView reloadData];
    
    GradientButton *hateBtn = [[GradientButton alloc]init];
    hateBtn.gradientStartColor = [UIColor whiteColor];
    hateBtn.gradientEndColor = [UIColor grayColor];
    hateBtn.frame = CGRectMake(0, 100, 40, 40);
    hateBtn.alpha = 0;
    [hateBtn setImage:[UIImage imageNamed:@"LL_nolike"] forState:(UIControlStateNormal)];
    [self.view addSubview:hateBtn];
    
    CGFloat X = [UIScreen mainScreen].bounds.size.width;
    GradientButton *likeBtn = [[GradientButton alloc]init];
    likeBtn.gradientStartColor = [UIColor redColor];
    likeBtn.gradientEndColor = [UIColor orangeColor];
    likeBtn.frame = CGRectMake(X, 100, 40, 40);
    likeBtn.alpha = 0;
    [likeBtn setImage:[UIImage imageNamed:@"icon_好友_好友列表"] forState:(UIControlStateNormal)];
    [self.view addSubview:likeBtn];
    
    self.likeBtn = likeBtn;
    self.hateBtn = hateBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GXCardViewDataSource

- (GXCardViewCell *)cardView:(GXCardView *)cardView cellForRowAtIndex:(NSInteger)index {
    GXCardItemDemoCell *cell = [cardView dequeueReusableCellWithIdentifier:@"GXCardViewCell"];
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld", (long)index];
    cell.leftLabel.hidden = YES;
    cell.rightLabel.hidden = YES;
    cell.layer.cornerRadius = 12.0;
    cell.userInteractionEnabled = YES;
    return cell;
}

- (NSInteger)numberOfCountInCardView:(UITableView *)cardView {
    return self.cellCount;
}

#pragma mark - GXCardViewDelegate

- (void)cardView:(GXCardView *)cardView didRemoveLastCell:(GXCardViewCell *)cell forRowAtIndex:(NSInteger)index {
    if (!cardView.isRepeat) {
        [cardView reloadDataAnimated:YES];
    }
}

- (void)cardView:(GXCardView *)cardView didRemoveCell:(GXCardViewCell *)cell forRowAtIndex:(NSInteger)index direction:(GXCardCellSwipeDirection)direction {
    NSLog(@"1位置didRemoveCell forRowAtIndex = %ld, direction = %ld", index, direction);
    if (direction == GXCardCellSwipeDirectionLeft) {
        [self hiddentBtn:YES];
    }
    if (direction == GXCardCellSwipeDirectionRight) {
        [self hiddentBtn:NO];
    }

    if (!cardView.isRepeat && index == 8) {
        self.cellCount = 15;
        [cardView reloadMoreDataAnimated:YES];
    }
}
- (void)cardView:(GXCardView *)cardView didMoveCell:(GXCardViewCell *)cell forMovePoint:(CGPoint)point direction:(GXCardCellSwipeDirection)direction {
    //    GXCardItemDemoCell *dcell = (GXCardItemDemoCell*)cell;
    //    dcell.leftLabel.hidden = !(direction == GXCardCellSwipeDirectionRight);
    //    dcell.rightLabel.hidden = !(direction == GXCardCellSwipeDirectionLeft);
    if (point.x < 0) {
        [self showBtn:YES];
    }else{
        [self showBtn:NO];
    }
    CGFloat X = [UIScreen mainScreen].bounds.size.width;
    cell.imageClickBlock = ^(void) {
        if (self.hateBtn.frame.origin.x == (X-40)/2) {
            [self hiddentBtn:YES];
        }
        if (self.likeBtn.frame.origin.x == (X-40)/2) {
            [self hiddentBtn:NO];
        }
    };
}


- (void)showBtn:(BOOL)show{
    if (show) {///YES 不喜欢
        self.likeBtn.alpha = 0;
        CGFloat X = [UIScreen mainScreen].bounds.size.width;
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = self.hateBtn.frame;
            self.hateBtn.alpha += 0.05;
            frame.origin.x = (X-40)/2;
            self.hateBtn.frame = frame;
            [self.hateBtn layoutIfNeeded];
        }];
    }else{///NO 喜欢
        self.hateBtn.alpha = 0;
        CGFloat X = [UIScreen mainScreen].bounds.size.width;
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = self.likeBtn.frame;
            self.likeBtn.alpha += 0.1;
            frame.origin.x = (X-40)/2;
            self.likeBtn.frame = frame;
            [self.likeBtn layoutIfNeeded];
        }];
    }
}
- (void)hiddentBtn:(BOOL)hiddent{
    if (hiddent) {///YES 不喜欢
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = self.hateBtn.frame;
            frame.origin.x = 0;
            self.hateBtn.frame = frame;
            self.hateBtn.alpha = 0;
        }];
    }else{///喜欢
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = self.likeBtn.frame;
            frame.origin.x = [UIScreen mainScreen].bounds.size.width;
            self.likeBtn.frame = frame;
            self.likeBtn.alpha = 0;
        }];
    }
}


#pragma mark -

- (IBAction)leftButtonClick:(id)sender {
    [self.cardView removeTopCardViewFromSwipe:GXCardCellSwipeDirectionLeft];
//    [self.cardView reloadDataFormIndex:2 animated:YES];
}

- (IBAction)rightButtonClick:(id)sender {
    [self.cardView removeTopCardViewFromSwipe:GXCardCellSwipeDirectionRight];
}

@end
