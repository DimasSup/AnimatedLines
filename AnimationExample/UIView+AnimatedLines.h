//
//  UIView+AnimatedLines.h
//  AnimationExample
//
//  Created by Dimas on 27.12.16.
//  Copyright © 2016 T.D.V.DG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LinesCurvePoints : NSObject
@property(nonatomic,assign)CGPoint controlPoint1;
@property(nonatomic,assign)CGPoint controlPoint2;
+(instancetype)curvePoints:(CGPoint)point1 point2:(CGPoint)point2;
@end

@interface UIView (AnimatedLines)
-(void)animateLinesWithColor:(CGColorRef)lineColor andLineWidth:(CGFloat)lineWidth startPoint:(CGPoint)startFromPoint rollToStroke:(CGFloat)rollToStroke curveControlPoints:(NSArray<LinesCurvePoints*>*)curvePoints animationDuration:(CGFloat)duration;
@end
