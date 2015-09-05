//
//  ILDSNavViewController.m
//  TransitionInteractiveDemo
//
//  Created by mo jun on 9/3/15.
//  Copyright © 2015 kimoworks. All rights reserved.
//

#import "ILDSNavViewController.h"
#import "ILDSNavAnimator.h"

@interface ILDSNavViewController ()

@property (nonatomic, strong) ILDSNavAnimator *animator;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveController;

@end

@implementation ILDSNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    UIScreenEdgePanGestureRecognizer* panRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    panRecognizer.edges = UIRectEdgeLeft;
    panRecognizer.delegate = self;
    [self.view addGestureRecognizer:panRecognizer];
    
    self.animator = [ILDSNavAnimator new];
    
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pan:(UIPanGestureRecognizer*)recognizer
{
    UIView* view = self.view;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:view];
        
        if (location.x <  CGRectGetMidX(view.bounds) && self.viewControllers.count > 1) { // left half
            [self.animator beginInteractiveTransition];
            [self popViewControllerAnimated:YES];
        }
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:view];
        CGFloat d = fabs(translation.x / CGRectGetWidth(view.bounds));
        NSLog(@"d: %@", @(d));
        d = MIN(1, d);
        d = MAX(0, d);
        [self.animator updateInteractiveTransition:d];
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        if ([recognizer velocityInView:view].x > 0) {
            [self.animator finishInteractiveTransition];
        } else {
            [self.animator cancelInteractiveTransition];
        }
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
        return self.animator;
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if ([animationController isKindOfClass:[ILDSNavAnimator class]]) {
        ILDSNavAnimator *controller = (ILDSNavAnimator *)animationController;
        if(controller.isInteractive) {
            return controller;
        } else  {
            return nil;
        }
    }
    return nil;
}

#pragma mark - Gesture Delegate 
- (BOOL)gestureRecognizerShouldBegin:(nonnull UIGestureRecognizer *)gestureRecognizer{
    if (self.viewControllers.count <= 1) {
        return NO;
    }
    
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
