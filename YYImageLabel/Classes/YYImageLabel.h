//
//  YYImageLabel.h
//  YYImageLabel
//
//  Created by HI_LOSER on 2025/5/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, YYImageLabelStyle) {
    YYImageLabelStyleAbove       = 1 << 0,   // 图片在文字上面
    YYImageLabelStyleBelow       = 1 << 1,   // 图片在文字下面
    YYImageLabelStyleLeft        = 1 << 2,   // 图片在文字左面
    YYImageLabelStyleRight       = 1 << 3,   // 图片在文字右面
    YYImageLabelStyleOnlyImage   = 1 << 4,   // 只有图片
    YYImageLabelStyleOnlyTitle   = 1 << 5,   // 只有文字
    YYImageLabelStyleCenter      = 1 << 6    // 居中
};


@interface YYImageLabel : UIView
@property (strong, nonatomic, readonly) UIImageView * imageView;
@property (strong, nonatomic, readonly) UIImageView * backgroundImageView;

@property (assign, nonatomic) YYImageLabelStyle  type;
@property (assign,nonatomic) NSTextAlignment textAlignment;
@property (assign, nonatomic) NSInteger numberOfLines;
@property (assign, nonatomic) UIEdgeInsets contentEdgeInsets;
@property (assign, nonatomic) CGFloat imagePadding;

@property (copy,   nonatomic) NSString * text;
@property (strong, nonatomic) UIFont * font;
@property (strong, nonatomic) UIColor * textColor;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)initWithType:(YYImageLabelStyle)type;
- (void)setLabelContentHuggingPriority:(UILayoutPriority)priority forAxis:(UILayoutConstraintAxis)axis;
- (void)setLabelContentCompressionResistancePriority:(UILayoutPriority)priority forAxis:(UILayoutConstraintAxis)axis;

@end

NS_ASSUME_NONNULL_END
