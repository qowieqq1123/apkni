







def_class("UIXM_ZZSH_noteJiJie",UIWindowBase)









function UIXM_ZZSH_noteJiJie:bindComponents()

self.closeButton=UIButton.get(self,0)
self.title=UIText.get(self,1)
self.LogScrollView=UILoopListView.new(self,2)
self.logGridPanel=UIObject.get(self,3)
self.frame=UIButton.get(self,4)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIXM_ZZSH_noteJiJie")end)

self.LogScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.frame:setButtonClick(function()self:onFrame()end)



end


function UIXM_ZZSH_noteJiJie:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.title);self.title=nil;
self.LogScrollView:deleteSelf();self.LogScrollView=nil;
_UIObject_release(self.logGridPanel);self.logGridPanel=nil;
_UIObject_release(self.frame);self.frame=nil;
end


















local this=nil

local itemcmp=
{
hpslider=0,

head=1,
}


function UIXM_ZZSH_noteJiJie:onLoaded(...)
self:bindComponents()
local id=self.LogScrollView:getID()
this=self

self.logGridPanelCmp=self.winlua:GetChildLoopListView2(id)
end


function UIXM_ZZSH_noteJiJie:__delete()
self:unbindComponents()
end




function UIXM_ZZSH_noteJiJie:onShow(argtable,afterOnloaded)
self:updataData()
self:RefreshWin()
end


function UIXM_ZZSH_noteJiJie:onHide()

end
function UIXM_ZZSH_noteJiJie:onStartAction()

end


function UIXM_ZZSH_noteJiJie:onFreshAction(index,widget)
self:refreshItem(widget,index)
end




function UIXM_ZZSH_noteJiJie:updataData()
self.data=zhengzhanshanhaiModel:GetJiJie_Data()

self.isBoss=false
for i,v in ipairs(self.data)do
if mathHelper.validInt64(self.data[1].damage)then
self.isBoss=true
return
end
end
end


function UIXM_ZZSH_noteJiJie:RefreshWin()

local itemIdList={}
local resourcetb=self.data
self.LogScrollView:initData("jijie_Item",itemIdList)
if next(resourcetb)then
for i=1,#resourcetb do
itemIdList[i]=i
end

self.LogScrollView:initData("jijie_Item",itemIdList)
local nowShowItemCount=self.logGridPanelCmp.ShownItemCount
for i=0,nowShowItemCount-1 do
local item=self.logGridPanelCmp:GetShownItemByIndex(i)
local index=item.ItemIndex+1
if item then
self:refreshItem(item.Widget,index)
end
end
end
end

function UIXM_ZZSH_noteJiJie:refreshItem(item,idx)
if item==nil then

return
end
local jijie_data=self.data
local jijieData=jijie_data[idx]

local func=function(...)

end
local myactorid=playerModel:getActorID()

item:SetChildActive(6,myactorid==jijieData.actorid)
item:SetChildText(2,idx)

local incoinfo_table={iconInfo=jijieData.iconInfo,scale=0.9}
playerController:setHeadIcon(item,itemcmp.head,incoinfo_table)
local otherserverName=loginModel:getServerName(jijieData.serverid)
item:SetChildText(3,otherserverName)

item:SetChildText(4,jijieData.actorname)


item:SetChildActive(0,not self.isBoss)
item:SetChildActive(7,self.isBoss)
local percent2=nil
if self.isBoss then
percent2=tonumber(tostring(jijieData.damage))
item:SetChildText(7,mathHelper.formatNumber(percent2))
else
local percent=jijieData.percent
percent2=percent/100
item:SetChildProgressValue(0,percent2,100)
local str=FMT.fmt("{0}%",percent2)
item:SetChildProgressText(0,str)
end


local reportId=jijieData.fightlogid

local huifang_txt=self.isBoss and"本次累计伤害：{0}\n奖励可以通过【山海日志】领取"or"本次累计伤害：{0}%\n奖励可以通过【山海日志】领取"
if not reportId or reportId==""then
item:SetChildActive(5,false)
else
item:SetChildActive(5,true)
item:SetChildButtonClick(5,function()

local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
local isSeason=shSeasonId~=-1
local isBigCrossServer=isSeason
fightController:send_254_29(reportId,{nil,reportId,eRePlayerType.shanhailog,huifang_txt,0,percent2,nil,1,1},true,isBigCrossServer,nil,isSeason)end)
end

end


function UIXM_ZZSH_noteJiJie:onLoseButton()
end


function UIXM_ZZSH_noteJiJie:onFrame()
UIManager:closeWindow("UIXM_ZZSH_noteJiJie")
end
