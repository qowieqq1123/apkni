







def_class("UIXingChenRongHePreviewWin",UIWindowBase)









function UIXingChenRongHePreviewWin:bindComponents()

self.attrPanel=UIObject.get(self,0)
self.center=UIObject.get(self,1)
self.ciZhuiPanel=UIObject.get(self,2)
self.closeBg=UIButton.get(self,3)
self.colorFrame=UIImage.get(self,4)
self.icon=UIImage.get(self,5)
self.level=UIText.get(self,6)
self.name=UIText.get(self,7)
self.queRenButton=UIButton.get(self,8)
self.star=UIObject.get(self,9)
self.starPanel=UIObject.get(self,10)
self.starText=UIText.get(self,11)
self.tips=UIText.get(self,12)
self.tipsBg=UIObject.get(self,13)
self.upStarText=UIText.get(self,14)
self.zhenxiPanel=UIObject.get(self,15)

self.closeBg:setButtonClick(function()
self:onCloseBg()
end)

self.queRenButton:setButtonClick(function()
self:onQueRenButton()
end)



end


function UIXingChenRongHePreviewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrPanel);
self.attrPanel=nil;
_UIObject_release(self.center);
self.center=nil;
_UIObject_release(self.ciZhuiPanel);
self.ciZhuiPanel=nil;
_UIObject_release(self.closeBg);
self.closeBg=nil;
_UIObject_release(self.colorFrame);
self.colorFrame=nil;
_UIObject_release(self.icon);
self.icon=nil;
_UIObject_release(self.level);
self.level=nil;
_UIObject_release(self.name);
self.name=nil;
_UIObject_release(self.queRenButton);
self.queRenButton=nil;
_UIObject_release(self.star);
self.star=nil;
_UIObject_release(self.starPanel);
self.starPanel=nil;
_UIObject_release(self.starText);
self.starText=nil;
_UIObject_release(self.tips);
self.tips=nil;
_UIObject_release(self.tipsBg);
self.tipsBg=nil;
_UIObject_release(self.upStarText);
self.upStarText=nil;
_UIObject_release(self.zhenxiPanel);
self.zhenxiPanel=nil;
end



















function UIXingChenRongHePreviewWin:onLoaded(...)
self:bindComponents()
end


function UIXingChenRongHePreviewWin:__delete()
self:unbindComponents()
end




function UIXingChenRongHePreviewWin:onShow(argtable,afterOnloaded)
local selectMainItem=argtable[1]
local selectChildItem=argtable[2]

self.previewItem=selectMainItem
self.addItem=selectChildItem
self.itemId=selectMainItem.itemid
self.itemConfig=itemsConfig.getConfig(self.itemId)
self.pos=self.itemConfig.type1

self:setShowItems()

self:refreshStarPanel()
end


function UIXingChenRongHePreviewWin:onHide()

end

function UIXingChenRongHePreviewWin:setShowItems()
local itemConfig=self.itemConfig
self.icon:setImageIcon(iconHelper.getIconName(self.itemId))
self.level:setText(FMT.fmt("星轨等级：{0}",xingChenBagModel:getOrbitLevel(self.pos)))
self.name:setText(xingChenHelper.getXingChenName(self.previewItem))

local colorFrame=FMT.fmt("image_xiaoshijiebz_{0}",itemConfig.color-2)
self.colorFrame:setCSImageSprite("ui/windows/xianjiebuilding/littleworld/littleworld_atlas_pak.ab",colorFrame)
end

function UIXingChenRongHePreviewWin:refreshStarPanel()
local equip=self.previewItem
local itemid=equip.itemid
local lv=xingChenHelper.getStarLevel(equip)

local addLv=xingChenHelper.getStarLevel(self.addItem)+1

local star_attrs=self.itemConfig.star_attrs
local maxLv=#star_attrs
local finLv=lv+addLv>maxLv and maxLv or lv+addLv

