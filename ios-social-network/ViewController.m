//
//  ViewController.m
//  ios-social-network
//
//  Created by Mac on 4/20/19.
//  Copyright © 2019 senapps. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (weak, nonatomic) IBOutlet UITextView *facebookTextView;
@property (weak, nonatomic) IBOutlet UITextView *moreTextView;

- (void) configureTweetTextView: (UITextView *) textView;
- (void) showAlertMessage: (NSString *) myMessage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureTweetTextView: self.tweetTextView];
    [self configureTweetTextView: self.facebookTextView];
    [self configureTweetTextView: self.moreTextView];
}

- (void) showAlertMessage: (NSString *) myMessage {
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:@"TwitterShare" message:myMessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Okay" style: UIAlertActionStyleDefault handler: nil];
    [alertController addAction: okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)postToTweeter:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        // Tweet out the tweet
        SLComposeViewController *twitterVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        if ( [self.tweetTextView.text length] < 140) {
            [twitterVC setInitialText:self.tweetTextView.text];
        } else {
            NSString *shortText = [self.tweetTextView.text substringToIndex:140];
            [twitterVC setInitialText: shortText];
        }
        
        [self presentViewController:twitterVC animated:YES completion:nil];
    } else {
        // Raise some kind of objection
        [self showAlertMessage:@"Please sign in to twitter before you tweet"];
    }
}
- (IBAction)postToFacebook:(id)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *facebookVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [facebookVC setInitialText:self.tweetTextView.text];
        [self presentViewController:facebookVC animated:YES completion:nil];
        
    } else {
        [self showAlertMessage:@"Please sign in to Facebook"];
    }
}
- (IBAction)postMore:(id)sender {
    UIActivityViewController *moreVC = [[UIActivityViewController alloc] initWithActivityItems:@[self.tweetTextView.text] applicationActivities:nil];
    [self presentViewController:moreVC animated:YES completion:nil];
}
- (IBAction)doNothing:(id)sender {
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:@"SocialShare" message:@"This doesn't do anything" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Okay" style: UIAlertActionStyleDefault handler: nil];
    [alertController addAction: okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) configureTweetTextView: (UITextView *) textView {
    textView.layer.backgroundColor = [UIColor colorWithRed: 1.0 green:1.0 blue:0.9 alpha:1.0].CGColor;
    textView.layer.cornerRadius = 10.0;
    textView.layer.borderColor = [UIColor colorWithWhite:0 alpha: 0.5].CGColor;
    textView.layer.borderWidth = 2.0;
}
@end
