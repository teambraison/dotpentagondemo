//
//  KeyboardViewController.m
//  DotDemo
//
//  Created by Titus Cheng on 12/12/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import "KeyboardViewController.h"

#define GROUP1 [NSArray arrayWithObjects:@"a", @"b", @"c", @"d", @"e", @"f", nil]
#define GROUP2 [NSArray arrayWithObjects:@"g", @"h", @"i", @"j", @"k", @"l", nil]
#define GROUP3 [NSArray arrayWithObjects:@"m", @"n", @"o", @"p", @"q", @"r", nil]
#define GROUP4 [NSArray arrayWithObjects:@"s", @"t", @"u", @"v", @"w", @"x", nil]
#define GROUP5 [NSArray arrayWithObjects:@"y", @"z", @"1", @"2", @"3", @"4", nil]
#define GROUP6 [NSArray arrayWithObjects:@"5", @"6", @"7", @"8", @"9", @"0", nil]
//#define GROUP7 [NSArray arrayWithObjects:@"y", @"z", @",", @".", nil]

#define INIT_X 16
#define ITEM_HEIGHT 150
#define ITEM_WIDTH 136



@interface KeyboardViewController ()
{
    NSArray *section1;
    NSArray *section2;
    NSArray *section3;
    NSArray *section4;
    NSArray *sections;
    NSMutableArray *allViews;
    BOOL firstTap;
    BOOL isUppercase;
}


@end

@implementation KeyboardViewController

@synthesize outputText, delegate, key;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    outputText.layer.cornerRadius = 6.0f;
    outputText.layer.masksToBounds = true;
    
    section1 = [NSArray arrayWithObjects:GROUP1, GROUP2, nil];
    section2 = [NSArray arrayWithObjects:GROUP3, GROUP4, nil];
    section3 = [NSArray arrayWithObjects:GROUP5, GROUP6, nil];
//    section4 = [NSArray arrayWithObjects:GROUP7, nil];
    
    UISwipeGestureRecognizer *changeKeys = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(switchKeys)];
    changeKeys.numberOfTouchesRequired = 1;
    changeKeys.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:changeKeys];
    
    UISwipeGestureRecognizer *delete = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(deleteOneCharacter)];
    delete.direction = UISwipeGestureRecognizerDirectionLeft;
    delete.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:delete];
    
    sections = [NSArray arrayWithObjects:section1, section2, section3, section4, nil];
    allViews = [[NSMutableArray alloc] init];
    
    outputText.delegate = self;
    
    firstTap = false;
    isUppercase = false;
    
    
    // Do any additional setup after loading the view.
    //Section 1
    int frames[2] = {INIT_X, INIT_X + ITEM_WIDTH + INIT_X};
    int k = 0;
    for(int i = 85; i < 440; i += 158)
    {
        if(k < 4) {
            [self populateKeyPad:frames AndYCoordinate:i AndKeyText:sections[k]];
            k++;
        }
    }
    
    [self clearTextField];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [self clearTextField];
}

- (void)clearTextField
{
    outputText.text = @"";
}

- (void)deleteOneCharacter
{
    if(outputText.text.length > 0){
     outputText.text = [outputText.text substringToIndex:outputText.text.length - 1];   
    }
}

- (void)returnToPreviousScreen
{
    if(key != nil) {
        [delegate keyboardViewDidFinishInput:outputText.text WithKey:key];
    }
    [self dismissViewControllerAnimated:true completion:nil];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return false;
}

- (void)populateKeyPad:(int[])frames AndYCoordinate:(int)y_coord AndKeyText:(NSArray *)sourceText
{
    for(int i = 0; i < 2; i++) {
        UITapGestureRecognizer *selectionTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedTap:)];
        selectionTap.numberOfTapsRequired = 1;
        selectionTap.numberOfTouchesRequired = 1;
        
        UITapGestureRecognizer *chooseTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedTap:)];
        chooseTap.numberOfTouchesRequired = 1;
        chooseTap.numberOfTapsRequired = 1;
    
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"KeyItemView" owner:self options:nil];
        CGRect newFrame = CGRectMake(frames[i], y_coord, ITEM_WIDTH, ITEM_HEIGHT);
        KeyItemView *theView = [nib objectAtIndex:0];
        theView.frame = newFrame;
        NSArray *alllabels = theView.items;
        for(int k = 0; k < alllabels.count; k++) {
            UILabel *l = alllabels[k];
            l.text = [[sourceText objectAtIndex:i] objectAtIndex:k];
        }
        [theView.focusedLabel addGestureRecognizer:selectionTap];
        [allViews addObject:theView];
        [self.view addSubview:theView];
    }
}

- (void)switchKeys
{
    if(!isUppercase) {
        isUppercase = true;
        for(int i = 0; i < allViews.count; i++) {
            KeyItemView *aView = allViews[i];
            if(firstTap) {
                aView.focusedLabel.text = [aView.focusedLabel.text uppercaseString];
            } else {
                for(int k = 0; k < aView.items.count; k++) {
                    UILabel *l = [aView.items objectAtIndex:k];
                    l.text = [l.text uppercaseString];
                }
            }
        }
    } else {
        for(int i = 0; i < allViews.count; i++) {
            KeyItemView *aView = allViews[i];
            if(firstTap) {
                aView.focusedLabel.text = [aView.focusedLabel.text lowercaseString];
            } else {
                for(int k = 0; k < aView.items.count; k++) {
                    UILabel *l = [aView.items objectAtIndex:k];
                    l.text = [l.text lowercaseString];
                }
            }
        }
        isUppercase = false;
        
    }
}

- (void)selectedTap:(UIGestureRecognizer *)tap
{
    KeyItemView *theView = (KeyItemView *)tap.view.superview;
    if(!firstTap) {
        firstTap = true;
        NSArray *allLabels = theView.items;
        for(int i = 0; i < allViews.count; i++) {
            theView = allViews[i];
            UILabel *theLabel = allLabels[i];
            [theView focusOnText:theLabel.text];
        }
    } else {
        NSLog(@"Going to insert %@", theView.focusedLabel.text);
        outputText.text = [outputText.text stringByAppendingString:theView.focusedLabel.text];
    //    [outputText replaceRange:[outputText selectedTextRange] withText:theView.focusedLabel.text];
        for(int i = 0; i < allViews.count; i++) {
            KeyItemView *myView = [allViews objectAtIndex:i];
            [myView deFocus];
        }
        firstTap = false;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
