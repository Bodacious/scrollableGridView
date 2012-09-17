class GridViewController < UITableViewController

  attr_accessor :subTablesScrollable

  def viewDidLoad
    self.tableView.showsVerticalScrollIndicator = false
  end

  # =======================
  # = UITableViewDelegate =
  # =======================

  def tableView(_tableView, didSelectRowAtIndexPath: indexPath)
    NSLog("indexPath:#{_tableView} didSelectRowAtIndexPath:#{indexPath}")
  end

  # =========================
  # = UITableViewDatasource =
  # =========================
  
  def tableView(_tableView, titleForHeaderInSection: section)
    case _tableView
    when self.tableView
      "This is section #{section}"
    else
      nil
    end
  end

  def tableView(_tableView, heightForRowAtIndexPath: indexPath)
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
    case _tableView
    when self.tableView
      10
    else
      1
    end
  end

  def tableView(_tableView, numberOfRowsInSection: section)
    case _tableView
    when self.tableView
      1
    else
      10
    end
  end
  
  # My reasoning here:
  # When the main table view is scrolling, disable scrolling on the 
  # sub tables and vice versa 
  def scrollViewWillBeginDragging(scrollView)
    puts "scrollViewWillBeginDragging: #{scrollView}"
    
    case scrollView
    when self.tableView
      self.subTablesScrollable = false
      tableView.reloadData
    else
      self.tableView.scrollEnabled = false
    end
  end
  
  # Same as scrollViewWillBeginDragging:scrollView but re-enabling scrolling on
  # other tables once scrolling stopped
  def scrollViewDidEndDecelerating(scrollView)
    case scrollView
    when self.tableView
      self.subTablesScrollable = true
      tableView.reloadData
    else
      self.tableView.scrollEnabled = true
    end
  end

end