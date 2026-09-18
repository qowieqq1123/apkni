







def_class("UIXJLittleWorldXingChenFenJieWin",UIWindowBase)









function UIXJLittleWorldXingChenFenJieWin:bindComponents()

self.attrPanel=UIObject.get(self,0)
self.BagList=UIScrollViewSlow.get(self,1)
self.bagNum=UIText.get(self,2)
self.ciZhuiPanel=UIObject.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.colorFrame=UIImage.get(self,5)
self.filterbutton=UIButton.get(self,6)
self.gainPanel=UIObject.get(self,7)
self.gainRoot=UIObject.get(self,8)
self.groupRoot=UIObject.get(self,9)
self.icon=UIImage.get(self,10)
self.jinglianlevel=UIText.get(self,11)
self.left=UIObject.get(self,12)
self.level=UIText.get(self,13)
self.name=UIText.get(self,14)
self.pageItem_1=UIObject.get(self,15)
self.progressBar=UIProgressBarAni.get(self,16)
self.progressBarReverse=UIProgressBarAni.get(self,17)
self.progressCount=UIText.get(self,18)
self.progressCountReverse=UIText.get(self,19)
self.right=UIObject.get(self,20)
self.root=UIButton.get(self,21)
self.shaiXuanButton=UIButton.get(self,22)
self.star=UIObject.get(self,23)
self.starAttrPanel=UIObject.get(self,24)
self.starPanel=UIObject.get(self,25)
self.starText=UIText.get(self,26)
self.upButton=UIButton.get(self,27)
self.zhenxiEffect=UIObject.get(self,28)
self.zhenxiPanel=UIObject.get(self,29)

self.closeBtn:setButtonClick(function()
self:onCloseBtn()
end)

self.filterbutton:setButtonClick(function()
self:onFilterbutton()
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
self.pageItem={
self.pageItem_1,
}



end


function UIXJLittleWorldXingChenFenJieWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrPanel);
self.attrPanel=nil;
_UIObject_release(self.BagList);
self.BagList=nil;
_UIObject_release(self.bagNum);
self.bagNum=nil;
_UIObject_release(self.ciZhuiPanel);
self.ciZhuiPanel=nil;
_UIObject_release(self.closeBtn);
self.closeBtn=nil;
_UIObject_release(self.colorFrame);
self.colorFrame=nil;
_UIObject_release(self.filterbutton);
self.filterbutton=nil;
_UIObject_release(self.gainPanel);
self.gainPanel=nil;
_UIObject_release(self.gainRoot);
self.gainRoot=nil;
_UIObject_release(self.groupRoot);
self.groupRoot=nil;
_UIObject_release(self.icon);
self.icon=nil;
_UIObject_release(self.jinglianlevel);
self.jinglianlevel=nil;
_UIObject_release(self.left);
self.left=nil;
_UIObject_release(self.level);
self.level=nil;
_UIObject_release(self.name);
self.name=nil;
_UIObject_release(self.pageItem_1);
self.pageItem_1=nil;
_UIObject_release(self.progressBar);
self.progressBar=nil;
_UIObject_release(self.progressBarReverse);
self.progressBarReverse=nil;
_UIObject_release(self.progressCount);
self.progressCount=nil;
_UIObject_release(self.progressCountReverse);
self.progressCountReverse=nil;
_UIObject_release(self.right);
self.right=nil;
_UIObject_release(self.root);
self.root=nil;
_UIObject_release(self.shaiXuanButton);
self.shaiXuanButton=nil;
_UIObject_release(self.star);
self.star=nil;
_UIObject_release(self.starAttrPanel);
self.starAttrPanel=nil;
_UIObject_release(self.starPanel);
self.starPanel=nil;
_UIObject_release(self.starText);
self.starText=nil;
_UIObject_release(self.upButton);
self.upButton=nil;
_UIObject_release(self.zhenxiEffect);
self.zhenxiEffect=nil;
_UIObject_release(self.zhenxiPanel);
self.zhenxiPanel=nil;
self.pageItem=nil;
end


















local _colomn=4
local _creatGirdPrecent=500

function UIXJLittleWorldXingChenFenJieWin:onLoaded(...)
self:bindComponents()

self.BagList:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)

self.BagList:setSlowClickAction(function(...)
self:onClickGrid(...)
end)

self.sortOrder=ITEM_SORT_COMPARE_TYPE.eDownOrder

end


function UIXJLittleWorldXingChenFenJieWin:__delete()
self:unbindComponents()
end




function UIXJLittleWorldXingChenFenJieWin:onShow(argtable,afterOnloaded)


