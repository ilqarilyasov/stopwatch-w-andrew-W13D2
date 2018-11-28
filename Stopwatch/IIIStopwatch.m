//
//  IIIStopwatch.m
//  Stopwatch
//
//  Created by Ilgar Ilyasov on 11/27/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import "IIIStopwatch.h"

@interface IIIStopwatch ()

@property (nonatomic, readwrite, getter=isRunning) BOOL running; // private
@property (nonatomic, readwrite) NSTimeInterval elapsedTime; // private

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) NSTimeInterval previouslyAccumulatedTime;

@end

@implementation IIIStopwatch

- (void)start
{
    self.startDate = [NSDate date];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                  target:self
                                                selector:@selector(timerDidFire:)
                                                userInfo:nil
                                                 repeats:YES];
    self.running = YES;
}

- (void)stop
{
    self.previouslyAccumulatedTime = self.elapsedTime;
    self.timer = nil;
    self.startDate = nil;
    self.running = NO;
}

- (void)reset
{
    [self stop];
    self.elapsedTime = 0;
    self.previouslyAccumulatedTime = 0;
}

- (void)timerDidFire:(NSTimer *)timer
{
    //self.elapsedTime += 0.1;
    self.elapsedTime = [[NSDate date] timeIntervalSinceDate:self.startDate] + self.previouslyAccumulatedTime;
}

// MARK: - Properties

- (void)setTimer:(NSTimer *)timer
{
    if (timer != _timer) {
        [_timer invalidate];
        _timer = timer;
    }
}

@end
