//
//  IIIStopwatchViewController.m
//  Stopwatch
//
//  Created by Ilgar Ilyasov on 11/27/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import "IIIStopwatchViewController.h"
#import "IIIStopwatch.h"

void *KVOContext = &KVOContext; // Andrew's pattern for KVO. Always use this with KVO

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
}

- (void)dealloc
{
    self.stopwatch = nil;
}

// MARK: - Actions

- (IBAction)reset:(id)sender
{
    [self.stopwatch reset];
}

- (IBAction)startOrStop:(id)sender
{
    if (self.stopwatch.isRunning) {
        [self.stopwatch stop];
    } else {
        [self.stopwatch start];
    }
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

// MARK: - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOContext) {
        [self updateViews];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


// MARK: -Properties

- (void)setStopwatch:(IIIStopwatch *)stopwatch
{
    if (stopwatch != _stopwatch) {
        [_stopwatch removeObserver:self forKeyPath:@"running" context:KVOContext];
        [_stopwatch removeObserver:self forKeyPath:@"elapsedTime" context:KVOContext];
        
        _stopwatch = stopwatch;
        
        [_stopwatch addObserver:self
                     forKeyPath:@"running"
                        options:NSKeyValueObservingOptionInitial
                        context:KVOContext];
        [_stopwatch addObserver:self
                     forKeyPath:@"elapsedTime"
                        options:NSKeyValueObservingOptionInitial
                        context:KVOContext];
    }
}

@end