self:onShowArgRecv(argtable)
end


function UIXJLittleWorldXingChenFenJieWin:onHide()
self.winFitler=nil
end

function UIXJLittleWorldXingChenFenJieWin:onShowArgRecv(argtable)
self.left:setChildAnchoredPos(-512,0)
self.left:setChildDOAnchorPosX(0,0.5)
self.groupIdx=nil
self.selectItemsLookup={}
self.selectNum=0
self.selectEquip=nil
self:refreshBagTypePanel()
self:selectGroupItem(1)
self:refreshInfoPanel()
end

function UIXJLittleWorldXingChenFenJieWin:refreshBagTypePanel()
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

function UIXJLittleWorldXingChenFenJieWin:selectGroupItem(i)
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

self:refreshBagListPanel()

end

function UIXJLittleWorldXingChenFenJieWin:recvFenJie()
self.selectItemsLookup={}
self.selectNum=0
self:refreshBagListPanel()
self:refreshInfoPanel()
end

function UIXJLittleWorldXingChenFenJieWin:refreshBagListPanel(selectAllItem,isEmptySort)
local newFitler={}
newFitler[ITEM_FILTER_TYPE.eXingChenRongHe]={ITEM_FILTER_COMPARE.eNot,{1}}
newFitler[ITEM_FILTER_TYPE.eXingChenRongHeChild]={ITEM_FILTER_COMPARE.eNot,{1}}

if self.sortFitler then
for i,v in pairs(self.sortFitler)do
newFitler[i]=v
end
end

local bagList=xingChenHelper.sortEquip(self.groupIdx,self.sortOrder,false,newFitler)

if selectAllItem then
self.selectItemsLookup={}
self.selectNum=0
if not isEmptySort then
local all=xingChenHelper.sortEquip(nil,nil,false,newFitler)
for i=#all,1,-1 do
local item=all[i]
local itemguidstr=tostring(item.itemguid)
self.selectItemsLookup[itemguidstr]={item.itemguid,item.itemid}
self.selectNum=self.selectNum+1
end
end
else
local isPutItem=function(itemguid)
for i,info in pairs(self.selectItemsLookup)do
if tostring(info[1])==tostring(itemguid)then
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
end

for i,v in ipairs(list)do
table.insert(bagList,1,v)
end
end
end

self.itemsList=bagList
local chlen=#bagList

local tNum=_creatGirdPrecent
tNum=math.max(tNum,chlen)

local row=math.ceil(tNum/_colomn)+7
tNum=(row+7)*_colomn
local row=math.ceil(tNum/_colomn)

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

function UIXJLittleWorldXingChenFenJieWin:bindGrid(index,widget)
local itemInfo=self.itemsList[index]

local isTemp=itemInfo==nil
if not isTemp then


local itemcount=itemInfo.itemcount or 0
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid or-1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=itemsModel.getIconName(itemInfo)
local num=self:getSelectNum(itemguid)


local has=num>0

local isSelect=self.selectEquip~=nil and self.selectEquip.itemguid==itemguid
local isLock=bagHelper.isLock(itemInfo)
widget:SetChildActive(0,true)
widget:SetChildActive(1,isSelect)
widget:SetChildQulaity(2,color)
widget:SetChildIcon(3,iconName,false)
widget:SetChildText(4,'')
widget:SetChildActive(5,false)
widget:SetChildText(6,'')
widget:SetChildText(7,'')
widget:SetChildActive(8,false)
widget:SetChildActive(9,isLock)
widget:SetChildActive(10,has)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid)





