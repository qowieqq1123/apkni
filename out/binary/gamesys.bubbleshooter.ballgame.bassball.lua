








local bassBall={}

function bassBall:__init(index,row,col,color)
self.color=color
self:setRowCol(index,row,col)
end

function bassBall:setRowCol(index,row,col)
self.row=row
self.col=col
self.index=index
end

function bassBall:setPos(x,y)
self.x=x
self.y=y
end

return bassBall