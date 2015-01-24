//
//  NewImageViewController.m
//  DBHack
//
//  Created by Kimberley Cook on 24/01/2015.
//  Copyright (c) 2015 Kimberley Cook. All rights reserved.
//

#import "NewImageViewController.h"
#import "ViewController.h"

@interface NewImageViewController ()

@property (nonatomic, strong) UIImageView *photoImageView;

@end

@implementation NewImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.photoImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    self.photoImageView.image = self.photoImage;
    [self.view addSubview:self.photoImageView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
