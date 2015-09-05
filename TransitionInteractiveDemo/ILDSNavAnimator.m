//
//  ILDSNavAnimator.m
//  TransitionInteractiveDemo
//
//  Created by mo jun on 9/3/15.
//  Copyright © 2015 kimoworks. All rights reserved.
//

#import "ILDSNavAnimator.h"

#define kAnimationDuration 0.25

@interface ILDSNavAnimator (){
    id<UIViewControllerContextTransitioning> _context;
    CGFloat _percentComplete;
}

@end

@implementation ILDSNavAnimator

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
    [containerView insertSubview:toView belowSubview:fromView];
    
    CGRect fromFrame = fromView.frame;
    fromFrame.origin.x = fromFrame.size.width;
    
    CGFloat viewWidth = fromFrame.size.width;
    CGAffineTransform fromEndForm = CGAffineTransformTranslate(CGAffineTransformIdentity, viewWidth, 0);
    CGAffineTransform toStartForm = CGAffineTransformTranslate(CGAffineTransformIdentity, -viewWidth * 1.0f / 3.0f, 0);
    CGAffineTransform toEndForm = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
    toView.transform = toStartForm;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromView.transform = fromEndForm;
        toView.transform = toEndForm;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
//    UIView *snapshot = [modalView snapshotViewAfterScreenUpdates:NO];
//    [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.15 animations:^{
//        //90 degrees (clockwise)
//        snapshot.transform = CGAffineTransformMakeRotation(M_PI * -1.5);
//    }];
}

- (void)animationEnded:(BOOL) transitionCompleted{
    self.interactive = NO;
    _percentComplete = 0;
}

#pragma mark - UIViewControllerInteractiveTransitioning
- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    _context = transitionContext;
    
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    UIView *containerView = [transitionContext containerView];
    
    CGFloat viewWidth = CGRectGetWidth(fromView.frame);
    CGAffineTransform toStartForm = CGAffineTransformTranslate(CGAffineTransformIdentity, -viewWidth * 1.0f / 3.0f, 0);
    toView.transform = toStartForm;
    [containerView insertSubview:toView belowSubview:fromView];
    
}

//- (CGFloat)completionSpeed{
//    return _percentComplete;
//}
//
//- (UIViewAnimationCurve)completionCurve{
//    return UIViewAnimationCurveEaseIn;
//}

#pragma mark - public
- (void)beginInteractiveTransition{
    _percentComplete = 0;
    _interactive = YES;
}
- (void)updateInteractiveTransition:(CGFloat)percentComplete{
    _percentComplete = percentComplete;
    UIView *toView = [_context viewControllerForKey:UITransitionContextToViewControllerKey].view;
    UIView *fromView = [_context viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    CGFloat viewWidth = CGRectGetWidth(fromView.frame);
    
    CGAffineTransform toEndForm = CGAffineTransformTranslate(CGAffineTransformIdentity, -viewWidth * (1.0f - _percentComplete) / 3.0f, 0);
    toView.transform = toEndForm;
    
    CGAffineTransform fromEndForm = CGAffineTransformTranslate(CGAffineTransformIdentity, viewWidth * _percentComplete, 0);
    fromView.transform = fromEndForm;
    [_context updateInteractiveTransition:_percentComplete];
}
- (void)finishInteractiveTransition{
    CGFloat endPercent = 1;
    UIView *toView = [_context viewControllerForKey:UITransitionContextToViewControllerKey].view;
    UIView *fromView = [_context viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    CGFloat viewWidth = CGRectGetWidth(fromView.frame);
    
    CGAffineTransform toEndForm = CGAffineTransformTranslate(CGAffineTransformIdentity, -viewWidth * (1.0f - endPercent) / 3.0f, 0);
    CGAffineTransform fromEndForm = CGAffineTransformTranslate(CGAffineTransformIdentity, viewWidth * endPercent, 0);
    
    [UIView animateWithDuration:kAnimationDuration * (1 - _percentComplete) delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toView.transform = toEndForm;
        fromView.transform = fromEndForm;
    } completion:^(BOOL finished) {
        [_context finishInteractiveTransition];
        [_context completeTransition:YES];
    }];
    
    _percentComplete = 1;
    _interactive = NO;
}
- (void)cancelInteractiveTransition{
    CGFloat endPercent = 0;
    
    UIView *toView = [_context viewControllerForKey:UITransitionContextToViewControllerKey].view;
    UIView *fromView = [_context viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    CGFloat viewWidth = CGRectGetWidth(fromView.frame);
    
    CGAffineTransform toEndForm = CGAffineTransformTranslate(CGAffineTransformIdentity, viewWidth * (1.0f - endPercent) / 3.0f, 0);
    CGAffineTransform fromEndForm = CGAffineTransformTranslate(CGAffineTransformIdentity, viewWidth * endPercent, 0);
    [UIView animateWithDuration:kAnimationDuration * _percentComplete delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toView.transform = toEndForm;
        fromView.transform = fromEndForm;
    } completion:^(BOOL finished) {
        [_context cancelInteractiveTransition];
        [_context completeTransition:NO];
    }];
    _percentComplete = 0;
    _interactive = NO;
}

@end
