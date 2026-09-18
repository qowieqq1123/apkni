







def_class("UIWanLingTa_TDLX",UIWindowBase)









function UIWanLingTa_TDLX:bindComponents()

self.attrContent=UIObject.get(self,0)
self.attrPanel=UIObject.get(self,1)
self.attrPanelMask=UIButton.get(self,2)
self.emptyAttrTips=UIText.get(self,3)
self.helpBtn=UIButton.get(self,4)
self.leftArrow=UIButton.get(self,5)
self.leftArrowReddot=UIObject.get(self,6)
self.rightArrow=UIButton.get(self,7)
self.rightArrowReddot=UIObject.get(self,8)
self.root=UIObject.get(self,9)
self.showItem_1=UIObject.get(self,10)
self.showItem_2=UIObject.get(self,11)
self.showItem_3=UIObject.get(self,12)
self.showItem_4=UIObject.get(self,13)
self.showItem_5=UIObject.get(self,14)
self.showLayout=UIObject.get(self,15)
self.suitContent=UIObject.get(self,16)
self.suitDesc=UIText.get(self,17)
self.tipsBtn=UIButton.get(self,18)
self.treasureNum=UIText.get(self,19)

self.attrPanelMask:setButtonClick(function()self:onAttrPanelMask()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.leftArrow:setButtonClick(function()self:onLeftArrow()end)

self.rightArrow:setButtonClick(function()self:onRightArrow()end)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)
self.showItem={
self.showItem_1,
self.showItem_2,
self.showItem_3,
self.showItem_4,
self.showItem_5,
}



end


function UIWanLingTa_TDLX:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrContent);self.attrContent=nil;
_UIObject_release(self.attrPanel);self.attrPanel=nil;
_UIObject_release(self.attrPanelMask);self.attrPanelMask=nil;
_UIObject_release(self.emptyAttrTips);self.emptyAttrTips=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.leftArrow);self.leftArrow=nil;
_UIObject_release(self.leftArrowReddot);self.leftArrowReddot=nil;
_UIObject_release(self.rightArrow);self.rightArrow=nil;
_UIObject_release(self.rightArrowReddot);self.rightArrowReddot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.showItem_1);self.showItem_1=nil;
_UIObject_release(self.showItem_2);self.showItem_2=nil;
_UIObject_release(self.showItem_3);self.showItem_3=nil;
_UIObject_release(self.showItem_4);self.showItem_4=nil;
_UIObject_release(self.showItem_5);self.showItem_5=nil;
_UIObject_release(self.showLayout);self.showLayout=nil;
_UIObject_release(self.suitContent);self.suitContent=nil;
_UIObject_release(self.suitDesc);self.suitDesc=nil;
_UIObject_release(self.tipsBtn);self.tipsBtn=nil;
_UIObject_release(self.treasureNum);self.treasureNum=nil;
self.showItem=nil;
end


















local abName="ui/windows/wanlingta/wanlingtaspriteatlas_pak.ab"
local this

function UIWanLingTa_TDLX:onLoaded(...)
self:bindComponents()
this=self
self.type=eWanLingTaShowcaseType.eTDLX
self:addNotify(notifyConfig.onWanLingTaTuJianChange,self.onWanLingTaTuJianChange)
end


function UIWanLingTa_TDLX:__delete()
self:unbindComponents()
this=nil
end




function UIWanLingTa_TDLX:onShow(argtable,afterOnloaded)
self.page=1
self.config=cfg_xumitatdlxgroupconfig()
self.maxPage=#self.config
if argtable and argtable.tj_id then
local ok=false
for groupid,v in ipairs(self.config)do
for _,id in ipairs(v.idGroup)do
if argtable.tj_id==id then
self.page=groupid
ok=true
break
end
end
if ok then
break
end
end
else
local ok=false
for groupid,v in ipairs(self.config)do
for _,id in ipairs(v.idGroup)do
if wanLingTaModel:checkTuJianReddot(id)then
self.page=groupid
ok=true
break
end
end
if ok then
break
end
end
end

