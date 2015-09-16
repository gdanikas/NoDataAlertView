//
//  NoDataAlertView.h
//  DiG
//
//  Created by George Danikas on 5/14/15.
//  Copyright (c) 2015 Intelen. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE @interface NoDataAlertView : UIView

@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UIView *circleContainter;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *circleImgRelHeightConstr;
@property (nonatomic) CGFloat circleImgRelHeightConstrValue;
@property (weak, nonatomic) IBOutlet UIView *leftLineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLineSpaceConstr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightLineSpaceConstr;
@property (nonatomic) CGFloat linesSpaceConstrValue;
@property (weak, nonatomic) IBOutlet UILabel *messageLbl;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

- (void)initialize;
- (void)showAlert;
- (void)hideAlertAnimated:(BOOL)animate;
- (void)hideWithNoInitialize;
- (BOOL)isAlertVisible;

- (void)setImage:(UIImage *)image;
- (void)setMessage:(NSString *)message;
@end
