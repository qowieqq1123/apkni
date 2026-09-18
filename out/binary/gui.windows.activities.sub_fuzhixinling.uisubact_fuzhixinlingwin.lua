







def_class("UISubAct_FuZhiXinLingWin",UIWindowBase)









function UISubAct_FuZhiXinLingWin:bindComponents()

self.bgImg=UIImage.get(self,0)
self.titleImg=UIImage.get(self,1)
self.descTitle=UIText.get(self,2)
self.descTx=UIText.get(self,3)
self.button=UIButton.get(self,4)
self.reddot=UIObject.get(self,5)
self.tokens=UIObject.get(self,6)
self.ruleIcon=UIImage.get(self,7)
self.timeBg=UIObject.get(self,8)
self.timeTx=UIText.get(self,9)

self.button:setButtonClick(function()self:onButton()end)



end


function UISubAct_FuZhiXinLingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgImg);self.bgImg=nil;
_UIObject_release(self.titleImg);self.titleImg=nil;
_UIObject_release(self.descTitle);self.descTitle=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.button);self.button=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.tokens);self.tokens=nil;
_UIObject_release(self.ruleIcon);self.ruleIcon=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
end















local _this=nil



function UISubAct_FuZhiXinLingWin:onLoaded(...)
self:bindComponents()
_this=self
self.instances={}
end


function UISubAct_FuZhiXinLingWin:__delete()
self:unbindComponents()
_this=nil
self:clearInstances()
self:stopCDTick()
end




function UISubAct_FuZhiXinLingWin:onShow(argtable,afterOnloaded)
if argtable then
local old=self.activityId==argtable.act_id and self.subType==argtable.sub_act_type and self.subId==argtable.sub_act_id
self.activityId=argtable.act_id
self.subType=argtable.sub_act_type
self.subId=argtable.sub_act_id
self.parentWin=argtable.parentWin
self.argtable=argtable
if not old then
self:clearInstances()
self:initView()
else
self:refresh()
end
end
end


function UISubAct_FuZhiXinLingWin:onHide()

end



function UISubAct_FuZhiXinLingWin:clearInstances()
for i,v in ipairs(self.instances)do
_InstantiateManager.RemoveInstance(v)
end
self.instances={}
end

function UISubAct_FuZhiXinLingWin:initView()
self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
local data=self.activityData:getData()
local reddot=not data or data<=0

local bgName=self.argtable.bg.name
local ab=FMT.fmt("ui/windows/activities/sub_fuzhixinling/sharedtextures/{0}.ab",bgName)
self.bgImg:setCSImageSprite(ab,bgName)

local titleName=self.argtable.title.name
local titleAb="ui/windows/activities/sub_fuzhixinling/fuzhixinling_title_atlas_pak.ab"
local titlePos=self.argtable.title.pos
self.titleImg:setCSImageSprite(titleAb,titleName)
self.winlua:SetChildAnchoredPos(self.titleImg:getID(),titlePos[1],titlePos[2])

local descStr=self.argtable.desc.content
local descSize=self.argtable.desc.size
local descPos=self.argtable.desc.pos
self.descTx:setText(descStr)
self.winlua:SetChildSizeDelta(self.descTx:getID(),descSize[1],descSize[2])
self.winlua:SetChildAnchoredPos(self.descTx:getID(),descPos[1],descPos[2])

local descTitleStr=self.argtable.descTitle.content
local descTitleSize=self.argtable.descTitle.size
local descTitlePos=self.argtable.descTitle.pos
self.descTitle:setText(descTitleStr)
self.winlua:SetChildSizeDelta(self.descTitle:getID(),descTitleSize[1],descTitleSize[2])
self.winlua:SetChildAnchoredPos(self.descTitle:getID(),descTitlePos[1],descTitlePos[2])

local bagModel=self.argtable.bag.model
local bagSize=self.argtable.bag.size
local bagPos=self.argtable.bag.pos
self.winlua:SetChildUIModelShowTarget(self.button:getID(),bagModel[1],bagModel[3],bagModel[2],0)
self.winlua:SetChildUIModelShowTargetOffset(self.button:getID(),bagModel[4],bagModel[5])
self.winlua:SetChildUIModelShowFlipX(self.button:getID(),bagModel[6]==1)
self.winlua:SetChildSizeDelta(self.button:getID(),bagSize[1],bagSize[2])
self.winlua:SetChildAnchoredPos(self.button:getID(),bagPos[1],bagPos[2])
self.winlua:SetChildActive(self.button:getID(),reddot)

