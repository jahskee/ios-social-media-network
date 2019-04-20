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
    [self configureTweetTextView: self.tweetTextView color1:1.0 color2:1.0 color3:0.9];
    [self configureTweetTextView: self.facebookTextView color1:1.0 color2:0.9 color3:1.0];
    [self configureTweetTextView: self.moreTextView color1:0.9 color2:1.0 color3:1.0];
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
        [facebookVC setInitialText:self.facebookTextView.text];
        [self presentViewController:facebookVC animated:YES completion:nil];
        
    } else {
        [self showAlertMessage:@"Please sign in to Facebook"];
    }
}
- (IBAction)postMore:(id)sender {
    UIActivityViewController *moreVC = [[UIActivityViewController alloc] initWithActivityItems:@[self.moreTextView.text] applicationActivities:nil];
    [self presentViewController:moreVC animated:YES completion:nil];
}
- (IBAction)doNothing:(id)sender {
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:@"SocialShare" message:@"This doesn't do anything" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Okay" style: UIAlertActionStyleDefault handler: nil];
    [alertController addAction: okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) configureTweetTextView: (UITextView *) textView color1:(float)color1 color2: (float)color2 color3:(float)color3{
    textView.layer.backgroundColor = [UIColor colorWithRed: color1 green:color2 blue:color3 alpha:1.0].CGColor;
    textView.layer.cornerRadius = 10.0;
    textView.layer.borderColor = [UIColor colorWithWhite:0 alpha: 0.5].CGColor;
    textView.layer.borderWidth = 2.0;
}
@end
