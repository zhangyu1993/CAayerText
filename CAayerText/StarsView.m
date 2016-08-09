//
//  StarsView.m
//  CustomStarView
//
//  Created by Shao Jie on 16/7/13.
//  Copyright © 2016年 yourangroup. All rights reserved.
//

#import "StarsView.h"
#import "DrawStar.h"
@interface StarsView ()
@property (nonatomic,strong) NSMutableArray * normalStarArray;
@property (nonatomic,strong) NSMutableArray * selectedStarArray;
@property (nonatomic,assign) NSInteger number;
@property (nonatomic,assign) CGFloat starWidth;
@property (nonatomic,assign) CGFloat starpadding;
@property (nonatomic,strong) UIColor * lightColor;
@property (nonatomic,strong) UIColor * normalColor;
@property (nonatomic,assign) CGFloat result;
@end

@implementation StarsView
- (instancetype)initWithFrame:(CGRect)frame starNumber:(NSInteger)number starWidth:(CGFloat)width starNormalColor:(UIColor *)normalColor starLightColor:(UIColor *)lightColor{
    if (self = [super initWithFrame:frame]) {
        self.normalStarArray = [NSMutableArray arrayWithCapacity:number];
        self.selectedStarArray = [NSMutableArray arrayWithCapacity:number];
        self.number = number;
        self.starWidth = width;
        self.lightColor = lightColor;
        self.normalColor = normalColor;
        self.starpadding = (frame.size.width - (number * width)) / (number +1);
        
        [self addStarToArray];
        [self addGestureOnView];
    }
    return self;
}
/**
 *  @brief 添加五角星
 */
- (void)addStarToArray{
    //第一组
    for (int i = 0; i < self.number; i ++) {
        DrawStar * star = [[DrawStar alloc] initWithFrame:CGRectMake(self.starpadding + i * (self.starWidth + self.starpadding), 0, self.starWidth, self.starWidth)];
        [star drawStarWidth:self.starWidth height:self.starWidth];
        star.starColor = self.normalColor;
        [self.normalStarArray addObject:star];
        [self addSubview:star];
    }
    //第二组
    for (int i = 0; i < self.number; i ++) {
        DrawStar * star = [[DrawStar alloc] initWithFrame:CGRectMake(self.starpadding + i * (self.starWidth + self.starpadding), 0, self.starWidth, self.starWidth)];
        [star drawStarWidth:self.starWidth height:self.starWidth];
        star.starColor = [UIColor clearColor];
        star.percent = 1;
        [self.selectedStarArray addObject:star];
        [self addSubview:star];
    }
}
/**
 *  @brief 手势添加
 */
- (void)addGestureOnView{
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureClicked:)];
    UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureClicked:)];
    [self addGestureRecognizer:tapGesture];
    [self addGestureRecognizer:panGesture];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
/**
 *  @brief 直接点击点亮星星
 *
 *  @param sender 点击手势
 */
- (void)tapGestureClicked:(UITapGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:self];
    
    // 点亮前先先将底色刷新为透明
    if (CGRectContainsPoint(self.bounds, point)){
        
        for (int i = 0; i < self.number; i ++) {
            DrawStar * star = [self.selectedStarArray objectAtIndex:i];
            star.percent = 1;
            star.starColor = [UIColor clearColor];
        }
        [self calculateWithPoint:point];
    }
}
/**
 *  @brief 拖拽点亮星星
 *
 *  @param sender 拖拽手势
 */
- (void)panGestureClicked:(UIPanGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:self];
    //每次显示星星前刷新星星为不存在
    for (int i = 0; i < self.number; i ++) {
        DrawStar * star = [self.selectedStarArray objectAtIndex:i];
        star.percent = 0;
    }
    
    [self calculateWithPoint:point];
    
    //拖拽结束后取值
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (point.x > (self.starpadding + self.starWidth) * self.number) {
            point.x = (self.starpadding + self.starWidth) * self.number;
            self.result = point.x / (self.starpadding + self.starWidth);
        }else{
            self.result = point.x / (self.starpadding + self.starWidth);
        }
        [self calculateWithPoint:point];
    }
    if ([self.delegate conformsToProtocol:@protocol(StarsDelegate)] && [self.delegate respondsToSelector:@selector(StarsView:getResult:)]) {
        [self.delegate StarsView:self getResult:self.result];
    }
}
- (void)calculateWithPoint:(CGPoint)point{
    
    CGFloat maxX = point.x;
    if (maxX > (self.starWidth + self.starpadding) * self.number) {
        maxX = (self.starpadding + self.starWidth) * self.number;
        self.result = maxX / (self.starWidth * self.starpadding);
    }else{
        self.result = maxX / (self.starpadding + self.starWidth);
    }
    
    for (int i = 0; i < floor(self.result); i ++) {
        DrawStar * star = [self.selectedStarArray objectAtIndex:i];
        star.starColor = self.lightColor;
        star.percent = 1;
    }
    if (self.result - floor(self.result) != 0) {
        DrawStar *star = [self.selectedStarArray objectAtIndex:floor(self.result)];
        star.percent = self.result - floor(self.result);
        star.starColor = self.lightColor;
    }
    
    if ([self.delegate conformsToProtocol:@protocol(StarsDelegate)] && [self.delegate respondsToSelector:@selector(StarsView:getResult:)]) {
        [self.delegate StarsView:self getResult:self.result];
    }
}


@end