if argtable and argtable.showAnim then
self.root:setChildAnchoredPos(0,-800)
local tween=self.root:setChildDOAnchorPosY(0,2)
tween:SetEase(_Ease.Linear)
UIManager:invokeUIMethod("UIWanLingTaBgWin","moveAnim")
else
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6)
end

self:refreshSuitList()
self:refreshShowcase()
self:refreshArrow()
self:refreshAttrInfo()
end

function UIWanLingTa_TDLX.onWanLingTaTuJianChange(tjId,tjLevel)
this:refreshSuitList()
this:refreshShowcase()
this:refreshAttrInfo()
this:checkPageReddot(true)
end

function UIWanLingTa_TDLX:refreshSuitList()
local num=#self.config
self.suitContent:setChildLayoutGroupCreateItems(num,function(index)
local suitItem=self.suitContent:getChildLayoutGroupGridItem(index-1)
local cfg=self.config[index]
local total=#cfg.idGroup
local activeNum=0
local reddot=false
for i,v in ipairs(cfg.idGroup)do
if wanLingTaModel:checkTuJianReddot(v)then
reddot=true
end
local data=wanLingTaModel:getTuJianData(v)
if data.level>0 then
activeNum=activeNum+1
end
end

suitItem:SetChildActive(0,index==self.page)

suitItem:SetChildText(1,cfg.name)

suitItem:SetChildText(2,string.format("%d/%d",activeNum,total))

suitItem:SetChildButtonClick(3,function()
if not self or self.isClose then return end
self:onClickSuit(index)
end)

suitItem:SetChildActive(4,reddot)
end)
end

function UIWanLingTa_TDLX:onClickSuit(index)
if self.page==index then
return
end
local suitItem=self.suitContent:getChildLayoutGroupGridItem(self.page-1)
suitItem:SetChildActive(0,false)
self.page=index
suitItem=self.suitContent:getChildLayoutGroupGridItem(self.page-1)
suitItem:SetChildActive(0,true)
self:refreshShowcaseFade()
self:refreshArrow()
end

function UIWanLingTa_TDLX:refreshShowcase()
local groupCfg=self.config[self.page]
local idGroup=groupCfg.idGroup
for i,v in ipairs(self.showItem)do
local itemWidget=v:getChildWidgetBase()
local tj_id=idGroup[i]
if tj_id then
itemWidget:SetChildActive(-1,true)
local tj_conf=wanLingTaModel:getTuJianConfig(tj_id)
local tj_data=wanLingTaModel:getTuJianData(tj_id)
local isActive=tj_data.level>0
local reddot=wanLingTaModel:checkTuJianReddot(tj_id)
itemWidget:SetChildImageExGray(0,not isActive)
itemWidget:SetChildText(1,isActive and tj_conf.name or"未收集")
itemWidget:SetChildActive(2,not isActive)
itemWidget:SetChildActive(4,reddot)
itemWidget:SetChildButtonClick(3,function()
if not self or self.isClose then return end
self:onClickTuJian(tj_id)
end)

if isActive then
if tj_conf.color>=5 then
itemWidget:SetChildIcon(0,nil,true)
itemWidget:SetChildDOTweenAnimation_DOPause(0)
itemWidget:SetChildAnchoredPos(0,0,30)
else
itemWidget:SetChildIcon(0,tj_conf.icon,true)
itemWidget:SetChildAnchoredPos(0,0,30)
itemWidget:SetChildDOTweenAnimation_DOPlay(0,nil,0,2)
end
itemWidget:SetChildShowEffect(5,tj_conf.iconEffect,true)
local size=tj_conf.iconEffectSize[1]
itemWidget:SetChildScale(5,Vector3(size,size,size))
itemWidget:SetChildAnchoredPos(5,0,30)
itemWidget:SetChildDOTweenAnimation_DOPlay(5,nil,0,2)
else
itemWidget:SetChildIcon(0,tj_conf.icon,true)
itemWidget:SetChildShowEffect(5,0,false)
itemWidget:SetChildDOTweenAnimation_DOPause(0)
itemWidget:SetChildAnchoredPos(0,0,30)
itemWidget:SetChildDOTweenAnimation_DOPause(5)
itemWidget:SetChildAnchoredPos(5,0,30)
end
else
itemWidget:SetChildActive(-1,false)
end
end
end

