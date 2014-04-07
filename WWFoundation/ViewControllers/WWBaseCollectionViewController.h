//
//  WWCollectionViewController.h
//  WWFoundation
//
//  Created by William Wu on 4/4/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import "WWBaseViewController.h"

@interface WWBaseCollectionViewController : WWBaseViewController

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end