local cnt=xingChenHelper.getStarCnt(lv)
if lv==0 then
cnt=0
end
local curImg,curAb=xingChenHelper.getStarImg(lv)
local curEffectId=cfgHelper.get(cfg_starsstarconfig_get,lv,"effect")or 0

local newCnt=xingChenHelper.getStarCnt(finLv)
if finLv==0 then
newCnt=0
end
local newImg,newAb=xingChenHelper.getStarImg(finLv)
local newEffectId=cfgHelper.get(cfg_starsstarconfig_get,finLv,"effect")or 0

self.upStarText:setActive(lv<finLv)
if lv<finLv then
self.starText:setText(FMT.fmt("{0}<color=#549327>{1}星</color>",cfgHelper.get(cfg_starsstarconfig_get,lv,"show_star"),finLv-lv))
else
self.starText:setText(cfgHelper.get(cfg_starsstarconfig_get,lv,"show_star"))
end

local starWidget=self.star:getChildWidgetBase()
if not starWidget then return end

local stage=xingChenHelper.getStarStage(lv)
local newStage=xingChenHelper.getStarStage(finLv)
local lastStage=math.max(0,newStage-1)
local isChangeStage=newStage~=stage

local lastStageLv=lastStage*5
if lastStageLv<0 then
lastStageLv=0
end
local lastStageCnt=xingChenHelper.getStarCnt(lastStageLv)
local lastStageEffectId=cfgHelper.get(cfg_starsstarconfig_get,lastStageLv,"effect")or 0

local backImg,backAb
if lastStage>0 then
backImg,backAb=xingChenHelper.getStarImgByStage(lastStage)
else
backImg,backAb=xingChenHelper.getGrayStarImg()
end

for i=0,4 do
local effIndex=i+10
local needShowBack=true
local bgIndex=i+5
local idx=i+1

local effectId
local isFade=false
if idx<=newCnt then

starWidget:SetChildCSImageSprite(i,newAb,newImg)
starWidget:SetChildActive(i,true)

needShowBack=false


effectId=newEffectId
if isChangeStage then

isFade=true
else

if idx>cnt then

isFade=true
end
end
else

starWidget:SetChildCSImageSprite(i,backAb,backImg)
starWidget:SetChildActive(i,true)


effectId=lastStageEffectId
if lastStage==stage or lastStage==0 then
if idx>cnt and idx<=lastStageCnt then
isFade=true
end
else
if isChangeStage then
isFade=true
end
end

end

if isFade then
self:startWidgetAlpha(starWidget,i,true,effIndex)
else
self:startWidgetAlpha(starWidget,i,false,effIndex)
end

if effectId and effectId>0 then
starWidget:SetChildActive(effIndex,true)
starWidget:SetChildShowEffect(effIndex,effectId,true)
else
starWidget:SetChildActive(effIndex,false)
starWidget:SetChildShowEffect(effIndex,0,false)
end
starWidget:SetChildActive(bgIndex,false)
end

