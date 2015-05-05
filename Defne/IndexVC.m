//
//  IndexVC.m
//  Defne
//
//  Created by aybek can kaya on 3/19/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "IndexVC.h"

@interface IndexVC ()

@end

@implementation IndexVC





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    controlViewShouldOpen = NO;
    self.viewGame.backgroundColor = [UIColor clearColor];
    
    // select random image (initializer)
    
    DefneImage *imageDefne = [[ControlShare defaultControl] randomImage];
    Game *theGame = [Game shared];
    theGame.imageDefneSelected = imageDefne;
    
    if(imageDefne != nil)
    {
        for(UIView *view in self.viewsInit)
        {
           // [view removeFromSuperview];
            view.alpha = 0;
            
        }
        controlViewShouldOpen = YES;
        ControlShare *share = [ControlShare defaultControl];
        share.defneImageOnScreen = theGame.imageDefneSelected;
        
         [self initializePuzzleViews];
    }
    else
    {
        
        for(UIView *view in self.viewsInit)
        {
            view.layer.cornerRadius = view.frame.size.height/2;
            view.layer.masksToBounds = YES;
        }
         
    }
   
    
    Game *gm = [Game shared];
    gm.delegate = self;
    
    [self addGestures];
    
    viewControl = [Story GetViewFromNibByName:@"ControlView"];
    [self.view addSubview:viewControl];
    
    CGRect frTemp = viewControl.frame;
    frTemp.origin.x = (-1)*frTemp.size.width ;
    viewControl.frame = frTemp;
    
    viewControl.delegate = self;
    
    
    viewWinner = [Story GetViewFromNibByName:@"WinnerView"];
    [self.view addSubview:viewWinner];
    viewWinner.alpha = 0;
    
    
    // Test
  //  [self performSelector:@selector(gameSucceed) withObject:nil afterDelay:3];
    
    // Test animation
  //  [self performSelector:@selector(testControlViewAnimation) withObject:nil afterDelay:2];
    
    
  //  BOOL hasList = [Plist listExists:]
    
    if([viewControl needsBlink] == YES)
    {
        //very bad way : I know :))
        //[NSTimer scheduledTimerWithTimeInterval:3.8 target:viewControl selector:@selector(blink) userInfo:nil repeats:YES];
        
        // better way
        [viewControl blinkRandom];
    }
    
}

/*
-(void)testControlViewAnimation
{
    [viewControl blink];
    
}
*/



/**
    gesture for left edge pan 
 */
-(void)addGestures
{
    UIScreenEdgePanGestureRecognizer *pan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleScreenPan:)];
    [pan setEdges:UIRectEdgeLeft];
    [pan setDelegate:self];
    [self.view addGestureRecognizer:pan];
}

-(void)handleScreenPan:(UIScreenEdgePanGestureRecognizer *)rec
{
    if(controlViewShouldOpen == YES)
    {
        if(rec.state == UIGestureRecognizerStateBegan)
        {
            
            
            [imViewBlur removeFromSuperview];
            
            UIImage *imScreen = [self.view screenShot];
            UIImage *blurImage = [imScreen applyBlurWithRadius:10 tintColor:[UIColor clearColor] saturationDeltaFactor:1.8 maskImage:nil];
            imViewBlur = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            imViewBlur.image = blurImage;
            [self.view addSubview:imViewBlur];
            imViewBlur.alpha = 0;
            
            [self.view bringSubviewToFront:viewControl];
        }
        else if(rec.state == UIGestureRecognizerStateChanged)
        {
            CGPoint locOfPan = [rec locationInView:self.view];
            float xPos = locOfPan.x;
            float widthControlView = viewControl.frame.size.width;
            
            float rate = (float) xPos/widthControlView;
            
            imViewBlur.alpha = rate;
            
            // set view Control position
            CGRect frTemp = viewControl.frame;
            frTemp.origin.x = (-1) * viewControl.frame.size.width + xPos;
            
            if(frTemp.origin.x < 1)
            {
                viewControl.frame = frTemp;
            }
            
            
        }
        else if(rec.state == UIGestureRecognizerStateEnded)
        {
            [viewControl setNeedsBlink:NO];
            
            CGPoint locOfPan = [rec locationInView:self.view];
            float xPos = locOfPan.x;
            float widthControlView = viewControl.frame.size.width;
            
            float rate = (float) xPos/widthControlView;
            
            
            if(rate < 0.5)
            {
                // hide
                [self hideControlView];
            }
            else
            {
                // show
                [self showControlView];
            }
        }

    }
    
   
}

#pragma mark Control View

-(void)showControlView
{
    CGRect nextFrame = viewControl.frame;
    nextFrame.origin.x = 0;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
       
        viewControl.frame = nextFrame;
        imViewBlur.alpha = 1;
    } completion:^(BOOL finished) {
        
        
        
    }];
}

