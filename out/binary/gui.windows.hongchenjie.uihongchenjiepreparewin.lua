







def_class("UIHongChenJiePrepareWin",UIWindowBase)









function UIHongChenJiePrepareWin:bindComponents()

self.Root=UIObject.get(self,0)
self.uiRoot=UIObject.get(self,1)
self.spineBg=UIObject.get(self,2)
self.identityList=UIObject.get(self,3)
self.refreshBtn=UIButton.get(self,4)
self.identity_1=UIBaseItem.get(self,5)
self.identity_2=UIBaseItem.get(self,6)
self.identity_3=UIBaseItem.get(self,7)
self.refreshCountInfo=UIText.get(self,8)

self.refreshBtn:setButtonClick(function()self:onRefreshBtn()end)
self.identity={
self.identity_1,
self.identity_2,
self.identity_3,
}



end


function UIHongChenJiePrepareWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.spineBg);self.spineBg=nil;
_UIObject_release(self.identityList);self.identityList=nil;
_UIObject_release(self.refreshBtn);self.refreshBtn=nil;
_UIObject_release(self.identity_1);self.identity_1=nil;
_UIObject_release(self.identity_2);self.identity_2=nil;
_UIObject_release(self.identity_3);self.identity_3=nil;
_UIObject_release(self.refreshCountInfo);self.refreshCountInfo=nil;
self.identity=nil;
end
















local CmpIdentityItemSlotIndex={
lihui=0,
name=1,
startBtn=2,
effect1=3,
id=4,
nameBg=5,
effect2=6,
}

local identityAB='ui/windows/hongchenjie/hongchenjie_prepare_atals_pak.ab'

local identityLiHuiPreName='image_hongchenjie_sf'
local identityNamePreName='image_hongchenjie_sfwz'




function UIHongChenJiePrepareWin:onLoaded(...)
self:bindComponents()

self.btTreeList={}
end


function UIHongChenJiePrepareWin:__delete()
self:clearDTW()

self:unbindComponents()
end




function UIHongChenJiePrepareWin:onShow(argtable,afterOnloaded)

self.id=argtable.id
self.list=argtable.identityList
self.data=hongChenJieModel:getGameHandle(self.id)

self:refreshList()
self:refreshCount()
self:preparePlayAnim()

if afterOnloaded then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.spineBg:getID(),true,true,true)
self.spineBg:setChildUIModelShowTarget(5397,1,{},eAnimationID.stand)
end
end


function UIHongChenJiePrepareWin:onHide()

end

function UIHongChenJiePrepareWin:onShowArgRecv(args)
self:onShow(args)
end

function UIHongChenJiePrepareWin:refreshList()
for index,identity in ipairs(self.list)do
self:refreshIdentityInfo(index,identity)
end
end

function UIHongChenJiePrepareWin:refreshCount()
local identityRefreshCost=hongChenJieConfig.getBaseInfo(self.id,'identity_refresh')
local refreshCounted=self.data:getRefreshedTimes()
local totalCount=#identityRefreshCost
local info=FMT.fmt("身份刷新\n({0}/{1})",refreshCounted,totalCount)
self.refreshCountInfo:setText(info)
end

function UIHongChenJiePrepareWin:refreshIdentityInfo(index,identity)
local _this=self

local clickFunc=function(index)

hongChenJieController:reqStartGame(_this.id,identity)
end

local item=self.identity[index]
local itemWidght=item:getWidgetBase()

local identityCfg=cfgHelper.get1(cfg_hongchenjieidentityconfig_get,identity)
local identity_res_idx=identityCfg.identity_res_idx

local lihuiIconName=FMT.fmt("{0}{1}",identityLiHuiPreName,identity_res_idx)
itemWidght:SetChildCSImageSprite(CmpIdentityItemSlotIndex.lihui,identityAB,lihuiIconName)

local nameIconName=FMT.fmt("{0}{1}",identityNamePreName,identity_res_idx)
itemWidght:SetChildCSImageSprite(CmpIdentityItemSlotIndex.name,identityAB,nameIconName)

itemWidght:SetChildButtonClickWithID(CmpIdentityItemSlotIndex.startBtn,clickFunc,index,true)
itemWidght:SetChildShowEffect(CmpIdentityItemSlotIndex.effect1,20263,true)
itemWidght:SetChildShowEffect(CmpIdentityItemSlotIndex.effect2,20262,true)







end


function UIHongChenJiePrepareWin:onRefreshBtn()
local _this=self

self.isEnableRfresh=self.data:checkIdentityRefreshedTimes()
if self.isEnableRfresh then
local identityRefreshCost=hongChenJieConfig.getBaseInfo(self.id,'identity_refresh')
local refreshCounted=self.data:getRefreshedTimes()
local cost=identityRefreshCost[refreshCounted+1]
local isDialouge=cost[2]>0
local discipleguid=_this.data:getSelectDisciple()

if isDialouge then
local itemId=cost[1]
local needValue=cost[2]
local iconname=iconHelper.getIconName(itemId)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,52)
local str=FMT.fmt('是否确认花费{0}{1} 刷新身份？',iconStr,needValue)
local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=str,
oktext='购买',
canceltext='取消',
allowclickBG=false,
okcallback=function(...)
moneySystem:useMoney(itemId,needValue,function(...)
hongChenJieController:reqRandIdentiy(_this.id,discipleguid,HongChenJieRefreshIdentityState.refresh)
end,WARNING_TYPE.eWarning)
end,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
else
hongChenJieController:reqRandIdentiy(_this.id,discipleguid,HongChenJieRefreshIdentityState.refresh)
end
else
UIManager.error('身份刷新次数已用完')
end
end


function UIHongChenJiePrepareWin:playFreshIndentityAnim(id,identityList)
self.list=identityList

self:refreshCount()

self:clearDTW()

for index,item in ipairs(self.identity)do
local initData={
idenityIndex=index,
identityId=self.list[index],

obj=item,
widget=item:getWidgetBase(),

alphaFadeVal1=0.1,
alphaFadeValDuration1=0.2,

alphaFadeVal2=1,
alphaFadeValDuration2=0.3,

scaleFadeVal1=0.2,
scaleFadeValDuration1=0.2,

scaleFadeVal2=1.1,
scaleFadeValDuration2=0.3,

scaleFadeVal3=1,
scaleFadeValDuration3=0.1,

invokeWaitTime=0.2,

hideCmp=CmpIdentityItemSlotIndex.nameBg,
}
self.btTreeList[index]=behaviorManager:addBehaviorTree('bt_ui_hcj_prepare',{},true,initData)
end
end

function UIHongChenJiePrepareWin:clearDTW()
if self.btTreeList then
for k,dt in pairs(self.btTreeList)do
behaviorManager:removeBehaviorTree(dt)
dt=nil
end
end
end

function UIHongChenJiePrepareWin:preparePlayAnim()
for index,item in ipairs(self.identity)do
item:setChildCanvasGroupAlpha(1)
item:setScale(Vector3(1,1,1))
end
end


