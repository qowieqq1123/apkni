







def_class("UIXJLittleWorldXingChenUpWin",UIWindowBase)









function UIXJLittleWorldXingChenUpWin:bindComponents()

self.addLevel=UIText.get(self,0)
self.attrPanel=UIObject.get(self,1)
self.attrPanel2=UIObject.get(self,2)
self.BagList=UIScrollViewSlow.get(self,3)
self.bagNum=UIText.get(self,4)
self.ciZhuiPanel=UIObject.get(self,5)
self.ciZhuiPanel2=UIObject.get(self,6)
self.closeBtn=UIButton.get(self,7)
self.colorFrame=UIImage.get(self,8)
self.colorFrame2=UIImage.get(self,9)
self.curEquipFlag=UIObject.get(self,10)
self.effect_1=UIObject.get(self,11)
self.effect_2=UIObject.get(self,12)
self.effect_3=UIObject.get(self,13)
self.effect_4=UIObject.get(self,14)
self.effect_5=UIObject.get(self,15)
self.effect_6=UIObject.get(self,16)
self.effect_7=UIObject.get(self,17)
self.effect_8=UIObject.get(self,18)
self.effect1=UIObject.get(self,19)
self.effect2=UIObject.get(self,20)
self.fastButton=UIButton.get(self,21)
self.flyRoot=UIObject.get(self,22)
self.groupRoot=UIObject.get(self,23)
self.icon=UIImage.get(self,24)
self.icon2=UIImage.get(self,25)
self.item_1=UIBaseItem.get(self,26)
self.item_2=UIBaseItem.get(self,27)
self.item_3=UIBaseItem.get(self,28)
self.item_4=UIBaseItem.get(self,29)
self.item_5=UIBaseItem.get(self,30)
self.item_6=UIBaseItem.get(self,31)
self.item_7=UIBaseItem.get(self,32)
self.item_8=UIBaseItem.get(self,33)
self.jinglianlevel=UIText.get(self,34)
self.left=UIObject.get(self,35)
self.level=UIText.get(self,36)
self.level2=UIText.get(self,37)
self.lock=UIObject.get(self,38)
self.max=UIObject.get(self,39)
self.name=UIText.get(self,40)
self.name2=UIText.get(self,41)
self.poButton=UIButton.get(self,42)
self.poCostPanel=UIObject.get(self,43)
self.poitem_1=UIBaseItem.get(self,44)
self.poitem_2=UIBaseItem.get(self,45)
self.poitem_3=UIBaseItem.get(self,46)
self.poitem_4=UIBaseItem.get(self,47)
self.poitem_5=UIBaseItem.get(self,48)
self.progressBar=UIProgressBarAni.get(self,49)
self.progressBarReverse=UIProgressBarAni.get(self,50)
self.progressCount=UIText.get(self,51)
self.progressCountReverse=UIText.get(self,52)
self.raycast=UIObject.get(self,53)
self.right=UIObject.get(self,54)
self.right2=UIObject.get(self,55)
self.root=UIButton.get(self,56)
self.shaiXuanButton=UIButton.get(self,57)
self.star=UIObject.get(self,58)
self.star2=UIObject.get(self,59)
self.starAttrPanel=UIObject.get(self,60)
self.starAttrPanel2=UIObject.get(self,61)
self.starPanel=UIObject.get(self,62)
self.starPanel2=UIObject.get(self,63)
self.starText=UIText.get(self,64)
self.starText2=UIText.get(self,65)
self.upButton=UIButton.get(self,66)
self.upCostPanel=UIObject.get(self,67)
self.zhenxiEffect=UIObject.get(self,68)
self.zhenxiEffect2=UIObject.get(self,69)
self.zhenxiPanel=UIObject.get(self,70)
self.zhenxiPanel2=UIObject.get(self,71)

self.closeBtn:setButtonClick(function()
self:onCloseBtn()
end)

self.fastButton:setButtonClick(function()
self:onFastButton()
end)

self.poButton:setButtonClick(function()
self:onPoButton()
end)

self.root:setButtonClick(function()
self:onRoot()
end)

self.shaiXuanButton:setButtonClick(function()
self:onShaiXuanButton()
end)

self.upButton:setButtonClick(function()
self:onUpButton()
end)
self.effect={
self.effect_1,
self.effect_2,
self.effect_3,
self.effect_4,
self.effect_5,
self.effect_6,
self.effect_7,
self.effect_8,
}
self.item={
self.item_1,
self.item_2,
self.item_3,
self.item_4,
self.item_5,
self.item_6,
self.item_7,
self.item_8,
}
self.poitem={
self.poitem_1,
self.poitem_2,
self.poitem_3,
self.poitem_4,
self.poitem_5,
}



end


function UIXJLittleWorldXingChenUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addLevel);
self.addLevel=nil;
_UIObject_release(self.attrPanel);
self.attrPanel=nil;
_UIObject_release(self.attrPanel2);
self.attrPanel2=nil;
_UIObject_release(self.BagList);
self.BagList=nil;
_UIObject_release(self.bagNum);
self.bagNum=nil;
_UIObject_release(self.ciZhuiPanel);
self.ciZhuiPanel=nil;
_UIObject_release(self.ciZhuiPanel2);
self.ciZhuiPanel2=nil;
_UIObject_release(self.closeBtn);
self.closeBtn=nil;
_UIObject_release(self.colorFrame);
self.colorFrame=nil;
_UIObject_release(self.colorFrame2);
self.colorFrame2=nil;
_UIObject_release(self.curEquipFlag);
self.curEquipFlag=nil;
_UIObject_release(self.effect_1);
self.effect_1=nil;
_UIObject_release(self.effect_2);
self.effect_2=nil;
_UIObject_release(self.effect_3);
self.effect_3=nil;
_UIObject_release(self.effect_4);
self.effect_4=nil;
_UIObject_release(self.effect_5);
self.effect_5=nil;
_UIObject_release(self.effect_6);
self.effect_6=nil;
_UIObject_release(self.effect_7);
self.effect_7=nil;
_UIObject_release(self.effect_8);
self.effect_8=nil;
_UIObject_release(self.effect1);
self.effect1=nil;
_UIObject_release(self.effect2);
self.effect2=nil;
_UIObject_release(self.fastButton);
self.fastButton=nil;
_UIObject_release(self.flyRoot);
self.flyRoot=nil;
_UIObject_release(self.groupRoot);
self.groupRoot=nil;
_UIObject_release(self.icon);
self.icon=nil;
_UIObject_release(self.icon2);
self.icon2=nil;
_UIObject_release(self.item_1);
self.item_1=nil;
_UIObject_release(self.item_2);
self.item_2=nil;
_UIObject_release(self.item_3);
self.item_3=nil;
_UIObject_release(self.item_4);
self.item_4=nil;
_UIObject_release(self.item_5);
self.item_5=nil;
_UIObject_release(self.item_6);
self.item_6=nil;
_UIObject_release(self.item_7);
self.item_7=nil;
_UIObject_release(self.item_8);
self.item_8=nil;
_UIObject_release(self.jinglianlevel);
self.jinglianlevel=nil;
_UIObject_release(self.left);
self.left=nil;
_UIObject_release(self.level);
self.level=nil;
_UIObject_release(self.level2);
self.level2=nil;
_UIObject_release(self.lock);
self.lock=nil;
_UIObject_release(self.max);
self.max=nil;
_UIObject_release(self.name);
self.name=nil;
_UIObject_release(self.name2);
self.name2=nil;
_UIObject_release(self.poButton);
self.poButton=nil;
_UIObject_release(self.poCostPanel);
self.poCostPanel=nil;
_UIObject_release(self.poitem_1);
self.poitem_1=nil;
_UIObject_release(self.poitem_2);
self.poitem_2=nil;
_UIObject_release(self.poitem_3);
self.poitem_3=nil;
_UIObject_release(self.poitem_4);
self.poitem_4=nil;
_UIObject_release(self.poitem_5);
self.poitem_5=nil;
_UIObject_release(self.progressBar);
self.progressBar=nil;
_UIObject_release(self.progressBarReverse);
self.progressBarReverse=nil;
_UIObject_release(self.progressCount);
self.progressCount=nil;
_UIObject_release(self.progressCountReverse);
self.progressCountReverse=nil;
_UIObject_release(self.raycast);
self.raycast=nil;
_UIObject_release(self.right);
self.right=nil;
_UIObject_release(self.right2);
self.right2=nil;
_UIObject_release(self.root);
self.root=nil;
_UIObject_release(self.shaiXuanButton);
self.shaiXuanButton=nil;
_UIObject_release(self.star);
self.star=nil;
_UIObject_release(self.star2);
self.star2=nil;
_UIObject_release(self.starAttrPanel);
self.starAttrPanel=nil;
_UIObject_release(self.starAttrPanel2);
self.starAttrPanel2=nil;
_UIObject_release(self.starPanel);
self.starPanel=nil;
_UIObject_release(self.starPanel2);
self.starPanel2=nil;
_UIObject_release(self.starText);
self.starText=nil;
_UIObject_release(self.starText2);
self.starText2=nil;
_UIObject_release(self.upButton);
self.upButton=nil;
_UIObject_release(self.upCostPanel);
self.upCostPanel=nil;
_UIObject_release(self.zhenxiEffect);
self.zhenxiEffect=nil;
_UIObject_release(self.zhenxiEffect2);
self.zhenxiEffect2=nil;
_UIObject_release(self.zhenxiPanel);
self.zhenxiPanel=nil;
_UIObject_release(self.zhenxiPanel2);
self.zhenxiPanel2=nil;
self.effect=nil;
self.item=nil;
self.poitem=nil;
end


















