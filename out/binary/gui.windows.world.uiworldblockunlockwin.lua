







def_class("UIWorldBlockUnlockWin",UIWindowBase)









function UIWorldBlockUnlockWin:bindComponents()

self.root=UIObject.get(self,0)
self.btnUnlock=UIButton.get(self,1)
self.title=UIText.get(self,2)
self.conditions=UIObject.get(self,3)
self.costIcon=UIImage.get(self,4)
self.costNum=UIText.get(self,5)
self.unlockBtnText=UIText.get(self,6)

self.btnUnlock:setButtonClick(function()self:onBtnUnlock()end)



end


function UIWorldBlockUnlockWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.btnUnlock);self.btnUnlock=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.conditions);self.conditions=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costNum);self.costNum=nil;
_UIObject_release(self.unlockBtnText);self.unlockBtnText=nil;
end















local _this=nil
local _condCmp={
gouBg=0,
gou=1,
desc=2
}



function UIWorldBlockUnlockWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.on_money_changed,self.onMoneyChanged)
end


function UIWorldBlockUnlockWin:__delete()
self:unbindComponents()
_this=nil
end




function UIWorldBlockUnlockWin:onShow(argtable,afterOnloaded)
self.world=argtable.world
self.block=argtable.block
self.config=cfgHelper.get2(cfg_worldblockconfig_get,self.world,self.block)

self.title:setText(self.config.name)
self:refreshComsume()


local blockCnt=#self.config.adjacentBlocks
local unlockCnt=#self.config.unlock
self.checks={}
self.check=nil
for index,adjacentBlocks in ipairs(self.config.adjacentBlocks)do
local world=adjacentBlocks[1]
local block=adjacentBlocks[2]
local c=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
local open=worldBlockModel:checkBlockState(world,block,eWorldBlockState.OPEN)
local args={
type=0,
desc=FMT.fmt("解锁{0}",c.name),
open=open,
param=adjacentBlocks,
}
table.insert(self.checks,args)
if not open then
self.check=#self.checks
end
end
for index,unlock in ipairs(self.config.unlock)do
local t=unlock[1]
local v=unlock[2]
local desc=""
local open=false
if t==1 then
local level=zongmenModel:getLevel()
desc=FMT.fmt("宗门等级达到{0}级",v)
open=v<=level
elseif t==2 then
local tc=taskModel:getTaskConfig(v)
local bantch=tc.tasklineid==taskModel.lineMain and"主线"or"支线"
desc=FMT.fmt("完成{1}任务·{0}",tc.name,bantch)
open=taskModel:checkTaskFinish(v)
end
local args={
type=1,
desc=desc,
open=open,
param=unlock,
}
table.insert(self.checks,args)
if not open then
self.check=#self.checks
end
end

self.conditions:setChildLayoutGroupCreateItems(#self.checks,function(index)
local item=self.conditions:getChildLayoutGroupGridItem(index-1)
local param=self.checks[index]
item:SetChildText(_condCmp.desc,param.desc)
item:SetChildActive(_condCmp.gouBg,not param.open)
item:SetChildActive(_condCmp.gou,param.open)
end)

if self.check then
local checkData=self.checks[self.check]
if checkData.type==0 then
self.unlockBtnText:setText("前往区块")
elseif checkData.type==1 then
if checkData.param[1]==1 then
self.unlockBtnText:setText("前往升级")
elseif checkData.param[1]==2 then
self.unlockBtnText:setText("前往任务")
end
end
else
self:setButtonCost()
end
end


function UIWorldBlockUnlockWin:onHide()

end




function UIWorldBlockUnlockWin:onBtnUnlock()
if self.check then
local checkData=self.checks[self.check]
if checkData.type==0 then
local c=cfgHelper.get2(cfg_worldblockconfig_get,checkData.param[1],checkData.param[2])
if c.unlockWeak then
weakGuideController:beginGuide(c.unlockWeak)
self:closeSelf()
else
UIManager.info(checkData.desc)
end
elseif checkData.type==1 then
local c=cfgHelper.get2(cfg_worldglobalconfig_get,"blockConditionTipsWeak","value")
local weak=c[checkData.param[1]]
if weak then
weakGuideController:beginGuide(weak)
self:closeSelf()
else
UIManager.info(checkData.desc)
end
end
else
if self.lack then
gainControl:showGainWin(self.lack)
else
worldBlockController:send_5_2(self.world,self.block)
worldController:selectCloud()
self:closeSelf()
end
end
end

function UIWorldBlockUnlockWin:onClickClose()
self:closeSelf()
end

function UIWorldBlockUnlockWin:refreshComsume()
local consume=self.config.consume[1]
local itemId=consume[1]
local need=consume[2]
local have=itemsModel.getCount(itemId)
self.costIcon:setImageIcon(iconHelper.getIconName(itemId),false)
local numStr=FMT.fmt("{0}/{1}",have,need)
if have<need then
numStr=FMT.cfmt(FONT_COLOR.eRedColor,numStr)
end
self.costNum:setText(numStr)
end

function UIWorldBlockUnlockWin:setButtonCost()
for i,v in ipairs(self.config.consume)do
local itemId=v[1]
local need=v[2]
local have=itemsModel.getCount(itemId)
if have<need then
self.lack=itemId
self.unlockBtnText:setText(FMT.fmt("获取{0}",itemsConfig.getItemName(itemId)))
return
end
end
self.unlockBtnText:setText("解  封")
end

function UIWorldBlockUnlockWin.onMoneyChanged(moneyType,oldVal,newVal)
if moneyType==_this.config.consume[1][1]then
_this:refreshComsume()
if not _this.check then
_this:setButtonCost()
end
end
end