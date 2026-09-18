







def_class("UISubAct_previewWin",UIWindowBase)









function UISubAct_previewWin:bindComponents()

self.root=UIObject.get(self,0)
self.prizeBtn=UIButton.get(self,1)
self.arrowRoot=UIObject.get(self,2)
self.gainBtn=UIButton.get(self,3)
self.gbname=UIImage.get(self,4)
self.title=UIObject.get(self,5)
self.toggleBtn=UIButton.get(self,6)
self.tipsRoot=UIObject.get(self,7)
self.prizeReddot=UIObject.get(self,8)
self.btnLeftArrow=UIButton.get(self,9)
self.btnRightArrow=UIButton.get(self,10)
self.closeTag=UIObject.get(self,11)
self.openTag=UIObject.get(self,12)
self.timeText=UIText.get(self,13)
self.tipsCreater=UIObject.get(self,14)
self.tipsTitle1=UIObject.get(self,15)
self.tipsTitle2=UIObject.get(self,16)
self.tipsDesc=UIText.get(self,17)
self.content=UIObject.get(self,18)
self.modelItem=UIObject.get(self,19)

self.prizeBtn:setButtonClick(function()self:onPrizeBtn()end)

self.gainBtn:setButtonClick(function()self:onGainBtn()end)

self.toggleBtn:setButtonClick(function()self:onToggleBtn()end)

self.btnLeftArrow:setButtonClick(function()self:onBtnLeftArrow()end)

self.btnRightArrow:setButtonClick(function()self:onBtnRightArrow()end)



end


function UISubAct_previewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.prizeBtn);self.prizeBtn=nil;
_UIObject_release(self.arrowRoot);self.arrowRoot=nil;
_UIObject_release(self.gainBtn);self.gainBtn=nil;
_UIObject_release(self.gbname);self.gbname=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.toggleBtn);self.toggleBtn=nil;
_UIObject_release(self.tipsRoot);self.tipsRoot=nil;
_UIObject_release(self.prizeReddot);self.prizeReddot=nil;
_UIObject_release(self.btnLeftArrow);self.btnLeftArrow=nil;
_UIObject_release(self.btnRightArrow);self.btnRightArrow=nil;
_UIObject_release(self.closeTag);self.closeTag=nil;
_UIObject_release(self.openTag);self.openTag=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.tipsCreater);self.tipsCreater=nil;
_UIObject_release(self.tipsTitle1);self.tipsTitle1=nil;
_UIObject_release(self.tipsTitle2);self.tipsTitle2=nil;
_UIObject_release(self.tipsDesc);self.tipsDesc=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.modelItem);self.modelItem=nil;
end


















function UISubAct_previewWin:onLoaded(...)
self:bindComponents()
self.isToggle=true
self:addProNotify(249,114,function(actid,subId,flag)
self:freshReddot()
end)

end

function UISubAct_previewWin:__delete()
self:unbindComponents()
self.actModel=nil
self.gbidx=nil
end

function UISubAct_previewWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
end
self.gblist=baoLingShuModel:getPickUpShowGBList()

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.actModel=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if not self.actModel then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.beginTime=self.actModel.start_time
self.endTime=self.actModel.end_time

local len=#self.gblist
math.randomseed(os.time())
local randidx=math.random(1,len)
local gbidx=argtable and argtable.gbidx or self.gbidx or randidx
self.gbidx=gbidx

self:refresh()
end

function UISubAct_previewWin:onHide()
local widget=self.modelItem:getChildWidgetBase()
widget:SetChildShowEffect(0,0,false)
if self.modelTimer then
self:stopTimerByID(self.modelTimer)
end
self.modelTimer=nil
self.modelEffectid=nil
end





function UISubAct_previewWin:onToggleBtn()
self.isToggle=not self.isToggle
self:freshToggle()
self:freshTips()
self:freshModelInfo()
end



function UISubAct_previewWin:onGainBtn()
jumpManager:jump({id=JUMP_TYPE.eBuilding,
args={type=SLG_SYSTEM_TYPE.eBaoLingShu,isOpenRepairWin=true}},
nil,JUMP_BACK.eNoBack)
end



function UISubAct_previewWin:onPrizeBtn()
local reddot=self.actModel:checkReddot()
if reddot then
self.actModel:reqPrize()
else
UIManager.error('今日礼包已领')
end
end

function UISubAct_previewWin:onBtnRightArrow()
local gbidx=self.gbidx
local len=#self.gblist
local nextidx=gbidx+1
if nextidx>len then nextidx=1 end
self:onSelectGuBao(nextidx)
end



function UISubAct_previewWin:onBtnLeftArrow()
local gbidx=self.gbidx
local len=#self.gblist
local nextidx=gbidx-1
if nextidx<1 then nextidx=len end
self:onSelectGuBao(nextidx)
end


function UISubAct_previewWin:refresh()

self:freshModelInfo()

self:freshLeftTimer()

self:freshToggle()