local _colomn=4
local _creatGirdPrecent=500
local _fillItemLen=8


function UIXJLittleWorldXingChenUpWin:onLoaded(...)
self:bindComponents()

self.selectItemsLookup={}
self.selectList={}

self.BagList:setSlowClickAction(function(...)
self:onClickGrid(...)
end)

self.BagList:setSlowLongClickAction(function(...)
self:onClickLongGridButton(...)
end)

self.BagList:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)

self.onShowPrize=function(prizeType,temp,effectData,temp2)
if self and not self.isClose and self.isVisible then
if prizeType==ePrizeType.eNone then
self:freshBagGrids(true)
elseif prizeType==ePrizeType.eXingChenUpgrade then
self.upgradePrize={temp,effectData}
end
end
end
self:addNotify(notifyConfig.onShowPrize,self.onShowPrize)

self.selectEquip=nil
self.sortOrder=ITEM_SORT_COMPARE_TYPE.eDownOrder
end


function UIXJLittleWorldXingChenUpWin:__delete()
self:unbindComponents()
self:stopBehavior()
UIManager:invokeUIMethod("UIPlanent","removeBigOrbit")
end




function UIXJLittleWorldXingChenUpWin:onShow(argtable,afterOnloaded)
local equip=argtable.equip
self.equip=equip
self.itemId=equip.itemid
self.itemguid=equip.itemguid
self.itemConfig=itemsConfig.getConfig(self.itemId)
self.pos=self.itemConfig.type1

self.selectItemsLookup={}
self.selectList={}
self.addItemExp=0
self.addLv=0
self.leftExp=0
self.overExp=0
self.total=0

self.groupIdx=nil

self:freshInfo()
self:setAffixPanel()

self:refreshBagTypePanel()
self:selectGroupItem(self.pos)

if not self.isThisShow then
self:refreshCenter()
end
self.isThisShow=true

end

function UIXJLittleWorldXingChenUpWin:onShowArgRecv(argtable)
self:onShow(argtable)
end

function UIXJLittleWorldXingChenUpWin:refreshCenter()

UIManager:callWindowFunc("UIXJLittleWorldXingChenInfoWin","clearFirst")


UIManager:invokeUIMethod("UIPlanent","setAnimator",7)
if not self.showFirst then
self:delayDo(0.5,function()

end)
else

end

end

function UIXJLittleWorldXingChenUpWin:freshInfo()
self:setShowItems()
self:setProgress()

self:setDropdowns()
self:setSelectItems()
self:setAttrs()
self:refreshStarPanel()
end

function UIXJLittleWorldXingChenUpWin:recvUpgrade()
self:startBehavior()
end

function UIXJLittleWorldXingChenUpWin:recvBroke(pos)

self.right2:setChildCanvasGroupAlpha(0)
local seq=Lua.SequenceProxy.New()
seq:AppendCallback(function()
self.raycast:setActive(true)
self.left:setChildDOAnchorPosX(-500,0.2)
self.right:setChildDOAnchorPosX(500,0.2)
end)
seq:AppendInterval(0.2)
seq:AppendCallback(function()
UIManager:invokeUIMethod("UIPlanent","playHaloUpEffect",self.groupIdx)
end)
seq:AppendInterval(1.5)
seq:AppendCallback(function()
UIManager:callWindowFunc("UIPlanent","playOrbitLevelEffect",pos)
UIManager:invokeUIMethod("UIPlanent","playHaloBreakEffect")
end)
seq:AppendInterval(3.5)
seq:AppendCallback(function()
self.left:setChildDOAnchorPosX(0,0.2)
self.right:setChildDOAnchorPosX(-3.4,0.2)
self.raycast:setActive(false)
end)

self:freshBagGrids(true,true)
self.addItemExp=0
self.addLv=0
self.needBorke=nil
self.total=nil
self:freshInfo()


end

function UIXJLittleWorldXingChenUpWin:onUpgradeAni()
self.isUpgrade=false
self.progressAni=true
self.progressReverseAni=false

UIManager.info("强化成功")
self:freshBagGrids(true,true)
self.addItemExp=0
self.addLv=0
self.needBorke=nil
self.total=nil
self:freshInfo()
self.raycast:setActive(false)

if self.upgradePrize then
self:showPrize(self.upgradePrize[1],self.upgradePrize[2])
self.upgradePrize=nil
end
end

function UIXJLittleWorldXingChenUpWin:showPrize(temp,effectData)
local tipsid=effectData.tipsid
local tips=showPrizeControl.getTips(tipsid)
showPrizeControl.showWindow(temp,nil,{tips=tips})
end

function UIXJLittleWorldXingChenUpWin:startBehavior()
local selectGUIDList={}
local startposList={}
local len=0

