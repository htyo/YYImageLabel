//
//  YYImageLabel.m
//  YYImageLabel
//
//  Created by HI_LOSER on 2025/5/6.
//

#import "YYImageLabel.h"

static const CGFloat YYImageLabelDefaultPadding = 4.0;
static void *YYImageLabelImageContext = &YYImageLabelImageContext;

@interface YYImageLabel ()
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic, readwrite) UIImageView *imageView;
@property (strong, nonatomic, readwrite) UIImageView *backgroundImageView;
@property (assign, nonatomic) YYImageLabelStyle type;
@property (strong, nonatomic) NSArray<NSLayoutConstraint *> *edgeConstraints;
@property (strong, nonatomic) NSArray<NSLayoutConstraint *> *centerConstraints;
@property (strong, nonatomic) NSArray<NSLayoutConstraint *> *styleConstraints;
@property (strong, nonatomic) NSLayoutConstraint *contentTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *contentBottomConstraint;
@property (strong, nonatomic) NSLayoutConstraint *contentLeadingConstraint;
@property (strong, nonatomic) NSLayoutConstraint *contentTrailingConstraint;
@end

@implementation YYImageLabel

- (instancetype)initWithType:(YYImageLabelStyle)type {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _numberOfLines = 1;
        _contentEdgeInsets = UIEdgeInsetsZero;
        _type = type;
        _imagePadding = YYImageLabelDefaultPadding;
        _font = [UIFont boldSystemFontOfSize:14.0];
        _textColor = UIColor.blackColor;
        _textAlignment = NSTextAlignmentCenter;
        [self loadSubViews];
        [self buildConstraints];
    }
    return self;
}

- (void)dealloc {
    [self.imageView removeObserver:self forKeyPath:@"image" context:YYImageLabelImageContext];
}

- (void)loadSubViews {
    UIImageView *backgroundImageView = [[UIImageView alloc] init];
    backgroundImageView.userInteractionEnabled = YES;
    backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:backgroundImageView];
    self.backgroundImageView = backgroundImageView;

    UIView *contentView = [[UIView alloc] init];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:contentView];
    self.contentView = contentView;

    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.contentMode = UIViewContentModeCenter;
    [imageView addObserver:self forKeyPath:@"image" options:0 context:YYImageLabelImageContext];
    [contentView addSubview:imageView];
    self.imageView = imageView;

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.font = self.font;
    titleLabel.textColor = self.textColor;
    titleLabel.textAlignment = self.textAlignment;
    titleLabel.numberOfLines = self.numberOfLines;
    [titleLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
}

