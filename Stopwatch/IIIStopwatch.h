//
//  IIIStopwatch.h
//  Stopwatch
//
//  Created by Ilgar Ilyasov on 11/27/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IIIStopwatch : NSObject

- (void)start;
- (void)stop;
- (void)reset;

@property (nonatomic, readonly, getter=isRunning) BOOL running;
@property (nonatomic, readonly) NSTimeInterval elapsedTime;

@end

NS_ASSUME_NONNULL_END
