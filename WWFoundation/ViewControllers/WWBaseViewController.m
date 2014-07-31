//
//  WWBaseViewController.m
//  WWFoundation
//
//  Created by William Wu on 4/4/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import "WWBaseViewController.h"

@interface WWBaseViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) UIToolbar *editInputAccessoryView;

@end

@implementation WWBaseViewController

@synthesize editInputAccessoryView = _editInputAccessoryView;

- (void)dealloc
{
    self.activeTextView = nil;
    self.activeTextField = nil;
    self.activeScrollView = nil;
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
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    [self applyStyle];
    
    [self prepareData];
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

- (void)applyStyle
{
    self.view.backgroundColor = [UIColor appBackgroundColor];
    
    NSArray *viewControllers = [self.navigationController viewControllers];
    
    if (self != viewControllers[0])
    {
        
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_navi_back_48_48"]
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(back:)];
        
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    }
}

- (void)prepareData
{}

- (void)reloadView
{}

- (void)reloadView:(BOOL)cleanUp
{}

- (void)refreshView
{}

- (void)popViewController
{
    if (self.navigationController)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)back:(UIButton *)sender
{
    [self popViewController];
}

- (IBAction)cancel:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.observeKeyboard)
    {
        [self registerForKeyboardNotifications];
    }
}

- (void) viewWillDisappear:(BOOL)animated
{
    if (self.observeKeyboard)
    {
        [self unregisterForKeyboardNotifications];
    }
    
    [super viewWillDisappear:animated];
}

- (UIView *)editInputAccessoryView
{
    if (!_editInputAccessoryView)
    {
        _editInputAccessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.sizeW, 44.0f)];
        
        UIBarButtonItem *flexibleBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self
                                                                              action:@selector(resigenKeyBoard)];
        _editInputAccessoryView.items = @[flexibleBar, right];
    }
    
    return _editInputAccessoryView;
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)unregisterForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.activeTextField)
    {
        [self.activeTextField resignFirstResponder];
    }
    
    if (self.activeTextView)
    {
        [self.activeTextView resignFirstResponder];
    }
}

- (void) keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = self.activeScrollView.contentInset;
    contentInsets.bottom = kbSize.height;
    
    //    UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.activeScrollView.scrollIndicatorInsets = contentInsets;
    self.activeScrollView.contentInset = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.activeScrollView.frame;
    aRect.size.height -= kbSize.height;
    CGPoint point = [self.activeTextField convertPoint:self.activeTextField.bounds.origin toView:self.activeScrollView];
    CGRect rect = [self.activeTextField convertRect:self.activeTextField.bounds toView:self.activeScrollView];
    
    if (!CGRectContainsPoint(aRect, point))
    {
        [self.activeScrollView scrollRectToVisible:rect animated:YES];
    }
}

- (void) keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = self.activeScrollView.contentInset;
    contentInsets.bottom -= kbSize.height;
    
    //    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.activeScrollView.contentInset = contentInsets;
    self.activeScrollView.scrollIndicatorInsets = contentInsets;
}

- (void) resigenKeyBoard
{
    if (self.activeTextField)
    {
        [self.activeTextField resignFirstResponder];
    }
    else if (self.activeTextView)
    {
        [self.activeTextView resignFirstResponder];
    }
    else if (self.activeSearchBar)
    {
        [self.activeSearchBar resignFirstResponder];
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeTextField = textField;
    
    if (self.observeKeyboard)
    {
        if (!self.activeTextField.inputAccessoryView)
        {
            self.activeTextField.inputAccessoryView = self.editInputAccessoryView;
        }
    }
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.activeTextView = textView;
    
    if (self.observeKeyboard)
    {
        self.activeTextView.inputAccessoryView = self.editInputAccessoryView;
    }
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.activeSearchBar = searchBar;
    
    if (self.observeKeyboard)
    {
        self.activeSearchBar.inputAccessoryView = self.editInputAccessoryView;
    }
    
}

@end
