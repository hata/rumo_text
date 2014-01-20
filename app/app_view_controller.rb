#
# AppViewController
#
class AppViewController < UIViewController
  def viewDidLoad
    frame = UIScreen.mainScreen.applicationFrame
    @scroll_view = UIScrollView.alloc.initWithFrame(frame)
    app_view = AppView.alloc.initWithFrame(CGRectMake(0, 0, frame.size.width, frame.size.height * 7))
    app_view.backgroundColor = UIColor.whiteColor
    @scroll_view.addSubview app_view
    @scroll_view.contentSize = app_view.bounds.size
    self.view = @scroll_view
  end
end