-(void)hideControlView
{
    CGRect nextFrame = viewControl.frame;
    nextFrame.origin.x = -1*viewControl.frame.size.width;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        viewControl.frame = nextFrame;
        imViewBlur.alpha = 0;
    } completion:^(BOOL finished) {
        
        
        
    }];
}

-(void)controlViewDidTappedDeveloperBtn
{
    [self hideControlView];
    
    DeveloperVC *vc = [Story viewController:@"developerVC"];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
    
}

-(void)controlView:(ControlView *)controlView didTranslatedToProgress:(float)progress
{
    float rate = 1+progress;
   // NSLog(@"rate : %f" , rate);
    
    imViewBlur.alpha = rate;
    
    
    if(rate < 0.5)
    {
        // hide
       // [self hideControlView];
    }
    else
    {
        // show
       // [self showControlView];
    }

    
}

-(void)controlViewImageDidSelected:(DefneImage *)imageDefne ShouldClose:(BOOL)closeView
{
    Game *gm = [Game shared];
    gm.imageDefneSelected = imageDefne;
    
    ControlShare *share = [ControlShare defaultControl];
    share.defneImageOnScreen = gm.imageDefneSelected;
    
    if(closeView == YES)
    {
        [self hideControlView];
    }
    
    
    [self initializePuzzleViews];
}

-(void)controlView:(ControlView *)controlView didEndedTranslationToProgress:(float)progress
{
     float rate = 1+progress;
    if(rate < 0.5)
    {
        // hide
        [self hideControlView];
    }
    else
    {
        // show
         [self showControlView];
    }

}


-(void)controlViewTakePhotoOnTap
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

-(void)controlViewGalleryOnTap
{
    // foto sec
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

-(BOOL)controlViewShouldOpen
{
    return controlViewShouldOpen;
}


#pragma mark ImagePickerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    for(UIView *vv in self.viewsInit)
    {
        vv.alpha = 0;
      //  [vv removeFromSuperview];
       // controlViewShouldOpen = YES;
    }
    
    
    
     // get extension
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    NSURL *url = info[@"UIImagePickerControllerReferenceURL"];
    NSString *urlString = [url absoluteString];
    NSArray *components = [urlString componentsSeparatedByString:@"&ext="];
    NSString *componentReal = [components lastObject];
    
    // create Defne Image
    DefneImage *image = [[DefneImage alloc]init];
    image.image =info[@"UIImagePickerControllerOriginalImage"];
      ((DefneImage *)image).appleName = urlString;
   ((DefneImage *)image).extension = componentReal;
    
    ControlShare *controlShared = [ControlShare defaultControl];
    controlShared.delegate = self;
    [controlShared saveImage:image];
    
    
    
}

#pragma mark Control Shared Delegate

-(void)controlShareDidStartSaveDefneImage:(DefneImage *)image
{
    
}

-(void)controlShareDidEndSaveDefneImage:(DefneImage *)image
{
    // set image of control View
    [viewControl supplyDefneImage:image];
    
    // If all of the images have erased or the game newly downloaded
    if(controlViewShouldOpen == NO)
    {
        [self controlViewImageDidSelected:image ShouldClose:YES];
        controlViewShouldOpen = YES;
    }
}

-(void)gameShouldCheck:(Game *)theGame
{
 //   [self.viewGame update];
    
   // Game *theGame = [Game shared];
    NSMutableArray *puzzleViewsArr = theGame.puzzleViewsArr;
    BOOL gameShouldEnd = YES;
    
    for(PuzzleView *view in puzzleViewsArr)
    {
        CGRect currFrame = view.frame;
        CGRect correctFrame = view.frameCorrect;
        
        // TEST
        /*
        if(CGRectEqualToRect(currFrame, correctFrame))
        {
            NSLog(@"correct view : %d" , view.ID);
        }
        */
        
        if(!CGRectEqualToRect(currFrame, correctFrame))
        {
            gameShouldEnd = NO;
            break;
        }
        
    }
    
    if(gameShouldEnd == YES)
    {
        [self gameSucceed];
    }
    
}

-(void)gameSucceed
{
    
    [viewWinner showWithView:self.view];
   
}

-(void)winnerViewDidClosed
{
    [viewControl refreshDidTapped:nil];

}


