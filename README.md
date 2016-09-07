# UICompass
A basic compass implemented into a UIView written in Swift

To use the compass use code like so:

        public var screenSize = UIScreen.mainScreen().bounds // Not required

        override func viewDidLoad() {
        super.viewDidLoad()
                let myCompass = UICompass(frame: CGRect(x: screenSize.width/2, y: screenSize.height/2, width: screenSize.width/1.2, height: screenSize.width/1.2))
                myCompass.center.x -= myCompass.frame.width/2 // Centers x of view
                myCompass.center.y -= myCompass.frame.height/2 // Centers y of view
                self.view.addSubview(myCompass)
        }
