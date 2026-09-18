







def_class("UISubAct_DaoBingGeActiveWin",UIWindowBase)









function UISubAct_DaoBingGeActiveWin:bindComponents()

self.leftRoot=UIObject.get(self,0)
self.rightRoot=UIObject.get(self,1)



end


function UISubAct_DaoBingGeActiveWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.leftRoot);self.leftRoot=nil;
_UIObject_release(self.rightRoot);self.rightRoot=nil;
end


















function UISubAct_DaoBingGeActiveWin:onLoaded(...)
self:bindComponents()
end

function UISubAct_DaoBingGeActiveWin:__delete()
local widget=self.leftRoot:getChildWidgetBase()
widget:SetChildScrollViewStopGridCreate(0)
local widget=self.rightRoot:getChildWidgetBase()
widget:SetChildScrollViewStopGridCreate(0)
self:unbindComponents()
end

function UISubAct_DaoBingGeActiveWin:onShow(argtable,afterOnloaded)
local actId=argtable.actId
local subType=argtable.subType
local subId=argtable.subId
self.actId=actId
self.subType=subType
self.subId=subId
self.subCfg=activitiesModel:getSubActivityConfig(subType,subId)
self.model=activitiesModel:getSubActInfo(actId,subType,subId)
self.data=activitiesModel:getSubActInfoData(actId,subType,subId)
self:freshInfo()
end

function UISubAct_DaoBingGeActiveWin:onHide()

end


function UISubAct_DaoBingGeActiveWin:freshInfo()
local isRecharge=self.model:isRecharge()
self.leftRoot:setActive(not isRecharge)
if not isRecharge then
self:freshLeft()
self:freshRight()
else
self.rightRoot:setChildAnchoredPosition(Vector2.New(0,-44.5))
self:freshRight()
end
end

function UISubAct_DaoBingGeActiveWin:freshLeft()

local widget=self.leftRoot:getChildWidgetBase()

local recharge_rewards=self.subCfg.recharge_rewards[1]
local rechargeId=recharge_rewards[1]
local lv=self.data.lv
local rweards=self.model:getBuyPrize()
local len=#rweards
widget:SetChildScrollViewInit(0,0.5,true,nil,nil)
widget:SetChildScrollViewDelayCreateGrids(0,len,0,0.02,16,false,false,function(index,item)
local data=rweards[index+1]
widgetHelper.setNormalRewardItem(item,0,data)
end)

widget:SetChildButtonClick(1,function()
local params=payControl.getActivityPayParams(self.actId,self.subType,self.subId)
payControl.reqPay(rechargeId,1,params)
self:closeSelf()
end)


local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
widget:SetChildText(2,str)
end

function UISubAct_DaoBingGeActiveWin:freshRight()
local widget=self.rightRoot:getChildWidgetBase()
local isRecharge=self.model:isRecharge()
local recharge_rewards=isRecharge and self.subCfg.recharge_rewards[2]or
self.subCfg.recharge_rewards[3]

local rechargeId=recharge_rewards[1]
local rewards=recharge_rewards[3]
local addlv=recharge_rewards[2]
local len=#rewards
widget:SetChildScrollViewInit(0,0.5,true,nil,nil)
widget:SetChildScrollViewDelayCreateGrids(0,len,2,0.02,16,false,false,function(index,item)
local data=rewards[index+1]
widgetHelper.setNormalRewardItem(item,0,data)
end)


local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
widget:SetChildButtonClick(1,function()
local params=payControl.getActivityPayParams(self.actId,self.subType,self.subId)
payControl.reqPay(rechargeId,1,params)
self:closeSelf()
end)

widget:SetChildText(2,str)
end
