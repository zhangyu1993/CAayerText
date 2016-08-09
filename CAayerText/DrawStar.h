//
//  DrawStar.h
//  CustomStarView
//
//  Created by Shao Jie on 16/7/13.
//  Copyright © 2016年 yourangroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawStar : UIView
@property (nonatomic,strong) UIColor * starColor;
@property (nonatomic,assign) CGFloat percent;
- (instancetype)drawStarWidth:(CGFloat)width height:(CGFloat)height;
@end
