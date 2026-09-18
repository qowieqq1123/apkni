







def_class("UIWanLingTa_SBLQ",UIWindowBase)









function UIWanLingTa_SBLQ:bindComponents()

self.bgSpine=UIObject.get(self,0)
self.leftArrow=UIButton.get(self,1)
self.leftArrowReddot=UIObject.get(self,2)
self.moBtn=UIButton.get(self,3)
self.moBtnReddot=UIObject.get(self,4)
self.moBtnSelect=UIObject.get(self,5)
self.rightArrow=UIButton.get(self,6)
self.rightArrowReddot=UIObject.get(self,7)
self.root=UIObject.get(self,8)
self.showGroup_1=UIObject.get(self,9)
self.showGroup_2=UIObject.get(self,10)
self.uiCanvas=UIObject.get(self,11)
self.xianBtn=UIButton.get(self,12)
self.xianBtnReddot=UIObject.get(self,13)
self.xianBtnSelect=UIObject.get(self,14)

self.leftArrow:setButtonClick(function()self:onLeftArrow()end)

self.moBtn:setButtonClick(function()self:onMoBtn()end)

self.rightArrow:setButtonClick(function()self:onRightArrow()end)

self.xianBtn:setButtonClick(function()self:onXianBtn()end)
self.showGroup={
self.showGroup_1,
self.showGroup_2,
}



end


function UIWanLingTa_SBLQ:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.leftArrow);self.leftArrow=nil;
_UIObject_release(self.leftArrowReddot);self.leftArrowReddot=nil;
_UIObject_release(self.moBtn);self.moBtn=nil;
_UIObject_release(self.moBtnReddot);self.moBtnReddot=nil;
_UIObject_release(self.moBtnSelect);self.moBtnSelect=nil;
_UIObject_release(self.rightArrow);self.rightArrow=nil;
_UIObject_release(self.rightArrowReddot);self.rightArrowReddot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.showGroup_1);self.showGroup_1=nil;
_UIObject_release(self.showGroup_2);self.showGroup_2=nil;
_UIObject_release(self.uiCanvas);self.uiCanvas=nil;
_UIObject_release(self.xianBtn);self.xianBtn=nil;
_UIObject_release(self.xianBtnReddot);self.xianBtnReddot=nil;
_UIObject_release(self.xianBtnSelect);self.xianBtnSelect=nil;
self.showGroup=nil;
end



















local pageType={
xian=1,
mo=2,
}
local groupItemNum=4
local pageGroup=2
local pageItemNum=pageGroup*groupItemNum
local groupCmp={
showItem={0,1,2,3},
}
local this
function UIWanLingTa_SBLQ:onLoaded(...)
self:bindComponents()
this=self
self.xianConfig={}
self.moConfig={}
self.pageType=pageType.xian
local cfg=cfg_xumitasblqconfig()
for i,v in pairs(cfg)do
if v.type2==pageType.xian then
table.insert(self.xianConfig,v)
elseif v.type2==pageType.mo then
table.insert(self.moConfig,v)
end
end
self.config=self.xianConfig
self:addNotify(notifyConfig.onWanLingTaTuJianChange,self.onWanLingTaTuJianChange)
end


function UIWanLingTa_SBLQ:__delete()
self:unbindComponents()
this=nil
end




function UIWanLingTa_SBLQ:onShow(argtable,afterOnloaded)
if argtable and argtable.showAnim then
self.root:setChildAnchoredPos(0,-800)
local tween=self.root:setChildDOAnchorPosY(0,2)
tween:SetEase(_Ease.Linear)
UIManager:invokeUIMethod("UIWanLingTaBgWin","moveAnim")
else
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6)
end
self.bgSpine:setChildUIModelShowTarget(6252,1,{},eAnimationID.stand,false,false,0)
self:onXianBtn(true)
self:refreshArrow()
self:refreshBtnReddot()
end

function UIWanLingTa_SBLQ.onWanLingTaTuJianChange(tjId,tjLevel)
this:refreshShowcase()
if this.maxPage>1 then
this:checkPageReddot(true)
end
this:refreshBtnReddot()
end

function UIWanLingTa_SBLQ:refreshBtnReddot()
local xianBtnReddot=false
for i,v in ipairs(self.xianConfig)do
if wanLingTaModel:checkTuJianReddot(v.id)then
xianBtnReddot=true
break
end
end
local moBtnReddot=false
for i,v in ipairs(self.moConfig)do
if wanLingTaModel:checkTuJianReddot(v.id)then
moBtnReddot=true
break
end
end
self.xianBtnReddot:setActive(xianBtnReddot)
self.moBtnReddot:setActive(moBtnReddot)
end

