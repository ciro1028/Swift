//
//  PortLabel.m
//  AirTurnExample
//
//  Created by Nick Brook on 02/01/2012.
//  Copyright (c) 2012 Nick Brook. All rights reserved.
//

#import "PortLabel.h"

@interface PortLabel()


@property(nonatomic, strong) NSTimer *timer;

- (void)setup;
- (void)deselectLabel;

@end

@implementation PortLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    if(!self.highlightedTextColor) {
        self.highlightedTextColor = [UIColor colorWithRed:0 green:0.5 blue:1 alpha:1];
    }
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 5;
    self.layer.masksToBounds = NO;
}

- (void)highlight {
    if(_timer == nil) {
        self.highlighted = YES;
        self.layer.shadowColor = self.highlightedTextColor.CGColor;
        self.layer.shadowOpacity = 1.0;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(deselectLabel) userInfo:nil repeats:NO];
}

- (void)deselectLabel {
    self.highlighted = NO;
    self.layer.shadowOpacity = 0.0;
    self.timer = nil;
}

- (void)setTimer:(NSTimer *)timer {
    [_timer invalidate];
    _timer = timer;
}

@end
