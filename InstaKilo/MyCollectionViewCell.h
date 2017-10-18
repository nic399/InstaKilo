//
//  MyCollectionViewCell.h
//  InstaKilo
//
//  Created by Nicholas Fung on 2017-10-18.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *imageName;

@end
