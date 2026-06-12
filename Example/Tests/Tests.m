//
//  YYImageLabelTests.m
//  YYImageLabelTests
//
//  Created by htyo on 05/07/2025.
//  Copyright (c) 2025 htyo. All rights reserved.
//

@import XCTest;
#import "YYImageLabel/YYImageLabel.h"

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    YYImageLabel *label = [[YYImageLabel alloc] initWithType:YYImageLabelStyleLeft];
    label.text = @"Title";
    label.textColor = UIColor.redColor;
    label.contentEdgeInsets = UIEdgeInsetsMake(1.0, 2.0, 3.0, 4.0);
    label.imagePadding = 8.0;

    XCTAssertEqual(label.type, YYImageLabelStyleLeft);
    XCTAssertEqualObjects(label.text, @"Title");
    XCTAssertEqualObjects(label.textColor, UIColor.redColor);
    XCTAssertEqual(label.imagePadding, 8.0);
    XCTAssertTrue(label.intrinsicContentSize.width > 0.0);
}

- (void)testChangingTypeUpdatesLayout
{
    YYImageLabel *label = [[YYImageLabel alloc] initWithType:YYImageLabelStyleLeft];
    label.text = @"Title";

    label.type = YYImageLabelStyleOnlyTitle;
    XCTAssertEqual(label.type, YYImageLabelStyleOnlyTitle);
    XCTAssertTrue(label.intrinsicContentSize.width > 0.0);

    UIImage *image = [[UIImage alloc] init];
    label.imageView.image = image;
    label.type = YYImageLabelStyleOnlyImage;
    XCTAssertEqual(label.type, YYImageLabelStyleOnlyImage);

    label.type = YYImageLabelStyleRight | YYImageLabelStyleCenter;
    XCTAssertEqual(label.type, (YYImageLabelStyleRight | YYImageLabelStyleCenter));
    XCTAssertNoThrow([label layoutIfNeeded]);
}

@end
