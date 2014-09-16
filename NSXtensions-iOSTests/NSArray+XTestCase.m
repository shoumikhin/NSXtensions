//
//  NSArray+XTestCase.m
//  NSXtensions
//
//  Created by Petr Korolev on 16/09/14.
//  Copyright (c) 2014 Anthony Shoumikhin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSArray+X.h"

@interface NSArray_XTestCase : XCTestCase

@end

@implementation NSArray_XTestCase
{
    NSArray *_array;
}

- (void)setUp {
    [super setUp];
    _array = @[@0,@1,@2,@3];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFilteredArrayPassingTest {
    // This is an example of a functional test case.
    NSArray *passingTestArray = [_array filteredArrayPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        NSNumber *number = obj;
        //return YES in case of even numbers
        return number.integerValue % 2 == 0;
    }];

    BOOL equalToArray = [passingTestArray isEqualToArray:@[@0, @2]];
    XCTAssertTrue(equalToArray);
}

@end
