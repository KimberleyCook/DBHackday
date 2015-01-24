//
//  CustomButton.m
//  DBHack
//
//  Created by Kimberley Cook on 23/01/2015.
//  Copyright (c) 2015 Kimberley Cook. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [[self layer] setBorderWidth:2.0f];
        [[self layer] setBorderColor:[UIColor whiteColor].CGColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
