







def_class("UIXianZhanReBuildWin",UIWindowBase)









function UIXianZhanReBuildWin:bindComponents()

self.buildScrollview=UIObject.get(self,0)
self.sortBtnScrollview=UIObject.get(self,1)
self.backBtn=UIButton.get(self,2)

self.backBtn:setButtonClick(function()self:onBackBtn()end)



end


function UIXianZhanReBuildWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.buildScrollview);self.buildScrollview=nil;
_UIObject_release(self.sortBtnScrollview);self.sortBtnScrollview=nil;
_UIObject_release(self.backBtn);self.backBtn=nil;
end


















local _this
local xianzhanABName='ui/windows/xianzhan/sharedtextures/xianzhan.ab'


function UIXianZhanReBuildWin:onLoaded(...)
self:bindComponents()
_this=self
self.buildScrollview:setChildScrollViewInit(1,true,nil,nil)
self.sortBtnScrollview:setChildScrollViewInit(0,true,self.onClickSortBtn,nil)

UIManager:showWindow('UITopMoneyWin5',{{1},{5},{9}})
end


function UIXianZhanReBuildWin:__delete()
_this=nil
self:unbindComponents()
UIManager:closeWindow('UITopMoneyWin5')
UIManager:closeWindow('UIXianZhanReBuildItemTipsWin')
xianzhanModel:setBuildingModel(false)
xianzhanModel:setRebuildRoomType(nil)
end




function UIXianZhanReBuildWin:onShow(argtable,afterOnloaded)
self.reBuildConfigs=xianzhanModel:getRoomsList()
self:initSortBtns()
local selectSortIdx=1
local selectIdx=1
local config=self.reBuildConfigs[selectSortIdx][selectIdx].cfg
self.selectRoomType=config.id
UIManager:showWindow('UIXianZhanReBuildItemTipsWin',config)

self.onClickSortBtn(1,selectSortIdx-1)

xianzhanModel:setBuildingModel(true)
xianzhanModel:setRebuildRoomType(config.id)
end


function UIXianZhanReBuildWin:onHide()

end

