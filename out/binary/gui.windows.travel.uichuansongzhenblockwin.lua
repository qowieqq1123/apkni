







def_class("UIChuanSongZhenBlockWin",UIWindowBase)









function UIChuanSongZhenBlockWin:bindComponents()

self.root=UIObject.get(self,0)
self.titleTx=UIText.get(self,1)
self.descTx=UIText.get(self,2)
self.effectList=UIObject.get(self,3)
self.repaired=UIObject.get(self,4)
self.conditions=UIObject.get(self,5)
self.costRoot=UIObject.get(self,6)
self.buildBtn=UIButton.get(self,7)
self.repairBtn=UIButton.get(self,8)
self.rewards=UIObject.get(self,9)

self.buildBtn:setButtonClick(function()self:onBuildBtn()end)

self.repairBtn:setButtonClick(function()self:onRepairBtn()end)



end


function UIChuanSongZhenBlockWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.titleTx);self.titleTx=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.effectList);self.effectList=nil;
_UIObject_release(self.repaired);self.repaired=nil;
_UIObject_release(self.conditions);self.conditions=nil;
_UIObject_release(self.costRoot);self.costRoot=nil;
_UIObject_release(self.buildBtn);self.buildBtn=nil;
_UIObject_release(self.repairBtn);self.repairBtn=nil;
_UIObject_release(self.rewards);self.rewards=nil;
end















local _this=nil
local _conditionCmp={
gou=0,
dian=1,
desc=2,
}
local moneyEx={[2]=3}
local emptyFunc=function()end



function UIChuanSongZhenBlockWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIChuanSongZhenBlockWin:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.swipe,self.on_swipe)
notifySystem:removelistener(notifyConfig.onClickEmptyInWorld,self.onClickEmptyInWorld)
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_change)
end




function UIChuanSongZhenBlockWin:onShow(argtable,afterOnloaded)
self.winArgs=argtable
self.unitKey=chuanSongZhenModel:convertUnitKey(self.winArgs.world,self.winArgs.block)
self.config=cfgHelper.get2(cfg_worldblocktransportconfig_get,self.winArgs.world,self.winArgs.block)
self.worldCfg=cfgHelper.get1(cfg_worldconfig_get,self.winArgs.world)

notifySystem:listenNotify(notifyConfig.swipe,self.on_swipe)
notifySystem:listenNotify(notifyConfig.onClickEmptyInWorld,self.onClickEmptyInWorld)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_change)

self.canClose=false

local callback=function()
self.canClose=true
end
self:rootAnimation(true,callback)

self:initPanel()
end


function UIChuanSongZhenBlockWin:onHide()
notifySystem:removelistener(notifyConfig.swipe,self.on_swipe)
notifySystem:removelistener(notifyConfig.onClickEmptyInWorld,self.onClickEmptyInWorld)
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_change)
end



function UIChuanSongZhenBlockWin.on_swipe()
if _this and _this.canClose then
worldController.on_swipe_end(0)
_this:onButtonClose()
end
end

function UIChuanSongZhenBlockWin.onClickEmptyInWorld()
if _this and _this.canClose then
_this:onButtonClose()
end
end

function UIChuanSongZhenBlockWin.on_money_change(moneyType,lastVal,val)
if _this then
for i,v in ipairs(_this.config.consume)do
if v[1]==moneyType then
local itemNum=v[2]
local haveNum=val
local countStr=mathHelper.formatNumber(itemNum)
if haveNum<itemNum then
countStr=FMT.fmt("<color=#ff3232>{0}</color>",countStr)
end
local prop={}
prop[PropIndex(DataPropKey.eWidgetText,3)]=countStr
local item=_this.rewards:getChildLayoutGroupGridItem(i-1)
item:SetChildPropData(-1,prop)
return
end
end
end
end


function UIChuanSongZhenBlockWin:onRepairBtn()
local open=chuanSongZhenModel:checkTransportConditions(self.config.condition)
if open then
for i,v in ipairs(self.config.consume)do
local itemId=v[1]
local need=v[2]
local enough=false
if not moneySystem:useMoney(itemId,need,function()enough=true end,WARNING_TYPE.eWarning,moneyEx[itemId])then
return
end
if not enough then
return
end
end
chuanSongZhenController:send_5_95(self.winArgs.world,self.winArgs.block)
else
UIManager.error("条件未达成")
end
end

