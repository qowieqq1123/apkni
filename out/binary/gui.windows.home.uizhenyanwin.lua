







def_class("UIZhenYanWin",UIWindowBase)









function UIZhenYanWin:bindComponents()

self.gotoBtnText=UIText.get(self,0)
self.effect=UIObject.get(self,1)
self.destext=UIText.get(self,2)
self.rwScrollview=UIObject.get(self,3)
self.gotoBtn=UIButton.get(self,4)
self.icon=UIObject.get(self,5)
self.title=UIText.get(self,6)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)



end


function UIZhenYanWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.gotoBtnText);self.gotoBtnText=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.destext);self.destext=nil;
_UIObject_release(self.rwScrollview);self.rwScrollview=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.title);self.title=nil;
end
















local _this




function UIZhenYanWin:onLoaded(...)
self:bindComponents()

_this=self

self.rwScrollview:setChildScrollViewInit(0.5,true,nil,nil)

notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end


function UIZhenYanWin:__delete()
self:unbindComponents()

_this=nil

UIManager:hideWindow('UITopMoneyWin')

notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
end

function UIZhenYanWin.on_building_event(etype,sfId,bdId,arg1,arg2)
if etype==buildingEvent.buildComplete then
_this.model=2
_this.data=zongmenModel:getBuildingData(bdId)
_this:refresh()
_this.effect:setChildShowEffect(10060,true)
end
end

function UIZhenYanWin:showTopMoney(id)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)
local rewards=cfg.repair_cost[1]
local mlist={}
for i,v in ipairs(rewards)do
if moneyConfig.isMoney(v[1])then
table.insert(mlist,{v[1],0})
end
end
UIManager:showWindow('UITopMoneyWin',mlist)
end




function UIZhenYanWin:onShow(argtable,afterOnloaded)
self.model=argtable[1]
self.data=argtable[2]
self:refresh()
end


function UIZhenYanWin:onHide()

end

function UIZhenYanWin:refresh()
local id
if self.model==1 then
id=self.data.id
self.bdData=self.data.bdData
else
id=self.data.build_id
self.bdData=self.data
end
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)
self.config=cfg
local levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,id,1)
self.destext:setText(levelCfg.build_desc)
local repairModel=self:getRepairModel(cfg)
local scale=isometricMapSystem:getModelScale(repairModel,true)
self.icon:setChildUIModelShowTarget(repairModel,scale,nil,eAnimationID.bd_stand)
self.title:setText(cfg.name)

local rewards=cfg.repair_cost[1]
self.costData=rewards
local len=#rewards
self.rwScrollview:setChildScrollViewCreateGrids(len,math.min(len,4))
local grids=self.rwScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local node=grids[i]
local data=rewards[i+1]
widgetHelper.setNormalRewardItem(node,0,{data[1],data[2],checkAmount=true})
end
end

function UIZhenYanWin:getRepairModel(cfg)
if cfg.sp_ui_model then
return cfg.sp_ui_model[0]
end
return cfg.repair_model[1]
end





function UIZhenYanWin:checkCost(wraning)
for i,v in ipairs(self.costData)do
local id=v[1]
local need=v[2]
if moneyConfig.isMoney(id)then
local have=moneyModel.getMoney(id)
if have<need then
if wraning then
UIManager.error(FMT.fmt('{0}不足',moneyModel.getMoneyName(id)))
gainControl:showGainWin(id)
end
return false,id
end
else
local have=bagModel.getItemCountById(id)
if have<need then
if wraning then
UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(id)))
gainControl:showGainWin(id)
end
return false,id
end
end
end
return true
end

function UIZhenYanWin:onGotoBtn()
if not self:checkCost(true)then
return
end
local gdata=self.config.game
if gdata then
local sfId=zongmenModel:getMountainId()
local bdData=self.bdData
local gtype=gdata[1]
local args=gdata[2]
zongmenControl:playSmallGame(gtype,args,function(success)
local win=success>0
if win then

zongmenControl:reqBuild(sfId,bdData.build_id,bdData.x,bdData.y,bdData.orientation,0,0)
UIManager:closeWindow('UIZhenYanWin')
end
end,function()
zongmenControl:reqBuild(sfId,bdData.build_id,bdData.x,bdData.y,bdData.orientation,0,1)
end)
end
end

function UIZhenYanWin:onUnlockBtn()
if self:checkCost(true)then
local sfId=zongmenModel:getMountainId()
zongmenControl:reqBuild(sfId,self.data.id,self.data.x,self.data.y,0)
end
end

function UIZhenYanWin:onClickClose()
self:closeSelf()
end