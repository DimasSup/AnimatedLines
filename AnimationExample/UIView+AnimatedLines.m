//
//  UIView+AnimatedLines.m
//  AnimationExample
//
//  Created by Dimas on 27.12.16.
//  Copyright © 2016 T.D.V.DG. All rights reserved.
//

#import "UIView+AnimatedLines.h"
#import <objc/runtime.h>

static const char * const LAYER_PRO_NAME = "ANIMATED_LINE_LAYER";

@implementation LinesCurvePoints

+(instancetype)curvePoints:(CGPoint)point1 point2:(CGPoint)point2
{
	LinesCurvePoints* point = [LinesCurvePoints new];
	point.controlPoint1 = point1;
	point.controlPoint1 = point2;
	return point;
}

@end
@implementation UIView (AnimatedLines)
-(void)animateLinesWithColor:(CGColorRef)lineColor andLineWidth:(CGFloat)lineWidth startPoint:(CGPoint)startFromPoint rollToStroke:(CGFloat)rollToStroke curveControlPoints:(NSArray<LinesCurvePoints*>*)curvePoints animationDuration:(CGFloat)duration

{
	CAShapeLayer* layer = objc_getAssociatedObject(self, LAYER_PRO_NAME);
	if(layer)
	{
		[layer removeFromSuperlayer];
		objc_setAssociatedObject(self,  LAYER_PRO_NAME, nil, OBJC_ASSOCIATION_RETAIN);
	}
	
	CAShapeLayer* animateLayer = [CAShapeLayer layer];
	animateLayer.lineCap = kCALineCapRound;
	animateLayer.lineJoin = kCALineJoinBevel;
	animateLayer.fillColor   = [[UIColor clearColor] CGColor];
	animateLayer.lineWidth   = lineWidth;
	animateLayer.strokeEnd   = 0.0;
	
	UIBezierPath* path = [UIBezierPath new];
	[path setLineWidth:1.0];
	[path setLineCapStyle:kCGLineCapRound];
	[path setLineJoinStyle:kCGLineJoinRound];
	
	
	
	CGRect bounds = self.layer.bounds;
	CGFloat radius = self.layer.cornerRadius;
	CGPoint zeroPoint = bounds.origin;
	
	
	
	
	BOOL isRounded = radius>0;
	
	if(isRounded)
	{
		zeroPoint.x = bounds.origin.x+radius;
	}
	
	[path moveToPoint:startFromPoint];
	
	long c = curvePoints.count;
	for (long i =1; i<=c; i++)
	{
		float nX = startFromPoint.x + (zeroPoint.x - startFromPoint.x)/(c)*i;
		float nY = startFromPoint.y +(zeroPoint.y - startFromPoint.y)/(c)*i;
		
		
		LinesCurvePoints* point = curvePoints[i-1];
		
		
		[path addCurveToPoint:CGPointMake(nX, nY) controlPoint1:CGPointMake(nX+point.controlPoint1.x,nY+point.controlPoint1.y) controlPoint2:CGPointMake(nX+ point.controlPoint2.y,nY+ point.controlPoint2.y)];
		
	}
	
	[path moveToPoint:zeroPoint];
	
	CGPoint nextPoint = CGPointMake(bounds.size.width, 0);
	if(isRounded)
	{
		nextPoint.x-=radius;
	}
	[path addLineToPoint:nextPoint];
	if(isRounded)
	{
		[path addArcWithCenter:CGPointMake(nextPoint.x, nextPoint.y+radius) radius:radius startAngle:-M_PI_2 endAngle:0 clockwise:YES];
	}
	
	nextPoint = CGPointMake(bounds.size.width, bounds.size.height);
	if(isRounded)
	{
		nextPoint.y-=radius;
	}
	[path addLineToPoint:nextPoint];
	if (isRounded)
	{
		[path addArcWithCenter:CGPointMake(nextPoint.x-radius, nextPoint.y) radius:radius startAngle:0 endAngle:M_PI_2 clockwise:YES];
	}
	
	nextPoint = CGPointMake(0, bounds.size.height);
	if(isRounded)
	{
		nextPoint.x +=radius;
	}
	[path addLineToPoint:nextPoint];
	if (isRounded)
	{
		[path addArcWithCenter:CGPointMake(nextPoint.x, nextPoint.y-radius) radius:radius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
	}
	
	nextPoint = CGPointMake(0, 0);
	if(isRounded)
	{
		nextPoint.y +=radius;
	}
	[path addLineToPoint:nextPoint];
	if (isRounded)
	{
		[path addArcWithCenter:CGPointMake(nextPoint.x+radius, nextPoint.y) radius:radius startAngle:M_PI endAngle:-M_PI_2 clockwise:YES];
	}
	
	animateLayer.path = path.CGPath;
	animateLayer.strokeColor = lineColor;
	
	objc_setAssociatedObject(self,  LAYER_PRO_NAME, animateLayer, OBJC_ASSOCIATION_RETAIN);

	[self.layer addSublayer:animateLayer];
	
	
	
	CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
	pathAnimation.duration = duration;
	pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
	pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
	pathAnimation.autoreverses = NO;
	[animateLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
	
	animateLayer.strokeEnd = 1.0;
	
	pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
	pathAnimation.duration = duration*1.2;
	
	
	
	pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
	pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
	pathAnimation.toValue = [NSNumber numberWithFloat:rollToStroke];
	pathAnimation.autoreverses = NO;
	
	
	[animateLayer addAnimation:pathAnimation forKey:@"strokeStartAnimation"];
	animateLayer.strokeStart = rollToStroke;

	
}
@end
