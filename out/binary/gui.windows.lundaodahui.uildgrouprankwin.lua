







def_class("UILDGroupRankWin",UIWindowBase)









function UILDGroupRankWin:bindComponents()

self.ToggleGroup=UIObject.get(self,0)
self.noHavePlayer=UIObject.get(self,1)
self.scrollerView=UIObject.get(self,2)
self.closeButton=UIButton.get(self,3)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UILDGroupRankWin")end)



end


function UILDGroupRankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ToggleGroup);self.ToggleGroup=nil;
_UIObject_release(self.noHavePlayer);self.noHavePlayer=nil;
_UIObject_release(self.scrollerView);self.scrollerView=nil;
_UIObject_release(self.closeButton);self.closeButton=nil;
end


















local menu_slot_name='button_dytab'
local doufataiAB='ui/windows/doufatai/doufatai_atlas_pak.ab'
local _this=nil

function UILDGroupRankWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.serverZoneFresh,function()
self:recvData()
end)
end


function UILDGroupRankWin:__delete()
self:unbindComponents()
_this=nil
end




function UILDGroupRankWin:onShow(argtable,afterOnloaded)
self.pageData={}
self:loadBtns(argtable)
end


function UILDGroupRankWin:onHide()

end

function UILDGroupRankWin:loadBtns(selectPage)
local len=cfgHelper.get(cfg_dftlundaodahuibisaiconfig_get,1,"xiaozu")
self.ToggleGroup:setChildScrollViewCreateGrids(len,len)
self.selectPage=selectPage or 1
local items=self.ToggleGroup:getChildScrollViewItemWidgets()
for i=1,len do
local name=FMT.fmt("第{0}组",i)
local sitem=items[i-1]

sitem:SetChildButtonClickWithID(0,self.onToggleChange,i,true)
sitem:SetChildText(1,name)

local isSelected=self.selectPage==i
sitem:SetChildActive(2,isSelected)

end
self:onSelectPage(self.selectPage)
self.ToggleGroup:setChildScrollViewSelectItem(self.selectPage-1,false,false,false)
end

function UILDGroupRankWin.onToggleChange(idx)
if _this.selectPage~=idx then
if _this.selectPage then
_this:setToggleOn(_this.selectPage,false)
end
_this:setToggleOn(idx,true)

_this:onSelectPage(idx)
end
end

function UILDGroupRankWin:setToggleOn(index,on)
local sitem=self.ToggleGroup:getChildScrollViewItemWidget(index-1)
sitem:SetChildActive(2,on)
end

function UILDGroupRankWin:onSelectPage(idx)
self.selectPage=idx
if self.waitToData then
return
end

if not self.pageData[idx]then
lundaodahuiController.req_17_22(idx)
self.waitToData=true
else
self:recvData()
end
end

function UILDGroupRankWin:recvData()
self.waitToData=false
local idx=self.selectPage
local data=self.pageData[idx]
if not data then
local nowTime=timeHelper.getServerLongTime()
local stateStamp=lundaodahuiModel:getMatchTime(eLDMatchType.xuanBa,2)
local isTimeWorking=nowTime<stateStamp

data=lundaodahuiModel:getXBSRankData(idx)
if data then
if isTimeWorking then
table.sort(data,function(a,b)return a.fight>b.fight end)
else
table.sort(data,function(a,b)return a.rank<b.rank end)
end
end
self.pageData[idx]=data
end
self:refreshGroupRank(data or{})
end

function UILDGroupRankWin:refreshGroupRank(dataList)
local myId=tostring(playerModel:getActorID())
local mySId=playerModel:getActorServerID()
local len=#dataList
local rewardList=cfgHelper.get(cfg_dftlundaodahuibisaiconfig_get,1,"reward")
local nowTime=timeHelper.getServerLongTime()
local stateStamp=lundaodahuiModel:getMatchTime(eLDMatchType.xuanBa,2)
local isTimeWorking=nowTime<stateStamp

self.noHavePlayer:setActive(len==0)
self.scrollerView:setChildScrollViewCreateGrids(len,1)
local items=self.scrollerView:getChildScrollViewItemWidgets()
for i=1,len do
local item=items[i-1]
local data=dataList[i]
local rank=data.rank
local name=data.name
local icon=data.iconInfo
local winNum=data.winNum
local score=data.jiFen
local showRank=rank
if rank==0 or isTimeWorking then
showRank=i
end
local reward=rewardList[showRank]
if showRank>=1 and showRank<=3 then
local iName='icon_phbmingci_{0}'
item:SetChildActive(0,true)
item:SetChildCSImageSprite(0,doufataiAB,FMT.fmt(iName,showRank))
item:SetChildText(1,showRank)
else
item:SetChildActive(0,false)
item:SetChildText(1,showRank)
end
local serverName=loginModel:getServerName(data.serverId)

local newname=playerModel:getOtherActorName(name)
if not name or name==""then
item:SetChildText(2,FMT.fmt("<color=#59412d>{0}\n{1}</color>",newname,"未知区服"))
item:SetChildActive(10,true)
else
if mySId==data.serverId and tostring(data.playerId)==myId then
item:SetChildText(2,FMT.fmt("<color=#549327>{0}\n{1}</color>",newname,serverName))
else
item:SetChildText(2,FMT.fmt("<color=#59412d>{0}\n{1}</color>",newname,serverName))
end
item:SetChildActive(10,false)
end


item:SetChildText(8,FMT.fmt("胜利{0}场",isTimeWorking and 0 or winNum))
item:SetChildText(9,FMT.fmt("{0}分",isTimeWorking and 0 or score))
item:SetChildText(3,FMT.fmt("{0}战力",mathHelper.formatNumber(tonumber(tostring(data.fight)),true)))
if reward then
local rLen=#reward
item:SetChildLayoutGroupCreateItems(6,rLen)
local gridList=item:GetChildLayoutGroupGridList(6)
for ii=1,rLen do
local grid=gridList[ii-1]
if grid then
local r=reward[ii]
local itemid=r[1]
local count=r[2]
local conf={itemid=itemid,itemcount=mathHelper.formatNumber(count),showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
grid:SetChildActive(-1,true)
grid:SetChildPropData(0,prop)
grid:SetBaseItemClickEvent(0,function(...)
self:onClickItem(...)
end)
end
end
else
item:SetChildLayoutGroupCreateItems(6,0)
end

local hgrid=item:GetChildWidgetBase(7)

self:setHead(hgrid,icon,name)
hgrid:SetChildButtonClick(2,function()
if not data.name or data.name==""then
return
end



UIFullLunDaoDaHuiControl:showLookRivalWinNew(data.playerId,{data.serverId,data.iconInfo,data.name},true)
end)
end
end

function UILDGroupRankWin:onClickItem(itemid,index,guid,attach)

if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid,itemguid=guid})
end

function UILDGroupRankWin:setHead(grid,icon,name)
if not name or name==""then
playerController:setHeadIcon(grid,0,nil)
else
playerController:setHeadIcon(grid,0,{scale=0.55,iconInfo=icon})
end

end


