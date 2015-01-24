//
//  ViewController.m
//  DBHack
//
//  Created by Kimberley Cook on 23/01/2015.
//  Copyright (c) 2015 Kimberley Cook. All rights reserved.
//

#import "ViewController.h"
#import "CustomButton.h"
#import "NewImageViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) NSNumber *brushWidth;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.photoImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    self.photoImageView.image = [UIImage imageNamed:@"selfie.jpg"];
    [self.view addSubview:self.photoImageView];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *colors = @[ [UIColor blackColor], [UIColor whiteColor], [UIColor grayColor], [UIColor brownColor], [UIColor orangeColor], [UIColor blueColor], [UIColor redColor], [UIColor magentaColor], [UIColor purpleColor], [UIColor yellowColor], [UIColor greenColor]];
    
    NSArray *brushWidths = @[@10.0f, @15.0f, @20.0f];
    
    int xColourPosition = 20; //left
    int xBrushPosition = 725; //left
    int yIncrement = 125; //top
    int width = 30;
    int height = 30;
    
    for (UIColor *color in colors) {
        CustomButton *button = [CustomButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:color];
        button.layer.cornerRadius = 25;
        [button setFrame:CGRectMake(xColourPosition, yIncrement, width, height)];
        [button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        yIncrement += 40;
    }

    for (NSNumber *brushWidth in brushWidths) {
        CustomButton *button = [CustomButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor blackColor]];
        [button setFrame:CGRectMake(xBrushPosition, yIncrement, [brushWidth floatValue], [brushWidth floatValue])];
        [button addTarget:self action:@selector(widthButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        yIncrement +=40;
    }
    
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(400, 100, 100, 40)];
    [saveButton setTitle:@"Save me" forState:UIControlStateNormal];
    [saveButton setBackgroundColor:[UIColor redColor]];
    [saveButton addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:saveButton];

}

-(void)pressButton:(UIButton *)button
{
    self.selectedColor = button.backgroundColor;
}

-(void)widthButtonPressed:(UIButton *)button
{
    self.brushWidth = [NSNumber numberWithFloat:CGRectGetWidth(button.frame)];
}

-(void)saveImage
{
    UIImage *newImage = self.photoImageView.image;
    
    NewImageViewController *newImageController = [[NewImageViewController alloc] init];
    newImageController.photoImage = newImage;
    [self.navigationController pushViewController:newImageController animated:YES];
    
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
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), [self.brushWidth floatValue]);
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
