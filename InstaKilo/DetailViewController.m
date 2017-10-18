//
//  DetailViewController.m
//  ImageGallery
//
//  Created by Nicholas Fung on 2017-10-16.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *detailImageView = [[UIImageView alloc] initWithImage:self.detailImage];
    detailImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.scrollView addSubview:detailImageView];
    
    [detailImageView.leftAnchor constraintEqualToAnchor:self.scrollView.leftAnchor].active = true;
    [detailImageView.rightAnchor constraintEqualToAnchor:self.scrollView.rightAnchor].active = true;
    [detailImageView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor].active = true;
    [detailImageView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor].active = true;

    self.scrollView.minimumZoomScale = 0.15;
    self.scrollView.maximumZoomScale = 4.0;
    self.scrollView.zoomScale = 0.15;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.scrollView.zoomScale = 0.15;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.scrollView.subviews.firstObject;
}

@end