function UIWanLingTa_TDLX:onClickTuJian(tj_id)
local tj_conf=wanLingTaModel:getTuJianConfig(tj_id)
local icon
local effect=tj_conf.iconEffect
local effectSize=tj_conf.iconEffectSize[2]
if tj_conf.color<5 then
icon=tj_conf.icon
if tj_conf.iconBig then
icon=tj_conf.iconBig
end
end
self:showWindow("UIWanLingTaTDLXActiveTip",{tj_id=tj_id,effect=effect,effectSize=effectSize,icon=icon})
end

function UIWanLingTa_TDLX:refreshArrow()
self.leftArrow:setActive(self.page>1)
self.rightArrow:setActive(self.page<self.maxPage)
local min,max=self:checkPageReddot()
self.leftArrowReddot:setActive(min and self.page>min)
self.rightArrowReddot:setActive(max and self.page<max)
end

function UIWanLingTa_TDLX:refreshAttrInfo()
local attrsLookup=wanLingTaModel:getWanLingTaTypeAttrsLookup(self.type)
local attrsList=attrListHelper.transformToList(attrsLookup)
local len=#attrsList
self.attrContent:setChildLayoutGroupCreateItems(len,function(index)
local attrItem=self.attrContent:getChildLayoutGroupGridItem(index-1)
local attrType,attrValue=unpack(attrsList[index])
local attrName=helper.getAttributeName(attrType)
local attrStr=helper.getAttributeStrEx(attrType,attrValue)
attrItem:SetChildText(0,string.format("%s：",attrName))
attrItem:SetChildText(1,attrStr)
end)
self.emptyAttrTips:setActive(len<=0)
end

function UIWanLingTa_TDLX:checkPageReddot(refresh)
if not(self.minPageReddot and self.maxPageReddot)or refresh then
local min,max
for groupid,v in ipairs(self.config)do
for _,id in ipairs(v.idGroup)do
if wanLingTaModel:checkTuJianReddot(id)then
local page=groupid
if not min then
min=page
end
if not max then
max=page
end
if min>page then
min=page
end
if max<page then
max=page
end
break
end
end
end
self.minPageReddot=min
self.maxPageReddot=max
end
return self.minPageReddot,self.maxPageReddot
end

function UIWanLingTa_TDLX:refreshShowcaseFade()
self.showLayout:setChildCanvasGroupDOFade(0,0.1,function()
self:refreshShowcase()
self.showLayout:setChildCanvasGroupDOFade(1,0.1)
end)
end


function UIWanLingTa_TDLX:onLeftArrow()
if self.page<=1 then return end
local suitItem=self.suitContent:getChildLayoutGroupGridItem(self.page-1)
suitItem:SetChildActive(0,false)
self.page=self.page-1
suitItem=self.suitContent:getChildLayoutGroupGridItem(self.page-1)
suitItem:SetChildActive(0,true)
self:refreshShowcaseFade()
self:refreshArrow()
end

function UIWanLingTa_TDLX:onRightArrow()
if self.page>=self.maxPage then return end
local suitItem=self.suitContent:getChildLayoutGroupGridItem(self.page-1)
suitItem:SetChildActive(0,false)
self.page=self.page+1
suitItem=self.suitContent:getChildLayoutGroupGridItem(self.page-1)
suitItem:SetChildActive(0,true)
self:refreshShowcaseFade()
self:refreshArrow()
end

function UIWanLingTa_TDLX:onAttrPanelMask()
self.attrPanel:setActive(false)
end

function UIWanLingTa_TDLX:onTipsBtn()
self.attrPanel:setActive(true)
end

function UIWanLingTa_TDLX:onHelpBtn()
local d={}
d.title='规则'
d.mode=3
d.name='wlt_tdlx_help_%d'
UIManager:showWindow('UIRuleWin',d)
end