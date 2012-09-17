# A parent class for both custom UITableViewCell subclasses
class CellParent < UITableViewCell

  ROW_HEIGHT = 100

  def reuseIdentifier
    self.class.name
  end

end
