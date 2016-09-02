//
//  ViewController.m
//  CAayerText
//
//  Created by LNXD1 on 16/8/3.
//  Copyright © 2016年 LNXD1. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "StarsView.h"
@interface ViewController ()
@property (nonatomic, strong) UIView * LayerView;
@property (nonatomic, strong) CALayer *textLayer;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *viewArr;
//两种不同的CAEmitterLayer
@property (strong, nonatomic) CAEmitterLayer *chargeLayer;
@property (strong, nonatomic) CAEmitterLayer *explosionLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self configUI];
    //[self creatCor];
    //[self creat3DView];
    //[self creatEmitterLayer];
    //[self creatAnimation];
    //[self creatKeyframeAnimation];
    //[self creatAnimation1];
    //[self creatAnimation2];
    //[self creatTimeoffset];
    //[self creatStar];
    [self setup];
}

-(void)creatStar
{
    StarsView *view = [[StarsView alloc] initWithFrame:CGRectMake(10, 100, 250, 50) starNumber:5 starWidth:50 starNormalColor:[UIColor redColor] starLightColor:[UIColor yellowColor]];
    [self.view addSubview:view];
    
    
}

-(void)creatTimeoffset
{
    CALayer *contentLayer = [CALayer layer];
    contentLayer.frame = CGRectMake(50, 100, 200, 300);
    [self.view.layer addSublayer:contentLayer];
    
    _textLayer = [CALayer layer];
    _textLayer.frame = CGRectMake(0, 0, 128, 256);
    _textLayer.position = CGPointMake(150 - 64, 150);
    _textLayer.anchorPoint = CGPointMake(0, 0.5);
    _textLayer.backgroundColor = [UIColor redColor].CGColor;
    [contentLayer addSublayer:_textLayer];
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0/500.0;
    contentLayer.sublayerTransform = perspective;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [pan addTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    
    _textLayer.speed = 0.0;
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.toValue = @(-M_PI_2);
    animation.duration = 1.0;
    [_textLayer addAnimation:animation forKey:nil];
    
}

-(void)pan:(UIPanGestureRecognizer *)pan
{
    CFTimeInterval oldTimeOffset;
    CGFloat x = [pan translationInView:self.view].x;
    x /= 200.f;
    CFTimeInterval timeoffset = self.textLayer.timeOffset;
    oldTimeOffset = timeoffset;
    timeoffset = MIN(0.999, MAX(0.0, timeoffset - x));
    NSLog(@"x = %lf -- old = %lf -- new = %lf ",x,oldTimeOffset,timeoffset);
    self.textLayer.timeOffset = timeoffset;
    [pan setTranslation:CGPointZero inView:self.view];
}

-(void)creatAnimation2
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(100,100)];
    [path addCurveToPoint:CGPointMake(100, 400) controlPoint1:CGPointMake(150, 150) controlPoint2:CGPointMake(50, 350)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.lineWidth = 3.0;
    [self.view.layer addSublayer:layer];
    
    CALayer *colorLayer = [CALayer layer];
    colorLayer.frame = CGRectMake(0, 0, 50, 50);
    colorLayer.position = CGPointMake(100, 100);
    colorLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:colorLayer];
    
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.path = path.CGPath;
    animation1.keyPath = @"position";
    animation1.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"transform.rotation";
    animation2.byValue = @(M_PI * 2);
  //  animation2.repeatCount = MAXFLOAT;
    
    CABasicAnimation *animation3 = [CABasicAnimation animation];
    animation3.keyPath = @"backgroundColor";
    animation3.toValue = (__bridge id)[UIColor redColor].CGColor;
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[animation1,animation2,animation3];
    group.duration = 3.0;
    
    [colorLayer addAnimation:group forKey:nil];
    
}

-(void)creatAnimation1
{
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(150, 150);
    layer.contents = (__bridge id)[UIImage imageNamed:@"6.jpg"].CGImage;
    [self.view.layer addSublayer:layer];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 2.0;
    animation.byValue = @(M_PI * 2);
    [layer addAnimation:animation forKey:nil];
    
}