- (void)buildConstraints {
    [NSLayoutConstraint activateConstraints:@[
        [self.backgroundImageView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.backgroundImageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.backgroundImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.backgroundImageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor]
    ]];

    self.contentTopConstraint = [self.contentView.topAnchor constraintEqualToAnchor:self.topAnchor constant:self.contentEdgeInsets.top];
    self.contentBottomConstraint = [self.contentView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-self.contentEdgeInsets.bottom];
    self.contentLeadingConstraint = [self.contentView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:self.contentEdgeInsets.left];
    self.contentTrailingConstraint = [self.contentView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-self.contentEdgeInsets.right];
    self.edgeConstraints = @[
        self.contentTopConstraint,
        self.contentBottomConstraint,
        self.contentLeadingConstraint,
        self.contentTrailingConstraint
    ];
    self.centerConstraints = @[
        [self.contentView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [self.contentView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor]
    ];

    if (self.type & YYImageLabelStyleCenter) {
        [NSLayoutConstraint activateConstraints:self.centerConstraints];
    } else {
        [NSLayoutConstraint activateConstraints:self.edgeConstraints];
    }

    self.styleConstraints = [self constraintsForCurrentStyle];
    [NSLayoutConstraint activateConstraints:self.styleConstraints];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if (context == YYImageLabelImageContext) {
        [self invalidateIntrinsicContentSize];
        [self setNeedsLayout];
        return;
    }

    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

- (NSArray<NSLayoutConstraint *> *)constraintsForCurrentStyle {
    if (self.type & YYImageLabelStyleOnlyImage) {
        self.titleLabel.hidden = YES;
        return @[
            [self.imageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
            [self.imageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
            [self.imageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
            [self.imageView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor]
        ];
    }

    if (self.type & YYImageLabelStyleOnlyTitle) {
        self.imageView.hidden = YES;
        return @[
            [self.titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
            [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
            [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
            [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor]
        ];
    }

    self.imageView.hidden = NO;
    self.titleLabel.hidden = NO;

    if (self.type & YYImageLabelStyleRight) {
        return @[
            [self.titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
            [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
            [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
            [self.imageView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
            [self.imageView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
            [self.imageView.leadingAnchor constraintEqualToAnchor:self.titleLabel.trailingAnchor constant:self.imagePadding],
            [self.contentView.heightAnchor constraintGreaterThanOrEqualToAnchor:self.titleLabel.heightAnchor],
            [self.contentView.heightAnchor constraintGreaterThanOrEqualToAnchor:self.imageView.heightAnchor]
        ];
    }

    if (self.type & YYImageLabelStyleAbove) {
        return @[
            [self.imageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
            [self.imageView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],
            [self.titleLabel.topAnchor constraintEqualToAnchor:self.imageView.bottomAnchor constant:self.imagePadding],
            [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
            [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
            [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
            [self.contentView.widthAnchor constraintGreaterThanOrEqualToAnchor:self.titleLabel.widthAnchor],
            [self.contentView.widthAnchor constraintGreaterThanOrEqualToAnchor:self.imageView.widthAnchor]
        ];
    }

    if (self.type & YYImageLabelStyleBelow) {
        return @[
            [self.titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
            [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
            [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
            [self.imageView.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:self.imagePadding],
            [self.imageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
            [self.imageView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],
            [self.contentView.widthAnchor constraintGreaterThanOrEqualToAnchor:self.titleLabel.widthAnchor],
            [self.contentView.widthAnchor constraintGreaterThanOrEqualToAnchor:self.imageView.widthAnchor]
        ];
    }

    return @[
        [self.imageView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [self.imageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
        [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor constant:self.imagePadding],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
        [self.contentView.heightAnchor constraintGreaterThanOrEqualToAnchor:self.titleLabel.heightAnchor],
        [self.contentView.heightAnchor constraintGreaterThanOrEqualToAnchor:self.imageView.heightAnchor]
    ];
}

- (CGSize)intrinsicContentSize {
    CGSize imageSize = self.imageView.hidden ? CGSizeZero : self.imageView.intrinsicContentSize;
    if (imageSize.width == UIViewNoIntrinsicMetric || imageSize.height == UIViewNoIntrinsicMetric) {
        imageSize = CGSizeZero;
    }

    CGSize titleSize = CGSizeZero;
    if (!self.titleLabel.hidden && self.titleLabel.text.length > 0) {
        CGFloat maxWidth = self.titleLabel.numberOfLines == 1 ? CGFLOAT_MAX : UIScreen.mainScreen.bounds.size.width;
        titleSize = [self.titleLabel sizeThatFits:CGSizeMake(maxWidth, CGFLOAT_MAX)];
    }

    BOOL hasImage = imageSize.width > 0.0 && imageSize.height > 0.0;
    BOOL hasTitle = titleSize.width > 0.0 && titleSize.height > 0.0;
    CGFloat spacing = (hasImage && hasTitle) ? self.imagePadding : 0.0;
    CGSize contentSize = CGSizeZero;

    if (self.type & YYImageLabelStyleOnlyImage) {
        contentSize = imageSize;
    } else if (self.type & YYImageLabelStyleOnlyTitle) {
        contentSize = titleSize;
    } else if ((self.type & YYImageLabelStyleAbove) || (self.type & YYImageLabelStyleBelow)) {
        contentSize = CGSizeMake(MAX(imageSize.width, titleSize.width), imageSize.height + spacing + titleSize.height);
    } else {
        contentSize = CGSizeMake(imageSize.width + spacing + titleSize.width, MAX(imageSize.height, titleSize.height));
    }

    contentSize.width += self.contentEdgeInsets.left + self.contentEdgeInsets.right;
    contentSize.height += self.contentEdgeInsets.top + self.contentEdgeInsets.bottom;
    return contentSize;
}

- (void)setText:(NSString *)text {
    _text = [text copy];
    self.titleLabel.text = text;
    [self invalidateIntrinsicContentSize];
}

- (void)setNumberOfLines:(NSInteger)numberOfLines {
    _numberOfLines = numberOfLines;
    self.titleLabel.numberOfLines = numberOfLines;
    [self invalidateIntrinsicContentSize];
}

- (void)setFont:(UIFont *)font {
    _font = font ?: [UIFont boldSystemFontOfSize:14.0];
    self.titleLabel.font = _font;
    [self invalidateIntrinsicContentSize];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    self.titleLabel.textAlignment = textAlignment;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor ?: UIColor.blackColor;
    self.titleLabel.textColor = _textColor;
}

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets {
    _contentEdgeInsets = contentEdgeInsets;
    self.contentTopConstraint.constant = contentEdgeInsets.top;
    self.contentBottomConstraint.constant = -contentEdgeInsets.bottom;
    self.contentLeadingConstraint.constant = contentEdgeInsets.left;
    self.contentTrailingConstraint.constant = -contentEdgeInsets.right;
    [self invalidateIntrinsicContentSize];
}

- (void)setImagePadding:(CGFloat)imagePadding {
    if (_imagePadding == imagePadding) {
        return;
    }

    _imagePadding = imagePadding;
    [NSLayoutConstraint deactivateConstraints:self.styleConstraints];
    self.styleConstraints = [self constraintsForCurrentStyle];
    [NSLayoutConstraint activateConstraints:self.styleConstraints];
    [self invalidateIntrinsicContentSize];
}

- (void)setLabelContentHuggingPriority:(UILayoutPriority)priority forAxis:(UILayoutConstraintAxis)axis {
    [self.titleLabel setContentHuggingPriority:priority forAxis:axis];
}

- (void)setLabelContentCompressionResistancePriority:(UILayoutPriority)priority forAxis:(UILayoutConstraintAxis)axis {
    [self.titleLabel setContentCompressionResistancePriority:priority forAxis:axis];
}

@end
