//
//  PlaygroundController.m
//  AirTurnExample
//
//  Created by Nick Brook on 29/04/2015.
//  Copyright (c) 2015 AirTurn. All rights reserved.
//

#import "PlaygroundController.h"
#import "NBPopoverController.h"

@interface PlaygroundController() <UIToolbarDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textView;

@property(nonatomic, strong) NBPopoverController *pc;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation PlaygroundController

- (void)awakeFromNib {
    [super awakeFromNib];
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        self.pc = [[NBPopoverController alloc] initWithContentViewController:[[UIViewController alloc] init]];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    /*
     When a modal view is dismissed, if there is no external keyboard connected but a text view is first responder, after the modal view is dismissed the AirTurn framework will indicate an external keyboard has been connected. This is because for some reason, UIKit dismisses the keyboard before resigning first responder. To avoid this problem, resign first responder before the view disappears.
     */
    [self.textView resignFirstResponder];
    [self.searchBar resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (IBAction)showPopover:(UIButton *)sender {
    [self.pc presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}
- (IBAction)tap:(id)sender {
    [self.textView resignFirstResponder];
    [self.searchBar resignFirstResponder];
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}

@end
