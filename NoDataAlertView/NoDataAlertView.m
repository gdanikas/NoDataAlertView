//
//  NoDataAlertView.m
//  DiG
//
//  Created by George Danikas on 5/14/15.
//  Copyright (c) 2015 Intelen. All rights reserved.
//

#import "NoDataAlertView.h"

@interface NoDataAlertView ()

@property (strong, nonatomic) UIView *containerView;
@property (nonatomic) IBInspectable UIImage *image;
@property (nonatomic) IBInspectable NSString *message;
@end

@implementation NoDataAlertView

- (void)setImage:(UIImage *)image {
    _image = image;
    self.iconImageView.image = image;
}

- (void)setMessage:(NSString *)message {
    _message = message;
    self.messageLbl.text = message;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupNib];
        self.alpha = 0.0;
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        [self setupNib];
        self.alpha = 0.0;
    }
    
    return self;
}

- (void)setupNib {
    _containerView = [self loadViewFromNib];

    // use bounds not frame or it'll be offset
    _containerView.frame = self.bounds;
    
    // Make the view stretch with containing view
    _containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    // Adding custom subview on top of our view (over any custom drawing > see note below)
    [self addSubview:_containerView];
    [self setNeedsUpdateConstraints];
}

- (UIView *)loadViewFromNib {
    UINib *nib = [UINib nibWithNibName:@"NoDataAlertView" bundle:[NSBundle mainBundle]];
    
    // Assumes UIView is top level and only object in xib file
    UIView *view = (UIView *)[nib instantiateWithOwner:self options:nil][0];
    return view;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)initialize {
    self.alpha = 0.0;
    
    // Store constraint values
    self.linesSpaceConstrValue = self.leftLineSpaceConstr.constant;
    
    // Minimize circle icon image
    // Consider formula: view1.attr1 = multiplier × view2.attr2 + constant, we can animate constant and NOT multiplier,
    // so we should play with constant for bounce fx of icon: Constant is -multiplier*container.height (no icon height) and
    // constant is zero for full size icon height
    self.circleImgRelHeightConstr.constant = - (self.circleImgRelHeightConstr.multiplier * self.circleContainter.bounds.size.height) + 1.0;
    
    // Minimize left / right lines
    self.leftLineSpaceConstr.constant = self.linesSpaceConstrValue + self.leftLineView.bounds.size.width - 1;
    self.rightLineSpaceConstr.constant = self.linesSpaceConstrValue + self.leftLineView.bounds.size.width - 1;
    
    // Make rounded circle cont
    //Create mask
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.bounds = self.circleContainter.bounds;
    maskLayer.position = CGPointMake(self.circleContainter.bounds.size.width/2.0f, self.circleContainter.bounds.size.height/2.0f);
    UIBezierPath *currentMaskPath = [UIBezierPath bezierPathWithOvalInRect:self.circleContainter.bounds];
    maskLayer.path = [currentMaskPath CGPath];
    maskLayer.fillColor = [[UIColor blackColor] CGColor];
    self.circleContainter.layer.mask = maskLayer;
    self.circleContainter.layer.masksToBounds = YES;
    
    // Hide alert message label
    self.messageLbl.alpha = 0.0;
    [self.container layoutIfNeeded];
}

- (void)showAlert {
    // Show It, start with fade in of view
    if (self.alpha == 0.0) {
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 1.0;
        } completion:^(BOOL finished) {
            // Then animate lines
            self.leftLineSpaceConstr.constant = self.linesSpaceConstrValue;
            self.rightLineSpaceConstr.constant = self.linesSpaceConstrValue;
            [UIView animateWithDuration:0.5 animations:^{
                [self.container layoutIfNeeded];
            } completion:^(BOOL finished) {
                // Then bounce circle icon
                // Magnify icon 20% of its actual height
                self.circleImgRelHeightConstr.constant = self.circleImgRelHeightConstr.multiplier * self.circleContainter.bounds.size.height * 0.2;
                [UIView animateWithDuration:0.3 animations:^{
                    [self.container layoutIfNeeded];
                } completion:^(BOOL finished) {
                    // Back to its actual height
                    self.circleImgRelHeightConstr.constant = 0.0;
                    [UIView animateWithDuration:0.3 animations:^{
                        [self.container layoutIfNeeded];
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.5 animations:^{
                            self.messageLbl.alpha = 1.0;
                        }];
                    }];
                }];
            }];
        }];
    }
}

- (void)hideAlertAnimated:(BOOL)animated {
    if (self.alpha == 1.0) {
        if (animated) {
            // Hide it and initialize it (for the next showing animation)
            [UIView animateWithDuration:0.3 animations:^{
                self.alpha = 0.0;
            } completion:^(BOOL finished) {
                [self initialize];
            }];
        } else {
            self.alpha = 0.0;
            [self initialize];
        }
    }
}

- (void)hideWithNoInitialize {
  self.alpha = 0.0;
}

- (BOOL)isAlertVisible {
  return (self.alpha > 0.01) ? YES : NO;
}

@end
