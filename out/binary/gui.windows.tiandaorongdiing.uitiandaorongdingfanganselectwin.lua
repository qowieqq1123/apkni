







def_class("UITianDaoRongDingFangAnSelectWin",UIWindowBase)









function UITianDaoRongDingFangAnSelectWin:bindComponents()

self.tipstxt=UIText.get(self,0)
self.bagGrid=UIObject.get(self,1)



end


function UITianDaoRongDingFangAnSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tipstxt);self.tipstxt=nil;
_UIObject_release(self.bagGrid);self.bagGrid=nil;
end
















local _this=nil


function UITianDaoRongDingFangAnSelectWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UITianDaoRongDingFangAnSelectWin:__delete()
_this=nil
self:unbindComponents()
end


function UITianDaoRongDingFangAnSelectWin:onHide()

end




function UITianDaoRongDingFangAnSelectWin:onShow(argtable,afterOnloaded)
self.danFangID=argtable.danFangID
self.fangAnID=argtable.fangAnID
self.callback=argtable.callback
self.parentWin=argtable.parentWin
self:updataBagView()
end

function UITianDaoRongDingFangAnSelectWin:getBaglist()
local baglist={}
local costlist=cfgHelper.get2(cfg_tdrlplanconfig_get,self.danFangID,'cost')
for fangAnID_,cost in ipairs(costlist)do
local d={}
d.fangAnID=fangAnID_
d.cost=table.deepCopy(cost)
d.fix=self:checkCost(d.cost)
d.isCurrent=fangAnID_==self.fangAnID
local sortWeight=10-fangAnID_
if d.isCurrent then
sortWeight=sortWeight+200
elseif d.fix then
sortWeight=sortWeight+100
end
d.sortWeight=sortWeight
table.insert(baglist,d)
end
if#baglist>1 then
table.sort(baglist,function(a,b)
return a.sortWeight>b.sortWeight
end)
end
self.baglist=baglist
end

function UITianDaoRongDingFangAnSelectWin:checkCost(cost,isWarning)
for i,v in ipairs(cost)do
local itemID=v[1]
local itemNum=v[2]
local hasnum=itemsModel.getCount(itemID)
if hasnum<itemNum then
if isWarning then
UIManager.error(FMT.fmt('{0}不足',itemsModel.getName(itemID)))
end
return false
end
end
return true
end

function UITianDaoRongDingFangAnSelectWin:updataBagView()
self:getBaglist()
local c=#self.baglist
self.bagGrid:setChildLayoutGroupCreateItems(c,function(idx)
if _this==nil then return end
_this:refreshItemView(nil,idx)
end)
end

function UITianDaoRongDingFangAnSelectWin:refreshItemView(item,idx)
if item==nil then
item=self.bagGrid:getChildLayoutGroupGridItem(idx-1)
end
local data=self.baglist[idx]
local fangAnID=data.fangAnID

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onItemClick(idx)
end)

item:SetChildActive(1,data.isCurrent)
item:SetChildActive(3,data.isCurrent)

local cost=data.cost
local c=#cost
item:SetChildLayoutGroupCreateItems(2,c)
local grids=item:GetChildLayoutGroupGridList(2)
for i=1,c do
local goodItem=grids[i-1]
local d=cost[i]
local itemID=d[1]
local itemNum=d[2]
local hasnum=itemsModel.getCount(itemID)
local countStr
if moneyConfig.isMoney(itemID)then
countStr=mathHelper.formatNumber(itemNum)
else
countStr=FMT.fmt('{0}/{1}',hasnum,itemNum)
end
if hasnum<itemNum then
countStr=FMT.fmt('<color=#c82c2c>{0}</color>',countStr)
end
local conf={itemid=itemID,itemcount=countStr,showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
goodItem:SetChildPropData(0,prop)
goodItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
tipsManager.showTips({itemid=itemID})
end)
goodItem:SetBaseItemLongTouchEvent(0,function(...)
if _this==nil then return end
_this:onItemLongClick(...)
end)
end
end

function UITianDaoRongDingFangAnSelectWin:onItemClick(idx)
local data=self.baglist[idx]
local fangAnID_=data.fangAnID
if fangAnID_==self.fangAnID then return end
if not self:checkCost(data.cost,true)then
return
end
local callback=self.callback
self.parentWin:onCloseClick()
if callback then
callback(fangAnID_)
end
end

function UITianDaoRongDingFangAnSelectWin:onItemLongClick(itemid,index,guid,attach)
tipsManager.showTips({itemid=itemid,itemguid=guid,attach=attach})
end