# Custom class for each row of the grid
class GridRowCell < CellParent

  def self.cellWithTableView(tableView, indexPath: indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(name) || begin
      alloc.initWithFrame([[0,0], [tableView.frame.size.width, ROW_HEIGHT]])
    end
    cell.prepareFromTableView(tableView, indexPath: indexPath)
    cell.subTableView.scrollEnabled = tableView.delegate.subTablesScrollable
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