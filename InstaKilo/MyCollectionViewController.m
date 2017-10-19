//
//  MyCollectionViewController.m
//  InstaKilo
//
//  Created by Nicholas Fung on 2017-10-18.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MyCollectionReusableView.h"
#import "MyCollectionViewCell.h"
#import "DetailViewController.h"
#import "MyImageClass.h"
#import "CustomCollectionReusableView.h"

@interface MyCollectionViewController ()

@property (nonatomic, strong) NSMutableArray<NSString *> *imagesNameArr;
@property (nonatomic, strong) NSMutableArray<MyImageClass *> *myImageObjectsArr;
@property (nonatomic, strong) NSMutableArray<NSString *> *locationsArr;
@property (nonatomic, strong) NSMutableArray<NSString *> *subjectsArr;
@property (nonatomic, strong) NSMutableArray<NSMutableArray *> *dataSourceArr;
@property (nonatomic, strong) UISegmentedControl *sortViewBy;

@end

typedef enum : NSUInteger {
    Subject,
    Location
} sortParameterEnum;

@implementation MyCollectionViewController

static NSString * const reuseIdentifier = @"Cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //[self.collectionView registerClass:[MyCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyHeader"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CustomCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyHeader"];
    // Do any additional setup after loading the view.
    
    self.imagesNameArr = [NSMutableArray new];
    self.myImageObjectsArr = [NSMutableArray new];
    self.locationsArr = [NSMutableArray new];
    self.subjectsArr = [NSMutableArray new];
    self.dataSourceArr = [NSMutableArray new];
    
    UISegmentedControl *sortViewBy = [[UISegmentedControl alloc] initWithItems:@[@"Subject", @"Location"]];
    [sortViewBy addTarget:self action:@selector(sortParameterChanged:) forControlEvents:UIControlEventValueChanged];
    sortViewBy.selectedSegmentIndex = 0;
    self.navigationItem.titleView = sortViewBy;
    self.sortViewBy = sortViewBy;
    
    for (int i = 0; i < 42; i++) {
        [self.imagesNameArr addObject:[NSString stringWithFormat:@"picture%d", i]];
        MyImageClass *myImage = [MyImageClass new];
        myImage.name = self.imagesNameArr[i];
        myImage.location = [self assignLocation:i%5];
        [myImage.subjectsArr addObject:[self assignSubject:i%3]];
        myImage.image = [UIImage imageNamed:self.imagesNameArr[i]];
        [self.myImageObjectsArr addObject:myImage];
    }
    
    
    
    for (int i = 0; i < [self.myImageObjectsArr count]; i++) {
        
        // Populate locationsArr with one element for each unique location tag in the array of myImageObjectsArr
        BOOL locationExists = false;
        for (int j = 0; j < [self.locationsArr count]; j++) {
            if ([self.locationsArr[j] isEqualToString:self.myImageObjectsArr[i].location]) {
                locationExists = true;
            }
        }
        if (!locationExists) {
            [self.locationsArr addObject:self.myImageObjectsArr[i].location];
        }
        
        // Populate subjectsArr with one element for each unique subject tag in the array of myImageObjectsArr
        BOOL subjectExists = false;
        for (int j = 0; j < [self.subjectsArr count]; j++) {
            if ([self.subjectsArr[j] isEqualToString:self.myImageObjectsArr[i].subjectsArr[0]]) {
                subjectExists = true;
            }
        }
        if (!subjectExists) {
            [self.subjectsArr addObject:self.myImageObjectsArr[i].subjectsArr[0]];
        }
    }
    
    [self sortImagesBy:Subject];
    
    
}

-(void)sortParameterChanged:(UISegmentedControl *)sender {
    NSLog(@"Currently selected segment index is %ld", (long)sender.selectedSegmentIndex);
    [self sortImagesBy:sender.selectedSegmentIndex];
}

