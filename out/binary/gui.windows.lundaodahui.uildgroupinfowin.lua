







def_class("UILDGroupInfoWin",UIWindowBase)









function UILDGroupInfoWin:bindComponents()

self.scrollerView=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.ToggleGroup=UIObject.get(self,2)
self.gridContent=UIObject.get(self,3)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UILDGroupInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollerView);self.scrollerView=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.ToggleGroup);self.ToggleGroup=nil;
_UIObject_release(self.gridContent);self.gridContent=nil;
end


















local menu_slot_name='button_dytab'
local _this=nil

function UILDGroupInfoWin:onLoaded(...)
self:bindComponents()
_this=self
self.ToggleGroup:setChildScrollViewInit(1,true,nil,nil)
notifySystem:listenNotify(notifyConfig.serverZoneFresh,function()
self:recvData()
end)
end


function UILDGroupInfoWin:__delete()
self:unbindComponents()
_this=nil
end




function UILDGroupInfoWin:onShow(argtable,afterOnloaded)
self.pageData={}
argtable=argtable or{}
self.lastY=argtable.lastY
self:loadBtns(argtable.selectPage)
end


function UILDGroupInfoWin:onHide()

end

function UILDGroupInfoWin:loadBtns(selectPage)
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

function UILDGroupInfoWin.onToggleChange(idx)
if _this.selectPage~=idx then
if _this.selectPage then
_this:setToggleOn(_this.selectPage,false)
end
_this:setToggleOn(idx,true)

_this:onSelectPage(idx)
end
end

function UILDGroupInfoWin:setToggleOn(index,on)
local sitem=self.ToggleGroup:getChildScrollViewItemWidget(index-1)
sitem:SetChildActive(2,on)
end

function UILDGroupInfoWin:onSelectPage(idx)
if self.waitToData then
return
end
self.selectPage=idx
if not self.pageData[idx]then
lundaodahuiController.req_17_21(idx)
self.waitToData=true
else
self:recvData()
end

end

function UILDGroupInfoWin:recvData()
self.waitToData=false
local idx=self.selectPage
local data=self.pageData[idx]
if not data then
data=lundaodahuiModel:getXBSGroupInfo(idx)
self.pageData[idx]=data
end
self:refreshGroupInfo(data)
end
local reAbname="ui/sharedtextures/uiglobalspriteatlas_1.ab"
function UILDGroupInfoWin:refreshGroupInfo(data)
local myId=tostring(playerModel:getActorID())
local mySId=playerModel:getActorServerID()
local dzList=data.dzList
local bsTime=cfgHelper.get(cfg_dftlundaodahuibisaiconfig_get,1,"bsTime")
local len=#bsTime[2]
local dzLen=#dzList
local tdzLen=dzLen/len
local state,stamp=lundaodahuiModel:checkXuanBaSaiState()
local nowTime=timeHelper.getServerLongTime()


self.gridContent:setChildLayoutGroupCreateItems(len)
local items=self.gridContent:getChildLayoutGroupGridList()
local height=0
for i=1,len do
local item=items[i-1]
local time=bsTime[2][i]
item:SetChildText(0,string.format("%02d：%02d",time[1],time[2]))
item:SetChildLayoutGroupCreateItems(1,tdzLen)
local gridList=item:GetChildLayoutGroupGridList(1)
local tLen=tdzLen
local nullNum=0

local stateStamp=lundaodahuiModel:getMatchTime(eLDMatchType.xuanBa,i)
local nextStamp=lundaodahuiModel:getMatchTime(eLDMatchType.xuanBa,i+1)
local timeWorking=nextStamp~=nil and nowTime<nextStamp and nowTime>=stateStamp


for ii=1,tdzLen do
local grid=gridList[ii-1]
if grid then
local dzData=dzList[(i-1)*tdzLen+ii]
if dzData then
local listLen=dzData.listLen
local dzPlayerList=dzData.dzPalyerList
local fightReport=0
if listLen>1 then
grid:SetChildActive(-1,true)
local player1=dzPlayerList[1]
local player2=dzPlayerList[2]
if player1 then
fightReport=player1.fightResult
if not player1.name or player1.name==""then
local name=playerModel:getOtherActorName(player1.name)
grid:SetChildText(3,FMT.fmt("{0}\n{1}",name,"未知区服"))
grid:SetChildActive(10,true)
else
local serverName=loginModel:getServerName(player1.serverId)
if myId==tostring(player1.playerId)and mySId==player1.serverId then
grid:SetChildText(3,FMT.fmt("<color=#549327>{0}\n{1}</color>",player1.name,serverName))
else
grid:SetChildText(3,FMT.fmt("{0}\n{1}",player1.name,serverName))
end
grid:SetChildActive(10,false)
end


