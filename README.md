This class is used to display a mask view and a circle progress view inside the mask view. The circle progress view consists of an clear outside circle and an inside progressing area.

### Drawing Property
The following properties is used to draw mask view and the inside progress area.

		@property (nonatomic, assign) CGFloat progress; // This property is between 0.0 and 1.0.
		@property (nonatomic, assign) CGFloat radius; // The radius of the outside circle
		@property (nonatomic, assign) CGFloat circleGap; // The gap between the ouside cirlce and the inside progressing area
		@property (nonatomic, strong) UIColor *maskColor; // The color of the mask view
		@property (nonatomic, strong) UIColor *progressColor; // The color of the inside progressing area

### Usage
Create an instance and add to subview.

		SHCircleProgressView *circleProgressView = [[SHCircleProgressView alloc] initWithFrame:self.view.bounds];
    	circleProgressView.titleLabel.text = @"Loading ...";
    	[self.view addSubview:circleProgressView];

Start the animation by calling the method _startAnimating_.

		[circleProgressView startAnimating];

The method _stopAnimating_ can stop the animation and remove the instance from super view. 

		[circleProgressView stopAnimating];