-(void)initializePuzzleViews
{
    
    // remove previous puzzle views
    
    for(id vv in self.viewGame.subviews)
    {
        if([vv isKindOfClass:[PuzzleView class]])
        {
            [(PuzzleView *)vv removeFromSuperview];
        }
    }
    
    
    // game View Test
   // UIImage *img = [UIImage imageNamed:@"image.jpg"];
    
    Game *gm = [Game shared];
    UIImage *img= gm.imageDefneSelected.image;
    self.viewGame.numberOfColumsAtEachRow = 3;
  NSMutableArray *arrImages = [self.viewGame imagesFromRealImage:img];
  
    int numColumns =  self.viewGame.numberOfColumsAtEachRow;
    
    float lengthOfEachSide = self.viewGame.lengthOfSideAtEachTile;
    
    
    NSMutableArray *viewsPuzzle =  [[NSMutableArray alloc]init];
    float currYPos = 0;
    for(int i = 0 ; i< arrImages.count ; i++)
    {
        int theID = i+1;
        
        if(i % numColumns == 0)
        {
            if(i != 0)
            {
                currYPos += lengthOfEachSide;
            }
        }
        
        int theIndex = i % numColumns;
        
        CGRect correctRectangle = CGRectMake(theIndex*lengthOfEachSide, currYPos, lengthOfEachSide, lengthOfEachSide);
        
        // puzzle views
        PuzzleView *viewPuzzle = [[PuzzleView alloc]init];
        
        /*
        int theRed = arc4random()%255;
        int theGreen = arc4random() %255;
        int theBlue = arc4random()%255;
        
        UIColor *randomColor = [UIColor colorWithR:theRed G:theGreen B:theBlue Alpha:1];
        
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, lengthOfEachSide, lengthOfEachSide)];
        lbl.textColor = [UIColor whiteColor];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.font = [UIFont systemFontOfSize:25];
        lbl.text = [NSString stringWithFormat:@"%d" , theID];
        [viewPuzzle addSubview:lbl];
        */
        viewPuzzle.backgroundColor = [UIColor colorWithPatternImage:arrImages[i]];
        
       // viewPuzzle.backgroundColor = randomColor;
        
         
        viewPuzzle.delegate = self;
        viewPuzzle.ID = theID;
        viewPuzzle.frameCorrect = correctRectangle;
        
       // [self.viewGame addSubview:viewPuzzle];
        
        [viewsPuzzle addObject:viewPuzzle];
        
    }
    
    
   // [self.viewGame addSubview:viewsPuzzle[3]];
    
    // shuffle the array as well as locations
    
    
    Game *theGame = [Game shared];
    theGame.puzzleViewsArr = viewsPuzzle;
    
    [theGame shufflePuzzleArray];
    
    // locate images
    
    NSMutableArray *finalPuzzleViewsArr = [[NSMutableArray alloc]init];
    currYPos = 0;
    for(int i = 0 ; i<viewsPuzzle.count ; i++)
    {
       // int theID = i+1;
        
        if(i % numColumns == 0)
        {
            if(i != 0)
            {
                currYPos += lengthOfEachSide;
            }
        }
        
        int theIndex = i % numColumns;
        
        CGRect newRectangle = CGRectMake(theIndex*lengthOfEachSide, currYPos, lengthOfEachSide, lengthOfEachSide);

        PuzzleView *theInnerPuzzleView = (PuzzleView *)viewsPuzzle[i];
        theInnerPuzzleView.frame = newRectangle;
        
        [finalPuzzleViewsArr addObject:theInnerPuzzleView];
        
       [self.viewGame addSubview:theInnerPuzzleView];
        
    }
    
    theGame.puzzleViewsArr = finalPuzzleViewsArr;
    
}


#pragma mark PuzzleView delegate

-(void)puzzleView:(PuzzleView *)puzzleView didStartDraggingLocation:(CGPoint)locationStart
{
    //NSLog(@"Start puzzle view  : %@" , NSStringFromCGPoint(locationStart));
    
    //CGRect emptyFrame = puzzleView.frame;
    
    Game *gm = [Game shared];
    gm.viewCurrentlyFocused = puzzleView;
    
    
    [gm focusedViewStartMove];
    
}

-(void)puzzleView:(PuzzleView *)puzzleView didMovedToLocation:(CGPoint)locationMoved
{
   //  NSLog(@"Moving  puzzle view  : %@" , NSStringFromCGPoint(locationMoved));
    
  //  CGRect emptyFrame = puzzleView.frame;
    
    Game *gm = [Game shared];
    gm.viewCurrentlyFocused = puzzleView;
    //gm.emptyRect = emptyFrame;
    
    [gm focusedViewOnMove];
    
}

-(void) puzzleView:(PuzzleView *)puzzleView didEndDraggingLocation:(CGPoint)locationFinal
{
    // NSLog(@"End puzzle view  : %@" , NSStringFromCGPoint(locationFinal));
    
    CGRect emptyFrame = puzzleView.frame;
    
    Game *gm = [Game shared];
    gm.viewCurrentlyFocused = puzzleView;
   
    
    [gm focusedViewEndedMove];
    
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

- (IBAction)photoOnTap:(id)sender {
    
    [self controlViewTakePhotoOnTap];
    
}

- (IBAction)galleryOnTap:(id)sender {
    
    [self controlViewGalleryOnTap];
}
@end