for i,v in ipairs(self.item)do
if self.selectList[i]then
len=len+1
local pos1=v:getChildPosition()
startposList[#startposList+1]=pos1
selectGUIDList[#selectGUIDList+1]=1
end
end
self.raycast:setActive(true)
if#startposList<=0 then
return
end

local parent=self.flyRoot:getID()
local pos=self.winlua:GetChildPosition(parent)

local eSidler={
Vector2.New(0.3,0.4),Vector2.New(0.1,0.2),Vector2.New(0,0),Vector2.New(-0.1,-0.2),Vector2.New(-0.3,-0.4),
Vector2.New(-0.3,-0.4),Vector2.New(-0.3,-0.4),Vector2.New(-0.3,-0.4),
}

local oSlider={
Vector2.New(0.3,0.4),Vector2.New(0.1,0.2),Vector2.New(0,0),Vector2.New(-0.1,-0.2),
Vector2.New(-0.3,-0.4),Vector2.New(-0.3,-0.4),Vector2.New(-0.3,-0.4),Vector2.New(-0.3,-0.4),
}

for i=1,8 do
local itemguid=selectGUIDList[i]
if itemguid then

self:playEffect(i,0.3+0.15*i,startposList[i],eSidler,oSlider,pos)
end
end




self.isUpgrade=true
self:delayDo(1.5,function()
self:onUpgradeAni()
end)

UIManager:invokeUIMethod("UIPlanent","playHaloUpEffect",self.groupIdx)
end

function UIXJLittleWorldXingChenUpWin:playEffect(idx,delay,startPos,oSidler,eSidler,endPos)
self.effect[idx]:setChildPosition(startPos)

self.effect[idx]:setChildShowEffect(10100,true)
self:delayDo(0.3,function()
self.effect[idx]:setChildShowEffect(10101,true)
CS.UIBezierUtility.SetChildDoMovePathWithSlider(self.effect[idx]:getTransform(),endPos,oSidler,eSidler,delay,0.001)
end)
end

function UIXJLittleWorldXingChenUpWin:stopBehavior()
if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
self.bt=nil
end
end

function UIXJLittleWorldXingChenUpWin:onClickLongGridButton(itemid,index,itemguid,attach)
if itemid~=-1 then
self.islong=true
end
end


function UIXJLittleWorldXingChenUpWin:setDropdowns()

end

function UIXJLittleWorldXingChenUpWin:setAttrs()
local curlv=xingChenBagModel:getOrbitLevel(self.pos)

local addLv=self.addLv
local targetlv=addLv+curlv

local fixAttrs=xingChenHelper.getFixedAttr(self.itemId,curlv)

local nextAttrs,nextFixAttrsLookup={},{}
if addLv>0 then
nextAttrs=xingChenHelper.getFixedAttr(self.itemId,targetlv)or{}
end

self.attrPanel:setChildLayoutGroupCreateItems(#fixAttrs)
local grids=self.attrPanel:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
local attr=fixAttrs[i]
local name,str=equipsHelper.getAttr(attr[1],attr[2])
grid:SetChildText(1,FMT.fmt("{0}：{1}",name,str))
grid:SetChildActive(2,nextAttrs[i]~=nil and nextAttrs[i][2]-attr[2]>0)
if nextAttrs[i]~=nil then

grid:SetChildText(2,FMT.fmt("+{0}",nextAttrs[i][2]-attr[2]))
end
end
end

function UIXJLittleWorldXingChenUpWin:setAffixPanel()
local equip=self.equip
local affixList=xingChenHelper.getAffixList(equip)
local affix_num=xingChenHelper.getAffixLimit(equip)
self.ciZhuiPanel:setChildLayoutGroupCreateItems(affix_num)
local grids=self.ciZhuiPanel:getChildLayoutGroupGridList()
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
grid:SetChildActive(6,affix==nil)
end
end
self.zhenxiEffect:setChildShowEffect(10661,(equip.itemData.fin_rare_id or 0)~=0)
if equip.itemData.fin_rare_id~=0 then
self.zhenxiPanel:setActive(true)

local zxConfig=cfgHelper.get(cfg_starsrareconfig_get,equip.itemData.fin_rare_id)
local effects_adddesc=zxConfig.effects_adddesc
local isJzAttr=zxConfig.jz_effects~=nil
local star_attrs=self.itemConfig.star_attrs
local lv=xingChenHelper.getStarLevel(equip)
local nextStar=star_attrs[lv+1]
local attrList,nextList
local maxLv=#star_attrs
local max_id=star_attrs[maxLv][1]
local isMax=max_id==equip.itemData.fin_rare_id
if nextStar and nextStar[1]>0 and nextStar[1]~=equip.itemData.fin_rare_id then
local nextConfig=cfgHelper.get(cfg_starsrareconfig_get,nextStar[1])
if nextConfig.prio>zxConfig.prio then
if isJzAttr then
attrList=zxConfig.jz_effects
nextList=nextConfig.jz_effects
else
attrList=zxConfig.grow_effects
nextList=nextConfig.grow_effects
end
end
end
self.zhenxiPanel:setChildLayoutGroupCreateItems(#effects_adddesc)
local grids=self.zhenxiPanel:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
if nextList then
if isJzAttr then
grid:SetChildText(1,FMT.fmt("<color=#ca631d>{0}</color>",effects_adddesc[i]))
else
if i==1 then
grid:SetChildText(1,FMT.fmt("<color=#ca631d>{0}</color>",effects_adddesc[i]))
end
end
else
if isMax then
grid:SetChildText(1,FMT.fmt("<color=#ca631d>{0}<color=#549327>（已满级）</color></color>",effects_adddesc[i]))
else
grid:SetChildText(1,FMT.fmt("<color=#ca631d>{0}</color>",effects_adddesc[i]))
end
end
end
else
local color=self.itemConfig.color
self.zhenxiPanel:setActive(color==eQualityColor.eRed)
if color==eQualityColor.eRed then
local nextLv=self.itemConfig.first_star_attrs_lv[2]
local id=xingChenHelper.getStarZhenXiId(equip.itemid,nextLv)
local zxConfig=cfgHelper.get(cfg_starsrareconfig_get,id,"effects_adddesc")
self.zhenxiPanel:setChildLayoutGroupCreateItems(#zxConfig)
local grids=self.zhenxiPanel:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
grid:SetChildText(1,FMT.fmt("<color=#8e8c87>{0}（{1}激活）</color>",zxConfig[i],cfgHelper.get(cfg_starsstarconfig_get,nextLv,"show_star")))
end
end
end
end

function UIXJLittleWorldXingChenUpWin:setShowItems()
local itemConfig=self.itemConfig
self.icon:setImageIcon(iconHelper.getIconName(self.itemId))
self.level:setText(FMT.fmt("星轨等级：{0}",xingChenBagModel:getOrbitLevel(self.pos)))
self.name:setText(xingChenHelper.getXingChenName(self.equip))

local colorFrame=FMT.fmt("image_xiaoshijiebz_{0}",itemConfig.color-2)
self.colorFrame:setCSImageSprite("ui/windows/xianjiebuilding/littleworld/littleworld_atlas_pak.ab",colorFrame)
end

function UIXJLittleWorldXingChenUpWin:freshBagList()
self.filter=self.filter or{}
self.filter[ITEM_FILTER_TYPE.eXingChenRongHeChild]={ITEM_FILTER_COMPARE.eNot,{1}}
local bagList=xingChenHelper.sortEquip(self.groupIdx,self.sortOrder,false,self.filter)

local moneyList=xingChenHelper:getIncreaseCostList()
bagList=table.concatTableX(moneyList,bagList)

local isPutItem=function(itemguid)
for i=1,_fillItemLen do
local info=self.selectList[i]
if info and tostring(info[1])==tostring(itemguid)and info[2]and info[2]>0 then
return true
end
end
end

local list={}
local lookup={}
if#bagList>0 then
for i=#bagList,1,-1 do
local item=bagList[i]
if not lookup[tostring(item.itemguid)]and isPutItem(item.itemguid)then
list[#list+1]=item
lookup[tostring(item.itemguid)]=true
table.remove(bagList,i)
end


if item.itemguid==self.itemguid then
table.remove(bagList,i)
end
end

for i,v in ipairs(list)do
table.insert(bagList,1,v)
end
end

for i,v in ipairs(self.selectList)do
if not lookup[tostring(v[1])]then
if itemsConfig.isMoney(v[3])then
table.insert(bagList,1,{itemguid=v[1],itemid=v[3],itemcount=itemsModel.getCount(v[3])})


end
lookup[tostring(v[1])]=true
end
end

self.itemsList=bagList


end

function UIXJLittleWorldXingChenUpWin:refreshBagTypePanel()
local pos=cfgHelper.get(cfg_starsbasicconfig_get,1,"pos")
self.groupRoot:setChildLayoutGroupCreateItems(#pos)
local grids=self.groupRoot:getChildLayoutGroupGridList()
for i=1,grids.Count do
local name=pos[i]
local grid=grids[i-1]
grid:SetChildText(0,name)
grid:SetChildActive(1,false)
grid:SetChildButtonClick(2,function()
self:selectGroupItem(i)
end)
end
end

function UIXJLittleWorldXingChenUpWin:selectGroupItem(i)
if i==self.groupIdx then
return
end
local grid=self.groupRoot:getChildLayoutGroupGridItem(i-1)
if grid then
grid:SetChildActive(1,true)
end
if self.groupIdx then
local grid=self.groupRoot:getChildLayoutGroupGridItem(self.groupIdx-1)
if grid then
grid:SetChildActive(1,false)
end
end
self.groupIdx=i

self:refreshInfoPanel(true)
self:freshBagGrids(true)

UIManager:callWindowFunc("UIPlanent","showHaloIndex",i)
end

function UIXJLittleWorldXingChenUpWin:freshBagGrids(freshData,resetSelectItem)
if freshData then
self:freshBagList()
end

local chlen=#self.itemsList
local tNum=_creatGirdPrecent
tNum=math.max(tNum,chlen)
local row=math.ceil(tNum/_colomn)+7
tNum=(row+7)*_colomn
local row=math.ceil(tNum/_colomn)

if resetSelectItem then
self.selectList={}
self.selectItemsLookup={}
end

if not self.isSetZero then
self.BagList:freshSlowGrids(tNum,row,_colomn,self.isSetZero)
self.isSetZero=true
else
if self.row~=row then
self.BagList:freshSlowGrids(tNum,row,_colomn,self.isSetZero)
end
self.BagList:freshAllItems()
end

self.row=row

local num=bagControl.invokeFuncByBagType(BAG_TYPE.eXingChen,'getBagNum')
local maxNum=bagConfig.getBagMaxNum(BAG_TYPE.eXingChen)
self.bagNum:setText(FMT.fmt("库存：<color={2}>{0}/{1}</color>",num,maxNum,num>=maxNum and FONT_COLOR_VAL[FONT_COLOR.eRedColor]or"#000000"))
end

function UIXJLittleWorldXingChenUpWin:bindGrid(index,widget)
local itemInfo=self.itemsList[index]

local isTemp=itemInfo==nil
if not isTemp then

local isXingChen=itemsConfig.isXingChen(itemInfo.itemid)
local itemcount=itemInfo.itemcount or 0
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid or-1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=itemsModel.getIconName(itemInfo)
local num=self:getSelectNum(itemguid)

local countStr=num>0 and FMT.fmt('{0}/{1}',itemcount,num)or itemcount>1 and itemcount or''
countStr=isXingChen and''or countStr
local has=num>0

local isSelect=tostring(self.selectItemguid)==tostring(itemguid)
local isLock=bagHelper.isLock(itemInfo)
widget:SetChildActive(0,true)
widget:SetChildActive(1,isSelect)
widget:SetChildQulaity(2,color)
widget:SetChildScale(3,Vector3.one)
widget:SetChildIcon(3,iconName,false)
widget:SetChildText(4,countStr)
widget:SetChildActive(5,countStr~='')
widget:SetChildText(6,'')
widget:SetChildText(7,'')
widget:SetChildActive(8,false)
widget:SetChildActive(9,isLock)
widget:SetChildActive(10,has)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid)
widget:SetChildLongPress(10,index,function(idx)
self:longPressAction(idx)
end,function(idx)
self:finishlongPressAction(idx)
end)
widget:SetChildLongPress(11,index,function(idx)
self:longPressAction(idx,true)
end,function(idx)
self:finishlongPressAction(idx,true)
end)


xingChenHelper.setStarFlag(widget:GetChildWidgetBase(12),xingChenHelper.getStarLevel(itemInfo),true)
else
widget:SetChildActive(0,true)
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
widget:SetChildActive(3,false)
widget:SetChildScale(3,Vector3.zero)
widget:SetChildText(4,'')
widget:SetChildActive(5,false)
widget:SetChildText(6,'')
widget:SetChildText(7,'')
widget:SetChildActive(8,false)
widget:SetChildActive(9,false)
widget:SetChildActive(10,false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
widget:SetChildLongPress(11,index,nil,nil)
widget:SetChildLongPress(10,index,nil,nil)
widget:SetChildActive(12,false)
end
end

function UIXJLittleWorldXingChenUpWin:getSelectNum(itemguid)
if self.selectList==nil then
self.selectList={}
end
if self.selectItemsLookup==nil then
self.selectItemsLookup={}
end
local selectItemsLookup=self.selectItemsLookup
local selectList=self.selectList
local index=selectItemsLookup[tostring(itemguid)]
if index then
local selectTable=selectList[index]or{}
return selectTable[2]or 0
end
return 0
end

function UIXJLittleWorldXingChenUpWin:onClickGrid(itemid,index,itemguid,attach)
if itemid==-1 then
return
end

if itemsConfig.isXingChen(itemid)then
self:putItem(itemid,itemguid,nil,true)
else
self:putOtherItem(itemid,itemguid)

end

if self.selectEquip then
self:freshSelectInfoGrid(self.selectEquip.itemguid,false)
end
self.selectEquip=self.itemsList[index]
local widget=self.BagList:getSlowItemByIndex(index-1)
if widget then
widget:SetChildActive(1,true)
end
self:refreshInfoPanel()
end

function UIXJLittleWorldXingChenUpWin:freshSelectInfoGrid(itemguid,flag)
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.BagList:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(1,flag)
end
end
end

function UIXJLittleWorldXingChenUpWin:refreshInfoPanel(refreshSelectEquip)
if refreshSelectEquip then
self.selectEquip=nil
end
local equip=self.selectEquip

if equip and itemsConfig.isXingChen(equip.itemid)then

self.right2:setChildCanvasGroupAlpha(1)
local itemid=equip.itemid
local config=itemsConfig.getConfig(itemid)
local type1=config.type1
local colorFrame=FMT.fmt("image_xiaoshijiebz_{0}",config.color-2)

self.colorFrame2:setCSImageSprite("ui/windows/xianjiebuilding/littleworld/littleworld_atlas_pak.ab",colorFrame)

local curlv=xingChenBagModel:getOrbitLevel(type1)

self.level2:setText(FMT.fmt("星轨等级：{0}",curlv))
self.name2:setText(xingChenHelper.getXingChenName(equip))

self.icon2:setImageIcon(iconHelper.getIconName(itemid))

local fixAttrs=xingChenHelper.getFixedAttr(itemid,curlv)
self.attrPanel2:setChildLayoutGroupCreateItems(#fixAttrs)
local grids=self.attrPanel2:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
local attr=fixAttrs[i]
local name,str=equipsHelper.getAttr(attr[1],attr[2])
grid:SetChildText(1,FMT.fmt("{0}：{1}",name,str))
end
local affix_num=xingChenHelper.getAffixLimit(equip)
local affixList=xingChenHelper.getAffixList(equip)
self.ciZhuiPanel2:setChildLayoutGroupCreateItems(affix_num)
local grids=self.ciZhuiPanel2:getChildLayoutGroupGridList()
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
grid:SetChildActive(6,affix==nil)
end
end
self.zhenxiEffect2:setChildShowEffect(10661,(equip.itemData.fin_rare_id or 0)~=0)
if equip.itemData.fin_rare_id~=0 then
self.zhenxiPanel2:setActive(true)

local zxConfig=cfgHelper.get(cfg_starsrareconfig_get,equip.itemData.fin_rare_id)
local effects_adddesc=zxConfig.effects_adddesc
local isJzAttr=zxConfig.jz_effects~=nil
local star_attrs=config.star_attrs
local lv=xingChenHelper.getStarLevel(equip)
local nextStar=star_attrs[lv+1]
local attrList,nextList
local maxLv=#star_attrs
local max_id=star_attrs[maxLv][1]
local isMax=max_id==equip.itemData.fin_rare_id
if nextStar and nextStar[1]>0 and nextStar[1]~=equip.itemData.fin_rare_id then
local nextConfig=cfgHelper.get(cfg_starsrareconfig_get,nextStar[1])
if nextConfig.prio>zxConfig.prio then
if isJzAttr then
attrList=zxConfig.jz_effects
nextList=nextConfig.jz_effects
else
attrList=zxConfig.grow_effects
nextList=nextConfig.grow_effects
end
end
end
self.zhenxiPanel2:setChildLayoutGroupCreateItems(#effects_adddesc)
local grids=self.zhenxiPanel2:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
if nextList then
if isJzAttr then
grid:SetChildText(1,FMT.fmt("<color=#ca631d>{0}</color>",effects_adddesc[i]))
else
if i==1 then
grid:SetChildText(1,FMT.fmt("<color=#ca631d>{0}</color>",effects_adddesc[i]))
end
end
else
if isMax then
grid:SetChildText(1,FMT.fmt("<color=#ca631d>{0}<color=#549327>（已满级）</color></color>",effects_adddesc[i]))
else
grid:SetChildText(1,FMT.fmt("<color=#ca631d>{0}</color>",effects_adddesc[i]))
end
end
end
else
local color=config.color
self.zhenxiPanel2:setActive(color==eQualityColor.eRed)
if color==eQualityColor.eRed then
local nextLv=config.first_star_attrs_lv[2]
local id=xingChenHelper.getStarZhenXiId(equip.itemid,nextLv)
local zxConfig=cfgHelper.get(cfg_starsrareconfig_get,id,"effects_adddesc")
self.zhenxiPanel2:setChildLayoutGroupCreateItems(#zxConfig)
local grids=self.zhenxiPanel2:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
grid:SetChildText(1,FMT.fmt("<color=#8e8c87>{0}（{1}激活）</color>",zxConfig[i],cfgHelper.get(cfg_starsstarconfig_get,nextLv,"show_star")))
end
end
end

self:refreshStarPanel2()
else
self.right2:setChildCanvasGroupAlpha(0)
self.zhenxiEffect2:setChildShowEffect(10661,false)

end
end

function UIXJLittleWorldXingChenUpWin:putItem(itemid,itemguid,addnum,isClick)
local num=self:getSelectNum(itemguid)
local item,itemcount
if itemsConfig.isMoney(itemid)then
itemcount=moneyModel.getMoney(itemid)
else
item=equipsHelper.getEquip(itemguid)
if not item then
return
end
itemcount=item.itemcount
end

if not self:checkMaxLv()then
return
end

if num>=itemcount then
if isClick and itemsConfig.isXingChen(itemid)then
self:onClickGridButton(itemid,nil,itemguid,nil,num)
return
end
UIManager.error('物品已达上限')
return
end

local fillIdx=self:getNextFillIdx(itemguid)
if fillIdx==nil then
UIManager.error('当前无空位可放入')
return
end

addnum=addnum or 1

local addItem={itemguid,addnum,itemid}

if not itemsConfig.isMoney(itemid)and bagHelper.isLock(item)then
self.dialog=UIDialogManager.getConfirmDialog(self.dialog,'装备锁定','该装备已锁定，是否解锁并进行强化消耗？')
self.dialog.okcallback=function()
bagProtocolControl.req_change_bag_item_lockflag(itemguid,true)
if self and not self.isClose then
self:onUnlockItem(itemguid)
end
end
self.dialog:show()
return
end


local canIncrease,nextLv,overExp,leftExp,needBorke,total,canAdd,remain=xingChenHelper.canIncrease(self.equip,self.selectList,addItem,false)

if not canIncrease then
UIManager.error("已达到当前最大经验值")
return
end

if not canAdd then
UIManager.error("已达到当前最大经验值")
return
end

self.onJinglianFinish=false
local lastNum=num
if lastNum==0 then
self:freshProvideSelectSingleGirid(itemguid,true)
end

num=num+(addnum-remain)

self:setSelectNum(itemguid,fillIdx,num,itemid)
self:freshProvideSingleGiridText(itemguid)

self:setSelectItems()
self:setProgress()
self:setAttrs()
return true
end

function UIXJLittleWorldXingChenUpWin:putOtherItem(itemid,itemguid)
local num=self:getSelectNum(itemguid)
local item,itemcount
if itemsConfig.isMoney(itemid)then
itemcount=moneyModel.getMoney(itemid)
else
item=equipsHelper.getEquip(itemguid)
itemcount=item.itemcount
end

if not self:checkMaxLv()then
return
end





local fillIdx=self:getNextFillIdx(itemguid)
if fillIdx==nil then
UIManager.error('当前无空位可放入')
return
end

local maxCount=math.min(itemcount,xingChenHelper.getMaxIncreaseExp(self.equip,self.selectList,itemid,itemguid))

local attach_={}
if maxCount>=1 then
local selectNumCmpArgs={numFormat='数量：<color=#f1ce78>{0}/{1}</color>',
min=0,max=maxCount,val=self:getSelectNum(itemguid)or 0}
attach_.selectNumCmpArgs=selectNumCmpArgs
attach_.tipsCommonUseItemCB=function(attach__)
local addnum=attach__.selectNumCmpArgs and attach__.selectNumCmpArgs.selectNum or 1

local lastNum=num

self:freshProvideSelectSingleGirid(itemguid,addnum>0)


num=addnum

self:setSelectNum(itemguid,fillIdx,num,itemid)
self:freshProvideSingleGiridText(itemguid)

self:setSelectItems()
self:setProgress()
self:setAttrs()
end
attach_.insertBtnList={TIPS_BTNS_TYPE.eCommonUseItem}
end
tipsManager.showTips({itemid=itemid,itemguid=nil,attach=attach_})

self.onJinglianFinish=false

return true
end

function UIXJLittleWorldXingChenUpWin:freshProvideSingleGiridText(itemguid)
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.BagList:getSlowItemByIndex(idx-1)
if widget then
local num=self:getSelectNum(itemguid)
local info=self.itemsList[idx]
local itemcount=info.itemcount or 0
local isXingChen=itemsConfig.isXingChen(info.itemid)
local countStr=num>0 and FMT.fmt('{0}/{1}',itemcount,num)or itemcount>1 and itemcount or''
countStr=isXingChen and''or countStr
widget:SetChildText(4,countStr)
widget:SetChildActive(5,countStr~='')
end
end

end

function UIXJLittleWorldXingChenUpWin:checkMaxLv()
local upItem=self.equip
local pos=xingChenHelper.getPosType(upItem.itemid)
local lv=xingChenBagModel:getOrbitLevel(pos)
local upConfig=cfgHelper.get(cfg_starslvconfig_get,pos)
if not upConfig[lv+1]then
UIManager.error("星辰轨道已满级")
return false
end
return true
end

function UIXJLittleWorldXingChenUpWin:getBagItemIdx(itemguid)
local list=self.itemsList or{}
for i,v in ipairs(list)do
if tostring(v.itemguid)==tostring(itemguid)then
return i,v
end
end
end

function UIXJLittleWorldXingChenUpWin:setSelectNum(itemguid,index,num,itemid)
if self.selectItemsLookup==nil then
self.selectItemsLookup={}
end
if self.selectList==nil then
self.selectList={}
end
if num==0 then
self.selectList[index]=nil
self.selectItemsLookup[tostring(itemguid)]=nil
else
self.selectList[index]={itemguid,num,itemid}
self.selectItemsLookup[tostring(itemguid)]=index
end
self:freshAddExp()
self.progressReverseAni=true
self.progressAni=false
end

function UIXJLittleWorldXingChenUpWin:getSelectIndex(itemguid)
if self.selectItemsLookup==nil then
self.selectItemsLookup={}
end
if self.selectList==nil then
self.selectList={}
end
return self.selectItemsLookup[tostring(itemguid)]
end

function UIXJLittleWorldXingChenUpWin:freshProvideSelectSingleGirid(itemguid,flag)
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.BagList:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(10,flag)
if not flag then
widget:SetChildLongPressStop(10)
self.useGoodTime=nil
end
end
end
end

function UIXJLittleWorldXingChenUpWin:freshAddExp()
local selectItems=self.selectList or{}
local addItemExp,addExp,addLv,leftExp,overExp=0,0,0,0,0

local pos=self.pos
local canIncrease,nextLv,oExp,lExp,needBorke,total=xingChenHelper.canIncrease(self.equip,selectItems)

if canIncrease then
local lv=xingChenBagModel:getOrbitLevel(pos)

if needBorke then
addLv=nextLv-lv
addItemExp=total

leftExp=xingChenHelper.getExp(pos,nextLv+1)
overExp=oExp

else
addLv=nextLv-lv
addItemExp=total
leftExp=lExp
overExp=oExp
end


end
self.total=total
self.addItemExp=addItemExp
self.addLv=addLv
self.leftExp=leftExp
self.overExp=overExp
self.needBorke=needBorke
end



function UIXJLittleWorldXingChenUpWin:setProgress()
local item=self.equip
local itemid=item.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local equipType=self.pos
local maxlv=xingChenHelper.getMaxLvByItemid(itemid)
local jinglianlv=xingChenBagModel:getOrbitLevel(equipType)
local jinglianexp=xingChenBagModel:getExp(equipType)
local duration=self.progressAni and 0.5 or 0
local durationReverse=self.progressReverseAni and 0.5 or 0

local addLv=self.addLv or 0
local curIsFull=jinglianlv>=maxlv

self.addLastItemExp=self.addItemExp
if curIsFull then
self.progressBar:animateThreeParams(100,100,duration)
self.progressBarReverse:animateThreeParams(0,100,durationReverse)
self.progressCount:setText('已满')
self.progressCountReverse:setText('')
else
local curExp=jinglianexp
local curShowExp=curExp
local fillExp=self.leftExp
local maxExp=0
local targetlv=addLv+jinglianlv
local isFull=targetlv>=maxlv
local addItemExp=self.addItemExp

if addItemExp==0 then

fillExp=curShowExp
end

if addLv<=0 then

maxExp=xingChenHelper.getExp(equipType,jinglianlv+1)
if not self.needBorke and fillExp==maxExp then
addLv=addLv+1
self.addLv=addLv
fillExp=0
self.leftExp=fillExp
end
else
if not isFull then
maxExp=xingChenHelper.getExp(equipType,targetlv+1)
if not self.needBorke and fillExp==maxExp then
addLv=addLv+1
self.addLv=addLv
fillExp=0
self.leftExp=fillExp
end
else

maxExp=xingChenHelper.getExp(equipType,targetlv)
fillExp=fillExp+maxExp
end
if addLv>0 and not(addLv==1 and jinglianlv==maxlv-1)then

curShowExp=0
end
end

if curShowExp==0 and self.progressAni then
self.progressBar:animateThreeParams(maxExp,maxExp,duration,false)
self:delayDo(duration,function()
if not self or self.isClose then
return
end
self.progressBar:animateThreeParams(curShowExp,maxExp,0,false)
end)
else
self.progressBar:animateThreeParams(curShowExp,maxExp,duration,false)
end

self.progressBarReverse:animateThreeParams(self.progressReverseAni and fillExp or curShowExp,maxExp,durationReverse)
local str=''
if self.total and self.total>0 then
str=FMT.fmt('<color=#29c200>+{3}</color>  {0}/{1}{2}',math.floor(curShowExp),maxExp,self.needBorke and"(需突破)"or"",self.total)
else
str=FMT.fmt('{0}/{1}{2}',math.floor(curShowExp),maxExp,self.needBorke and"(需突破)"or"")
end
self.progressCount:setText(xingChenHelper.needBorke(self.pos)and"需突破"or str)
self.progressCountReverse:setText(FMT.fmt('+{0}',math.floor(self.addItemExp)))

end




self.addLevel:setText(addLv>0 and FMT.fmt('+{0}',addLv)or'')



self.progressAni=false
self.progressReverseAni=false
end


function UIXJLittleWorldXingChenUpWin:setBrokeCostItems()

end




function UIXJLittleWorldXingChenUpWin:onHide()
if self.isThisShow then



UIManager:invokeUIMethod("UIPlanent","setAnimator",8)
self.isThisShow=nil
end
end

function UIXJLittleWorldXingChenUpWin:getNextFillIdx(itemguid)
if self.selectList==nil then
self.selectList={}
end
if self.selectItemsLookup==nil then
self.selectItemsLookup={}
end
local selectItemsLookup=self.selectItemsLookup
local selectList=self.selectList
local index=selectItemsLookup[tostring(itemguid)]
if index then
return index
end
for i=1,_fillItemLen do
local info=selectList[i]
if not info then
return i
end
end
end


function UIXJLittleWorldXingChenUpWin:longPressAction(idx,isAdd)
if isAdd and not self.islong then
return
end
local info=self.itemsList[idx]
if not info then
self:StopItemLongPress(idx,isAdd and 11 or 10)
self.useGoodTime=nil
return
end
local num=1
if self.useGoodTime~=nil then
local cur=Time.realtimeSinceStartup
local lerp=cur-self.useGoodTime
if lerp>=10 then
num=100
elseif lerp>=6 then
num=50
elseif lerp>=3 then

num=10
elseif lerp>=2 then

num=5
end
else
self.useGoodTime=Time.realtimeSinceStartup
end
local maxNum=isAdd and info.itemcount or self:getSelectNum(info.itemguid)
if num>maxNum then
num=maxNum
end
if isAdd then
if not self:putItem(info.itemid,info.itemguid,num)then
self:StopItemLongPress(idx,11)
self.useGoodTime=nil
end
else
if not self:onClickGridButton(info.itemid,idx,info.itemguid,nil,num)then
self:StopItemLongPress(idx,10)
self.useGoodTime=nil
end
end
end


function UIXJLittleWorldXingChenUpWin:finishlongPressAction(idx,isAdd)
if isAdd then
self.islong=false
end
self.useGoodTime=nil
end

function UIXJLittleWorldXingChenUpWin:StopItemLongPress(idx,index)
local widget=self.BagList:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildLongPressStop(index)
end
end



function UIXJLittleWorldXingChenUpWin:setSelectItems()

local needBorke=xingChenHelper.needBorke(self.pos)
self.upCostPanel:setActive(not needBorke)
self.poCostPanel:setActive(needBorke)
if needBorke then
local upConfig=cfgHelper.get(cfg_starslvconfig_get,self.pos)
local lv=xingChenBagModel:getOrbitLevel(self.pos)
local cost=upConfig[lv+1].costs
local itemsList=self.poitem

for i,v in ipairs(itemsList)do
local costItem=cost[i]
if costItem then
local num=costItem[2]
local item={itemid=costItem[1],itemcount=num}
local have=itemsModel.getCount(costItem[1])
local countStr=num>have and FMT.cfmt(FONT_COLOR.eRedColor,"{0}/{1}",have,num)or FMT.fmt("{0}/{1}",have,num)
local conf={showname=false,itemcount=countStr,showcount=countStr~='',showCountBG=countStr~='',showRare=true}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
prop[PropIndex(DataPropKey.eWidgetActive,9)]=false
v:setActive(true)
v:setChildPropData(itemsComponentHelper.getCommonFillData(item,conf))
v:setBaseItemClickEvent(itemsComponentHelper.onItemClick)
else
v:setActive(false)
end
end
else
local selectList=self.selectList or{}
local itemsList=self.item
for i,v in ipairs(itemsList)do
local selectInfo=selectList[i]
if selectInfo then
local itemguid=selectInfo[1]
local num=selectInfo[2]or 0
local itemid=selectInfo[3]

local item=itemsConfig.isXingChen(itemid)and equipsHelper.getEquip(itemguid)or{itemid=itemid}

local countStr=itemsConfig.isXingChen(itemid)and''or num>1 and num or''
local conf={showname=false,itemcount=countStr,showcount=countStr~='',showCountBG=countStr~=''}
v:setChildPropData(self:getSelectFillData(item,conf))
v:setBaseItemClickEvent(function()
self:onClickGridButton(itemid,nil,itemguid,nil,1)
end)
else
v:setChildPropData(self:getSelectFillData())
end
end
end


end

function UIXJLittleWorldXingChenUpWin:getSelectFillData(item,conf)
if item==nil then
return self:getSelectTempFillData()
end
local prop=itemsComponentHelper.getCommonFillData(item,conf)
prop[PropIndex(DataPropKey.eWidgetActive,3)]=true
prop[PropIndex(DataPropKey.eWidgetActive,8)]=false
prop[PropIndex(DataPropKey.eWidgetActive,9)]=false
prop[PropIndex(DataPropKey.eWidgetActive,11)]=false
return prop
end

function UIXJLittleWorldXingChenUpWin:getSelectTempFillData()
local conf={}
conf.showbg=true
local prop=itemsComponentHelper.getTempFillData(conf)
prop[PropIndex(DataPropKey.eWidgetActive,3)]=false
prop[PropIndex(DataPropKey.eWidgetActive,8)]=false
prop[PropIndex(DataPropKey.eWidgetActive,9)]=true
return prop
end

function UIXJLittleWorldXingChenUpWin:onClickGridButton(itemid,index,itemguid,attach,delnum)
if itemid==-1 then
return
end
local num=self:getSelectNum(itemguid)
if num<=0 then
UIManager.error('物品已达下限')
self:freshProvideSelectSingleGirid(itemguid,false)
return
end
self.onJinglianFinish=false
delnum=delnum or 1
num=num-delnum
local selectIdx=self:getSelectIndex(itemguid)
self:setSelectNum(itemguid,selectIdx,num,itemid)

if num<=0 then
self:freshProvideSelectSingleGirid(itemguid,false)
end
self:freshProvideSingleGiridText(itemguid)
self:setSelectItems()
self:setProgress()
self:setAttrs()
return true
end


function UIXJLittleWorldXingChenUpWin:refreshStarPanel()
local equip=self.equip
local itemid=self.equip.itemid
local config=self.itemConfig
local color=self.itemConfig.color
if color==eQualityColor.eRed then
local lv=xingChenHelper.getStarLevel(equip)
self.starPanel:setActive(true)
self.starAttrPanel:setActive(true)

xingChenHelper.setStarFlag(self.star:getChildWidgetBase(),lv)
if lv>0 then
self.starText:setText(cfgHelper.get(cfg_starsstarconfig_get,lv,"show_star"))
else
self.starText:setText("一阶零星")
end
local attrList=xingChenHelper.getStarAttr(itemid,lv)
if next(attrList)then
local attrLength=#attrList
local nextAttrList=xingChenHelper.getStarAttr(itemid,lv+1)or defaultT
local growAttrList=xingChenHelper.getStarGrowAttr(itemid,lv)
local growNextAttrList=xingChenHelper.getStarGrowAttr(itemid,lv+1)or defaultT
self.starAttrPanel:setChildLayoutGroupCreateItems(attrLength+#growAttrList)
local grids=self.starAttrPanel:getChildLayoutGroupGridList()

for i=1,grids.Count do
local grid=grids[i-1]
local attr=attrList[i]
local nextAttr=nextAttrList[i]
if attr then
local name,str=equipsHelper.getAttr(attr[1],attr[2])
if nextAttr then
grid:SetChildText(1,FMT.fmt("<color=#d03497>{0}+{1}</color>",name,str))
else
grid:SetChildText(1,FMT.fmt("<color=#d03497>{0}+{1}<color=#549327>（已满级）</color></color>",name,str))
end
else
local gAttr=growAttrList[i-attrLength]
if gAttr then
local name,str=xingChenCiZhuiEffectController.getAttr(gAttr[1],gAttr[2])
if growNextAttrList[i-attrLength]then
grid:SetChildText(1,FMT.fmt("<color=#d03497>{0}+{1}</color>",name,str))
else
grid:SetChildText(1,FMT.fmt("<color=#d03497>{0}+{1}<color=#549327>（已满级）</color></color>",name,str))
end
end
end
end
else
local nextLv=config.first_star_attrs_lv[1]
local nextAttr=xingChenHelper.getStarAttr(itemid,nextLv)
local growAttrList=xingChenHelper.getStarGrowAttr(itemid,nextLv)

local attrLength=#nextAttr
self.starAttrPanel:setChildLayoutGroupCreateItems(attrLength+#growAttrList)
local grids=self.starAttrPanel:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
local attr=nextAttr[i]
if attr then
local name,str=equipsHelper.getAttr(attr[1],attr[2])
grid:SetChildText(1,FMT.fmt("<color={2}>{0}+{1}（升星激活）</color>",name,str,FONT_TIPS_COLOR_VAL[FONT_COLOR.eGrayColor]))
else
local gAttr=growAttrList[i-attrLength]
if gAttr then
local name,str=xingChenCiZhuiEffectController.getAttr(gAttr[1],gAttr[2])
grid:SetChildText(1,FMT.fmt("<color={2}>{0}+{1}（升星激活）</color>",name,str,FONT_TIPS_COLOR_VAL[FONT_COLOR.eGrayColor]))
end
end
end
end
else
self.starPanel:setActive(false)
self.starAttrPanel:setActive(false)
end
end

function UIXJLittleWorldXingChenUpWin:refreshStarPanel2()
local equip=self.selectEquip
if equip and itemsConfig.isXingChen(equip.itemid)then
local itemid=self.selectEquip.itemid
local config=itemsConfig.getConfig(itemid)
local color=config.color
if color==eQualityColor.eRed then
local lv=xingChenHelper.getStarLevel(equip)
self.starPanel2:setActive(true)
self.starAttrPanel2:setActive(true)
xingChenHelper.setStarFlag(self.star2:getChildWidgetBase(),lv)
if lv>0 then
self.starText2:setText(cfgHelper.get(cfg_starsstarconfig_get,lv,"show_star"))
else
self.starText2:setText("一阶零星")
end
local attrList=xingChenHelper.getStarAttr(itemid,lv)
if next(attrList)then
local attrLength=#attrList
local nextAttrList=xingChenHelper.getStarAttr(itemid,lv+1)or defaultT
local growAttrList=xingChenHelper.getStarGrowAttr(itemid,lv)
local growNextAttrList=xingChenHelper.getStarGrowAttr(itemid,lv+1)or defaultT
self.starAttrPanel2:setChildLayoutGroupCreateItems(attrLength+#growAttrList)
local grids=self.starAttrPanel2:getChildLayoutGroupGridList()

for i=1,grids.Count do
local grid=grids[i-1]
local attr=attrList[i]
local nextAttr=nextAttrList[i]
if attr then
local name,str=equipsHelper.getAttr(attr[1],attr[2])
if nextAttr then
grid:SetChildText(1,FMT.fmt("<color=#d03497>{0}+{1}</color>",name,str))
else
grid:SetChildText(1,FMT.fmt("<color=#d03497>{0}+{1}<color=#549327>（已满级）</color></color>",name,str))
end
else
local gAttr=growAttrList[i-attrLength]
if gAttr then
local name,str=xingChenCiZhuiEffectController.getAttr(gAttr[1],gAttr[2])
if growNextAttrList[i-attrLength]then
grid:SetChildText(1,FMT.fmt("<color=#d03497>{0}+{1}</color>",name,str))
else
grid:SetChildText(1,FMT.fmt("<color=#d03497>{0}+{1}<color=#549327>（已满级）</color></color>",name,str))
end
end
end
end
else
local nextLv=config.first_star_attrs_lv[1]
local nextAttr=xingChenHelper.getStarAttr(itemid,nextLv)
local growAttrList=xingChenHelper.getStarGrowAttr(itemid,nextLv)

local attrLength=#nextAttr
self.starAttrPanel2:setChildLayoutGroupCreateItems(attrLength+#growAttrList)
local grids=self.starAttrPanel2:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
local attr=nextAttr[i]
if attr then
local name,str=equipsHelper.getAttr(attr[1],attr[2])
grid:SetChildText(1,FMT.fmt("<color={2}>{0}+{1}（升星激活）</color>",name,str,FONT_TIPS_COLOR_VAL[FONT_COLOR.eGrayColor]))
else
local gAttr=growAttrList[i-attrLength]
if gAttr then
local name,str=xingChenCiZhuiEffectController.getAttr(gAttr[1],gAttr[2])
grid:SetChildText(1,FMT.fmt("<color={2}>{0}+{1}（升星激活）</color>",name,str,FONT_TIPS_COLOR_VAL[FONT_COLOR.eGrayColor]))
end
end
end
end
else
self.starPanel2:setActive(false)
self.starAttrPanel2:setActive(false)
end
end
end




function UIXJLittleWorldXingChenUpWin:onCloseBtn()
UIFullLittleWorldControl:showXingChenBagWindow()
end

function UIXJLittleWorldXingChenUpWin:onRoot()
self:onCloseBtn()
end




function UIXJLittleWorldXingChenUpWin:onPoButton()
local needBorke=xingChenHelper.needBorke(self.pos)
if needBorke then
local upConfig=cfgHelper.get(cfg_starslvconfig_get,self.pos)
local lv=xingChenBagModel:getOrbitLevel(self.pos)
local cost=upConfig[lv+1].costs

for i,v in ipairs(cost)do
local costItem=cost[i]
local num=costItem[2]
if itemsModel.getCount(costItem[1])<num then
gainControl:showGainWin(costItem[1])
return
end
end
xingChenBagProtocolControl.req_37_94(self.pos)
end
end



function UIXJLittleWorldXingChenUpWin:onUpButton()
if not next(self.selectList)then
UIManager.error("需要选择好素材")
return
end

local guidList={}
local itemList={}

local haveRed=false
local haveUpStar=false
local haveOrange=false

for i,v in pairs(self.selectList)do
if itemsConfig.isXingChen(v[3])then
table.insert(guidList,v[1])
if itemsConfig.getItemColor(v[3])>=eQualityColor.eRed then
haveRed=true
end
if itemsConfig.getItemColor(v[3])==eQualityColor.eOrange then
haveOrange=true
end
if xingChenHelper.getStarLevelByGuid(v[1])>0 then
haveUpStar=true
end
else
table.insert(itemList,{v[1],v[2]})
end
end

if haveUpStar or haveRed or haveOrange then
local rType
local contentStr
if haveUpStar then
rType=REPEAT_TYPE.eXingChenQiangHua
contentStr='该星辰已升星，是否用来强化星轨？'
elseif haveRed then
rType=REPEAT_TYPE.eXingChenQiangHua_RedItem
contentStr='确认消耗红色品质的星辰？'
elseif haveOrange then
rType=REPEAT_TYPE.eXingChenQiangHua_OrangeItem
contentStr='确认消耗橙色品质的星辰？'
end
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eLogin,rType)
if not flag then
local showdata={
type='UIDialouge',
title='提示',
content=contentStr,
canceltext='取消',
oktext='确定',
choosetext="本次登录不再提示",
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eLogin,rType,flag)
end,
okcallback=function(...)
xingChenBagProtocolControl.req_37_93(self.pos,#guidList,guidList,#itemList,itemList)
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
else
xingChenBagProtocolControl.req_37_93(self.pos,#guidList,guidList,#itemList,itemList)
end
else
xingChenBagProtocolControl.req_37_93(self.pos,#guidList,guidList,#itemList,itemList)
end

self.upItemList=itemList

end

function UIXJLittleWorldXingChenUpWin:onShaiXuanButton()
self:showWindow("UIXJXingChenFilterWin",{
sortCondition=self.winFitler,
callback=function(fitler,winFitler)
self.filter=fitler
self.winFitler=winFitler
self:freshBagGrids(true)
end})
end

function UIXJLittleWorldXingChenUpWin:onFastButton()
local itemList,guidLookup=xingChenHelper.fastSelectIncrease(self.pos,self.groupIdx)
self.selectList=itemList
self.selectItemsLookup=guidLookup

self:freshBagGrids()

self:freshAddExp()
self.progressReverseAni=true
self.progressAni=false
self:setProgress()
self:setAttrs()
self:setSelectItems()
end