grid:SetChildActive(4,not timeWorking)
if not timeWorking then
if player1.fightResult==1 then
grid:SetChildCSImageSprite(4,reAbname,"image_pqjsshengbai_1")
elseif player1.fightResult==2 then
grid:SetChildCSImageSprite(4,reAbname,"image_pqjsshengbai_2")
elseif player1.fightResult==3 then
grid:SetChildCSImageSprite(4,reAbname,"image_pqjsshengbai_3")
end
end
local hgrid=grid:GetChildWidgetBase(2)
grid:SetChildActive(2,true)
self:setHead(hgrid,player1.iconInfo)
hgrid:SetChildButtonClick(2,function()
if not player1.name or player1.name==""then
return
end



UIFullLunDaoDaHuiControl:showLookRivalWinNew(player1.playerId,{player1.serverId,player1.iconInfo,player1.name},true)
end)
else
grid:SetChildText(3,"")
grid:SetChildActive(2,false)
grid:SetChildActive(4,false)
grid:SetChildActive(10,true)
end
if player2 then
if not player2.name or player2.name==""then
local name=playerModel:getOtherActorName(player2.name)
grid:SetChildText(6,FMT.fmt("{0}\n[{1}]",name,"未知区服"))
grid:SetChildActive(11,true)
else
local serverName=loginModel:getServerName(player2.serverId)
if myId==tostring(player2.playerId)and mySId==player2.serverId then
grid:SetChildText(6,FMT.fmt("<color=#549327>{0}\n[{1}]</color>",player2.name,serverName))
else
grid:SetChildText(6,FMT.fmt("{0}\n[{1}]",player2.name,serverName))
end
grid:SetChildActive(11,false)
end


grid:SetChildActive(7,not timeWorking)
if not timeWorking then
if player2.fightResult==1 then
grid:SetChildCSImageSprite(7,reAbname,"image_pqjsshengbai_1")
elseif player2.fightResult==2 then
grid:SetChildCSImageSprite(7,reAbname,"image_pqjsshengbai_2")
elseif player2.fightResult==3 then
grid:SetChildCSImageSprite(7,reAbname,"image_pqjsshengbai_3")
end
end
local hgrid=grid:GetChildWidgetBase(5)
grid:SetChildActive(5,true)
self:setHead(hgrid,player2.iconInfo)
hgrid:SetChildButtonClick(2,function()
if not player2.name or player2.name==""then
return
end



UIFullLunDaoDaHuiControl:showLookRivalWinNew(player2.playerId,{player2.serverId,player2.iconInfo,player2.name},true)
end)
else
grid:SetChildText(6,"")
grid:SetChildActive(5,false)
grid:SetChildActive(7,false)
grid:SetChildActive(11,true)
end


grid:SetChildActive(1,timeWorking)

if not timeWorking and(fightReport~=0)then
local fightLogId=dzData.fightLogIdList and dzData.fightLogIdList[1]or''
grid:SetChildButtonClick(0,function()self:openFight(fightLogId,dzPlayerList)end)
grid:SetChildActive(0,true)

else

grid:SetChildActive(0,false)
end
else
grid:SetChildActive(-1,false)
tLen=tLen-1
nullNum=nullNum+1
end
end
end
end
item:SetChildActive(2,tLen<=0)
local sh=175+112*((tLen<=0 and 1 or tLen)-1)
item:SetChildSizeDelta(-1,1050,sh)
height=height+sh
end
self.gridContent:setChildSizeDelta(1030,height)
if self.lastY then
self.gridContent:setChildAnchoredPos(0,self.lastY)
self.lastY=nil
end
end

function UILDGroupInfoWin:setHead(grid,icon)
playerController:setHeadIcon(grid,0,{scale=0.55,iconInfo=icon})
end

function UILDGroupInfoWin:openFight(str,info)
if str~=""then
local fightId=str
local lastY=self.gridContent:getChildAnchoredPosition().y
local groupArgs={self.selectPage,lastY}
fightController:send_254_29(fightId,{info,fightId,eRePlayerType.lundaodahui,groupArgs=groupArgs,},true)
end
end

function UILDGroupInfoWin:onCloseBtn()
self:closeSelf()
end


