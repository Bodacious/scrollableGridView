class CellParent < UITableViewCell

  ROW_HEIGHT = 100

  def reuseIdentifier
    self.class.name
  end

end

class GridRowCell < CellParent

  def self.cellWithTableView(tableView, indexPath: indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(name) || begin
      alloc.initWithFrame([[0,0], [tableView.frame.size.width, ROW_HEIGHT]])
    end
    cell.prepareFromTableView(tableView, indexPath: indexPath)
    cell
  end

  def initWithFrame(frame)
    if super
      addSubview(subTableView)
    end
    self
  end

  def subTableView
    @subTableView ||= begin 
      xOrigin	= (self.bounds.size.width - self.bounds.size.height)/2
      yOrigin	= (self.bounds.size.height - self.bounds.size.width)/2
      _subTableView	= UITableView.alloc.initWithFrame [[xOrigin, yOrigin], [self.bounds.size.height, self.bounds.size.width]]
      _subTableView.transform                    = CGAffineTransformMakeRotation(-Math::PI/2)
      _subTableView.autoresizingMask             = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
      _subTableView.showsVerticalScrollIndicator = false
      _subTableView.scrollEnabled                = false

      _subTableView
    end
  end

  def prepareFromTableView(tableView, indexPath: indexPath)
    subTableView.dataSource = tableView.dataSource
    subTableView.delegate = tableView.delegate
  end

  def prepareForReuse
  end

end

class GridCell < CellParent

  def self.cellWithTableView(tableView, indexPath: indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(name) || begin
      alloc.initWithFrame([[0,0], [ROW_HEIGHT, ROW_HEIGHT]])
    end
    cell.prepareFromIndexPath(indexPath)
    cell
  end

  def initWithFrame(frame)
    if super
      addSubview(textLabel)
    end
    self
  end

  def textLabel
    UITextLabel.alloc.initWithFrame([[0,0], [bounds.size.width, bounds.size.height]])
  end

  def prepareFromIndexPath(indexPath)
    textLabel.text = "Hello #{indexPath.row}"
  end

end

class GridViewController < UITableViewController

  def viewDidLoad
    self.tableView.showsVerticalScrollIndicator = false
  end

  # =======================
  # = UITableViewDelegate =
  # =======================

  def tableView(_tableView, didSelectRowAtIndexPath: indexPath)
    NSLog("indexPath: #{indexPath}")
  end

  # =========================
  # = UITableViewDatasource =
  # =========================

  def tableView(_tableView, heightForRowAtIndexPath: indexPath)
    case _tableView

    when self.tableView then CellParent::ROW_HEIGHT

    else
      _tableView.rowHeight
    end
    CellParent::ROW_HEIGHT
  end

  def tableView(_tableView, cellForRowAtIndexPath: indexPath)
    case _tableView

      # If it's the root view's UITableView ...
    when self.tableView
      GridRowCell.cellWithTableView(_tableView, indexPath: indexPath)

      # if not, assume it's a horizontal UITableView
    else
      GridCell.cellWithTableView(_tableView, indexPath: indexPath)

    end
  end


  def numberOfSectionsInTableView(_tableView)
    1
  end

  def tableView(_tableView, numberOfRowsInSection: section)
    case _tableView
    when self.tableView
      1
    else
      10
    end
    10
  end

end


class AppDelegate

  def window
    @window ||= UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
  end

  def viewController
    UINavigationController.alloc.initWithRootViewController(GridViewController.new)
  end

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    window.rootViewController = viewController
    window.makeKeyAndVisible
    true
  end

end