self.winlua:SetChildActive(self.reddot:getID(),self.argtable.reddot~=nil)
if self.argtable.reddot then
local reddotPos=self.argtable.reddot.pos
self.winlua:SetChildAnchoredPos(self.reddot:getID(),reddotPos[1],reddotPos[2])
end

local commonAb="ui/windows/activities/sub_fuzhixinling/fuzhixinling_common_atlas_pak.ab"
local ruleIconImg=self.argtable.ruleIcon.name
local ruleIconPos=self.argtable.ruleIcon.pos
self.ruleIcon:setCSImageSprite(commonAb,ruleIconImg)
self.winlua:SetChildAnchoredPos(self.ruleIcon:getID(),ruleIconPos[1],ruleIconPos[2])

local tokenCfg=self.argtable.tokens
self.tokens:setChildLayoutGroupCreateItems(#tokenCfg,function(index)
local cfg=tokenCfg[index]
local item=self.tokens:getChildLayoutGroupGridItem(index-1)
local bgName=cfg.bg
local model=cfg.model
local hud=cfg.hud
item:SetChildAnchoredPos(-1,cfg.pos[1],cfg.pos[2])
item:SetChildCSImageSprite(0,commonAb,bgName)
local parent=item:GetCommonComponent(0,'Transform')
local instance=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDisciple,parent,function(id)
self:onModelLoaded(id,model,hud)
end)
table.insert(self.instances,instance)
end)

local cdInfo=self.argtable.cd
if cdInfo then
self.timeBg:setChildAnchoredPos(cdInfo.pos[1],cdInfo.pos[2])
self:startCDTick()
self.timeBg:setActive(true)
else
self:stopCDTick()
self.timeBg:setActive(false)
end
end

function UISubAct_FuZhiXinLingWin:onModelLoaded(id,model,hud)
local stWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
local bodyId=model[1]
local components=model[2]
local scale=model[3]
local anim=model[4]
local x=model[5]
local y=model[6]
local flip=model[7]==1
local hudID=hud[1]
local money=hud[2]
local flipHUD=hud[3]==1
local offsetX=hud[4]or 0
local offsetY=hud[5]or 0
stWidget:SetChildAnchoredPos(0,x,y)
stWidget:SetChildUIModelShowTarget(0,bodyId,scale,components,anim)
stWidget:SetChildUIModelShowFlipX(0,flip)
local parent=stWidget:GetCommonComponent(1,'Transform')
local instance=_InstantiateManager.AddInstance(hudID,parent,function(hudId)
self:onHUDLoaded(hudId,money,flipHUD,offsetX,offsetY)
end)
table.insert(self.instances,instance)
end

function UISubAct_FuZhiXinLingWin:onHUDLoaded(id,money,flip,offsetX,offsetY)
local stWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
local icon=iconHelper.getIconName(money)
stWidget:SetChildCSImageIcon(1,icon,true)
stWidget:SetChildScale(2,Vector3.New(flip and-1 or 1,1,1))
stWidget:SetChildAnchoredPos(0,offsetX,offsetY)
stWidget:SetChildButtonClick(2,function()
tipsManager.showTips({itemid=money})
end)
end

function UISubAct_FuZhiXinLingWin:refresh()
self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
local data=self.activityData:getData()
local reddot=not data or data<=0
self.winlua:SetChildActive(self.button:getID(),reddot)
if self.argtable.reddot then
self.reddot:setActive(reddot)
end
end

function UISubAct_FuZhiXinLingWin:onButton()
local data=self.activityData:getData()
if data and data<=0 then
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.activityId,self.subType,self.subId,"")
end
end

function UISubAct_FuZhiXinLingWin:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISubAct_FuZhiXinLingWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISubAct_FuZhiXinLingWin:updateCDTick()
local time=activitiesModel:getSubActEndLeftTime(self.activityId,self.subType,self.subId)
self.timeTx:setText(FMT.fmt(self.argtable.cd.str,timeHelper.format_time_stamp3(time)))
end