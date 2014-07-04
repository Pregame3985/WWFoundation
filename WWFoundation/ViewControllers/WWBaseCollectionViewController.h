//
//  WWCollectionViewController.h
//  WWFoundation
//
//  Created by William Wu on 4/4/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import "WWBaseViewController.h"

typedef NS_ENUM(NSInteger, CollectionViewScrollingDirection)
{
    CollectionViewScrollingDirectionNone = 0,
    CollectionViewScrollingDirectionUp,
    CollectionViewScrollingDirectionDown,
};

@interface WWBaseCollectionViewController : WWBaseViewController

@property (nonatomic, unsafe_unretained) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSNumber *pageNum;
@property (nonatomic, weak) UITableView *currentCollectionView;

- (void)reloadView;
- (void)reloadView:(BOOL)cleanUp;
- (void)refreshView;
- (void)loadMoreView;

@end
