//
//  UserContext.m
//  ImIn 프로젝트에서 기본 형식만 가져옴.
//
//  Created by choipd on 10. 4. 13..
//  Copyright 2010 kth. All rights reserved.
//

#import "UserContext.h"

@implementation UserContext

//
// singleton stuff
//
static UserContext *_sharedUserContext = nil;

+ (UserContext *)sharedUserContext
{
	@synchronized([UserContext class])
	{
		if (!_sharedUserContext) {
			[[self alloc] initWithDefault];
		}
		return _sharedUserContext;
	}
	// to avoid compiler warning
	return nil;
}

+ (id)alloc
{
	@synchronized([UserContext class])
	{
		NSAssert(_sharedUserContext == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedUserContext = [super alloc];
		return _sharedUserContext;
	}
	// to avoid compiler warning
	return nil;
}


- (id) initWithDefault {
	self = [super init];
	if (self != nil) {
//		vcCallStack = [[NSMutableArray alloc] initWithCapacity:20];
//		self.feedCounter = [[[FeedCounter alloc] init] autorelease];
    }
	return self;
}

#pragma mark - Wating View

- (void) startWaitView: (NSInteger) yDeltaPos
{
	if( nil == waitV ) {
		UIWindow* mainWindow = [[UIApplication sharedApplication] keyWindow];
		waitV = [[WaitView alloc] initWithFrame:CGRectMake(mainWindow.frame.size.width/2-60, (mainWindow.frame.size.height/2)+yDeltaPos,120,50)];

        [waitV setAlpha:0.0];
        [waitV setTransform:CGAffineTransformMakeScale(1.5, 1.5)];
		[mainWindow addSubview:waitV];

        [UIView animateWithDuration:0.4 animations:^(void) {
            [waitV setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
            [waitV setAlpha:1.0];
        } completion:^(BOOL finished) {
            ;
        }];
	}
}

- (void) stopWaitView
{
	if( waitV ){
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView animateWithDuration:0.3 animations:^(void) {
            [waitV setAlpha:0.0];
            [waitV setTransform:CGAffineTransformMakeScale(1.5, 1.5)];
        } completion:^(BOOL finished) {
            [waitV removeFromSuperview];
        }];
		waitV = nil;
	}
}

@end
