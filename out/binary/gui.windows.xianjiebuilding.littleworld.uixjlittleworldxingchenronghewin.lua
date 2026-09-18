







def_class("UIXJLittleWorldXingChenRongHeWin",UIWindowBase)








function UIXJLittleWorldXingChenRongHeWin:bindComponents()

self.afterPanel=UIObject.get(self,0)
self.afterWidget=UIObject.get(self,1)
self.beforePanel=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.effect=UIObject.get(self,4)
self.fenliButton=UIButton.get(self,5)
self.finEffect=UIObject.get(self,6)
self.groupRoot=UIObject.get(self,7)
self.kongRoot=UIObject.get(self,8)
self.kongWidget_1=UIObject.get(self,9)
self.kongWidget_2=UIObject.get(self,10)
self.kongWidget_3=UIObject.get(self,11)
self.left=UIObject.get(self,12)
self.mask=UIObject.get(self,13)
self.materialsItem=UIBaseItem.get(self,14)
self.previewButton=UIButton.get(self,15)
self.previewRect=UIObject.get(self,16)
self.querenButton=UIButton.get(self,17)
self.querenButton2=UIButton.get(self,18)
self.rate=UIText.get(self,19)
self.ratePanel=UIObject.get(self,20)
self.rongheButton=UIButton.get(self,21)
self.root=UIObject.get(self,22)
self.tips=UIText.get(self,23)
self.tipsBg=UIObject.get(self,24)
self.titleKong=UIImage.get(self,25)
self.useCost=UIButton.get(self,26)
self.useCostCheck=UIObject.get(self,27)
self.wanfaButton=UIButton.get(self,28)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.fenliButton:setButtonClick(function()self:onFenliButton()end)

self.previewButton:setButtonClick(function()self:onPreviewButton()end)

self.querenButton:setButtonClick(function()self:onQuerenButton()end)

self.querenButton2:setButtonClick(function()self:onQuerenButton2()end)

self.rongheButton:setButtonClick(function()self:onRongheButton()end)

self.useCost:setButtonClick(function()self:onUseCost()end)

self.wanfaButton:setButtonClick(function()self:onWanfaButton()end)
self.kongWidget={
self.kongWidget_1,
self.kongWidget_2,
self.kongWidget_3,
}



end


function UIXJLittleWorldXingChenRongHeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.afterPanel);self.afterPanel=nil;
_UIObject_release(self.afterWidget);self.afterWidget=nil;
_UIObject_release(self.beforePanel);self.beforePanel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.fenliButton);self.fenliButton=nil;
_UIObject_release(self.finEffect);self.finEffect=nil;
_UIObject_release(self.groupRoot);self.groupRoot=nil;
_UIObject_release(self.kongRoot);self.kongRoot=nil;
_UIObject_release(self.kongWidget_1);self.kongWidget_1=nil;
_UIObject_release(self.kongWidget_2);self.kongWidget_2=nil;
_UIObject_release(self.kongWidget_3);self.kongWidget_3=nil;
_UIObject_release(self.left);self.left=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.materialsItem);self.materialsItem=nil;
_UIObject_release(self.previewButton);self.previewButton=nil;
_UIObject_release(self.previewRect);self.previewRect=nil;
_UIObject_release(self.querenButton);self.querenButton=nil;
_UIObject_release(self.querenButton2);self.querenButton2=nil;
_UIObject_release(self.rate);self.rate=nil;
_UIObject_release(self.ratePanel);self.ratePanel=nil;
_UIObject_release(self.rongheButton);self.rongheButton=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.tipsBg);self.tipsBg=nil;
_UIObject_release(self.titleKong);self.titleKong=nil;
_UIObject_release(self.useCost);self.useCost=nil;
_UIObject_release(self.useCostCheck);self.useCostCheck=nil;
_UIObject_release(self.wanfaButton);self.wanfaButton=nil;
self.kongWidget=nil;
end



















local PANEL_TYPE={
front=1,
afterUseItem=2,
afterNoUseItem=3,
}

