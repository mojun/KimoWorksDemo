//
//  INavPushLikePresentAnimator.m
//  TransitionInteractiveDemo
//
//  Created by mojun on 15/11/5.
//  Copyright © 2015年 kimoworks. All rights reserved.
//

#import "INavPushLikePresentAnimator.h"

#define kAnimationDuration 0.35

@implementation INavPushLikePresentAnimator

#pragma mark - UIViewControllerAnimatedTransitioning
// This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return kAnimationDuration;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    UIView *containerView = [transitionContext containerView];
    
    
    
    
    
    if (self.push) {
        [containerView addSubview:toView];
        CGRect fromFrame = fromView.frame;
        CGFloat viewHeight = fromFrame.size.height;
        fromFrame.origin.y = viewHeight;
        
        CGAffineTransform toStartForm = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, viewHeight);
        CGAffineTransform toEndForm = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
        toView.transform = toStartForm;
        
        [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewKeyframeAnimationOptionOverrideInheritedDuration animations:^{
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.75 animations:^{
                toView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, viewHeight * 0.5f);
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.20 animations:^{
                toView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -5);
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.95 relativeDuration:0.05 animations:^{
                toView.transform = toEndForm;
            }];
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    } else {
        [containerView insertSubview:toView belowSubview:fromView];
        CGRect fromFrame = fromView.frame;
        CGFloat viewHeight = fromFrame.size.height;
        CGAffineTransform fromEndForm = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, viewHeight);
        [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewKeyframeAnimationOptionOverrideInheritedDuration animations:^{
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.75 animations:^{
                fromView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, viewHeight * 0.5f);
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.25 animations:^{
                fromView.transform = fromEndForm;
            }];
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    }
}

@end
