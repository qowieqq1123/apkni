







def_class("UIXianJieHomeBuffWin",UIWindowBase)









function UIXianJieHomeBuffWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.Content=UIObject.get(self,1)
self.creater=UIGameobjectClone.new(self,2)
self.layout=UIObject.get(self,3)
self.mask=UIButton.get(self,4)
self.Scroll_View=UIObject.get(self,5)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIXianJieHomeBuffWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.Content);self.Content=nil;
self.creater:deleteSelf();self.creater=nil;
_UIObject_release(self.layout);self.layout=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.Scroll_View);self.Scroll_View=nil;
end


















local _this=nil
local nightFightFatigueWeakGuideId=4162
function UIXianJieHomeBuffWin:onLoaded(...)
_this=self
self:bindComponents()
self.sizeX=self.winlua:GetChildSizeDeltaX(self.Scroll_View:getID())




end

function UIXianJieHomeBuffWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXianJieHomeBuffWin:onShow(argtable,afterOnloaded)
local config={}
local isInit=argtable and argtable.isInit or false

local buffList={}
local curOrder=0


local pvpNightBattleFatigue=cfg_globalconfig_get(1).pvpNightBattleFatigue
if pvpNightBattleFatigue and next(pvpNightBattleFatigue)then
local xianjieBuffId=pvpNightBattleFatigue[1]
local startHour,endHour=unpack(pvpNightBattleFatigue[2])
endHour=endHour-1
if timeHelper.isCurrentHourBetween(startHour,endHour)then
curOrder=curOrder+1
local data={}
data.buffid=xianjieBuffId
data.endsec=0
local idx=#config+1
local singleInfo={}
singleInfo.name='UIXianJieHomeBuffItem'
singleInfo.parentIdx=self.Content:getID()
singleInfo.order=curOrder
singleInfo.args={}
singleInfo.args.buffData=data
singleInfo.args.buffType=1
singleInfo.args.idx=idx
singleInfo.args.len=1
local nightFightFatigueTips=not dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eNightFightFatigueTips)
if nightFightFatigueTips then
singleInfo.args.weakGuide={"UIXianJieHomeBuffItem.nightFightFatigue",nightFightFatigueWeakGuideId}
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eNightFightFatigueTips,true)
end
config[idx]=singleInfo
table.insert(buffList,singleInfo)
end
end

local xianjieBufflist=xianjieModel:getBuffList()
local len=#xianjieBufflist
for i,v in ipairs(xianjieBufflist)do
local buffCfg=cfg_fairylandbuffconfig_get(v.buffid)
if buffCfg.show then
curOrder=curOrder+1
local idx=#config+1
local singleInfo={}
singleInfo.name='UIXianJieHomeBuffItem'
singleInfo.parentIdx=self.Content:getID()
singleInfo.order=curOrder
singleInfo.args={}
singleInfo.args.buffData=v
singleInfo.args.buffType=1
singleInfo.args.idx=idx
singleInfo.args.len=len
config[idx]=singleInfo
table.insert(buffList,singleInfo)
end
end

local homeBuffList=homeBuffModel.getAllList()
local len2=#homeBuffList
for i,v in ipairs(homeBuffList)do
local guildstateconfig=cfg_guildstateconfig_get(v[1])
if guildstateconfig.isSystemShow==2 then
curOrder=curOrder+1
local idx=#config+1
local singleInfo={}
singleInfo.name='UIXianJieHomeBuffItem'
singleInfo.parentIdx=self.Content:getID()
singleInfo.order=curOrder
singleInfo.args={}
singleInfo.args.buffData={buffid=v[1],endsec=v[2]}
singleInfo.args.buffType=2
singleInfo.args.idx=idx
singleInfo.args.len=len2
config[idx]=singleInfo
table.insert(buffList,singleInfo)
end
end


local flag=xianjieModel:checkIsInRanLingZF()
if flag then
local buffCfg=cfg_fairylandbuffconfig_get(60302)
if buffCfg.show then
curOrder=curOrder+1
local idx=#config+1
local singleInfo={}
singleInfo.name='UIXianJieHomeBuffItem'
singleInfo.parentIdx=self.Content:getID()
singleInfo.order=curOrder
singleInfo.args={}
singleInfo.args.buffData={buffid=buffCfg.id,endsec=-1}
singleInfo.args.buffType=1
singleInfo.args.idx=idx
singleInfo.args.len=len
config[idx]=singleInfo
table.insert(buffList,singleInfo)
end
end

self.buffList=buffList

self.creater:createObjectList(config)

self.Scroll_View:setActive(true)

if isInit then
self.winlua:SetChildLocalPosX(self.layout:getID(),0)
else
self.winlua:SetChildLocalPosX(self.layout:getID(),-500)

self:showHomeBuffPanel()
end
end

function UIXianJieHomeBuffWin:onShowArgRecv()
self.Scroll_View:setActive(true)
end

function UIXianJieHomeBuffWin:refreshBuffList()
local config={}
if#self.buffList>0 then
for i,v in ipairs(self.buffList)do
local idx=#config+1
v.args.idx=idx
config[idx]=v
end
end
self.creater:createObjectList(config)
end

function UIXianJieHomeBuffWin:onHide()
self.Scroll_View:setActive(false)
end

function UIXianJieHomeBuffWin:onRectChange()
local sizeY=self.winlua:GetChildSizeDeltaY(self.Scroll_View:getID())
if sizeY>460 then

self.winlua:SetChildContentSizeFitterEnable(self.Scroll_View:getID(),false)
self.winlua:SetChildSizeDelta(self.Scroll_View:getID(),self.sizeX,460)

end
end

function UIXianJieHomeBuffWin:showHomeBuffPanel()
self:clearShowPanelTweener()
local endVal=0
self.winlua:SetChildLocalPosX(self.layout:getID(),-500)
self.showPanelTweener=self.winlua:SetChildDOLocalMoveX(self.layout:getID(),endVal,0.3)
end

function UIXianJieHomeBuffWin:hideHomeBuffPanel()
self:clearShowPanelTweener()
local endVal=-500
self.winlua:SetChildLocalPosX(self.layout:getID(),0)
self.showPanelTweener=self.winlua:SetChildDOLocalMoveX(self.layout:getID(),endVal,0.3,function()
UIManager:closeWindow("UIXianJieHomeBuffWin")
end)
UIManager:invokeUIMethod("UIXianJieMainWin","hideChatRoot",false)
end

function UIXianJieHomeBuffWin:clearShowPanelTweener()
if self.showPanelTweener~=nil then
self.showPanelTweener:Kill()
self.showPanelTweener=nil
end
end

function UIXianJieHomeBuffWin:onMask()
self:hideHomeBuffPanel()
end

function UIXianJieHomeBuffWin:onCloseBtn()
self:hideHomeBuffPanel()
end
