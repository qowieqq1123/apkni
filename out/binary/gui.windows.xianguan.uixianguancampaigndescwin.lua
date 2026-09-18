







def_class("UIXianGuanCampaignDescWin",UIWindowBase)









function UIXianGuanCampaignDescWin:bindComponents()

self.descListPanel=UIObject.get(self,0)
self.dialougeText=UILinkImageText.get(self,1)
self.okButton=UIButton.get(self,2)
self.okText=UIText.get(self,3)
self.tabBtn=UIButton.get(self,4)
self.tipsRoot=UIButton.get(self,5)

self.okButton:setButtonClick(function()self:onOkButton()end)

self.tabBtn:setButtonClick(function()self:onTabBtn()end)

self.tipsRoot:setButtonClick(function()self:onTipsRoot()end)



end


function UIXianGuanCampaignDescWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.descListPanel);self.descListPanel=nil;
_UIObject_release(self.dialougeText);self.dialougeText=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.tabBtn);self.tabBtn=nil;
_UIObject_release(self.tipsRoot);self.tipsRoot=nil;
end
















local _this




function UIXianGuanCampaignDescWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXianGuanCampaignDescWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianGuanCampaignDescWin:onShow(argtable,afterOnloaded)
local officerId=argtable.officerId
self.initDescIdx=argtable.descIdx
self.okStr=argtable.okStr
self.okFunc=argtable.okFunc
self.jobCfg=xianguanConfig.getJobConfig(1,officerId)
self.descCfgs=self.jobCfg.campaignType==XianGuanCampaignType.eWenXuan and cfg_officerelectiondeclarationconfig()or cfg_officerelectiondeclaration2config()
self.selectDescIdx=self.initDescIdx or math.random(1,#self.descCfgs)
self.okText:setText(self.okStr or(self.initDescIdx==nil and"发 布"or"修改宣言"))

self:refreshDesc()
end


function UIXianGuanCampaignDescWin:onHide()

end


function UIXianGuanCampaignDescWin:refreshDesc()
local descStr=self.descCfgs[self.selectDescIdx].desc
self.dialougeText:setText(chatEmotHelper.decodeEmot(descStr))
end


function UIXianGuanCampaignDescWin:initDescListPanel()
local createFunc=function(index)
if _this==nil then return end

local item=_this.descListPanel:getChildLayoutGroupGridItem(index-1)

local cfg=_this.descCfgs[index]
item:SetChildText(0,chatEmotHelper.decodeEmot(cfg.desc))

local isSelect=_this.selectDescIdx==index
item:SetChildActive(1,isSelect)

local clickFunc=function()
if _this==nil then return end
if _this.selectDescIdx==index then return end
if _this.selectDescIdx~=nil then
local oldItem=_this.descListPanel:getChildLayoutGroupGridItem(_this.selectDescIdx-1)
oldItem:SetChildActive(1,false)
end
_this.selectDescIdx=index
item:SetChildActive(1,true)

_this:refreshDesc()
_this.tipsRoot:setActive(false)
end

item:SetChildButtonClick(2,clickFunc,true)
end

self.descListPanel:setChildLayoutGroupCreateItems(#self.descCfgs,createFunc)
end




function UIXianGuanCampaignDescWin:onOkButton()
if self.okFunc then
self.okFunc(self.selectDescIdx)
else
if self.jobCfg.campaignType==XianGuanCampaignType.eWenXuan then
local status=xianguanController:getActivitySegment_Enter_WenXuan_Compatible()
if status~=XianGuanWenXuanSegment.eRegister then
if self.initDescIdx~=nil then
UIManager.error("只有报名阶段才能修改宣言")
else
UIManager.error("只有报名阶段才能参选")
end
self:closeSelf()
return
end
end

if self.initDescIdx~=nil then
if self.initDescIdx==self.selectDescIdx then
UIManager.error("请选择不同的宣言")
return
end
if self.jobCfg.campaignType==XianGuanCampaignType.eWenXuan then
xianguanController:req_send_40_4(self.selectDescIdx)
else
xianguanController:send_40_25(self.selectDescIdx)
end
else
local config=xianguanController:getJingXuanConfig(self.jobCfg.campaignType)
if self.jobCfg.campaignType==XianGuanCampaignType.eWenXuan then
local currTime=timeHelper.getServerShortTime()
local lastCooldown=xianguanModel:getWenXuanLastCooldown()

local lerf=lastCooldown>0 and lastCooldown+config.cooldown_sec-currTime or 0
if lerf>0 then
UIManager.error(FMT.fmt("{0}秒后才能参选",lerf))
return
end
xianguanController:req_send_40_2(self.jobCfg.id,self.selectDescIdx)
else
xianguanController:send_40_25(self.selectDescIdx)
end
end
end
self:closeSelf()
end



function UIXianGuanCampaignDescWin:onTabBtn()
self.isTipsAnim=true
self.tipsRoot:setActive(true)
self.tipsRoot:setChildCanvasGroupAlpha(0)
self:delayDo(0.01,function()
_this.tipsRoot:setChildCanvasGroupDOFade(1,0.25,function()
self.isTipsAnim=false
end)
local maxY=math.max(#_this.descCfgs*62-248,0)
local _y=math.min(maxY,(_this.selectDescIdx-1)*62)
if not _this.initShowTips then
_this.initShowTips=true
_this:initDescListPanel()

self:delayDo(math.ceil(#_this.descCfgs/4)*0.04,function()
_this.descListPanel:setChildDOAnchorPosY(_y,0.1,nil)
end)
else
_this.descListPanel:setChildDOAnchorPosY(_y,0.1,nil)
end
end)
end



function UIXianGuanCampaignDescWin:onTipsRoot()
if self.isTipsAnim then
return
end
self.tipsRoot:setActive(false)
end
