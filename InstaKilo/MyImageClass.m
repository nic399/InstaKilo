//
//  MyImageClass.m
//  InstaKilo
//
//  Created by Nicholas Fung on 2017-10-18.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import "MyImageClass.h"

@implementation MyImageClass

-(instancetype)init {
    self = [super init];
    if (self) {
        _subjectsArr = [NSMutableArray new];
        _name = @"";
        _location = @"";
        _image = [UIImage new];
    }
    return self;
}

@end
