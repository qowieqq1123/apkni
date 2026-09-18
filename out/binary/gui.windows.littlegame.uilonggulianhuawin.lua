







def_class("UILongGuLianHuaWin",UIWindowBase)









function UILongGuLianHuaWin:bindComponents()

self.title=UIText.get(self,0)
self.btnClose=UIButton.get(self,1)
self.times=UIText.get(self,2)
self.btnHelp=UIButton.get(self,3)
self.map=UIObject.get(self,4)
self.tipList=UIObject.get(self,5)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.btnHelp:setButtonClick(function()self:onBtnHelp()end)



end


function UILongGuLianHuaWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.times);self.times=nil;
_UIObject_release(self.btnHelp);self.btnHelp=nil;
_UIObject_release(self.map);self.map=nil;
_UIObject_release(self.tipList);self.tipList=nil;
end


















local icon_ab='ui/icons/buff/sharedtextures/icon_buff_pack1.ab'
local icon_name='icon_buff_'

local mapId=nil




function UILongGuLianHuaWin:onLoaded(...)
self:bindComponents()
self.mapArea={4,7}
self.isWin=false
end


function UILongGuLianHuaWin:__delete()
self:unbindComponents()

if self.args.callback then
self.args.callback(self.isWin)
end
end




function UILongGuLianHuaWin:onShow(argtable,afterOnloaded)
self.args=argtable
self.isWin=false
mapId=UILG_LongGuLianHuaModel:get_cur_mapId()or self.args.mapId
if not mapId then
self:onBtnClose()
return
end
self.mapConfig=cfgHelper.get1(cfg_longgulianhuamapconfig_get,mapId)
local reset=self.args.reset
self:loadMap(reset)
end


function UILongGuLianHuaWin:onHide()

end

function UILongGuLianHuaWin:loadMap(reset)
if not self.mapConfig then
return
end



if self.mapConfig.maparea then
self.mapArea=self.mapConfig.maparea
end
local mapData=self.mapConfig.map
local lgTypeLookUp={}


local checkFinish=true

local dataMap={}

if not reset then
local checkFinish=UILG_LongGuLianHuaModel:check_finish()
if not checkFinish then
dataMap=UILG_LongGuLianHuaModel:get_map_all_data()
end
end

local length=self.mapArea[1]*self.mapArea[2]
self.map:setChildLayoutGroupCreateItems(length)
local gridlist=self.map:getChildLayoutGroupGridList()

for x,xList in ipairs(mapData)do
for y,lgType in ipairs(xList)do
local index=(x-1)*(self.mapArea[2])+y
if not lgTypeLookUp[lgType]then
lgTypeLookUp[lgType]=true
end
if checkFinish then
dataMap[index]=lgType
end
if gridlist[index-1]then
local item=gridlist[index-1]
local lgConfig=cfgHelper.get1(cfg_longgulianhuatypeconfig_get,dataMap[index])
if dataMap[index]then
item:SetChildActive(1,true)
item:SetChildCSImageSprite(1,icon_ab,FMT.fmt('{0}{1}',icon_name,lgConfig.image))
else
item:SetChildActive(1,false)
end
item:SetChildButtonClick(0,function()
self:onClickItemCallback(index,x,y)
end)
end
end
end

local times=UILG_LongGuLianHuaModel:get_times()or self.mapConfig.times

if checkFinish then
UILG_LongGuLianHuaModel:init_map_data(mapId,self.mapArea[1],self.mapArea[2],dataMap,times)
end

self.times:setText(FMT.fmt('剩余炼化次数：{0}',times))

local lgTypeList={}
for k,_ in pairs(lgTypeLookUp)do
table.insert(lgTypeList,k)
end
table.sort(lgTypeList,function(a,b)return a<b end)

self.tipList:setChildLayoutGroupCreateItems(#lgTypeList)
gridlist=self.tipList:getChildLayoutGroupGridList()
for i,lgType in ipairs(lgTypeList)do
local item=gridlist[i-1]
if item then
local lgConfig=cfgHelper.get1(cfg_longgulianhuatypeconfig_get,lgType)
item:SetChildText(0,FMT.fmt('{0}炼化{1}次',lgConfig.name,lgConfig.times))
end
end

end

function UILongGuLianHuaWin.getNearPos(x,y)
return{{x,y},{x-1,y},{x,y-1},{x+1,y},{x,y+1}}
end

function UILongGuLianHuaWin:onClickItemCallback(index,x,y)

if UILG_LongGuLianHuaModel:check_finish()then
return
end

local nearPos=self.getNearPos(x,y)
for i,v in ipairs(nearPos)do
if v[1]>0 and v[2]>0 and v[1]<=self.mapArea[1]and v[2]<=self.mapArea[2]then
local nearIndex=(v[1]-1)*(self.mapArea[2])+v[2]
if UILG_LongGuLianHuaModel:get_map_data(v[1],v[2])then
local lgType=UILG_LongGuLianHuaModel:get_map_data(v[1],v[2])
local grid=self.map:getChildLayoutGroupGridItem(nearIndex-1)
if grid then
local lgConfig=cfgHelper.get1(cfg_longgulianhuatypeconfig_get,lgType)
local nextType=lgConfig.change
if nextType then
lgConfig=cfgHelper.get1(cfg_longgulianhuatypeconfig_get,nextType)
grid:SetChildCSImageSprite(1,icon_ab,FMT.fmt('{0}{1}',icon_name,lgConfig.image))
UILG_LongGuLianHuaModel:set_map_data(v[1],v[2],nextType)
else

grid:SetChildCanvasGroupDOFade(1,0,0.7)
UILG_LongGuLianHuaModel:set_map_data(v[1],v[2],nil)
end
end
end
end
end

local times=UILG_LongGuLianHuaModel:get_times()
times=times-1
UILG_LongGuLianHuaModel:set_times(times)
self.times:setText(FMT.fmt('剩余炼化次数：{0}',times))

if UILG_LongGuLianHuaModel:check_success()then
UIManager.error("挑战成功")
UILG_LongGuLianHuaModel:clear_map_data()
self.isWin=true
self:closeWin()
elseif UILG_LongGuLianHuaModel:check_fail()then
UIManager.error("挑战失败")
UILG_LongGuLianHuaModel:clear_map_data()
self.isWin=false
self:closeWin()
end
end

function UILongGuLianHuaWin:closeWin()
UIManager:closeWindow("UILongGuLianHuaWin")
end

function UILongGuLianHuaWin:onBtnClose()
UILittleGameController:quitTips(function()
self.isWin=false
self:closeWin()
end)

end

function UILongGuLianHuaWin:onBtnHelp()
UIManager.info("帮助")
end



