//
//  IIIStopwatchViewController.m
//  Stopwatch
//
//  Created by Ilgar Ilyasov on 11/27/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import "IIIStopwatchViewController.h"
#import "IIIStopwatch.h"

@interface IIIStopwatchViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *startStopButton;

@property (nonatomic, strong) IIIStopwatch *stopwatch;

@end

@implementation IIIStopwatchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.stopwatch = [[IIIStopwatch alloc] init];
}

- (IBAction)reset:(id)sender
{
    if (self.stopwatch.isRunning) {
        [self.stopwatch stop];
    } else {
        [self.stopwatch start];
    }
}

- (IBAction)startOrStop:(id)sender
{
    [self.stopwatch reset];
}

@end
