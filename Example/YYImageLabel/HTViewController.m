//
//  HTViewController.m
//  YYImageLabel
//
//  Created by htyo on 05/07/2025.
//  Copyright (c) 2025 htyo. All rights reserved.
//

#import "HTViewController.h"
#import "YYImageLabel/YYImageLabel.h"
#import "Masonry/Masonry.h"

@interface HTViewController ()

@end

@implementation HTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    /// 图片在文字左边
    YYImageLabel * imageLabelLeft = [[YYImageLabel alloc] initWithType:YYImageLabelStyleLeft];
    imageLabelLeft.imageView.image = [UIImage imageNamed:@"11111"];
    imageLabelLeft.text = @"图片在文字左边";
    imageLabelLeft.textColor = UIColor.redColor;
    [self.view addSubview:imageLabelLeft];
    
    [imageLabelLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0.0);
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
    
    
}

@end
