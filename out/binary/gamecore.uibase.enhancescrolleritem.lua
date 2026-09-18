










EnhanceScrollerItem=simple_class(UIWindowBase)

function EnhanceScrollerItem:__init(gameObject,winlua)
self.winlua=winlua
self.gameObject=gameObject
end

function EnhanceScrollerItem:SetSelected(bool)
self.isSelect=bool
self:RefreshState()
end

function EnhanceScrollerItem:CanCelSelected()
self.isSelect=false
self:RefreshState()
end


function EnhanceScrollerItem:SetDataIndex(dataIndex)
self.dataIndex=dataIndex
end

function EnhanceScrollerItem:GetDataIndex()
return self.dataIndex
end

function EnhanceScrollerItem:RefreshState()
end

function EnhanceScrollerItem:RefreshDataInfo(data)
end

function EnhanceScrollerItem:__delete()
end
