









local xjEntityHud_moGong={}


function xjEntityHud_moGong:onInit()
self.needFollow=true

self.uiOffset={Vector2(0,0)}
local data=self.data
self.arenaId=data[1]
self.showOccupyList={}

end


function xjEntityHud_moGong:onCreateWidget(widget)
return self:initShow(widget)
end


function xjEntityHud_moGong:onRemoveWidget(widget)

end

function xjEntityHud_moGong:initShow(widget)

self:refreshXMName(widget)


local occupyListData=self:getArenaOccupyFront3List(true)

local occupyList=occupyListData and occupyListData.f3List or{}
local nowOccupyItem=occupyListData and occupyListData.nowOccupyItem
local count=#occupyList
local isOpenAct=moGongZhengDuoActModel:checkIsXJArenaActDoing()
local isOpen=moGongZhengDuoActModel:checkIsXJArenaActCanOpen()
self.isShowRankPanel=isOpen and isOpenAct and(count>0 or nowOccupyItem~=nil)
widget:SetChildActive(2,self.isShowRankPanel)
if self.isShowRankPanel then
self:refreshTime(widget)
end


widget:SetChildButtonClick(2,function()
return self:onClick()
end,true)
widget:SetChildButtonClick(3,function()
return self:onClick()
end,true)
end

function xjEntityHud_moGong:refreshXMName(widget)
local xyName="暂无归属"
local arenaData=moGongZhengDuoActModel:getArenaBuildData(self.arenaId)or{}

if arenaData.xmGuidStr and arenaData.xmGuidStr~='0'then
xyName=arenaData.xmName
local isSelf=xianmengModel:compareTwoGuildID(xianmengModel:myXMGuildID(),arenaData.xmGuid)
if isSelf then
xyName=FMT.cfmt(FONT_COLOR.eGreenColor,xyName)
else
xyName=FMT.cfmt(FONT_COLOR.eRedColor,xyName)
end
end
widget:SetChildText(0,xyName)

local isShowXmIcon=arenaData.xmIcon>0
widget:SetChildActive(4,isShowXmIcon)

if isShowXmIcon then
local image=xianmengModel.splitGuildIcon(arenaData.xmIcon)
local abname=globalABLookup.xianmengicons

widget:SetChildCSImageSprite(5,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(4,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(6,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
end
end

function xjEntityHud_moGong:refreshTime(widget,isInit)
local occupyListData=self:getArenaOccupyFront3List(isInit)
local occupyList=occupyListData and occupyListData.f3List
local arenaData=moGongZhengDuoActModel:getArenaBuildData(self.arenaId)
if not arenaData then
return
end

local grids=widget:GetChildCommonLayoutGroupWidgetList(1)
local cross_sid=loginModel:getCrossServerId()
local nowTime=timeHelper.getServerShortTime()
local showOccupyList=self.showOccupyList
table.clear(showOccupyList)
local nowOccupyItem=occupyListData and occupyListData.nowOccupyItem
local occupyStartTime=arenaData.occupyStartTime or 0
local xmGuid=arenaData.xmGuid
if nowOccupyItem then
local nowOccupyTime=nowOccupyItem.occupyTime
if occupyStartTime>0 then
nowOccupyTime=nowOccupyTime+nowTime-occupyStartTime
end
local isInsertNowOccupy=false
for i,data in ipairs(occupyList)do
if not isInsertNowOccupy and data.occupyTime<nowOccupyTime then
showOccupyList[#showOccupyList+1]=nowOccupyItem
isInsertNowOccupy=true
end
showOccupyList[#showOccupyList+1]=data
end
if not isInsertNowOccupy then
showOccupyList[#showOccupyList+1]=nowOccupyItem
end
else
showOccupyList=occupyList
end

for i=1,grids.Count do
local item=grids[i-1]
local data=showOccupyList[i]
if data then
item:SetChildActive(-1,true)
local isNowOccupy=data.xmGuid==xmGuid
local isSelfXianYu=xianmengModel:compareTwoGuildID(xmGuid,xianmengModel:myXMGuildID())
local xmName=data.xmName
local occupyTime=data.occupyTime
if isNowOccupy and occupyStartTime>0 then
occupyTime=occupyTime+nowTime-occupyStartTime
end
local str
if isSelfXianYu then
str=FMT.cfmt1(FONT_COLOR.eGreenColor,"{0}[已占{1}]",xmName,timeHelper.format_time_stamp16(occupyTime))
else
str=FMT.fmt("{0}[已占{1}]",xmName,timeHelper.format_time_stamp3(occupyTime))
end
item:SetChildText(-1,str)
else
item:SetChildActive(-1,false)
end
end
end

function xjEntityHud_moGong:refreshInfo()
local widget=self:getWidget()
if widget then



end
end

function xjEntityHud_moGong:resetShow()
local widget=self:getWidget()
if widget then
return self:initShow(widget)
end
end

function xjEntityHud_moGong:onClick()
if not self:checkWidget()then return end
moGongZhengDuoActController:openArenaInfoWin()
end


function xjEntityHud_moGong:onDelete()

end


function xjEntityHud_moGong:onUpdate()
local widget=self:getWidget()
if widget then
self:refreshXMName(widget)
if self.isShowRankPanel then
self:refreshTime(widget)
end
end
end
function xjEntityHud_moGong:getArenaOccupyFront3List(isInit)
if not isInit and self.occupyListData then
return self.occupyListData
end

local list={}
local arenaData=moGongZhengDuoActModel:getArenaBuildData(self.arenaId)or{}
local nowXmGuid=arenaData.xmGuid
local occupyStartTime=arenaData.occupyStartTime or 0
local nowOccupyItem
local insertFunc=function(item)
local itemOccupyTime=item.occupyTime
if not list[1]or itemOccupyTime>list[1].occupyTime then
list[3]=list[2]
list[2]=list[1]
list[1]=item
elseif not list[2]or itemOccupyTime>list[2].occupyTime then
list[3]=list[2]
list[2]=item
elseif not list[3]or itemOccupyTime>list[3].occupyTime then
list[3]=item
end
end

if arenaData.xmGuidStr~='0'and occupyStartTime>0 then
nowOccupyItem={
xmGuid=nowXmGuid,
occupyTime=0,
xmName=arenaData.xmName,
}
end

if arenaData.occupyHis then
for i,v in ipairs(arenaData.occupyHis)do
local xmGuid=v.xmGuid
local occupyTime=v.occupyTime

if not list[3]or list[3].occupyTime<occupyTime then
local item={
xmGuid=xmGuid,
occupyTime=occupyTime,
xmName=v.xmName,
}
if xmGuid==nowXmGuid then
nowOccupyItem=item
else
insertFunc(item)
end
end
end
end
self.occupyListData={f3List=list,nowOccupyItem=nowOccupyItem}
return self.occupyListData
end



return xjEntityHud_moGong