local attrList=xingChenHelper.getStarAttr(itemid,lv)
local nextLv=lv+addLv
local maxLv=#star_attrs
if nextLv>maxLv then
nextLv=maxLv
end
local nextAttrList=xingChenHelper.getStarAttr(itemid,nextLv)or defaultT
local growAttrList=xingChenHelper.getStarGrowAttr(itemid,lv)
local nextGrowAttrList=xingChenHelper.getStarGrowAttr(itemid,nextLv)or defaultT
if next(attrList)or next(nextAttrList)then
local star_attrs=self.itemConfig.star_attrs
local maxAttrList=star_attrs[maxLv][2]
self.attrPanel:setChildLayoutGroupCreateItems(#nextAttrList+#nextGrowAttrList)
local grids=self.attrPanel:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
local nextAttr=nextAttrList[i]
if nextAttr then
local attr=attrList[i]or defaultT
local name,str=equipsHelper.getAttr(nextAttr[1],attr[2]or 0)
if nextLv<=maxLv then
local _,nstr=equipsHelper.getAttr(nextAttr[1],nextAttr[2]-(attr[2]or 0))
grid:SetChildText(1,FMT.fmt("<color=#d03497>{0}+{1}</color>",name,str))
grid:SetChildActive(2,nextAttr[2]-(attr[2]or 0)>0)
grid:SetChildText(2,nstr)
else
grid:SetChildText(1,FMT.fmt("<color=#d03497>{0}+{1}<color=#549327>（已满级）</color></color>",name,str))
grid:SetChildActive(2,false)
end
else
local gNAttr=nextGrowAttrList[i-#nextAttrList]
local gAttr=growAttrList[i-#nextAttrList]or defaultT
local name,str=xingChenCiZhuiEffectController.getAttr(gNAttr[1],gAttr[2]or 0)
if nextLv<=maxLv then
local _,nstr=xingChenCiZhuiEffectController.getAttr(gNAttr[1],gNAttr[2]-(gAttr[2]or 0))
grid:SetChildText(1,FMT.fmt("<color=#d03497>{0}+{1}</color>",name,str))
grid:SetChildActive(2,gNAttr[2]-(gAttr[2]or 0)>0)
grid:SetChildText(2,nstr)
else
grid:SetChildText(1,FMT.fmt("<color=#d03497>{0}+{1}<color=#549327>（已满级）</color></color>",name,str))
grid:SetChildActive(2,false)
end
end
end
else
local nextLv=self.itemConfig.first_star_attrs_lv[1]
local nextAttr=xingChenHelper.getStarAttr(itemid,nextLv)
self.attrPanel:setChildLayoutGroupCreateItems(#nextAttr)
local grids=self.attrPanel:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
local attr=nextAttr[i]
local name,str=equipsHelper.getAttr(attr[1],attr[2])
grid:SetChildText(1,FMT.fmt("<color={3}>{0}+{1}（{2}激活）</color>",name,str,cfgHelper.get(cfg_starsstarconfig_get,nextLv,"show_star"),FONT_TIPS_COLOR_VAL[FONT_COLOR.eGrayColor]))
end
end

self:setCiZhuiPanel()
self:refreshZhenXiPanel()
end

local checkSameCiZhui=function(selectMainItem,selectChildItem)
if not selectMainItem then
return
end
if not selectChildItem then
return
end
local affixList=xingChenHelper.getAffixList(selectMainItem)
local childAffixList=xingChenHelper.getAffixList(selectChildItem)

local diff_num=0
local diff_list={}
for _,v in ipairs(childAffixList)do
if not table.containsValue(affixList,v)then
diff_num=diff_num+1
diff_list[#diff_list+1]=v
end
end

return diff_num==0,diff_num,diff_list
end

local SHOW_AFFIX_TYPE={
eUnchanged=0,
eReplace=1,
eAddSlot=2,
eAddFix=3,
eAddRandom=4,
}

function UIXingChenRongHePreviewWin:setCiZhuiPanel()
local equip=self.previewItem
local addItem=self.addItem
local affixList=xingChenHelper.getAffixList(equip)
local affixListCnt=#affixList
local lv=xingChenHelper.getStarLevel(equip)
local affix_num=0
local o_add_num=0
o_add_num=cfgHelper.get(cfg_starsstarconfig_get,lv,"affix_cnt")
local addLv=xingChenHelper.getStarLevel(self.addItem)+1
local star_attrs=self.itemConfig.star_attrs
local maxLv=#star_attrs
local finLv=lv+addLv>maxLv and maxLv or lv+addLv
local add_num=cfgHelper.get(cfg_starsstarconfig_get,finLv,"affix_cnt")
local new_num=add_num-o_add_num
affix_num=affix_num+add_num

local isContains,diffNum,diffList=checkSameCiZhui(equip,addItem)

local affixType

if affixListCnt<affix_num and(new_num>0 or(affixListCnt<o_add_num and not isContains))then

self.tipsBg:setGray(false)
if isContains then
affixType=SHOW_AFFIX_TYPE.eAddSlot
self.tips:setText(FMT.fmt("新增{0}个空槽",mathHelper.numberToChinese(new_num)))
else
if diffNum>1 then
affixType=SHOW_AFFIX_TYPE.eAddRandom
self.tips:setText("随机新增词缀")
else
affixType=SHOW_AFFIX_TYPE.eAddFix
self.tips:setText("新增一个词缀")
end
end
else
if isContains then
affixType=SHOW_AFFIX_TYPE.eUnchanged
self.tips:setText("词缀无变化")
self.tipsBg:setGray(true)
else

affixType=SHOW_AFFIX_TYPE.eReplace
self.tips:setText("概率替换其一")
self.tipsBg:setGray(false)
end
end

self:startWidgetAlpha(self.winid,self.tipsBg:getID(),true,1)

self.ciZhuiPanel:setChildLayoutGroupCreateItems(math.max(affixListCnt,affix_num))
local grids=self.ciZhuiPanel:getChildLayoutGroupGridList()
if affixListCnt>0 then
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
grid:SetChildActive(6,true)
grid:SetChildActive(4,true)
else
local newIndex=i-affixListCnt
if affixType==SHOW_AFFIX_TYPE.eAddFix then
local diffAffix=diffList[newIndex]
if diffAffix then
grid:SetChildActive(6,false)
grid:SetChildActive(4,true)
local config=cfgHelper.get(cfg_starsaffixconfig_get,diffAffix)
local ab,frame=xingChenHelper.getAffixColorFrame(config.color)
local name=xingChenHelper.getAffixNameStr(config.name)
grid:SetChildText(1,name)
grid:SetChildCSImageSprite(0,ab,frame)
grid:SetChildButtonClick(0,function()
self:showWindow("UILittleWorldAffixWin",{item=grid,node='bottom',config=config})
end)
else
grid:SetChildActive(6,true)
grid:SetChildActive(4,false)
end
else

grid:SetChildActive(6,true)
local diffAffix=newIndex==1 and diffList[newIndex]or nil
if diffAffix then
grid:SetChildActive(4,true)
grid:SetChildActive(0,false)
grid:SetChildText(1,"<color=#4f4f4f>?</color>")
else
grid:SetChildActive(4,false)
end
end
end
grid:SetChildActive(7,affix==nil)
end
end
end

function UIXingChenRongHePreviewWin:refreshZhenXiPanel()
local equip=self.previewItem
local lv=xingChenHelper.getStarLevel(equip)
local addLv=xingChenHelper.getStarLevel(self.addItem)+1
local star_attrs=self.itemConfig.star_attrs
local maxLv=#star_attrs
local finLv=lv+addLv>maxLv and maxLv or lv+addLv
local nextStar=star_attrs[finLv]

if nextStar[1]~=0 then

local effects_adddesc={}
local oPrio=0
if equip.itemData.fin_rare_id~=0 then
local zxConfig=cfgHelper.get(cfg_starsrareconfig_get,equip.itemData.fin_rare_id)
effects_adddesc=zxConfig.effects_adddesc
oPrio=zxConfig.prio
end

local nextConfig=cfgHelper.get(cfg_starsrareconfig_get,nextStar[1])

local isJzAttr=nextConfig.jz_effects~=nil

local attrList,nextList

local max_id=star_attrs[maxLv][1]
local isMax=max_id==equip.itemData.fin_rare_id
if nextStar and nextStar[1]>0 and nextStar[1]~=equip.itemData.fin_rare_id then
if nextConfig.prio>oPrio then
if isJzAttr then
if equip.itemData.fin_rare_id~=0 then
local zxConfig=cfgHelper.get(cfg_starsrareconfig_get,equip.itemData.fin_rare_id)
attrList=zxConfig.jz_effects
end
nextList=nextConfig.jz_effects
else
if equip.itemData.fin_rare_id~=0 then
local zxConfig=cfgHelper.get(cfg_starsrareconfig_get,equip.itemData.fin_rare_id)
attrList=zxConfig.grow_effects
end
nextList=nextConfig.grow_effects
end
end
end
self.zhenxiPanel:setChildLayoutGroupCreateItems(equip.itemData.fin_rare_id>0 and#effects_adddesc or#nextConfig.effects_adddesc)
local grids=self.zhenxiPanel:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
if nextList then
local attr=(attrList~=nil and attrList[i])or defaultT
attr=attr or defaultT
if isJzAttr then
local _,str=equipsHelper.getAttr(nextList[i][1],nextList[i][2]-(attr[2]or 0))
if attr[2]then
grid:SetChildText(1,FMT.fmt("<color=#ca631d>{0}</color>",effects_adddesc[i]))
else
local name,str=equipsHelper.getAttr(nextList[i][1],0)
grid:SetChildText(1,FMT.fmt("<color=#ca631d>{0}+{1}</color>",name,str))
end
grid:SetChildActive(2,true)
grid:SetChildText(2,str)
else
if i==1 then
local k=next(nextList[i][2])
local _,str=equipsHelper.getAttr(k,nextList[i][2][k]-(attr[2]~=nil and attr[2][k]or 0))
if attr[2]then
grid:SetChildText(1,FMT.fmt("<color=#ca631d>{0}</color>",effects_adddesc[i]))
else
local name,str=equipsHelper.getAttr(k,0)
grid:SetChildText(1,FMT.fmt("<color=#ca631d>{0}+{1}</color>",name,str))
end
grid:SetChildActive(2,true)
grid:SetChildText(2,str)
end
end
else
if isMax then
grid:SetChildText(1,FMT.fmt("<color=#ca631d>{0}<color=#549327>（已满级）</color></color>",effects_adddesc[i]))
grid:SetChildActive(2,false)
else
grid:SetChildText(1,FMT.fmt("<color=#ca631d>{0}</color>",effects_adddesc[i]))
grid:SetChildActive(2,false)
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
if finLv>=nextLv then
grid:SetChildText(1,FMT.fmt("<color=#8e8c87>{0}<color=#549327>（{1}激活）</color></color>",zxConfig[i],cfgHelper.get(cfg_starsstarconfig_get,nextLv,"show_star")))
else
grid:SetChildText(1,FMT.fmt("<color=#8e8c87>{0}（{1}激活）</color>",zxConfig[i],cfgHelper.get(cfg_starsstarconfig_get,nextLv,"show_star")))
end
end
end
end
end

function UIXingChenRongHePreviewWin:startWidgetAlpha(widget,componentIndex,isPlay,reddotIndex)
if isPlay then
if self.reddotTweenerList==nil then
self.reddotTweenerList={}
end

if self.reddotTweenerList[reddotIndex]==nil then

widget:SetChildCanvasGroupAlpha(componentIndex,0.2)
local tweener=widget:SetChildCanvasGroupDOFade(componentIndex,1,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Yoyo)
self.reddotTweenerList[reddotIndex]={}
self.reddotTweenerList[reddotIndex].tweener=tweener
self.reddotTweenerList[reddotIndex].widget=widget
self.reddotTweenerList[reddotIndex].componentIndex=componentIndex
end

return reddotIndex
else
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return nil
end
if self.reddotTweenerList[reddotIndex]~=nil then
self.reddotTweenerList[reddotIndex].tweener:Complete()
self.reddotTweenerList[reddotIndex].tweener:Kill()
self.reddotTweenerList[reddotIndex]=nil
widget:SetChildCanvasGroupAlpha(componentIndex,1)
return nil
end
end
end




function UIXingChenRongHePreviewWin:onCloseBg()
self:closeSelf()
end

function UIXingChenRongHePreviewWin:onQueRenButton()
self:closeSelf()
end