function UIChuanSongZhenBlockWin:onBuildBtn()
cameraMoveController:Begin({eSceneType.eZongmen,mapIdType.zhufeng},{cameraMoveTargetType.eZongmeng_build6,SLG_SYSTEM_TYPE.eChuanSongZhen},function(flag,pos,backParams)
if flag then
local temp1=zongmenModel:getBuildingDataByBdId(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eChuanSongZhen)
if temp1~=nil and#temp1>0 then
local target=temp1[1]
isometricMapSystem:onTouchUp(nil,target.entityId)
return
end
local temp2=isometricMapSystem:getAllRepairData()
if temp2~=nil then
local buildInfoList={}
for k,data in pairs(temp2)do
if data.id==SLG_SYSTEM_TYPE.eChuanSongZhen then
isometricMapSystem:onTouchUp(nil,data.guid)
return
end
end
end

end
end)
end

function UIChuanSongZhenBlockWin:onButtonClose()
local returnHeight=self.winArgs.height
local cb=self.winArgs.callback
local unitKey=self.unitKey

worldController:resetRightView()
worldController:stopCameraControl()

local height=returnHeight
if not height then
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,worldModel.world)
height=worldCfg.cameraPos[2]
else
local range=worldController:getCameraZoomRange()
if range then
height=Mathf.Clamp(height,range[1],range[2])
end
end
worldController:lookAtUnit(unitKey,height,false,function()
worldController:resumeCameraControl()
if cb then cb()end
end)
end

function UIChuanSongZhenBlockWin:initPanel()
self.titleTx:setText(self.config.name)
self.descTx:setText(self.config.desc)

local effects={}
for i,v in pairs(self.config.money)do
table.insert(effects,i)
end
table.sort(effects)

self.effectList:setChildLayoutGroupCreateItems(#effects+1,function(index)
local item=self.effectList:getChildLayoutGroupGridItem(index-1)
if index==1 then
item:SetChildText(0,"缩短弟子派遣行走距离")
else
local mType=effects[index-1]
local value=self.config.money[mType]
local effectStr=FMT.fmt("{0}游历时获得的{1}+{2}%",self.worldCfg.name,itemsConfig.getItemName(mType),value)
item:SetChildText(0,effectStr)
end
end)

self.rewards:setChildLayoutGroupCreateItems(#self.config.consume,function(index)
local item=self.rewards:getChildLayoutGroupGridItem(index-1)
local costCfg=self.config.consume[index]
local itemId=costCfg[1]
local itemNum=costCfg[2]
local haveNum=itemsModel.getCount(itemId)
local countStr=mathHelper.formatNumber(itemNum)
if haveNum<itemNum then
countStr=FMT.fmt("<color=#ff3232>{0}</color>",countStr)
end
local conf={itemid=itemId,itemcount=countStr,showCountBG=true,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(-1,function(...)itemsComponentHelper.onItemClick(...)end)
item:SetChildPropData(-1,prop)
end)

self.conditions:setChildLayoutGroupCreateItems(#self.config.condition)

self:refreshPanel()
end

function UIChuanSongZhenBlockWin:refreshPanel()
local flag=chuanSongZhenModel:getFlagBit(self.winArgs.world,self.winArgs.block)
self.repaired:setActive(flag)
if flag then
self.conditions:setActive(false)
self.costRoot:setActive(false)
else
local open=chuanSongZhenModel:checkTransportConditions(self.config.condition)
self.costRoot:setActive(open)
self.conditions:setActive(not open)
if not open then
self:refreshConditions()
end
end
end

function UIChuanSongZhenBlockWin:refreshConditions()
local conditionList=self.conditions:getChildLayoutGroupGridList()
for i=1,conditionList.Count do
local conditionItem=conditionList[i-1]
local conditionCfg=self.config.condition[i]
local open=chuanSongZhenModel:checkTransportCondition(conditionCfg)
local str=chuanSongZhenModel:getTransportConditionStr(conditionCfg)
local color=open and"549327"or"65615F"
conditionItem:SetChildActive(_conditionCmp.gou,open)
conditionItem:SetChildText(_conditionCmp.desc,FMT.fmt("<color=#{1}>需要完成{0}</color>",str,color))
end
end

function UIChuanSongZhenBlockWin:refreshView(world,block)
if world==self.winArgs.world and block==self.winArgs.block then
self:refreshPanel()
end
end

function UIChuanSongZhenBlockWin:rootAnimation(show,callback)
local pos=show and-24 or 500
self.root:setChildDOAnchorPosX(pos,0.25,callback)
end