self:freshReddot()

end


function UISubAct_previewWin:onSelectGuBao(gbidx)
if gbidx==self.gbidx then return end
self.gbidx=gbidx
self:freshModelInfo()
end

function UISubAct_previewWin:freshModelInfo()
local gbidx=self.gbidx
local gblist=self.gblist
local itemid=gblist[gbidx][1]
local gbid=gubaoLookup:good2GuBao(itemid)
local itemCfg=itemsConfig.getConfig(gbid,ITEM_CONFIG_TYPE.eGuBao)
local imagename=itemCfg.imagename or''
local abname=globalABLookup.gubaonamesprite
self.gbname:setSprite(abname,imagename)
self:fillModel()
self:freshTips()
end

function UISubAct_previewWin:fillModel()
local widget=self.modelItem:getChildWidgetBase()
local gblist=self.gblist
local gbidx=self.gbidx
local itemid=gblist[gbidx][1]
local gbid=gubaoLookup:good2GuBao(itemid)
local itemCfg=itemsConfig.getConfig(gbid,ITEM_CONFIG_TYPE.eGuBao)
local pram=itemCfg.relevantPram.pram
local icon=pram.icon or''
local effectid=pram.effectid
if effectid then
if self.modelEffectid~=effectid then
self.modelEffectid=effectid
widget:SetChildLocalPosX(0,10000)
widget:SetChildShowEffect(0,effectid,true)
if self.modelTimer then
self:stopTimerByID(self.modelTimer)
end
self.modelTimer=self:delayDo(0.1,function()
widget:SetChildLocalPosX(0,0)
end)
end
else
if self.modelTimer then
self:stopTimerByID(self.modelTimer)
end
widget:SetChildLocalPosX(0,0)
widget:SetChildShowEffect(0,0,false)
end
widget:SetChildCSImageIcon(1,icon,true)
end

function UISubAct_previewWin:freshToggle()
local isToggle=self.isToggle
self.closeTag:setActive(not isToggle)
self.openTag:setActive(isToggle)
end


function UISubAct_previewWin:freshLeftTimer()
if self.tickTimer then
self:stopTimerByID(self.tickTimer)
end
self.tickTimer=nil
local func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.endTime and self.endTime-nowTime or 0
if lerp>0 then
self.timeText:setText(FMT.fmt("活动时间：{0}",timeHelper.format_time_stamp3(lerp,true)))
else
self.timeText:setText("活动已结束")
if self.tickTimer then
self:stopTimerByID(self.tickTimer)
end
end
end

self.tickTimer=self:setTimer(1,0,func)

func()
end

function UISubAct_previewWin:freshTips()
self.tipsTitle1:setActive(self.isToggle)
self.tipsTitle2:setActive(not self.isToggle)

local gblist=self.gblist
local gbidx=self.gbidx or 1
local itemid=gblist[gbidx][1]
local gbid=gubaoLookup:good2GuBao(itemid)

local baseAttrs=cfgHelper.get2(cfg_gubaoconfig_get,gbid,'attr')
local len=#baseAttrs
local minAttrsLookup=gubaoModel:getMinAttrLookup(gbid)
local maxAttrsLookup=self.isToggle and gubaoModel:getMaxAttrLookup(gbid)
or minAttrsLookup
self.tipsCreater:setChildLayoutGroupCreateItems(len)
local grids=self.tipsCreater:getChildLayoutGroupGridList()
local bonusIdx=0
for i=1,len do
local item=grids[i-1]
local attr=baseAttrs[i]
local attrType=attr[1]
local attrValue=self.isToggle and maxAttrsLookup[attrType]or
minAttrsLookup[attrType]


self:fillAttr(item,attrType,attrValue,0)
end

local cfg=cfg_gubaoconfig_get(gbid)
local starlv=self.isToggle and#cfg.star or 0
local awakelv=self.isToggle and#cfg.awake or 0
local skilllv=self.isToggle and cfg.level and 1 or 0
local n_skilllv=self.isToggle and gubaoModel:getSkillLvEx(gbid,starlv,awakelv,skilllv)
or skilllv

local skill_str,skill_str_2,skill_str_3=gubaoModel:getSkillDesc(gbid,self.isToggle and n_skilllv or skilllv)
if skill_str_2 then
skill_str=FMT.fmt('{0}\n{1}',skill_str,skill_str_2)
end

self.tipsDesc:setText(skill_str)
end

function UISubAct_previewWin:fillAttr(item,attrType,attrValue,add)
local name,valstr=equipsHelper.getAttr(attrType,attrValue)
local attrStr=FMT.fmt('{0}：{1}',name,valstr)
item:SetChildText(0,attrStr)
item:SetChildActive(1,add>0)
if add>0 then
item:SetChildText(3,add)
end
end

function UISubAct_previewWin:freshReddot()
local reddot=self.actModel:checkReddot()
self.prizeReddot:setActive(reddot)
self.prizeBtn:setActive(reddot)
end