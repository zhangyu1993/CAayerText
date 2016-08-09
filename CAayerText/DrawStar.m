//
//  DrawStar.m
//  CustomStarView
//
//  Created by Shao Jie on 16/7/13.
//  Copyright © 2016年 yourangroup. All rights reserved.
//

#import "DrawStar.h"
@interface DrawStar ()
@property (nonatomic,weak) CAShapeLayer * backgroundLayer;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@end
@implementation DrawStar
- (instancetype)drawStarWidth:(CGFloat)width height:(CGFloat)height{
    self.backgroundColor = [UIColor clearColor];
    self.width = width;
    self.height = height;
    
    UIBezierPath *bgPath = [UIBezierPath bezierPath];
    [bgPath moveToPoint:CGPointMake(0, height * 0.5)];
    [bgPath addLineToPoint:CGPointMake(width, height * 0.5)];
    
    CAShapeLayer *backgroundLayer = [CAShapeLayer layer];
    backgroundLayer.path = bgPath.CGPath;
    backgroundLayer.lineWidth = height;

    [self.layer addSublayer:backgroundLayer];
    
    self.backgroundLayer = backgroundLayer;

    
    [self drawStarMethod];
    

    return self;
}
/**
 *  @brief 画五角星的核心算法
 */
- (void)drawStarMethod{
    UIBezierPath * star = [[UIBezierPath alloc] init];
    for (int i = 0; i < 2; i ++) {
        if (i%2 != 0) {
            CGFloat startX = self.width / (self.width / self.height) * i;
            CGPoint center = CGPointMake(startX * 0.5, self.height * 0.5);
            CGFloat radius = self.height * 0.5;
            CGFloat angle = 4 * M_PI / 5;
            
            // 开始绘画
            [star moveToPoint:CGPointMake(startX * 0.5, 0)];
            for (int j = 0; j < 5; j ++) {
                CGFloat x = center.x - sinf((j + 1) * angle) * radius;
                CGFloat y = center.y - cosf((j + 1) * angle) * radius;
                [star addLineToPoint:CGPointMake(x, y)];
            }
            [star addLineToPoint:CGPointMake(startX * 0.5, 0)];
        }
    }
    
    //遮盖
    CAShapeLayer * starLayer = [CAShapeLayer layer];
    starLayer.path = star.CGPath;

    self.layer.mask = starLayer;
}
#pragma mark --- setter方法
- (void)setStarColor:(UIColor *)starColor{
    _starColor = starColor;
    self.backgroundLayer.strokeColor = starColor.CGColor;
    self.backgroundLayer.fillColor = starColor.CGColor;
}
- (void)setPercent:(CGFloat)percent{
    _percent = percent;
    self.backgroundLayer.strokeEnd = percent;
}
@end