local titleBgName={
"image_xiaoshijieui_45","image_xiaoshijieui_42","image_xiaoshijieui_44","image_xiaoshijieui_43"
}
local titleAbName="ui/windows/xianjiebuilding/littleworld/littleworld_atlas_pak.ab"


function UIXJLittleWorldXingChenRongHeWin:onLoaded(...)
self:bindComponents()

self.selectItemCall=function(mainEquip,childEquip,isLeft,pos)
self.selectMainItem=mainEquip
self.selectChildItem=childEquip
self:refreshItem_front(true)

end

self.bgAnim={}

self.selectMainItem=nil
self.selectChildItem=nil
self.groupIdx=1
self.isUseCost=userActorSetting.get('xc_rongHe_use_cost',nil)
end


function UIXJLittleWorldXingChenRongHeWin:__delete()
self:unbindComponents()

end




function UIXJLittleWorldXingChenRongHeWin:onShow(argtable,afterOnloaded)
self.isThisShow=true
local bagItem=xingChenHelper.getBagRongHeItem()
if not bagItem then
bagItem=xingChenHelper.getEquipRongHeItem()
end

UIManager:invokeUIMethod("UIPlanent","showStar",false)

self.root:setChildCanvasGroupAlpha(0)
local tween=self.root:setChildCanvasGroupDOFade(1,0.2)

self.panelType=bagItem~=nil and PANEL_TYPE.afterUseItem or PANEL_TYPE.front

if self.panelType==PANEL_TYPE.front then
if self.selectMainItem then
if not equipsHelper.getEquip(self.selectMainItem.itemguid)then
self.selectMainItem=nil
end
end
self.effect:setChildShowEffect(0,false)
self:refreshFront()
elseif self.panelType==PANEL_TYPE.afterUseItem then
xingChenBagProtocolControl.is_use=1
self.selectMainItem=bagItem
self.selectChildItem=equipsModel.getEquip(bagItem.itemData.minor_stars_guid)
self:refreshAfterUseItem()
end
end

local posname={"icon_xingchenfxwz_1","icon_xingchenfxwz_3","icon_xingchenfxwz_2","icon_xingchenfxwz_4"}