function UIXianZhanReBuildWin:initSortBtns()
local sortList=cfgHelper.get2(cfg_xianzhanbaseconfig_get,1,'zhuangxiuType')
self.sortBtnScrollview:setChildScrollViewCreateGrids(#sortList,0)
local grids=self.sortBtnScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local item=grids[i]
local sort=sortList[i+1]
item:SetChildText(1,sort[2])
end
end

function UIXianZhanReBuildWin.onClickSortBtn(clickCount,index)
index=index+1
if _this.selectSortIdx==index then return end
local isfirst=_this.selectSortIdx==nil
if _this.selectSortIdx then
local lastItem=_this.sortBtnScrollview:getChildScrollViewItemWidget(_this.selectSortIdx-1)
lastItem:SetChildActive(0,false)
end
_this.selectSortIdx=index
local item=_this.sortBtnScrollview:getChildScrollViewItemWidget(index-1)
item:SetChildActive(0,true)

_this.roomsCofig=_this.reBuildConfigs[_this.selectSortIdx]
if not isfirst then
local h=nil
for i,v in ipairs(_this.roomsCofig)do
local cfg=v.cfg
if h==nil and cfg.id==_this.selectRoomType then
h=true
end
end
if h==nil then
local f=_this.roomsCofig[1].cfg
_this.selectRoomType=f.id
UIManager:showWindow('UIXianZhanReBuildItemTipsWin',f)
xianzhanModel:setRebuildRoomType(_this.selectRoomType)
end
end
_this:refreshRooms()
end

function UIXianZhanReBuildWin:refreshRooms()
self.buildScrollview:setChildScrollViewCreateGrids(#self.roomsCofig,0)
local grids=self.buildScrollview:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local item=grids[i-1]
local config=self.roomsCofig[i].cfg
local roomType=config.id
item:SetChildText(0,config.name)
item:SetChildCSImageSprite(1,globalABLookup.xzrome,FMT.fmt('xzrome_{0}',config.icon))

self:refreshRoomItemLock(item,i)


item:SetChildButtonClick(6,function()self.onClickBuildItem(i)end,true)

local isSelect=roomType==self.selectRoomType
self:refreshRoomItem(item,isSelect)
end
end

function UIXianZhanReBuildWin:refreshAllRoomItemLock()
local grids=self.buildScrollview:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local item=grids[i-1]
self:refreshRoomItemLock(item,i)
end
end

function UIXianZhanReBuildWin:refreshRoomItemLock(item,index)
local config=self.roomsCofig[index].cfg
local roomType=config.id

local isunlock=xianzhanModel:isZXUnLock(roomType)
local costs=config.useItems
local showTips=false
local costIdxList={2,3}
if costs then
for i=1,#costIdxList do
item:SetChildActive(costIdxList[i],i<=#costs and isunlock)
if i<=#costs then
local cost=costs[i]
local itemid=cost[1]
local count=cost[2]
local countStr
local have=0
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
else
have=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
end
if have<count then
showTips=true
countStr=FMT.fmt('<color=#C82C2C>{0}</color>',count)
else
countStr=tostring(count)
end
local widget=item:GetChildWidgetBase(costIdxList[i])
widget:SetChildIcon(1,iconHelper.getIconName(itemid),true)
widget:SetChildText(0,countStr)
end
end
else
for i=1,#costIdxList do
item:SetChildActive(costIdxList[i],false)
end
end
item:SetChildActive(5,showTips and isunlock)

item:SetChildActive(4,not isunlock)
if not isunlock then
local flag,lockItemId=xianzhanModel:checkUnLockCond(roomType)
local lockstr=FMT.fmt('需要<color=#C82C2C>{0}</color>',itemsConfig.getItemName(lockItemId))
item:SetChildText(4,lockstr)
item:SetChildButtonClick(4,function()
itemsComponentHelper.onItemClickEx(lockItemId,-1,-1,nil)
end)
end
end

function UIXianZhanReBuildWin:refreshRoomItem(item,isSelect)
item:SetChildActive(7,isSelect)
local posy=isSelect and 20 or 0
item:SetChildLocalPosY(6,posy)
end

function UIXianZhanReBuildWin:getBuildItemByRoomType(roomType)
for i,v in ipairs(self.roomsCofig)do
local cfg=v.cfg
if cfg.id==roomType then
return self.buildScrollview:getChildScrollViewItemWidget(i-1)
end
end
return nil
end

function UIXianZhanReBuildWin:checkRoomCanSelect(roomType)
if not xianzhanModel:isZXUnLock(roomType)then
return false
end
local cfg=cfgHelper.get1(cfg_xianzhanzhuangxiuconfig_get,roomType)
if not xianzhanModel.checkRebuildCondition(cfg,true,true)then
return
end
return true
end

function UIXianZhanReBuildWin.onClickBuildItem(index)
local config=_this.roomsCofig[index].cfg
local roomType=config.id
if _this.selectRoomType==roomType then return end














if _this.selectRoomType then
local lastItem=_this:getBuildItemByRoomType(_this.selectRoomType)
if lastItem then
_this:refreshRoomItem(lastItem,false)
end
end
_this.selectRoomType=roomType
UIManager:showWindow('UIXianZhanReBuildItemTipsWin',config)
local item=_this.buildScrollview:getChildScrollViewItemWidget(index-1)
_this:refreshRoomItem(item,true)

xianzhanModel:setRebuildRoomType(config.id)
end



function UIXianZhanReBuildWin:onBackBtn()
self:onClickClose()
end

function UIXianZhanReBuildWin:onClickClose()
self:closeSelf()
end


function UIXianZhanReBuildWin:rec_rebuildRoom(roomId)
self:refreshAllRoomItemLock()
end