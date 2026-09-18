









local xjEntityHud_arena={}


function xjEntityHud_arena:onInit()
self.needFollow=true

self.uiOffset={Vector2(0,0)}
local data=self.data
self.arenaId=data[1]
self.showOccupyList={}
end


function xjEntityHud_arena:onCreateWidget(widget)
return self:initShow(widget)
end


function xjEntityHud_arena:onRemoveWidget(widget)

end

function xjEntityHud_arena:initShow(widget)

self:refreshXyName(widget)


local occupyListData=self:getArenaOccupyFront3List(true)
local occupyList=occupyListData and occupyListData.f3List or{}
local nowOccupyItem=occupyListData and occupyListData.nowOccupyItem
local count=#occupyList
local isOpenAct=xianJieArenaActModel:checkIsXJArenaActDoing()
local isOpen=xianJieArenaActModel:checkIsXJArenaActCanOpen()
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

function xjEntityHud_arena:refreshXyName(widget)
local xyName="暂无归属"
local arenaData=xianJieArenaActModel:getArenaBuildData(self.arenaId)or{}
local occupyNowServerId=arenaData.occupyServerId
if occupyNowServerId and occupyNowServerId~=0 then
xyName=xianjieController:getCrossServerNamebySCidx(arenaData.sceneidx)
local cross_sid=loginModel:getCrossServerId()
local isSelfXianYu=occupyNowServerId==cross_sid
if isSelfXianYu then
xyName=FMT.cfmt1(FONT_COLOR.eGreenColor,xyName)
else
xyName=FMT.cfmt1(FONT_COLOR.eRedColor,xyName)
end
end
widget:SetChildText(0,xyName)
end

function xjEntityHud_arena:refreshTime(widget,isInit)
local occupyListData=self:getArenaOccupyFront3List(isInit)
local occupyList=occupyListData and occupyListData.f3List
local arenaData=xianJieArenaActModel:getArenaBuildData(self.arenaId)
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
local occupyNowServerId=arenaData.occupyServerId
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
local isNowOccupy=data.serverId==occupyNowServerId
local isSelfXianYu=data.serverId==cross_sid
local xyName=xianjieController:getCrossServerNamebySCidx(data.sceneIdx)
local occupyTime=data.occupyTime
if isNowOccupy and occupyStartTime>0 then
occupyTime=occupyTime+nowTime-occupyStartTime
end
local str
if isSelfXianYu then
str=FMT.cfmt1(FONT_COLOR.eGreenColor,"{0}[已占{1}]",xyName,timeHelper.format_time_stamp16(occupyTime))
else
str=FMT.fmt("{0}[已占{1}]",xyName,timeHelper.format_time_stamp3(occupyTime))
end
item:SetChildText(-1,str)
else
item:SetChildActive(-1,false)
end
end
end

function xjEntityHud_arena:refreshInfo()
local widget=self:getWidget()
if widget then



end
end

function xjEntityHud_arena:resetShow()
local widget=self:getWidget()
if widget then
return self:initShow(widget)
end
end

function xjEntityHud_arena:onClick()
if not self:checkWidget()then return end

local arenaId=self.arenaId
xianjieController:openArenaInfoWin(arenaId)
end


function xjEntityHud_arena:onDelete()

end


function xjEntityHud_arena:onUpdate()
local widget=self:getWidget()
if widget then
self:refreshXyName(widget)
if self.isShowRankPanel then
self:refreshTime(widget)
end
end
end

function xjEntityHud_arena:getArenaOccupyFront3List(isInit)
if not isInit and self.occupyListData then
return self.occupyListData
end

local list={}
local arenaData=xianJieArenaActModel:getArenaBuildData(self.arenaId)or{}
local occupyNowServerId=arenaData.occupyServerId
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

if occupyNowServerId~=0 and occupyStartTime>0 then
local occupySceneIdx=arenaData.sceneidx
nowOccupyItem={
serverId=occupyNowServerId,
occupyTime=0,
sceneIdx=occupySceneIdx,
}
end

if arenaData.occupyHis then
for i,v in ipairs(arenaData.occupyHis)do
local serverId=v.param_1
local occupyTime=v.param_2
local sceneIdx=v.param_3
if not list[3]or list[3].occupyTime<occupyTime then
local item={
serverId=serverId,
occupyTime=occupyTime,
sceneIdx=sceneIdx,
}
if serverId==occupyNowServerId then
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

return xjEntityHud_arena