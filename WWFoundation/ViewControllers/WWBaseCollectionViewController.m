//
//  WWCollectionViewController.m
//  WWFoundation
//
//  Created by William Wu on 4/4/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import "WWBaseCollectionViewController.h"

@interface WWBaseCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation WWBaseCollectionViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [@[] mutableCopy];
    }
    
    return _dataArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.activeScrollView = self.collectionView;
}

- (void)reloadView
{
    [self reloadView:NO];
}

- (void)reloadView:(BOOL)cleanUp
{
    if (cleanUp)
    {
        [self.dataArray removeAllObjects];
    }
    
    [self.collectionView reloadData];
}

- (void)refreshView
{
    self.pageNum = @1;
}

- (void)loadMoreView
{
    self.pageNum = @(self.pageNum.integerValue + 1);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
