# Custom class for each cell within the grid
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