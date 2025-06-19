//
//  YYImageLabel.m
//  YYImageLabel
//
//  Created by HI_LOSER on 2025/5/6.
//

#import "YYImageLabel.h"

@interface YYImageLabel ()
@property (strong, nonatomic) UIView * contentView;
@property (strong, nonatomic) UILabel * titleLabel;
@property (strong, nonatomic) UIImageView * imageView;
@property (strong, nonatomic) UIImageView * backgroundImageView;
@end

@implementation YYImageLabel

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc]init];
        _backgroundImageView.userInteractionEnabled = YES;
        _backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _backgroundImageView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _contentView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.contentMode = UIViewContentModeCenter;
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel= [[UILabel alloc] init];
        [_titleLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        [_titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

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

- (void)awakeFromNib{
    [super awakeFromNib];
    [self loadSubViews];
}

- (void)loadSubViews {
    [self addSubview:self.backgroundImageView];

    [self addSubview:self.contentView];
    
    [self.contentView addSubview:self.imageView];
    
    self.titleLabel.numberOfLines = self.numberOfLines;
    [self.contentView addSubview:self.titleLabel];
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

-(void)setType:(YYImageLabelStyle)type{
    _type = type;
}

- (void)setText:(NSString *)text {
    _text = text;
    self.titleLabel.text = text;
}

- (void)setNumberOfLines:(NSInteger)numberOfLines {
    _numberOfLines = numberOfLines;
    self.titleLabel.numberOfLines = numberOfLines;
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
