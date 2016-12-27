//
//  ViewController.m
//  AnimationExample
//
//  Created by Dimas on 27.12.16.
//  Copyright © 2016 T.D.V.DG. All rights reserved.
//

#import "ViewController.h"
#import "UIView+AnimatedLines.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *panel;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	_panel.layer.cornerRadius = 5;
	
	[_panel animateLinesWithColor:[UIColor redColor].CGColor andLineWidth:2 startPoint:CGPointMake(100, -200) rollToStroke:0.25
			   curveControlPoints:@[[LinesCurvePoints curvePoints:CGPointMake(-50, -2) point2:CGPointMake(60, 5)],[LinesCurvePoints curvePoints:CGPointMake(-60, 10) point2:CGPointMake(100, 5)]] animationDuration:2 ];
	
	
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