function UIXJLittleWorldXingChenRongHeWin:refreshBagTypePanel()
local pos=cfgHelper.get(cfg_starsbasicconfig_get,1,"pos")
self.groupRoot:setChildLayoutGroupCreateItems(#pos)
local grids=self.groupRoot:getChildLayoutGroupGridList()
for i=1,grids.Count do
local name=pos[i]
local grid=grids[i-1]
grid:SetChildCSImageSprite(0,"ui/windows/xianjiebuilding/littleworld/littleworld_atlas_pak.ab",posname[i])
grid:SetChildActive(1,self.groupIdx==i)
grid:SetChildButtonClick(2,function()
self:selectGroupItem(i)
self.selectMainItem=nil
self.selectChildItem=nil
self:refreshItem_front()
self:closeWindow("UIXJLittleWorldXingChenSelectWin")
end)
end
end

function UIXJLittleWorldXingChenRongHeWin:selectGroupItem(i)
if self.groupIdx then
local grid=self.groupRoot:getChildLayoutGroupGridItem(self.groupIdx-1)
if grid then
grid:SetChildActive(1,false)
end
end

local grid=self.groupRoot:getChildLayoutGroupGridItem(i-1)
if grid then
grid:SetChildActive(1,true)
end

self.groupIdx=i
self.titleKong:setSprite(titleAbName,titleBgName[self.groupIdx])
end

function UIXJLittleWorldXingChenRongHeWin:onShowArgRecv(argtable)
self:onShow(argtable)
end

function UIXJLittleWorldXingChenRongHeWin:showHand(flag)
if flag then
UIManager:invokeUIMethod("UIPlanent","setAnimator",7)
else
UIManager:invokeUIMethod("UIPlanent","setAnimator",8)
end
self.isShowHand=flag
end

function UIXJLittleWorldXingChenRongHeWin:playBgAnim(isLeft,pos)
local widget
if isLeft then
widget=self.kongWidget_1:getChildWidgetBase()
else
widget=self.kongWidget_2:getChildWidgetBase()
end
self.mask:setActive(true)
widget:SetChildPosition(2,pos)
local pos=widget:GetChildPosition(1)
local jumpCallBack=function()
self.mask:setActive(false)
widget:SetChildShowEffect(8,10405,true)
end
widget:SetChildDOJump(2,pos,-0.1,0,0.4,jumpCallBack)
end

function UIXJLittleWorldXingChenRongHeWin:stopBgAnim()

end

function UIXJLittleWorldXingChenRongHeWin:recvRongHe(affixList)
self.selectMainItem=equipsHelper.getEquip(self.selectMainItem.itemguid)
self.selectChildItem=equipsHelper.getEquip(self.selectChildItem.itemguid)
self.panelType=PANEL_TYPE.afterUseItem

self.effect:setChildShowEffect(20264,true)
local oriList=xingChenHelper.getAffixList(self.selectMainItem)
local seq=Lua.SequenceProxy.New()
seq:AppendInterval(0.5)
seq:AppendCallback(function()
self:showHand(true)
end)
local tween=self.root:setChildCanvasGroupDOFade(0,1,function()
self:refreshAfterUseItem(affixList,2.2,oriList)

end)
seq:Append(tween)
seq:AppendInterval(1.5)

local tween2=self.root:setChildCanvasGroupDOFade(1,0.7)
seq:Append(tween2)

end

function UIXJLittleWorldXingChenRongHeWin:recvRongHeNoUse(affixList)
self.selectMainItem=equipsHelper.getEquip(self.selectMainItem.itemguid)
self.selectChildItem=equipsHelper.getEquip(self.selectChildItem.itemguid)
self.panelType=PANEL_TYPE.afterUseItem

self.effect:setChildShowEffect(20264,true)
local oriList=xingChenHelper.getAffixList(self.selectMainItem)
local seq=Lua.SequenceProxy.New()
seq:AppendInterval(0.5)
seq:AppendCallback(function()
self:showHand(true)
end)
local tween=self.root:setChildCanvasGroupDOFade(0,1,function()
self:refreshAfterNoUseItem(affixList,2.2,oriList)
end)
seq:Append(tween)
seq:AppendInterval(1.5)

local tween2=self.root:setChildCanvasGroupDOFade(1,0.7)
seq:Append(tween2)
end

function UIXJLittleWorldXingChenRongHeWin:recvRongHeEnd()
self.selectMainItem=equipsHelper.getEquip(self.selectMainItem.itemguid)
self.selectChildItem=nil
self.panelType=PANEL_TYPE.front
self.groupIdx=itemsConfig.getConfig(self.selectMainItem.itemid).type1

self.effect:setChildShowEffect(22653,true)
self.mask:setActive(true)
self:delayDo(1,function()
self.mask:setActive(false)
self:refreshFront()
self:showWindow("UIXingChenRongHeGetWin",self.selectMainItem)
end)

end

function UIXJLittleWorldXingChenRongHeWin:recvRongHeCancel()
self.selectMainItem=equipsHelper.getEquip(self.selectMainItem.itemguid)
self.selectChildItem=nil
self.panelType=PANEL_TYPE.front
self.groupIdx=itemsConfig.getConfig(self.selectMainItem.itemid).type1

self.effect:setChildShowEffect(22653,true)
self.mask:setActive(true)
self:delayDo(1,function()
self.mask:setActive(false)
self:refreshFront()
self:showWindow("UIXingChenRongHeGetWin",self.selectMainItem)
end)
end



function UIXJLittleWorldXingChenRongHeWin:onHide()
if self.isThisShow then
self.selectChildItem=nil
if self.isShowHand then
self:showHand(false)
end
UIManager:invokeUIMethod("UIPlanent","showStar",true)
self.isThisShow=nil
end
end

function UIXJLittleWorldXingChenRongHeWin:refreshFront()
self.beforePanel:setActive(true)
self.afterPanel:setActive(false)

self:refreshCost()

self:refreshCenter()

self:refreshLeftItem_front(true)
self:refreshRightItem_front(true)

self:refreshBagTypePanel()

self.titleKong:setSprite(titleAbName,titleBgName[self.groupIdx])
end

function UIXJLittleWorldXingChenRongHeWin:refreshRate()

if self.selectMainItem then
local newRate=cfgHelper.get(cfg_starsbasicconfig_get,1,"fusion_add_rate")
local replaceRate=cfgHelper.get(cfg_starsbasicconfig_get,1,"fusion_replace_rate")
local affixList=xingChenHelper.getAffixList(self.selectMainItem)
local affix_num=#affixList
local nRate,rRate=0
for i,v in ipairs(newRate)do
if v[1]==affix_num then
nRate=v[2]
break
end
end
for i,v in ipairs(replaceRate)do
if v[1]==affix_num then
rRate=v[2]
break
end
end
self.rate:setText(FMT.fmt("新增词缀：<color=#aae252>{0}%</color>\n替换词缀：<color=#aae252>{1}%</color>",nRate/100,rRate/100))
end

end

function UIXJLittleWorldXingChenRongHeWin:refreshItem_front(hideTips)
self:refreshLeftItem_front(hideTips)
self:refreshRightItem_front(hideTips)

self:refreshCenter()
end

function UIXJLittleWorldXingChenRongHeWin:showSelectWin(extraParams)
self:showWindow('UIXingChenRongHeSelect2Win',extraParams)
end

function UIXJLittleWorldXingChenRongHeWin:refreshLeftItem_front(hideTips)
local selectMainItem=self.selectMainItem
local widget=self.kongWidget_1:getChildWidgetBase()
widget:SetChildActive(0,selectMainItem==nil)
widget:SetChildActive(1,selectMainItem~=nil)
widget:SetChildButtonClick(5,function()
widget:SetChildActive(3,false)
local widget2=self.kongWidget_2:getChildWidgetBase()
widget2:SetChildActive(3,false)






self:showSelectWin({isLeft=true,
selectMainItem=selectMainItem,
selectChildItem=self.selectChildItem,
callback=self.selectItemCall,
pos=self.groupIdx,})
end)
if selectMainItem~=nil then
local itemid=selectMainItem.itemid
widget:SetChildIcon(2,iconHelper.getIconName(itemid),false)
widget:SetChildActive(3,not hideTips)
widget:SetChildText(6,xingChenHelper.getXingChenName(selectMainItem))
local affixList=xingChenHelper.getAffixList(selectMainItem)
local affix_num=xingChenHelper.getAffixLimit(selectMainItem)

widget:SetChildLayoutGroupCreateItems(4,affix_num)
local grids=widget:GetChildLayoutGroupGridList(4)
for i=1,grids.Count do
local grid=grids[i-1]
local affix=affixList[i]
if affix then
local config=cfgHelper.get(cfg_starsaffixconfig_get,affix)
local ab,frame=xingChenHelper.getAffixColorFrame(config.color)
local name=xingChenHelper.getAffixNameStr(config.name)
grid:SetChildText(1,name)
grid:SetChildCSImageSprite(0,ab,frame)
grid:SetChildButtonClick(0,function()
self:showWindow("UILittleWorldAffixWin",{item=grid,node='bottom',config=config})
end)
end
grid:SetChildActive(4,affix~=nil)
grid:SetChildActive(5,affix==nil)
end




end

end

function UIXJLittleWorldXingChenRongHeWin:refreshRightItem_front(hideTips)
local selectChildItem=self.selectChildItem
local widget=self.kongWidget_2:getChildWidgetBase()
widget:SetChildActive(0,selectChildItem==nil)
widget:SetChildActive(1,selectChildItem~=nil)
widget:SetChildButtonClick(5,function()
widget:SetChildActive(3,false)
local widget1=self.kongWidget_1:getChildWidgetBase()
widget1:SetChildActive(3,false)






self:showSelectWin({isLeft=false,
selectMainItem=self.selectMainItem,
selectChildItem=self.selectChildItem,
callback=self.selectItemCall,
pos=self.groupIdx,})
end)
if selectChildItem~=nil then
local itemid=selectChildItem.itemid
widget:SetChildIcon(2,iconHelper.getIconName(itemid),false)
widget:SetChildActive(3,not hideTips)
widget:SetChildText(6,xingChenHelper.getXingChenName(selectChildItem))
local affixList=xingChenHelper.getAffixList(selectChildItem)
local affix_num=xingChenHelper.getAffixLimit(selectChildItem)
widget:SetChildLayoutGroupCreateItems(4,affix_num)
local grids=widget:GetChildLayoutGroupGridList(4)
if#affixList>0 then
for i=1,grids.Count do
local grid=grids[i-1]
local affix=affixList[i]
if affix then
local config=cfgHelper.get(cfg_starsaffixconfig_get,affix)
local ab,frame=xingChenHelper.getAffixColorFrame(config.color)
local name=xingChenHelper.getAffixNameStr(config.name)
grid:SetChildText(1,name)
grid:SetChildCSImageSprite(0,ab,frame)
grid:SetChildButtonClick(0,function()
self:showWindow("UILittleWorldAffixWin",{item=grid,node='bottom',config=config})
end)
end
grid:SetChildActive(4,affix~=nil)
grid:SetChildActive(5,affix==nil)
end
end

end
end

function UIXJLittleWorldXingChenRongHeWin:refreshAfterUseItem(affixList,delay,oriList)

self.afterPanel:setActive(true)
self.beforePanel:setActive(false)

self:refreshAfterItem(affixList,delay or 0,oriList)

self.fenliButton:setActive(true)
self.querenButton:setActive(true)
self.querenButton2:setActive(false)
end

function UIXJLittleWorldXingChenRongHeWin:refreshAfterNoUseItem(affixList,delay,oriList)
self.afterPanel:setActive(true)
self.beforePanel:setActive(false)

self:refreshAfterItem(affixList,delay or 0,oriList,true)

self.fenliButton:setActive(false)
self.querenButton:setActive(false)
self.querenButton2:setActive(true)
end

function UIXJLittleWorldXingChenRongHeWin:refreshAfterItem(fusionList,delay,oriList,hideOld)
local selectMainItem=self.selectMainItem
local widget=self.afterWidget:getChildWidgetBase()
if hideOld then
self.tipsBg:setActive(false)
widget:SetChildActive(6,false)
else
self.tipsBg:setActive(true)
widget:SetChildActive(6,true)
self:refreshAfterItemOld(oriList)
end

if selectMainItem~=nil then
local itemid=selectMainItem.itemid
widget:SetChildIcon(0,iconHelper.getIconName(itemid),false)
widget:SetChildText(2,xingChenHelper.getXingChenName(selectMainItem))
local equipFusion=xingChenBagModel:getRongHeAffixList()
if not equipFusion then
equipFusion=xingChenHelper.changeRongHeList(selectMainItem)
end
fusionList=fusionList or equipFusion
local affix_num=xingChenHelper.getAffixLimit(selectMainItem)
widget:SetChildLayoutGroupCreateItems(1,affix_num)
local grids=widget:GetChildLayoutGroupGridList(1)
local isReplace=selectMainItem.itemData.fusion_affix_id==1
if#fusionList>0 then
local affixList=oriList or xingChenHelper.getAffixList(selectMainItem)
local ori
local changeLookup={}
for i,v in ipairs(fusionList)do
changeLookup[v]=i
end
local lookup={}
for i,v in ipairs(affixList)do
lookup[v]=i
if not changeLookup[v]then
ori=v
end
end

for i=1,grids.Count do
local grid=grids[i-1]
local affix=fusionList[i]
if affix then
local config=cfgHelper.get(cfg_starsaffixconfig_get,affix)
local ab,frame=xingChenHelper.getAffixColorFrame(config.color)
local name=xingChenHelper.getAffixNameStr(config.name)

grid:SetChildButtonClick(0,function()
self:showWindow("UILittleWorldAffixWin",{item=grid,node='bottom',config=config})
end)
grid:SetChildActive(7,not lookup[affix])
if not lookup[affix]and delay>0 then
if not isReplace then

grid:SetChildText(1,name)

grid:SetChildCSImageSprite(0,ab,frame)
grid:SetChildCanvasGroupAlpha(4,0)
local sequenceProxy=Lua.SequenceProxy.New()
sequenceProxy:AppendInterval((delay or 0))
sequenceProxy:AppendCallback(function()
grid:SetChildShowEffect(2,10223,true)
end)
sequenceProxy:Append(grid:SetChildCanvasGroupDOFade(4,1,0.05,nil))
sequenceProxy:AppendInterval(1)
else
local ori=ori or affixList[i]
local oconfig=cfgHelper.get(cfg_starsaffixconfig_get,ori)
local oab,oframe=xingChenHelper.getAffixColorFrame(oconfig.color)
local oname=xingChenHelper.getAffixNameStr(oconfig.name)
grid:SetChildText(1,oname)
grid:SetChildCSImageSprite(0,oab,oframe)

local sequenceProxy=Lua.SequenceProxy.New()
sequenceProxy:AppendInterval((delay or 0))
sequenceProxy:AppendCallback(function()
grid:SetChildShowEffect(2,10030,true)
end)
sequenceProxy:AppendInterval(0.5)
sequenceProxy:AppendCallback(function()
grid:SetChildShowEffect(2,10223,true)
end)
sequenceProxy:AppendInterval(0.7)
sequenceProxy:Append(grid:SetChildCanvasGroupDOFade(4,0,0.05,function()
grid:SetChildText(1,name)
grid:SetChildCSImageSprite(0,ab,frame)
end))
sequenceProxy:Append(grid:SetChildCanvasGroupDOFade(4,1,1))
end
else
grid:SetChildText(1,name)
grid:SetChildCSImageSprite(0,ab,frame)
end
end
grid:SetChildActive(4,affix~=nil)
grid:SetChildActive(5,affix==nil)
end
end
end


end

function UIXJLittleWorldXingChenRongHeWin:refreshAfterItemOld(oriList)
local selectMainItem=self.selectMainItem
local affixList=oriList or xingChenHelper.getAffixList(selectMainItem)
local affix_num=xingChenHelper.getAffixLimit(selectMainItem)
local widget=self.afterWidget:getChildWidgetBase()
widget:SetChildLayoutGroupCreateItems(4,affix_num)
local grids=widget:GetChildLayoutGroupGridList(4)
for i=1,grids.Count do
local grid=grids[i-1]
local affix=affixList[i]
if affix then
local config=cfgHelper.get(cfg_starsaffixconfig_get,affix)
local ab,frame=xingChenHelper.getAffixColorFrame(config.color)
local name=xingChenHelper.getAffixNameStr(config.name)
grid:SetChildText(1,name)
grid:SetChildCSImageSprite(0,ab,frame)
grid:SetChildButtonClick(0,function()
self:showWindow("UILittleWorldAffixWin",{item=grid,node='bottom',config=config})
end)
end
grid:SetChildActive(4,affix~=nil)
grid:SetChildActive(5,affix==nil)
end
widget:SetChildText(5,xingChenHelper.getXingChenName(selectMainItem))
end

function UIXJLittleWorldXingChenRongHeWin:refreshCenter()
local selectMainItem=self.selectMainItem
local selectChildItem=self.selectChildItem
local widget=self.kongWidget_3:getChildWidgetBase()
if selectMainItem and selectChildItem then
widget:SetChildActive(1,true)
widget:SetChildActive(0,false)
local itemid=selectMainItem.itemid
widget:SetChildIcon(2,iconHelper.getIconName(itemid),false)

else
widget:SetChildActive(0,true)
widget:SetChildActive(1,false)
end
end





function UIXJLittleWorldXingChenRongHeWin:onCloseBtn()
UIFullLittleWorldControl:showXingChenMainWindow()
end



function UIXJLittleWorldXingChenRongHeWin:onFenliButton()
xingChenBagProtocolControl.req_37_79(self.selectMainItem.itemguid)
self:showHand(false)
end



function UIXJLittleWorldXingChenRongHeWin:onQuerenButton()
xingChenBagProtocolControl.req_37_78(self.selectMainItem.itemguid)
self:showHand(false)
end

function UIXJLittleWorldXingChenRongHeWin:onQuerenButton2()

self:showHand(false)
self:recvRongHeEnd()
end



function UIXJLittleWorldXingChenRongHeWin:onRongheButton()
if not self.selectMainItem or not self.selectChildItem then
UIManager.error("需要选择好融合素材")
return
end

local okCall=function(change,over)
if change and over then
local tips="融合后副星辰将被消耗，是否继续融合？"
local dialog=UIDialogManager.getConfirmDialog(nil,'提示',tips,'确定','取消',function()
xingChenBagProtocolControl.req_37_77(self.selectMainItem.itemguid,self.selectChildItem.itemguid,0)
end)
dialog:show()
else
xingChenBagProtocolControl.req_37_77(self.selectMainItem.itemguid,self.selectChildItem.itemguid,0)
end
end

local okCall2=function(change)
if not self:checkOver(okCall)then
okCall(change,true)
end
end
if not self:checkNoChange(okCall2)then
okCall2(true)
end
end

function UIXJLittleWorldXingChenRongHeWin:checkNoChange(okCall)
local equip=self.selectMainItem
local addItem=self.selectChildItem
local affixList=xingChenHelper.getAffixList(equip)
local childAffixList=xingChenHelper.getAffixList(addItem)
local diff_num=0
for _,v in ipairs(childAffixList)do
if not table.containsValue(affixList,v)then
diff_num=diff_num+1
break
end
end
if diff_num==0 then
local tips="当前选择的星辰融合后主星辰<color=#ca631d>随机词缀无变化</color>，是否继续融合？"
local dialog=UIDialogManager.getConfirmDialog(nil,'提示',tips,'确定','取消',okCall)
dialog:show()
return true
end
end

function UIXJLittleWorldXingChenRongHeWin:checkOver(okCall)
local equip=self.selectMainItem
local addItem=self.selectChildItem
local lv=xingChenHelper.getStarLevel(equip)
local addLv=xingChenHelper.getStarLevel(addItem)+1
local star_attrs=itemsConfig.getConfig(equip.itemid).star_attrs
local maxLv=#star_attrs
if lv+addLv>maxLv then
local compose_full_revert=cfgHelper.get(cfg_starsbasicconfig_get,1,"compose_full_revert")
local tips=string.format("当前选择的星辰融合后主星辰<color=#ca631d>满星溢出</color>，溢出的星级会按<color=#ca631d>分解星辰奖励的%d%%</color>进行补偿，是否继续融合？",compose_full_revert)
local dialog=UIDialogManager.getConfirmDialog(nil,'提示',tips,'确定','取消',okCall)
dialog:show()
return true
end
end



function UIXJLittleWorldXingChenRongHeWin:onWanfaButton()







local descFMT='xingchen_ronghe_%d'
self:showWindow('UIRuleScrollViewWin',{showBlack=true,mode=3,name=descFMT,title="规则介绍"})
end

function UIXJLittleWorldXingChenRongHeWin:onUseCost()
self.isUseCost=not self.isUseCost
self:refreshCost()
userActorSetting.flushVal('xc_rongHe_use_cost',self.isUseCost)
end

function UIXJLittleWorldXingChenRongHeWin:refreshCost()



end

function UIXJLittleWorldXingChenRongHeWin:onPreviewButton()
if self.panelType~=PANEL_TYPE.front then
return
end
self:showWindow("UIXingChenRongHePreviewWin",{self.selectMainItem,self.selectChildItem})
end
