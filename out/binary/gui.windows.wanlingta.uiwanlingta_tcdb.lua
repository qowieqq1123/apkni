







def_class("UIWanLingTa_TCDB",UIWindowBase)









function UIWanLingTa_TCDB:bindComponents()

self.collectNum=UIText.get(self,0)
self.collectProgress=UIObject.get(self,1)
self.filterBtn=UIButton.get(self,2)
self.leftArrow=UIButton.get(self,3)
self.leftArrowReddot=UIObject.get(self,4)
self.rightArrow=UIButton.get(self,5)
self.rightArrowReddot=UIObject.get(self,6)
self.root=UIObject.get(self,7)
self.showGroup_1=UIObject.get(self,8)
self.showGroup_2=UIObject.get(self,9)

self.filterBtn:setButtonClick(function()self:onFilterBtn()end)

self.leftArrow:setButtonClick(function()self:onLeftArrow()end)

self.rightArrow:setButtonClick(function()self:onRightArrow()end)
self.showGroup={
self.showGroup_1,
self.showGroup_2,
}



end


function UIWanLingTa_TCDB:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.collectNum);self.collectNum=nil;
_UIObject_release(self.collectProgress);self.collectProgress=nil;
_UIObject_release(self.filterBtn);self.filterBtn=nil;
_UIObject_release(self.leftArrow);self.leftArrow=nil;
_UIObject_release(self.leftArrowReddot);self.leftArrowReddot=nil;
_UIObject_release(self.rightArrow);self.rightArrow=nil;
_UIObject_release(self.rightArrowReddot);self.rightArrowReddot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.showGroup_1);self.showGroup_1=nil;
_UIObject_release(self.showGroup_2);self.showGroup_2=nil;
self.showGroup=nil;
end


















local abName="ui/windows/wanlingta/wanlingtaspriteatlas_pak.ab"
local pageGroup=2
local groupCmp={
groupTitle=0,
showItem={1,2,3,4},
}
local this

function UIWanLingTa_TCDB:onLoaded(...)
self:bindComponents()
this=self
self.type=eWanLingTaShowcaseType.eTCDB
self:addNotify(notifyConfig.onWanLingTaTuJianChange,self.onWanLingTaTuJianChange)
end


function UIWanLingTa_TCDB:__delete()
self:unbindComponents()
this=nil
end




function UIWanLingTa_TCDB:onShow(argtable,afterOnloaded)
self.page=1
self.config=cfg_xumitatcdbgroupconfig()
self.maxPage=math.ceil(#self.config/pageGroup)
if argtable and argtable.tj_id then
local ok=false
for groupid,v in ipairs(self.config)do
for _,id in ipairs(v.idGroup)do
if argtable.tj_id==id then
self.page=math.ceil(groupid/pageGroup)
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
self.page=math.ceil(groupid/pageGroup)
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

self:refreshShowcase()
self:refreshCollectProgress()
self:refreshArrow()
end

function UIWanLingTa_TCDB.onWanLingTaTuJianChange(tjId,tjLevel)
this:refreshShowcase()
this:refreshCollectProgress()
this:checkPageReddot(true)
end

function UIWanLingTa_TCDB:refreshShowcase()
for i,v in ipairs(self.showGroup)do
local groupId=i+(self.page-1)*pageGroup
local groupCfg=self.config[groupId]
if groupCfg then
v:setActive(true)
local widget=v:getChildWidgetBase()
local idGroup=groupCfg.idGroup
widget:SetChildCSImageSprite(groupCmp.groupTitle,abName,groupCfg.groupIcon)
for ii,idx in ipairs(groupCmp.showItem)do
local tj_id=idGroup[ii]
if tj_id then
widget:SetChildActive(idx,true)
local itemWidget=widget:GetChildWidgetBase(idx)
local tj_conf=wanLingTaModel:getTuJianConfig(tj_id)
local tj_data=wanLingTaModel:getTuJianData(tj_id)
local isActive=tj_data.level>0
local reddot=wanLingTaModel:checkTuJianReddot(tj_id)

itemWidget:SetChildIcon(0,tj_conf.icon,true)
itemWidget:SetChildImageExGray(0,not isActive)
itemWidget:SetChildActive(1,not isActive)
itemWidget:SetChildText(2,isActive and tj_conf.name or"未收集")
itemWidget:SetChildActive(3,reddot)
itemWidget:SetChildButtonClick(4,function()
if not self or self.isClose then return end
self:onClickTuJian(tj_id)
end)
else
widget:SetChildActive(idx,false)
end
end
else
v:setActive(false)
end
end
end

function UIWanLingTa_TCDB:onClickTuJian(tj_id)
self:showWindow("UIWanLingTaActiveTip",{tj_id=tj_id})
end

function UIWanLingTa_TCDB:refreshArrow()
self.leftArrow:setActive(self.page>1)
self.rightArrow:setActive(self.page<self.maxPage)
local min,max=self:checkPageReddot()
self.leftArrowReddot:setActive(min and self.page>min)
self.rightArrowReddot:setActive(max and self.page<max)
end

function UIWanLingTa_TCDB:refreshCollectProgress()
local curCollect,maxCollect=wanLingTaModel:getCollectCount(self.type)
self.collectProgress:setChildIconFillAmount(curCollect/maxCollect)
self.collectNum:setText(string.format("总收集：%d/%d",curCollect,maxCollect))
end

function UIWanLingTa_TCDB:checkPageReddot(refresh)
if not(self.minPageReddot and self.maxPageReddot)or refresh then
local min,max
for groupid,v in ipairs(self.config)do
for _,id in ipairs(v.idGroup)do
if wanLingTaModel:checkTuJianReddot(id)then
local page=math.ceil(groupid/pageGroup)
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


function UIWanLingTa_TCDB:onLeftArrow()
if self.page<=1 then return end
self.page=self.page-1
for i,v in ipairs(self.showGroup)do
v:setChildCanvasGroupDOFade(0,0.1,function()
self:refreshShowcase()
v:setChildCanvasGroupDOFade(1,0.1)
end)
end
self:refreshArrow()
end

function UIWanLingTa_TCDB:onRightArrow()
if self.page>=self.maxPage then return end
self.page=self.page+1
for i,v in ipairs(self.showGroup)do
v:setChildCanvasGroupDOFade(0,0.1,function()
self:refreshShowcase()
v:setChildCanvasGroupDOFade(1,0.1)
end)
end
self:refreshArrow()
end

function UIWanLingTa_TCDB:onFilterBtn()

end