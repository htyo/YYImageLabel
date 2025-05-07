//
//  YYImageLabel.m
//  YYImageLabel
//
//  Created by HI_LOSER on 2025/5/6.
//

#import "YYImageLabel.h"

@interface YYImageLabel ()
@property (weak,   nonatomic) UIView * contentView;
@property (weak,   nonatomic) UILabel * titleLabel;
@property (weak,   nonatomic) UIImageView * imageView;
@property (weak,   nonatomic) UIImageView * backgroundImageView;
@property (assign, nonatomic) YYImageLabelStyle  type;
@end

@implementation YYImageLabel

- (instancetype)initWithType:(YYImageLabelStyle)type {
    self = [super init];
    if (self) {
        self.numberOfLines = 1;
        self.contentEdgeInsets = UIEdgeInsetsZero;
        self.type = type;
        self.imagePadding = 4.0;
        [self loadSubViews];
    }
    return self;
}

- (void) loadSubViews {
    UIImageView * backgroundImageView = [[UIImageView alloc]init];
    backgroundImageView.userInteractionEnabled = YES;
    backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:backgroundImageView];
    self.backgroundImageView = backgroundImageView;

    
    UIView * contentView = [[UIView alloc] init];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:contentView];
    self.contentView = contentView;
    
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.contentMode = UIViewContentModeCenter;
    [contentView addSubview:imageView];
    self.imageView = imageView;
        
    UILabel * titleLabel = [UILabel new];
    [titleLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = self.numberOfLines;
    [contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;

}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.backgroundImageView.topAnchor constraintEqualToAnchor:self.topAnchor constant:0.0].active = YES;
    [self.backgroundImageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0.0].active = YES;
    [self.backgroundImageView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:0.0].active = YES;
    [self.backgroundImageView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:0.0].active = YES;

    [self.imageView.widthAnchor constraintEqualToConstant:self.imageView.image.size.width].active = YES;
    
    if (self.type & YYImageLabelStyleCenter) {
        [self.contentView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:0.0].active = YES;
        [self.contentView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:0.0].active = YES;
    } else {
        [self.contentView.topAnchor constraintEqualToAnchor:self.topAnchor constant:self.contentEdgeInsets.top].active = YES;
        [self.contentView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-self.contentEdgeInsets.bottom].active = YES;
        [self.contentView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:self.contentEdgeInsets.left].active = YES;
        [self.contentView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-self.contentEdgeInsets.right].active = YES;
    }

    if (self.type & YYImageLabelStyleLeft) {
        [self.imageView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor constant:0.0].active = YES;
        [self.imageView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:0.0].active = YES;
        
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:0.0].active = YES;
        [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:0.0].active = YES;
        [self.titleLabel.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:0.0].active = YES;
        [self.titleLabel.leftAnchor constraintEqualToAnchor:self.imageView.rightAnchor constant:self.imagePadding].active = YES;
        
        NSLayoutConstraint *titleLabelHeightConstraint = [self.contentView.heightAnchor constraintGreaterThanOrEqualToAnchor:self.titleLabel.heightAnchor];
        titleLabelHeightConstraint.priority = UILayoutPriorityDefaultLow;
        titleLabelHeightConstraint.active = YES;
                
        NSLayoutConstraint *imageViewHeightConstraint = [self.contentView.heightAnchor constraintGreaterThanOrEqualToAnchor:self.imageView.heightAnchor];
        imageViewHeightConstraint.priority = UILayoutPriorityDefaultLow;
        imageViewHeightConstraint.active = YES;
    }
    
    if (self.type & YYImageLabelStyleRight) {
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:0.0].active = YES;
        [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:0.0].active = YES;
        [self.titleLabel.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:0.0].active = YES;
        
        [self.imageView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor constant:0.0].active = YES;
        [self.imageView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:0.0].active = YES;
        [self.imageView.leftAnchor constraintEqualToAnchor:self.titleLabel.rightAnchor constant:self.imagePadding].active = YES;
        
        NSLayoutConstraint *titleLabelHeightConstraint = [self.contentView.heightAnchor constraintGreaterThanOrEqualToAnchor:self.titleLabel.heightAnchor];
        titleLabelHeightConstraint.priority = UILayoutPriorityDefaultLow;
        titleLabelHeightConstraint.active = YES;
                
        NSLayoutConstraint *imageViewHeightConstraint = [self.contentView.heightAnchor constraintGreaterThanOrEqualToAnchor:self.imageView.heightAnchor];
        imageViewHeightConstraint.priority = UILayoutPriorityDefaultLow;
        imageViewHeightConstraint.active = YES;
    }
    
    if (self.type & YYImageLabelStyleAbove) {
        [self.imageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:0.0].active = YES;
        [self.imageView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor constant:0.0].active = YES;

        [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:0.0].active = YES;
        [self.titleLabel.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:0.0].active = YES;
        [self.titleLabel.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:0.0].active = YES;
        
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.imageView.bottomAnchor constant:self.imagePadding].active = YES;

        NSLayoutConstraint *titleLabelWidthConstraint = [self.contentView.widthAnchor constraintGreaterThanOrEqualToAnchor:self.titleLabel.widthAnchor];
        titleLabelWidthConstraint.priority = UILayoutPriorityDefaultLow;
        titleLabelWidthConstraint.active = YES;
                
        NSLayoutConstraint *imageViewWidthConstraint = [self.contentView.widthAnchor constraintGreaterThanOrEqualToAnchor:self.imageView.widthAnchor];
        imageViewWidthConstraint.priority = UILayoutPriorityDefaultLow;
        imageViewWidthConstraint.active = YES;
    }
    
    if (self.type & YYImageLabelStyleBelow) {
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:0.0].active = YES;
        [self.titleLabel.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:0.0].active = YES;
        [self.titleLabel.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:0.0].active = YES;
        
        [self.imageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:0.0].active = YES;
        [self.imageView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor constant:0.0].active = YES;
                
        [self.imageView.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:self.imagePadding].active = YES;

        NSLayoutConstraint *titleLabelWidthConstraint = [self.contentView.widthAnchor constraintGreaterThanOrEqualToAnchor:self.titleLabel.widthAnchor];
        titleLabelWidthConstraint.priority = UILayoutPriorityDefaultLow;
        titleLabelWidthConstraint.active = YES;
                
        NSLayoutConstraint *imageViewWidthConstraint = [self.contentView.widthAnchor constraintGreaterThanOrEqualToAnchor:self.imageView.widthAnchor];
        imageViewWidthConstraint.priority = UILayoutPriorityDefaultLow;
        imageViewWidthConstraint.active = YES;
    }
    
    if (self.type & YYImageLabelStyleOnlyImage) {
        [self.titleLabel removeFromSuperview];
        [self.imageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:0.0].active = YES;
        [self.imageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:0.0].active = YES;
        [self.imageView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:0.0].active = YES;
        [self.imageView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:0.0].active = YES;
    }
    
    if (self.type & YYImageLabelStyleOnlyTitle) {
        [self.imageView removeFromSuperview];
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:0.0].active = YES;
        [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:0.0].active = YES;
        [self.titleLabel.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:0.0].active = YES;
        [self.titleLabel.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:0.0].active = YES;
    }
    
}


- (void)setText:(NSString *)text {
    _text = text;
    self.titleLabel.text = text;
}

- (void)setNumberOfLines:(NSInteger)numberOfLines {
    _numberOfLines = numberOfLines;
    self.titleLabel.numberOfLines = numberOfLines;
//    [self layoutIfNeeded];
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.titleLabel.font = font;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    self.titleLabel.textAlignment = textAlignment;
}

- (void)setTextColor:(UIColor *)textColor {
    self.titleLabel.textColor = textColor;
}

- (void)setLabelContentHuggingPriority:(UILayoutPriority)priority forAxis:(UILayoutConstraintAxis)axis {
    [self.titleLabel setContentHuggingPriority:priority forAxis:axis];
}

- (void)setLabelContentCompressionResistancePriority:(UILayoutPriority)priority forAxis:(UILayoutConstraintAxis)axis {
    [self.titleLabel setContentCompressionResistancePriority:priority forAxis:axis];
}

@end
