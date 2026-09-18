







def_class("UIHomeBuffWin",UIWindowBase)









function UIHomeBuffWin:bindComponents()

self.creater=UIGameobjectClone.new(self,0)
self.Content=UIObject.get(self,1)
self.bg=UIObject.get(self,2)
self.layout=UIObject.get(self,3)
self.Scroll_View=UIObject.get(self,4)
self.frdRoot=UIButton.get(self,5)
self.StableValText=UIText.get(self,6)
self.frdReddot=UIObject.get(self,7)
self.frdValue=UIText.get(self,8)

self.frdRoot:setButtonClick(function()self:onFrdRoot()end)



end


function UIHomeBuffWin:unbindComponents()
local _UIObject_release=UIObject.release
self.creater:deleteSelf();self.creater=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.layout);self.layout=nil;
_UIObject_release(self.Scroll_View);self.Scroll_View=nil;
_UIObject_release(self.frdRoot);self.frdRoot=nil;
_UIObject_release(self.StableValText);self.StableValText=nil;
_UIObject_release(self.frdReddot);self.frdReddot=nil;
_UIObject_release(self.frdValue);self.frdValue=nil;
end


















local _this=nil

function UIHomeBuffWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.building_event,self.onBuildEvent)
self.sizeX=self.winlua:GetChildSizeDeltaX(self.Scroll_View:getID())

self:initClientBuffList()

self.creater:setCreatAction(function()
self.winlua:ForceLayoutRect(self.bg:getID())
end)

self:addNotify(notifyConfig.onProsperityLevelChange,function(...)self:onProsperityLevelChange(...)end)
self:addNotify(notifyConfig.onProsperityChange,function(...)self:onProsperityLevelChange(...)end)

end

function UIHomeBuffWin:__delete()
_this=nil
self:unbindComponents()
end

function UIHomeBuffWin.onBuildEvent(eventType,param1,param2,param3)
if _this==nil then return end
if eventType==buildingEvent.zongmenLevelUp and param3~=param1 then
local zmlv_=cfgHelper.getglobal1('wageloyalty')
if param1>zmlv_ and param3<=zmlv_ then
_this:initClientBuffList()
end
end
end

function UIHomeBuffWin:initClientBuffList()
local buffList2={}
local zmlv=zongmenModel:getLevel()
local zmlv_=cfgHelper.getglobal1('wageloyalty')
if zmlv<=zmlv_ then
local idx=#buffList2+1
local info={}
info.name='UIHomeBuffClientItem'
info.parentIdx=self.Content:getID()
info.order=100
info.args={}
info.args.idx=idx
info.args.buffName='仙门初创'
info.args.buffIcon=4
info.args.buffDesc=FMT.fmt('弟子忠诚度不因俸禄不足降低\n宗门等级{0}级后过期',zmlv_)
buffList2[idx]=info
end
self.buffList2=buffList2
end

function UIHomeBuffWin:onShow(argtable,afterOnloaded)
local config={}
local list=argtable and argtable.list or{}
local isInit=argtable and argtable.isInit or false

local buffList={}
local len=#list
for i,v in ipairs(list)do
local guildstateconfig=cfg_guildstateconfig_get(v[1])
if guildstateconfig.show or guildstateconfig.show==nil then
local idx=#config+1
local singleInfo={}
singleInfo.name='UIHomeBuffItem'
singleInfo.parentIdx=self.Content:getID()
singleInfo.order=i
singleInfo.args=v
singleInfo.args.idx=idx
singleInfo.args.len=len
config[idx]=singleInfo
table.insert(buffList,singleInfo)
end
end
self.buffList=buffList
if#self.buffList2>0 then
for i,v in ipairs(self.buffList2)do
local idx=#config+1
v.args.idx=idx
config[idx]=v
end
end
self.creater:createObjectList(config)
self:refreshStableVal()

self:refreshProsperityRoot()

self.Scroll_View:setActive(true)

if isInit then
self.winlua:SetChildLocalPosX(self.layout:getID(),0)
else
self.winlua:SetChildLocalPosX(self.layout:getID(),-300)

self:showHomeBuffPanel()
end
end

function UIHomeBuffWin:onShowArgRecv()
self.Scroll_View:setActive(true)
end


function UIHomeBuffWin:refreshBuffList()
self:initClientBuffList()

local config={}
if#self.buffList>0 then
for i,v in ipairs(self.buffList)do
local idx=#config+1
v.args.idx=idx
config[idx]=v
end
end
if#self.buffList2>0 then
for i,v in ipairs(self.buffList2)do
local idx=#config+1
v.args.idx=idx
config[idx]=v
end
end
self.creater:createObjectList(config)
end

function UIHomeBuffWin:refreshProsperityRoot()
local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eProsperity)
self.frdRoot:setActive(isOpen)
if isOpen then
local lv=prosperityModel:getProsperityLevel()
self.frdValue:setText(FMT.fmt("{0}级",lv))





self.frdReddot:setActive(prosperityModel:isCanUpLevel())
end
end

function UIHomeBuffWin:onHide()
self.Scroll_View:setActive(false)
end



function UIHomeBuffWin:refreshStableVal()
local stable=homeBuffModel.getStableValue()
local stableData=homeBuffModel.getStableScaleData()
local stableStr=stableData[3]
self.StableValText:setText(FMT.fmt('稳定度：<color=#f7f7f7>{0}({1})</color>',stable,stableStr))
end

function UIHomeBuffWin:onRectChange()
local sizeY=self.winlua:GetChildSizeDeltaY(self.Scroll_View:getID())
if sizeY>230 then

self.winlua:SetChildContentSizeFitterEnable(self.Scroll_View:getID(),false)
self.winlua:SetChildSizeDelta(self.Scroll_View:getID(),self.sizeX,230)

end
end

function UIHomeBuffWin:onProsperityLevelChange()
self:refreshProsperityRoot()
end

function UIHomeBuffWin:onFrdRoot()
UIFullProsperityController:showMainWindow()
end


function UIHomeBuffWin:showHomeBuffPanel()
self:clearShowPanelTweener()
local endVal=0
self.winlua:SetChildLocalPosX(self.layout:getID(),-300)
self.showPanelTweener=self.winlua:SetChildDOLocalMoveX(self.layout:getID(),endVal,0.3)
end

function UIHomeBuffWin:hideHomeBuffPanel(callBack)
self:clearShowPanelTweener()
local endVal=-300
self.winlua:SetChildLocalPosX(self.layout:getID(),0)
self.showPanelTweener=self.winlua:SetChildDOLocalMoveX(self.layout:getID(),endVal,0.3,callBack)
end

function UIHomeBuffWin:clearShowPanelTweener()
if self.showPanelTweener~=nil then
self.showPanelTweener:Kill()
self.showPanelTweener=nil
end
end
