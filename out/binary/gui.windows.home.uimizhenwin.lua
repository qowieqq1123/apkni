







def_class("UIMiZhenWin",UIWindowBase)









function UIMiZhenWin:bindComponents()

self.title=UIText.get(self,0)
self.icon=UIObject.get(self,1)
self.destext=UIText.get(self,2)
self.rwScrollview=UIObject.get(self,3)
self.openTips=UIText.get(self,4)
self.gotoBtn=UIButton.get(self,5)
self.gotoBtnText=UIText.get(self,6)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)



end


function UIMiZhenWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.destext);self.destext=nil;
_UIObject_release(self.rwScrollview);self.rwScrollview=nil;
_UIObject_release(self.openTips);self.openTips=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.gotoBtnText);self.gotoBtnText=nil;
end



















function UIMiZhenWin:onLoaded(...)
self:bindComponents()

self.rwScrollview:setChildScrollViewInit(1,true,nil,nil)
end


function UIMiZhenWin:__delete()
self:unbindComponents()

self:clearAddModel()

UIManager:hideWindow('UITopMoneyWin')
end

function UIMiZhenWin:showTopMoney(id)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)
local rewards=cfg.repair_reward
local mlist={}
for i,v in ipairs(rewards)do
if moneyConfig.isMoney(v[1])then
table.insert(mlist,{v[1],0})
end
end
UIManager:showWindow('UITopMoneyWin',mlist)
end




function UIMiZhenWin:onShow(argtable,afterOnloaded)
self.data=argtable
self:showTopMoney(self.data.id)
self:refresh()
end


function UIMiZhenWin:onHide()

end

function UIMiZhenWin:getTipsData(cfg)
local checkUnlock=isometricMapSystem:isInUnlockArea(self.data.guid)
local tipsdata=(not checkUnlock and cfg.repair_tips[2])and cfg.repair_tips[2]or cfg.repair_tips[1]
return tipsdata
end

function UIMiZhenWin:checkOpen(cfg)
if cfg.repair_tips then
local tipsdata=self:getTipsData(cfg)
local ctype=tipsdata.ctype
if ctype==1 then
local areaId=tipsdata.cargs[1]

local isUnlock=zongmenModel:isAreaUnlock(areaId)
return isUnlock
elseif ctype==2 then
local isOpen=systemModel.isOpen(tipsdata.cargs[1])
return isOpen
end
else
local isUnlock=isometricMapSystem:isInUnlockArea(self.data.guid)
return isUnlock
end
end

function UIMiZhenWin:addAModel(tran,model,offset)
local id=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDModel,tran,function(mId)
local widget=_InstantiateManager.GetComponent(mId,'CSGUIWidgetBase')
local scale=isometricMapSystem:getModelScale(model,true)
widget:SetChildUIModelShowTarget(0,model,scale,nil,eAnimationID.stand)
if offset then
widget:SetChildAnchoredPosition(0,Vector2.New(offset[1],offset[2]))
end
end)
return id
end

function UIMiZhenWin:createAddModel(add_model)
if self.modelList then
self:clearAddModel()
end
self.modelList={}
if add_model then
local tran=self.icon:getCommonComponent('Transform')
for i,v in ipairs(add_model)do
local id=self:addAModel(tran,v.model,v.ui_offset)
table_insert(self.modelList,id)
end
end
end

function UIMiZhenWin:clearAddModel()
if self.modelList then
for i,v in ipairs(self.modelList)do
_InstantiateManager.RemoveInstance(v)
end
self.modelList=nil
end
end

function UIMiZhenWin:refresh()
local id=self.data.id
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)
self.config=cfg
local levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,id,1)
self.destext:setText(levelCfg.build_desc)
local repairModel=self:getRepairModel(cfg)
local scale=isometricMapSystem:getModelScale(repairModel,true)
self.icon:setChildUIModelShowTarget(repairModel,scale,nil,eAnimationID.bd_stand)
self.title:setText(cfg.name)

local add_model=cfg.add_model
self:createAddModel(add_model)

local rewards=cfg.repair_reward
self.rwScrollview:setChildScrollViewCreateGrids(#rewards,0)
local grids=self.rwScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local node=grids[i]
local data=rewards[i+1]
widgetHelper.setNormalRewardItem(node,0,{data[1],data[2]})
end

local isOpen=self:checkOpen(cfg)

if isOpen then
self.openTips:setText('解除所有阵眼方能解封迷阵')
self.gotoBtnText:setText('前往阵眼')
else
local rtips=self:getTipsData(cfg)
local desc=rtips.desc
if rtips.ctype==1 then
local acfg=cfgHelper.get1(cfg_monijyareaconfig_get,rtips.cargs[1])
desc=FMT.fmt(desc,acfg.name)
end
self.openTips:setText(desc)
self.gotoBtnText:setText('前往')
end
end

function UIMiZhenWin:getRepairModel(cfg)
if cfg.sp_ui_model then
return cfg.sp_ui_model[0]
end
return cfg.repair_model[1]
end





function UIMiZhenWin:onGotoBtn()



if self.config.repair_tips then
local rtips=self:getTipsData(self.config)
local jtype=rtips.jump.jtype
if jtype==1 then
weakGuideController:beginGuide(rtips.jump.jargs[1])
elseif jtype==2 then
jumpManager:jump(rtips.jump.jargs)
end
self:onClickClose()
end
end

function UIMiZhenWin:onClickClose()
self:closeSelf()
end