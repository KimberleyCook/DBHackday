//
//  ViewController.m
//  DBHack
//
//  Created by Kimberley Cook on 23/01/2015.
//  Copyright (c) 2015 Kimberley Cook. All rights reserved.
//

#import "ViewController.h"
#import "CustomButton.h"

@interface ViewController ()

@property (nonatomic, strong) UIColor *selectedColor;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.photoImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.photoImageView];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *colors = @[ [UIColor blackColor], [UIColor grayColor], [UIColor brownColor], [UIColor orangeColor], [UIColor redColor], [UIColor blueColor], [UIColor purpleColor], [UIColor greenColor]];
    
    int xPosition = 20;
    int yIncrement = 125;
    int width = 30;
    int height = 30;
    
    for (UIColor *color in colors) {
        CustomButton *button = [CustomButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:color];
        button.layer.cornerRadius = 25;
        [button setFrame:CGRectMake(xPosition, yIncrement, width, height)];
        [button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        yIncrement += 40;
    }

}

-(void)pressButton:(UIButton *)button
{
    self.selectedColor = button.backgroundColor;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.lastDraggedPoint = [[[touches allObjects] firstObject] locationInView:self.photoImageView];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    UIGraphicsBeginImageContext(self.photoImageView.frame.size);
    [self.photoImageView.image drawInRect:self.photoImageView.bounds];
    
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeCopy);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 10.0f);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), self.selectedColor.CGColor);
    
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _lastDraggedPoint.x, _lastDraggedPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    self.photoImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _lastDraggedPoint = currentPoint;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
