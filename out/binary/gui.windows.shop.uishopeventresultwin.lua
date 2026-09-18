







def_class("UIShopEventResultWin",UIWindowBase)









function UIShopEventResultWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.title=UIText.get(self,1)
self.dizi=UIObject.get(self,2)
self.desc=UIText.get(self,3)
self.rewards=UIObject.get(self,4)
self.moneyReward=UIObject.get(self,5)
self.rewardText=UIText.get(self,6)
self.tips=UIText.get(self,7)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIShopEventResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.dizi);self.dizi=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.rewards);self.rewards=nil;
_UIObject_release(self.moneyReward);self.moneyReward=nil;
_UIObject_release(self.rewardText);self.rewardText=nil;
_UIObject_release(self.tips);self.tips=nil;
end



















function UIShopEventResultWin:onLoaded(...)
self:bindComponents()
end


function UIShopEventResultWin:__delete()
self:unbindComponents()
end




function UIShopEventResultWin:onShow(argtable,afterOnloaded)
local bdId=argtable[1]
local eventId=argtable[2]
local selectId=argtable[3]

local sfId=zongmenModel:getMountainId()
local bdData=zongmenModel:getBuildingData(bdId)
local cfg=cfgHelper.get1(cfg_shangpuconfig_get,bdData.build_id)
local data=cfg.event_list[eventId].select[selectId]

self.title:setText(data.title or'')
self.desc:setText(data.desc or'')
self.tips:setText(chatEmotHelper.decodeEmot(data.tips or''))

if tostring(bdData.dizi_id)~='0'then
local info=UIDiscipleModel:getDiscipleOutsideModelInfo(bdData.dizi_id)
local scale=isometricMapSystem:getModelScale(info.body,true)
self.dizi:setChildUIModelShowTarget(info.body,scale,info.componets,eAnimationID.stand)
end

local etype=data.type
if etype==1 then
local d1=data.param1[1]
if itemsConfig.isMoney(d1[1])then
self.rewards:setActive(false)
self.moneyReward:setActive(true)
self.rewardText:setText('')

local node=self.moneyReward:getChildWidgetBase()
node:SetChildIcon(0,iconHelper.getIconName(d1[1]),true)
local val=d1[2]
node:SetChildText(1,FMT.fmt('{0}{1}',val>0 and'+'or'',val))
else
self.rewards:setActive(true)
self.moneyReward:setActive(false)
self.rewardText:setText('')

self.rewards:setChildLayoutGroupCreateItems(#data.param1)
local items=self.rewards:getChildLayoutGroupGridList()
for i=0,items.Count-1 do
local item=items[i]
local rd=data.param1[i+1]









widgetHelper.setNormalRewardItem(item,0,rd)
end
end
elseif etype==2 then
self.rewards:setActive(false)
self.moneyReward:setActive(false)
self.rewardText:setText(string.format('获得效果：%s',homeBuffModel:getBuffDescByStateId(data.param1)))
elseif etype==3 then
self.rewards:setActive(false)
self.moneyReward:setActive(false)

local count=5
self.rewardText:setText(string.format('即将触发战斗（%s）',count))
local endtime=os.time()+count
self.timer=self:setTimer(1,count+3,function()
local dt=endtime-os.time()
if dt>=0 then
self.rewardText:setText(string.format('即将触发战斗（%s）',dt))
else
self:stopTimerByID(self.timer)
local fightLog=argtable[4]
self:StartFight(fightLog)
end
end)
self.waitBattle=true
elseif etype==0 then
self.rewards:setActive(false)
self.moneyReward:setActive(false)
self.rewardText:setText('什么都没有发生')
end
self.closeBtn:setActive(etype~=3)
end

function UIShopEventResultWin:StartFight(fightLog)
isometricMapSystem:enterBattleMode()
fightController:startBallte(fightLog,true,function(bId)
fightController:closeBattle(bId)
end,function()
isometricMapSystem:leaveBattleMode()
end)
self.waitBattle=false
self:onCloseClick()
end


function UIShopEventResultWin:onHide()

end




function UIShopEventResultWin:onCloseBtn()
self:onCloseClick()
end

function UIShopEventResultWin:onCloseClick()
if not self.waitBattle then
self:closeSelf()
end
end