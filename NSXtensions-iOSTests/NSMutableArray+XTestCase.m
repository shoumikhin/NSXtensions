//
//  NSMutableArray+XTestCase.m
//  NSXtensions
//
//  Created by Petr Korolev on 16/09/14.
//  Copyright (c) 2014 Anthony Shoumikhin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSMutableArray+X.h"

@interface NSMutableArray_XTestCase : XCTestCase

@property(nonatomic, strong) NSMutableArray *mutableArray;
@end

@implementation NSMutableArray_XTestCase
{
    NSMutableArray *_mutableArray;
}

- (void)setUp {
    [super setUp];
    _mutableArray = [NSMutableArray arrayWithArray:@[@0,@1,@2,@3]];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDequeueFromArray {
    [_mutableArray dequeue];
    XCTAssertEqualObjects(_mutableArray[0], @1);
}

- (void)testMoveItem
{
    [_mutableArray moveObjectAtIndex:0 toIndex:2];
    XCTAssertEqualObjects(_mutableArray[2], @0);
    XCTAssertNotEqualObjects(_mutableArray[0], @0);
}

@end