-(void)creatKeyframeAnimation
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(10,150)];
    [path addCurveToPoint:CGPointMake(310, 150) controlPoint1:CGPointMake(85, 70) controlPoint2:CGPointMake(235, 230)];
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 3.0f;
    shapeLayer.lineCap = kCALineCapRound;
    [self.view.layer addSublayer:shapeLayer];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 50, 50);
    layer.position = CGPointMake(10, 150);
    layer.contents = (__bridge id)[UIImage imageNamed:@"6.jpg"].CGImage;
    [self.view.layer addSublayer:layer];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 4.0;
    animation.path = path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    [layer addAnimation:animation forKey:nil];
}


-(void)creatAnimation
{
    CALayer *colorLayer = [CALayer layer];
    colorLayer.frame = CGRectMake(50, 50, 100, 100);
    colorLayer.backgroundColor = [UIColor redColor].CGColor;
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    colorLayer.actions = @{@"backgroundColor":transition};
    
    [self.view.layer addSublayer:colorLayer];

    __block CALayer *BlockColorLayer = colorLayer;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        BlockColorLayer.backgroundColor = [UIColor blackColor].CGColor;
    });
    
}




-(void)configUI
{
    UIBezierPath * path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(175, 100)];
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    [self.view.layer addSublayer:shapeLayer];
    
    CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration=3;
    CAMediaTimingFunction *f = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    bas.timingFunction = f;
    bas.delegate=self;
    bas.fromValue=[NSNumber numberWithInteger:0];
    bas.toValue=[NSNumber numberWithInteger:1];
    [shapeLayer addAnimation:bas forKey:nil];
    
}

-(void)creatCor
{
    CGRect rect = CGRectMake(50, 50, 100, 100);
    CGSize raddii = CGSizeMake(10 ,10);
    UIRectCorner corners = UIRectCornerTopLeft | UIRectCornerTopRight;
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:raddii];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    [self.view.layer addSublayer:shapeLayer];

}

-(void)creat3DView
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(100, 100, 100, 100);
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                             (__bridge id)[UIColor orangeColor].CGColor,
                             (__bridge id)[UIColor yellowColor].CGColor,
                             (__bridge id)[UIColor greenColor].CGColor,
                             (__bridge id)[UIColor cyanColor].CGColor,
                             (__bridge id)[UIColor blueColor].CGColor,
                             (__bridge id)[UIColor purpleColor].CGColor];
    gradientLayer.locations = @[@(1/6.0),@(2/6.0),@(3/6.0),@(4/6.0),@(5/6.0),@(1)];
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint = CGPointMake(1, 0.5);
    [self.view.layer addSublayer:gradientLayer];
}

-(void)creatEmitterLayer
{
   // self.view.backgroundColor = [UIColor redColor];
    
    CAEmitterLayer *emitterLayer= [CAEmitterLayer layer];
    emitterLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:emitterLayer];
    
    emitterLayer.renderMode = kCAEmitterLayerAdditive;
    emitterLayer.emitterPosition = CGPointMake(emitterLayer.frame.size.width/2.0, emitterLayer.frame.size.height/2.0);
    
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"QQ20160804-0"].CGImage;
    cell.birthRate = 150;
    cell.lifetime = 5.0;
    cell.color = [UIColor redColor].CGColor;
    cell.alphaSpeed = -0.1;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.emissionRange = M_PI * 2.0;
    emitterLayer.emitterCells = @[cell];
}

