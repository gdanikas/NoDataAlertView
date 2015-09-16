//
//  DemoViewController.m
//  NoDataAlertViewDemo
//
//  Created by George Danikas on 9/16/15.
//  Copyright (c) 2015 GDanikas. All rights reserved.
//

#import "DemoViewController.h"
#import "NoDataAlertView.h"

@interface DemoViewController ()

@property (weak, nonatomic) IBOutlet NoDataAlertView *noDataAlertView;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Initialize no data alert view
    [self.noDataAlertView initialize];
    
    // Show no data alert view
    [self.noDataAlertView showAlert];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
