//
//  MyImageClass.h
//  InstaKilo
//
//  Created by Nicholas Fung on 2017-10-18.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface MyImageClass : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSMutableArray *subjectsArr;

@end
