//
//  StarsView.h
//  CustomStarView
//
//  Created by Shao Jie on 16/7/13.
//  Copyright © 2016年 yourangroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StarsDelegate;
@interface StarsView : UIView
@property (nonatomic,assign) id <StarsDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame starNumber:(NSInteger)number starWidth:(CGFloat)width starNormalColor:(UIColor *)normalColor starLightColor:(UIColor *)lightColor;
@end
@protocol StarsDelegate <NSObject>
- (void)StarsView:(StarsView *)starsView getResult:(CGFloat)result;
@end