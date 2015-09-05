//
//  ILDSNavAnimator.h
//  TransitionInteractiveDemo
//
//  Created by mo jun on 9/3/15.
//  Copyright © 2015 kimoworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ILDSNavAnimator : NSObject<UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning>

@property (nonatomic, assign, getter=isInteractive) BOOL interactive;

- (void)beginInteractiveTransition;
- (void)updateInteractiveTransition:(CGFloat)percentComplete;
- (void)finishInteractiveTransition;
- (void)cancelInteractiveTransition;

@end
