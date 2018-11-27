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

// MARK: - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.stopwatch = [[IIIStopwatch alloc] init];
    [self updateViews];
}

// MARK: - Actions

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

// MARK: - Private

- (void)updateViews
{
    self.timeLabel.text = [self stringFromTimeInterval:self.stopwatch.elapsedTime];
    
    if (self.stopwatch.isRunning) {
        [self.startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
    } else {
        [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
    }
    
    self.resetButton.enabled = self.stopwatch.elapsedTime > 0;
}

- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval
{
    NSInteger timeIntervalAsInt = (NSInteger)interval;
    NSInteger tenths = (NSInteger)((interval - floor(interval)) * 10);
    NSInteger seconds = timeIntervalAsInt % 60;
    NSInteger minutes = (timeIntervalAsInt / 60) % 60;
    NSInteger hours = (timeIntervalAsInt / 3600);
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld.%ld", (long)hours, (long)minutes, (long)seconds, (long)tenths];
}

@end
