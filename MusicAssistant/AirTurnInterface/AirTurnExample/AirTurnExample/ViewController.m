//
//  ViewController.m
//  AirTurnExample
//
//  Created by Nick Brook on 11/08/2014.
//  Copyright (c) 2014 AirTurn. All rights reserved.
//

/*
 
 This is the main AirTurn View Controller.
 
 To test background operation, first connect to an airturn, then kill the App using the button provided (to demonstrate the situation when the App is killed by the system when in the background), then press a pedal on the AirTurn.  You will notice music in the iPod starts playing, this has been triggered by this example App.
 
 To support background operation in your own App, simply tick 'Uses Bluetooth LE devices' in the project Capabilities tab.
 
 */

#define AirTurnPlayPauseiPod (1 && !TARGET_IPHONE_SIMULATOR)

#import "ViewController.h"
#import "PortLabel.h"

#import <AirTurnInterface/AirTurnInterface.h>
#import "AirTurnUIConnectionController.h"

#if AirTurnPlayPauseiPod
@import MediaPlayer;
#endif

@interface ViewController () <UIPopoverPresentationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (strong, nonatomic) IBOutletCollection(PortLabel) NSArray *portLabels;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIImageView *connectedLED;

- (IBAction)killApp:(id)sender;

- (void)AirTurnEvent:(NSNotification *)notification;
- (void)viewTapped:(UITapGestureRecognizer *)gr;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // To be notified of button events, add an object as an observer of the button event to NSNotificationCenter.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AirTurnEvent:) name:AirTurnPedalPressNotification object:nil];
    
    self.connectedLED.highlighted = [AirTurnManager sharedManager].isConnected;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectionStateChanged:) name:AirTurnConnectionStateChangedNotification object:nil];
    
    // add the tap gesture to exit the text field
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    gr.numberOfTapsRequired = 1; gr.numberOfTouchesRequired = 1;
    gr.cancelsTouchesInView = NO; gr.delaysTouchesBegan = NO;
    [self.view addGestureRecognizer:gr];
}

- (void)dealloc {
    // remove as an observer
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Airturn

- (IBAction)killApp:(id)sender {
    kill(getpid(), SIGKILL);
}

- (void)AirTurnEvent:(NSNotification *)notification {
    AirTurnPort pedal = [notification.userInfo[AirTurnPortNumberKey] intValue];
    if(pedal == AirTurnPortInvalid) return;
    
    PortLabel *curLab = self.portLabels[pedal-1];
    [curLab highlight];
    
#if AirTurnPlayPauseiPod
    if([AirTurnCentral backgroundOperationEnabled]) {
        MPMusicPlayerController *ipod = [MPMusicPlayerController systemMusicPlayer];
        if(ipod.nowPlayingItem == nil) {
            // pick a random song to play
            MPMediaQuery *query = [MPMediaQuery songsQuery];
            [ipod setQueueWithQuery:query];
            MPMediaItem *item = query.items[arc4random_uniform((u_int32_t)query.items.count)];
            ipod.nowPlayingItem = item;
        }
        if(pedal == AirTurnPort1) {
            [ipod play];
        } else if(pedal == AirTurnPort3) {
            [ipod pause];
        }
    }
#endif
}

- (void)connectionStateChanged:(NSNotification *)notification {
    AirTurnConnectionState state = [notification.userInfo[AirTurnConnectionStateKey] intValue];
    self.connectedLED.highlighted = state == AirTurnConnectionStateConnected;
}

- (BOOL)AirTurnUIRequestsDisplay:(AirTurnUIConnectionController *)connectionController {
    [self performSegueWithIdentifier:@"AirTurnUI" sender:self.settingsButton];
    return YES;
}

#pragma mark - Other bits

- (void)viewTapped:(UITapGestureRecognizer *)gr {
    if(!CGRectContainsPoint(self.textField.frame, [gr locationInView:self.view])) {
        [self.textField resignFirstResponder];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // make the AirTurnUIConnectionController handle its presentation in a popover
    UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
    if([nav respondsToSelector:@selector(popoverPresentationController)]) {
        nav.popoverPresentationController.delegate = self;
    }
    [super prepareForSegue:segue sender:sender];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationFullScreen;
}

- (UIViewController *)presentationController:(UIPresentationController *)controller viewControllerForAdaptivePresentationStyle:(UIModalPresentationStyle)style {
    if([controller.presentedViewController isKindOfClass:[UINavigationController class]]) {
        // add a "Done" button to the parent navigation controller
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", @"AirTurn UI dismiss button in nav controller") style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
        UINavigationController *nc = (UINavigationController *)controller.presentedViewController;
        nc.topViewController.navigationItem.leftBarButtonItem = bbi;
    }
    return controller.presentedViewController;
}

-(IBAction)exit:(UIStoryboardSegue *)segue {
}

@end