- (void)setup {
    //参数详情请见博客详解：http://blog.csdn.net/wang631106979/article/details/51258020
    CAEmitterCell *explosionCell = [CAEmitterCell emitterCell];
    explosionCell.name           = @"explosion";
    explosionCell.alphaRange     = 0.10;
    explosionCell.alphaSpeed     = -1.0;
    explosionCell.lifetime       = 0.7;
    explosionCell.lifetimeRange  = 0.3;
    explosionCell.birthRate      = 0;
    explosionCell.velocity       = 40.00;
    explosionCell.velocityRange  = 10.00;
    explosionCell.scale          = 0.03;
    explosionCell.scaleRange     = 0.02;
    explosionCell.contents       = (id)[UIImage imageNamed:@"Sparkle"].CGImage;
    
    _explosionLayer               = [CAEmitterLayer layer];
    _explosionLayer.name          = @"emitterLayer";
    _explosionLayer.emitterShape  = kCAEmitterLayerCircle;
    _explosionLayer.emitterMode   = kCAEmitterLayerOutline;
    _explosionLayer.emitterSize   = CGSizeMake(10, 0);
    _explosionLayer.emitterCells  = @[explosionCell];
    _explosionLayer.renderMode    = kCAEmitterLayerOldestFirst;
    _explosionLayer.masksToBounds = NO;
    _explosionLayer.position      = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0);
    _explosionLayer.zPosition     = -1;
    [self.view.layer addSublayer:_explosionLayer];
    
    CAEmitterCell *chargeCell = [CAEmitterCell emitterCell];
    chargeCell.name           = @"charge";
    chargeCell.alphaRange     = 0.10;
    chargeCell.alphaSpeed     = -1.0;
    chargeCell.lifetime       = 0.3;
    chargeCell.lifetimeRange  = 0.1;
    chargeCell.birthRate      = 0;
    chargeCell.velocity       = -40.0;
    chargeCell.velocityRange  = 0.00;
    chargeCell.scale          = 0.03;
    chargeCell.scaleRange     = 0.02;
    chargeCell.contents       = (id)[UIImage imageNamed:@"Sparkle"].CGImage;
    
    _chargeLayer               = [CAEmitterLayer layer];
    _chargeLayer.name          = @"emitterLayer";
    _chargeLayer.emitterShape  = kCAEmitterLayerCircle;
    _chargeLayer.emitterMode   = kCAEmitterLayerOutline;
    _chargeLayer.emitterSize   = CGSizeMake(20, 0);
    _chargeLayer.emitterCells  = @[chargeCell];
    _chargeLayer.renderMode    = kCAEmitterLayerOldestFirst;
    _chargeLayer.masksToBounds = NO;
    _chargeLayer.position      = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0);
    _chargeLayer.zPosition     = -1;
    [self.view.layer addSublayer:_chargeLayer];
    
    [self animation];
}

/**
 *  开始动画
 */
- (void)animation {
    //    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    //    if (self.selected) {
    //        animation.values = @[@1.5 ,@0.8, @1.0,@1.2,@1.0];
    //        animation.duration = 0.5;
    [self startAnimate];
    //    }else
    //    {
    //        animation.values = @[@0.8, @1.0];
    //        animation.duration = 0.4;
    //    }
    //    animation.calculationMode = kCAAnimationCubic;
    //    [self.layer addAnimation:animation forKey:@"transform.scale"];
}

/**
 *  开始喷射
 */
- (void)startAnimate {
    //chareLayer开始时间
    self.chargeLayer.beginTime = CACurrentMediaTime();
    //chareLayer每秒喷射的80个
    [self.chargeLayer setValue:@80 forKeyPath:@"emitterCells.charge.birthRate"];
    //进入下一个动作
    [self performSelector:@selector(explode) withObject:nil afterDelay:0.2];
}

/**
 *  大量喷射
 */
- (void)explode {
    //让chareLayer每秒喷射的个数为0个
    [self.chargeLayer setValue:@0 forKeyPath:@"emitterCells.charge.birthRate"];
    //explosionLayer开始时间
    self.explosionLayer.beginTime = CACurrentMediaTime();
    //explosionLayer每秒喷射的2500个
    [self.explosionLayer setValue:@2500 forKeyPath:@"emitterCells.explosion.birthRate"];
    //停止喷射
    [self performSelector:@selector(stop) withObject:nil afterDelay:0.2];
}

/**
 *  停止喷射
 */
- (void)stop {
    //让chareLayer每秒喷射的个数为0个
    [self.chargeLayer setValue:@0 forKeyPath:@"emitterCells.charge.birthRate"];
    //explosionLayer每秒喷射的0个
    [self.explosionLayer setValue:@0 forKeyPath:@"emitterCells.explosion.birthRate"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