xingChenHelper.setStarFlag(widget:GetChildWidgetBase(12),xingChenHelper.getStarLevel(itemInfo),true)
else
widget:SetChildActive(0,true)
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
widget:SetChildActive(3,false)
widget:SetChildText(4,'')
widget:SetChildActive(5,false)
widget:SetChildText(6,'')
widget:SetChildText(7,'')
widget:SetChildActive(8,false)
widget:SetChildActive(9,false)
widget:SetChildActive(10,false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
widget:SetChildActive(12,false)


end
end

function UIXJLittleWorldXingChenFenJieWin:refreshInfoPanel()
local equip=self.selectEquip

if equip then
self.right:setActive(true)

local itemid=equip.itemid
local config=itemsConfig.getConfig(itemid)
local type1=config.type1
local colorFrame=FMT.fmt("image_xiaoshijiebz_{0}",config.color-2)

self.colorFrame:setCSImageSprite("ui/windows/xianjiebuilding/littleworld/littleworld_atlas_pak.ab",colorFrame)

local curlv=xingChenBagModel:getOrbitLevel(type1)
local curExp=xingChenBagModel:getExp(type1)

local upConfig=cfgHelper.get(cfg_starslvconfig_get,type1)
if upConfig[curlv+1]then
local maxExp=upConfig[curlv+1].exp
self.progressBar:animateThreeParams(curExp,maxExp,0,false)
self.progressCount:setText(FMT.fmt("{0}/{1}",curExp,maxExp))
else
local maxExp=upConfig[curlv].exp
self.progressBar:animateThreeParams(100,100,0,false)
self.progressCount:setText(FMT.fmt("{0}/{1}",maxExp,maxExp))
end

self.level:setText(FMT.fmt("星轨等级：{0}",curlv))
self.name:setText(xingChenHelper.getXingChenName(equip))

self.icon:setImageIcon(iconHelper.getIconName(itemid))

local fixAttrs=xingChenHelper.getFixedAttr(itemid,curlv)
self.attrPanel:setChildLayoutGroupCreateItems(#fixAttrs)
local grids=self.attrPanel:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
local attr=fixAttrs[i]
local name,str=equipsHelper.getAttr(attr[1],attr[2])
grid:SetChildText(1,FMT.fmt("{0}：{1}",name,str))
end

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
local color=config.color
self.zhenxiPanel:setActive(color==eQualityColor.eRed)
if color==eQualityColor.eRed then
local nextLv=config.first_star_attrs_lv[2]
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

self:freshGainList()
else
self.right:setActive(false)
end

self:refreshStarPanel()
end

function UIXJLittleWorldXingChenFenJieWin:getSelectNum(itemguid)
if self.selectItemsLookup==nil then
self.selectItemsLookup={}
end
local selectItemsLookup=self.selectItemsLookup
local index=selectItemsLookup[tostring(itemguid)]
if index then
return 1
end
return 0
end

function UIXJLittleWorldXingChenFenJieWin:freshGainList()
local gainList={}
if self.selectItemsLookup then
for i,v in pairs(self.selectItemsLookup)do
local star=xingChenHelper.getStarLevelByGuid(v[1])
local itemConfig=itemsConfig.getConfig(v[2])

local decompose_reward=itemConfig.decompose_reward
gainList=xingChenHelper.concatList(gainList,decompose_reward,star+1)

end
end

if#gainList>0 then
self.gainRoot:setActive(true)
self.gainPanel:setChildScrollViewCreateGrids(#gainList,#gainList)
local grids=self.gainPanel:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local costItem=gainList[i]
local num=costItem[2]
local item={itemid=costItem[1],itemcount=num}
local countStr=num>1 and num or''
local conf={showname=false,itemcount=countStr,showcount=countStr~='',showCountBG=countStr~='',showRare=true}
grids[i-1]:SetChildPropData(0,itemsComponentHelper.getCommonFillData(item,conf))
grids[i-1]:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end
else
self.gainRoot:setActive(false)
end

end

function UIXJLittleWorldXingChenFenJieWin:onClickGrid(itemid,index,itemguid,attach)
if itemid==-1 then
return
end

local itemguidstr=tostring(itemguid)
local selectData=self.selectItemsLookup[itemguidstr]
if selectData then
self.selectItemsLookup[itemguidstr]=nil
self:freshProvideSelectSingleGirid(itemguidstr,false)
self.selectNum=self.selectNum-1
else
if self.selectNum>=200 then
UIManager.error("已达到单次分解上限")
return
end

self.selectItemsLookup[itemguidstr]={itemguid,itemid}
self:freshProvideSelectSingleGirid(itemguidstr,true)
self.selectNum=self.selectNum+1
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

function UIXJLittleWorldXingChenFenJieWin:getBagItemIdx(itemguid)
local list=self.itemsList or{}
for i,v in ipairs(list)do
if tostring(v.itemguid)==tostring(itemguid)then
return i,v
end
end
end

function UIXJLittleWorldXingChenFenJieWin:freshProvideSelectSingleGirid(itemguid,flag)
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.BagList:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(10,flag)
if not flag then
widget:SetChildLongPressStop(10)
end

end
end
end

function UIXJLittleWorldXingChenFenJieWin:freshSelectInfoGrid(itemguid,flag)
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.BagList:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(1,flag)
end
end
end

function UIXJLittleWorldXingChenFenJieWin:refreshStarPanel()
local equip=self.selectEquip
if equip then
local itemid=self.selectEquip.itemid
local config=itemsConfig.getConfig(itemid)
local color=config.color
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
end






function UIXJLittleWorldXingChenFenJieWin:onCloseBtn()

UIFullLittleWorldControl:showXingChenMainWindow()
end

function UIXJLittleWorldXingChenFenJieWin:onRoot()
self:onCloseBtn()
end




function UIXJLittleWorldXingChenFenJieWin:onShaiXuanButton()

self.sortCondition=self.sortCondition or{}
if not self.isInitFilter then
self:initFilter()
self.isInitFilter=true
end
self.filterbutton:setActive(true)
end

local sortTypeList={
[ITEM_FILTER_TYPE.eColor]={
title="品质",
getNameList=function()
return{{"<color=#6833c0>紫</color>",3},{"<color=#ca631d>橙</color>",4},{"<color=#c82c2c>红</color>",5}}
end
},
}

function UIXJLittleWorldXingChenFenJieWin:initFilter()
local filterType=ITEM_FILTER_TYPE.eColor

local pageWidget=self.pageItem_1:getChildWidgetBase()
local nameList=sortTypeList[filterType].getNameList()
local childnum=#nameList


pageWidget:SetChildLayoutGroupCreateItems(1,childnum)
local childGrids=pageWidget:GetChildLayoutGroupGridList(1)
for i2=1,childnum do
local childItem=childGrids[i2-1]
local isselect=self.sortCondition[i2]or false
self.lockToggle=true
childItem:SetChildToggle(0,isselect)
self.lockToggle=false
childItem:SetChildToggleChange(0,function(name,isOn)
if self.lockToggle then
return
end
self.sortCondition[i2]=isOn==true and true or nil
end)
childItem:SetChildText(1,nameList[i2][1])
end
end

function UIXJLittleWorldXingChenFenJieWin:getSortCond()
local empty=true
local sortCondition={}
local list={}
local nameList=sortTypeList[ITEM_FILTER_TYPE.eColor].getNameList()
for i,v in pairs(self.sortCondition)do
if v then
table.insert(list,nameList[i][2])
end
end
if#list>0 then
sortCondition[ITEM_FILTER_TYPE.eColor]={ITEM_FILTER_COMPARE.eEquals,list}
empty=false
end
return sortCondition,empty
end

function UIXJLittleWorldXingChenFenJieWin:onFilterbutton()
self.filterbutton:setActive(false)
local fitler,isEmpty=self:getSortCond()
self.selectItemsLookup={}
self.selectNum=0
local last
if not isEmpty then
fitler[ITEM_FILTER_TYPE.eXingChenRongHe]={ITEM_FILTER_COMPARE.eNot,{1}}
fitler[ITEM_FILTER_TYPE.eXingChenRongHeChild]={ITEM_FILTER_COMPARE.eNot,{1}}

local all=xingChenHelper.sortEquip(nil,nil,false,fitler)

for i=#all,1,-1 do
if self.selectNum>=200 then
break
end
local item=all[i]
local itemguidstr=tostring(item.itemguid)
self.selectItemsLookup[itemguidstr]={item.itemguid,item.itemid}
self.selectNum=self.selectNum+1
if not last then
last=item
end
end
end
self.BagList:freshAllItems()
self.selectEquip=last
self:refreshInfoPanel()
end



function UIXJLittleWorldXingChenFenJieWin:onUpButton()

if self.selectItemsLookup and next(self.selectItemsLookup)then
local guidList={}
local haveUpStar=false
local haveRed=false
for i,v in pairs(self.selectItemsLookup)do
table.insert(guidList,v[1])
if itemsConfig.getItemColor(v[2])>=eQualityColor.eRed then
haveRed=true
end
if xingChenHelper.getStarLevelByGuid(v[1])>0 then
haveUpStar=true
end
end

local str='确认分解选择星辰?'
local rType=REPEAT_TYPE.eXingChenFenJie
if haveUpStar then
str='该星辰已升星，是否用来分解？'
rType=REPEAT_TYPE.eXingChenFenJieRedStar
else
if haveRed then
str='确认分解红色品质的星辰？'
rType=REPEAT_TYPE.eXingChenFenJieRed
end
end
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eLogin,rType)
if not flag then

local showdata={
type='UIDialouge',
title='提示',
content=str,
canceltext='取消',
oktext='确定',
choosetext="本次登录不再提示",
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eLogin,rType,flag)
end,
okcallback=function(...)
xingChenBagProtocolControl.req_37_92(#guidList,guidList)
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
else
xingChenBagProtocolControl.req_37_92(#guidList,guidList)
end


else
UIManager.error("请选择要分解的星辰")
end

end


function UIXJLittleWorldXingChenFenJieWin:refreshList()
self.BagList:freshAllItems()
end