-(void)sortImagesBy:(sortParameterEnum)sortParameter {
    NSLog(@"Sorting by %ld", sortParameter);
    
    self.dataSourceArr = [NSMutableArray new];
    NSLog(@"dataSourceArr emptied");
    switch (sortParameter) {
        case 0: // sort by 'Subject'
            // create new arrays in the dataSourceArr (one for each subject)
            for (int i = 0; i < [self.subjectsArr count]; i++) {
                self.dataSourceArr[i] = [NSMutableArray new];
            }
            // add each image to the dataSourceArr
            for (int i = 0; i < [self.myImageObjectsArr count]; i++) {
                for (int j = 0; j < [self.subjectsArr count]; j++) {
                    if ([self.subjectsArr[j] isEqualToString:self.myImageObjectsArr[i].subjectsArr[0]]) {
                        [self.dataSourceArr[j] addObject:self.myImageObjectsArr[i]];
                        break;
                    }
                }
            }
            
            break;
            
        case 1: // sort by 'Location'
            // create new arrays in the dataSourceArr (one for each subject)
            for (int i = 0; i < [self.locationsArr count]; i++) {
                self.dataSourceArr[i] = [NSMutableArray new];
            }
            // add each image to the dataSourceArr
            for (int i = 0; i < [self.myImageObjectsArr count]; i++) {
                for (int j = 0; j < [self.locationsArr count]; j++) {
                    if ([self.locationsArr[j] isEqualToString:self.myImageObjectsArr[i].location]) {
                        [self.dataSourceArr[j] addObject:self.myImageObjectsArr[i]];
                        break;
                    }
                }
            }
            
            break;
            
        default:
            NSLog(@"Unknown sorting parameter selected");
            break;
    }
    NSLog(@"Sorting Complete");
    [self.collectionView reloadData];
}

-(NSString *)assignLocation:(int)input {
    switch (input) {
        case 0:
            return @"Vancouver";
        case 1:
            return @"New York";
        case 2:
            return @"London";
        case 3:
            return @"Hong Kong";
        case 4:
            return @"Jerusalem";
        default:
            return @"No Location";
    }
}

-(NSString *)assignSubject:(int)input {
    switch (input) {
        case 0:
            return @"Sadness";
        case 1:
            return @"Demotivation";
        case 2:
            return @"Despair";
        default:
            return @"No Subject";
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSInteger numOfSections = 0;
    switch (self.sortViewBy.selectedSegmentIndex) {
        case 0:
            numOfSections = [self.subjectsArr count];
            break;
            
        case 1:
            numOfSections = [self.locationsArr count];
            break;
            
        default:
            NSLog(@"Unable to identify proper number of sections");
            numOfSections = 1;
            break;
    }
    return numOfSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSourceArr[section] count];
    //return [self.imagesNameArr count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Section: %d, Row: %d", indexPath.section, indexPath.row);
    
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];

    // Configure the cell
//    cell.imageView.image = [UIImage imageNamed:self.imagesNameArr[indexPath.row]];
//    cell.imageName.text = self.imagesNameArr[indexPath.row];
    NSArray<MyImageClass *> *sectionArr = self.dataSourceArr[indexPath.section];
    MyImageClass *cellImageClassObject = sectionArr[indexPath.row];

    cell.imageView.image = cellImageClassObject.image;
    cell.imageName.text = cellImageClassObject.name;
    
    
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Creating supplement view");
    MyCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyHeader" forIndexPath:indexPath];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        NSLog(@"creating header");
        
        if (self.sortViewBy.selectedSegmentIndex == 0) {
            NSLog(@"set to %@, indexPath.section: %ld current text %@", self.subjectsArr[indexPath.section], (long)indexPath.section, headerView.titleLabel.text);
            headerView.titleLabel.text = self.subjectsArr[indexPath.section];
        }
        else if (self.sortViewBy.selectedSegmentIndex == 1) {
            NSLog(@"1");
            headerView.titleLabel.text = self.locationsArr[indexPath.section];
        }
        
        NSLog(@"HeaderView creation complete, title: %@", headerView.titleLabel.text);
        
        return headerView;
    }
    
    return [UIView new];
}


#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showDetail" sender:[self.collectionView cellForItemAtIndexPath:indexPath]];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"preparing for sugue");
    MyCollectionViewCell *myCell = sender;
    DetailViewController *destinationController = segue.destinationViewController;
    destinationController.detailImage = myCell.imageView.image;
}




/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
 return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 
 }
 */

@end