function UIWanLingTa_SBLQ:refreshShowcase()
for i,v in ipairs(self.showGroup)do
local widget=v:getChildWidgetBase()
for ii,vv in ipairs(groupCmp.showItem)do
local idx=ii+(i-1)*groupItemNum+(self.page-1)*pageItemNum
local tj_conf=self.config[idx]
if tj_conf then
widget:SetChildActive(vv,true)
local itemWidget=widget:GetChildWidgetBase(vv)
local tj_id=tj_conf.id
local tj_data=wanLingTaModel:getTuJianData(tj_id)
local isActive=tj_data.level>0
local reddot=wanLingTaModel:checkTuJianReddot(tj_id)
local itemid=tj_conf.needItem
local name=itemsConfig.getItemName(itemid)
local iconName=iconHelper.getIconName(itemid)

itemWidget:SetChildIcon(0,iconName,true)
itemWidget:SetChildActive(1,not isActive)
itemWidget:SetChildText(2,name)
itemWidget:SetChildActive(3,reddot)
itemWidget:SetChildButtonClick(4,function()
if not self or self.isClose then return end
self:onClickTuJian(tj_id,idx,reddot)
itemWidget:SetChildActive(3,false)
end)
itemWidget:SetChildActive(5,tj_conf.type2==1)
itemWidget:SetChildActive(6,tj_conf.type2==2)
else
widget:SetChildActive(vv,false)
end
end
end
end

function UIWanLingTa_SBLQ:onClickTuJian(tj_id,idx,reddot)

local tj_conf=self.config[idx]
local itemid=tj_conf.needItem
if reddot then
local equip=bagControl.invokeFuncByItemId(itemid,'getItemByItemID',itemid)
if equip then
wanLingTaController.send_43_3(tj_id,1,{{equip.itemguid,0}})
return
end

local all_equip=equipsModel.getAllEquipByItemID(itemid)
for _,equip in ipairs(all_equip)do
local guid=equipsModel.getDiziguidByItemguid(equip.itemguid)
if guid then
wanLingTaController.send_43_3(tj_id,1,{{guid,1}})
return
end
end
else
tipsManager.showTips({itemid=itemid})
end

end

function UIWanLingTa_SBLQ:refreshArrow()
self.leftArrow:setActive(self.page>1)
self.rightArrow:setActive(self.page<self.maxPage)
if self.maxPage>1 then
local min,max=self:checkPageReddot()
self.leftArrowReddot:setActive(min and self.page>min)
self.rightArrowReddot:setActive(max and self.page<max)
end
end

function UIWanLingTa_SBLQ:checkPageReddot(refresh)
if not(self.minPageReddot and self.maxPageReddot)or refresh then
local min,max
for idx,v in ipairs(self.config)do
local tj_id=v.id
if wanLingTaModel:checkTuJianReddot(tj_id)then
local page=math.ceil(idx/pageItemNum)
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
end
end
self.minPageReddot=min
self.maxPageReddot=max
end
return self.minPageReddot,self.maxPageReddot
end


function UIWanLingTa_SBLQ:onXianBtn(init)
self.pageType=pageType.xian
self.config=self.xianConfig
self.page=1
self.maxPage=math.ceil(#self.config/pageItemNum)
self.xianBtnSelect:setActive(true)
self.moBtnSelect:setActive(false)
if init then
self.bgSpine:setChildModelAnimationState(eAnimationID.stand)
self:refreshShowcase()
else
self.uiCanvas:setChildCanvasGroupDOFade(0,0.1,function()
self.bgSpine:setChildModelAnimationState(eAnimationID.stand)
self:refreshShowcase()
self.uiCanvas:setChildCanvasGroupDOFade(1,0.1)
end)
end
self:refreshArrow()
end

function UIWanLingTa_SBLQ:onMoBtn(init)
self.pageType=pageType.mo
self.config=self.moConfig
self.page=1
self.maxPage=math.ceil(#self.config/pageItemNum)
self.xianBtnSelect:setActive(false)
self.moBtnSelect:setActive(true)
if init then
self.bgSpine:setChildModelAnimationState(eAnimationID.stand2)
self:refreshShowcase()
else
self.uiCanvas:setChildCanvasGroupDOFade(0,0.1,function()
self.bgSpine:setChildModelAnimationState(eAnimationID.stand2)
self:refreshShowcase()
self.uiCanvas:setChildCanvasGroupDOFade(1,0.1)
end)
end
self:refreshArrow()
end

function UIWanLingTa_SBLQ:onLeftArrow()
if self.page<=1 then return end
self.page=self.page-1
self.uiCanvas:setChildCanvasGroupDOFade(0,0.1,function()
self:refreshShowcase()
self.uiCanvas:setChildCanvasGroupDOFade(1,0.1)
end)
self:refreshArrow()
end

function UIWanLingTa_SBLQ:onRightArrow()
if self.page>=self.maxPage then return end
self.page=self.page+1
self.uiCanvas:setChildCanvasGroupDOFade(0,0.1,function()
self:refreshShowcase()
self.uiCanvas:setChildCanvasGroupDOFade(1,0.1)
end)
self:refreshArrow()
end

