







def_class("UIWanBaoXunBaoDui_EquipWin",UIWindowBase)









function UIWanBaoXunBaoDui_EquipWin:bindComponents()

self.root=UIObject.get(self,0)
self.successEffect=UIObject.get(self,1)
self.leftDialogue=UIButton.get(self,2)
self.uiRoot=UIObject.get(self,3)
self.leftdialogueinfo=UIObject.get(self,4)
self.leftroot=UIObject.get(self,5)
self.refinementRRoot=UIObject.get(self,6)
self.goGetMaterial=UIObject.get(self,7)
self.materialRoot=UIObject.get(self,8)
self.refinementLRoot=UIObject.get(self,9)
self.Dropdown2_Dialogue=UIDropdownEx.get(self,10)
self.quickFillBtn=UIButton.get(self,11)
self.refineBtn=UIButton.get(self,12)
self.effectRoot=UIObject.get(self,13)
self.addExpTip=UIText.get(self,14)
self.costList=UIObject.get(self,15)
self.progressBar1=UIProgressBarAni.get(self,16)
self.refinelevelinfo=UIText.get(self,17)
self.tipsBg=UIObject.get(self,18)
self.equipitem=UIBaseItem.get(self,19)
self.namebg=UIObject.get(self,20)
self.jlMetarial_5=UIBaseItem.get(self,21)
self.jlMetarial_1=UIBaseItem.get(self,22)
self.jlMetarial_3=UIBaseItem.get(self,23)
self.jlMetarial_2=UIBaseItem.get(self,24)
self.jlMetarial_4=UIBaseItem.get(self,25)
self.effectList=UIObject.get(self,26)
self.progresstxt=UIText.get(self,27)
self.progressBar2=UIProgressBarAni.get(self,28)
self.noEquipTip=UIText.get(self,29)
self.refineEquipName=UIText.get(self,30)
self.redefineTip=UIText.get(self,31)
self.putBtnReddot_Dialogue=UIObject.get(self,32)
self.btnQuickPut=UIButton.get(self,33)
self.btnReset=UIButton.get(self,34)
self.ScrollView=UIScrollViewSlow.get(self,35)
self.Dropdown1_Dialogue=UIDropdownEx.get(self,36)
self.goGetMaterialBtn=UIButton.get(self,37)

self.leftDialogue:setButtonClick(function()self:onLeftDialogue()end)

self.quickFillBtn:setButtonClick(function()self:onQuickFillBtn()end)

self.refineBtn:setButtonClick(function()self:onRefineBtn()end)

self.btnQuickPut:setButtonClick(function()self:onBtnQuickPut()end)

self.btnReset:setButtonClick(function()self:onBtnReset()end)

self.goGetMaterialBtn:setButtonClick(function()self:onGoGetMaterialBtn()end)
self.jlMetarial={
self.jlMetarial_1,
self.jlMetarial_2,
self.jlMetarial_3,
self.jlMetarial_4,
self.jlMetarial_5,
}
self.Dropdown2={
["Dialogue"]=self.Dropdown2_Dialogue,
}
self.putBtnReddot={
["Dialogue"]=self.putBtnReddot_Dialogue,
}
self.Dropdown1={
["Dialogue"]=self.Dropdown1_Dialogue,
}



end


function UIWanBaoXunBaoDui_EquipWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.successEffect);self.successEffect=nil;
_UIObject_release(self.leftDialogue);self.leftDialogue=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.leftdialogueinfo);self.leftdialogueinfo=nil;
_UIObject_release(self.leftroot);self.leftroot=nil;
_UIObject_release(self.refinementRRoot);self.refinementRRoot=nil;
_UIObject_release(self.goGetMaterial);self.goGetMaterial=nil;
_UIObject_release(self.materialRoot);self.materialRoot=nil;
_UIObject_release(self.refinementLRoot);self.refinementLRoot=nil;
_UIObject_release(self.Dropdown2_Dialogue);self.Dropdown2_Dialogue=nil;
_UIObject_release(self.quickFillBtn);self.quickFillBtn=nil;
_UIObject_release(self.refineBtn);self.refineBtn=nil;
_UIObject_release(self.effectRoot);self.effectRoot=nil;
_UIObject_release(self.addExpTip);self.addExpTip=nil;
_UIObject_release(self.costList);self.costList=nil;
_UIObject_release(self.progressBar1);self.progressBar1=nil;
_UIObject_release(self.refinelevelinfo);self.refinelevelinfo=nil;
_UIObject_release(self.tipsBg);self.tipsBg=nil;
_UIObject_release(self.equipitem);self.equipitem=nil;
_UIObject_release(self.namebg);self.namebg=nil;
_UIObject_release(self.jlMetarial_5);self.jlMetarial_5=nil;
_UIObject_release(self.jlMetarial_1);self.jlMetarial_1=nil;
_UIObject_release(self.jlMetarial_3);self.jlMetarial_3=nil;
_UIObject_release(self.jlMetarial_2);self.jlMetarial_2=nil;
_UIObject_release(self.jlMetarial_4);self.jlMetarial_4=nil;
_UIObject_release(self.effectList);self.effectList=nil;
_UIObject_release(self.progresstxt);self.progresstxt=nil;
_UIObject_release(self.progressBar2);self.progressBar2=nil;
_UIObject_release(self.noEquipTip);self.noEquipTip=nil;
_UIObject_release(self.refineEquipName);self.refineEquipName=nil;
_UIObject_release(self.redefineTip);self.redefineTip=nil;
_UIObject_release(self.putBtnReddot_Dialogue);self.putBtnReddot_Dialogue=nil;
_UIObject_release(self.btnQuickPut);self.btnQuickPut=nil;
_UIObject_release(self.btnReset);self.btnReset=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.Dropdown1_Dialogue);self.Dropdown1_Dialogue=nil;
_UIObject_release(self.goGetMaterialBtn);self.goGetMaterialBtn=nil;
self.jlMetarial=nil;
self.Dropdown2=nil;
self.putBtnReddot=nil;
self.Dropdown1=nil;
end

















local _this=nil

local CmpMenuItemIndex={
self=0,
normal=1,
select=2,
name=3,
}

local CmpBagMenuItemIndex={
self=0,
bg=1,
name=2,
select=3,
}

local CmpEquipItemIndex={
bg=0,
item=1,
add=2,
}

local _colomn=4
local _row=5
local _maxAttrLine=7
local _fillItemLen=5

local _bag_filter_color_desc_1
local _bag_filter_color_desc_2




function UIWanBaoXunBaoDui_EquipWin:onLoaded(...)
self:bindComponents()

_this=self
self.jlMetarialsNum=0
self.jlMetarialsList={}

self.ScrollView:bindSlowWidget(function(...)_this:bindGrid(...)end)
self.ScrollView:setSlowClickAction(function(...)self:onClickGrid(...)end)
self.ScrollView:setSlowLongClickAction(function(...)self:onClickLongGridButton(...)end)

self.Dropdown1_Dialogue:setChangeAction(function(...)_this:onDropdownChange(...)end)
self.Dropdown2_Dialogue:setChangeAction(function(...)_this:onDropdownChange(...)end)


local colorlist=table.toTable(eQualityColor.eGreen,eQualityColor.eRed)
_bag_filter_color_desc_1=itemsFilterHelper.getFilterNames(colorlist,function(color)
return FMT.fmt('{0}及以下',eQualityColorName[color])
end)

_bag_filter_color_desc_2=itemsFilterHelper.getFilterNames(colorlist,function(color)
return FMT.fmt('{0}及以上',eQualityColorName[color])
end)


self.leftDialogue:setActive(false)

self.jlEquipLv=0
self.jlEquipExp=0

self.colorIdx=0

self:resetData()
end


function UIWanBaoXunBaoDui_EquipWin:__delete()
self:unbindComponents()

if self.tw then
self.tw:Kill()
self.tw=nil
end
end




function UIWanBaoXunBaoDui_EquipWin:onShow(argtable,afterOnloaded)
self.selectEquipGuid=argtable and argtable.guid or self.selectEquipGuid
self.selectEquipItem=argtable and argtable.item or self.selectEquipItem

self:fillSelectItem()

self:freshInfo()

self:playAnimation()
end


function UIWanBaoXunBaoDui_EquipWin:onHide()

end

function UIWanBaoXunBaoDui_EquipWin:onShowArgRecv(argtable)
self:onShow(argtable)
self:playAnimation()
end

function UIWanBaoXunBaoDui_EquipWin:playAnimation()
if self.tw then
self.tw:Kill()
self.tw=nil
end

UIManager:invokeUIMethod('UIWanBaoXunBaoDui_MenuWin','playSwitchAnimation',10)
self.uiRoot:setChildAnchoredPos(0,700)
self.tw=self.uiRoot:setChildDOAnchorPosY(0,0.5,function()
UIManager:invokeUIMethod('UIWanBaoXunBaoDui_MenuWin','playSwitchAnimation',0)
end)
end

function UIWanBaoXunBaoDui_EquipWin:resetData()
self.selectItemsLookup={}
self.selectList={}
self.addExp=0
self.lastLeftExp=0
self.leftExp=0
self.overExp=0
self.addItemExp=0
self.addLastItemExp=0
self.addLv=0
self.randNum=0
self.curPageIndex=1
self.isSetZero=false
end

function UIWanBaoXunBaoDui_EquipWin:fillSelectItem()
if self.selectEquipGuid==nil and self.selectEquipItem~=nil then
self.selectEquipGuid=self.selectEquipItem.itemguid
end

if self.selectEquipItem==nil and self.selectEquipGuid~=nil then
self.selectEquipItem=wanBaoXunBaoDuiModel:getEquipDataByGuid(self.selectEquipGuid)
end
end

function UIWanBaoXunBaoDui_EquipWin:freshInfo()

self:setShowItems()

self:freshJlInfo()
end

function UIWanBaoXunBaoDui_EquipWin:freshJlInfo()

self:setProgressPart()

self:setDropdowns()

self:setSelectItems()
end

function UIWanBaoXunBaoDui_EquipWin:recvRefineEquip()
self.successEffect:setChildShowEffect(10060,true)

self.progressAni=true
self.progressReverseAni=false

self:resetData()
self:freshInfo()

end


function UIWanBaoXunBaoDui_EquipWin:setShowItems()
local refineEquipWidght=self.equipitem:getWidgetBase()
local state=self.selectEquipGuid~=nil
self.refineEquipName:setActive(state)
self.noEquipTip:setActive(not state)
self.redefineTip:setActive(state)
refineEquipWidght:SetChildActive(CmpEquipItemIndex.add,not state)
refineEquipWidght:SetChildActive(CmpEquipItemIndex.item,state)
if state then
local itemdata=wanBaoXunBaoDuiModel:getEquipDataByGuid(self.selectEquipGuid)
local itemID=itemdata.itemid
local equipconfig=itemsConfig.getConfig(itemID)
local jl_lv=itemdata.itemData and itemdata.itemData.jl_lv or 0
local lvInfo=jl_lv>0 and FMT.fmt("{0}级",jl_lv)or""
local conf={itemid=itemID,itemcount=lvInfo,showCountBG=jl_lv>0,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
refineEquipWidght:SetChildPropData(CmpEquipItemIndex.item,prop)
self.refineEquipName:setText(equipconfig.name)

local maxJlLv=wanBaoXunBaoDuiModel:getEquipMaxJlLevel(self.selectEquipGuid)
self.redefineTip:setText(FMT.fmt('此装备最高可精炼{0}级',maxJlLv))
end

local clickFunc=function()
UIFullWanBaoXunBaoDuiController:showWindow("UIWanBaoXunBaoDuiJLSelectEquipWin",{
selectGuid=_this.selectEquipGuid,
type=WBXBD_SelectEquip_TYPE.REFINE,
putcallback=function(guid,catguid)
_this.selectEquipGuid=guid
_this.selectEquipCatGuid=catguid
_this:resetData()
_this:freshInfo()
_this:fillSelectItem()
end,
removecallback=function(guid,catguid)
_this.selectEquipGuid=nil
_this.selectEquipCatGuid=nil
_this.selectEquipItem=nil
_this:resetData()
_this:freshInfo()
end
})

end

refineEquipWidght:SetBaseItemClickEvent(-1,clickFunc)
refineEquipWidght:SetBaseItemClickEvent(CmpEquipItemIndex.item,clickFunc)
end

function UIWanBaoXunBaoDui_EquipWin:setProgressPart()
if self.selectEquipGuid then
self:setProgress()
self:setEquipEffet()
else
self.refinelevelinfo:setText(FMT.fmt("精炼等级：{0}/{1}",0,0))
self.progressBar1:animateThreeParams(0,100,0)
self.progressBar2:animateThreeParams(0,100,0)
self.progresstxt:setActive(false)
self.addExpTip:setActive(false)
self.effectList:setActive(false)
end
end

function UIWanBaoXunBaoDui_EquipWin:setEquipEffet()
local equipData=wanBaoXunBaoDuiModel:getEquipDataByGuid(self.selectEquipGuid)
self.effectList:setActive(true)
local itemAttrVal,itemAttrValType=wanBaoXunBaoDuiModel:statisticsEquipAttr(equipData)
local propName=wanBaoXunBaoDuiModel:getPropNameList()
self.effectList:setChildLayoutGroupCreateItems(1,function(index)
local attrItem=_this.effectList:getChildLayoutGroupGridItem(index-1)
attrItem:SetChildActive(-1,true)
attrItem:SetChildText(0,propName[itemAttrValType])
attrItem:SetChildText(1,FMT.fmt(" +{0}",itemAttrVal))
local isShowInterval=_this.addLv>0
attrItem:SetChildActive(2,isShowInterval)
attrItem:SetChildActive(3,isShowInterval)
if isShowInterval then
local intervalVal=wanBaoXunBaoDuiModel:getAddAttrVal(equipData,_this.addLv)
attrItem:SetChildText(2,FMT.fmt("(+{0})",intervalVal))
end
end)
end

function UIWanBaoXunBaoDui_EquipWin:setProgress()
local equipData=wanBaoXunBaoDuiModel:getEquipDataByGuid(self.selectEquipGuid)
local jinglianlv=equipData.itemData.jl_lv or 0
local jinglianexp=equipData.itemData.jl_exp or 0
local maxlv=wanBaoXunBaoDuiModel:getEquipMaxJlLevel(equipData.itemguid)


local curIsFull=jinglianlv>=maxlv
local duration=self.progressAni and 0.5 or 0
local durationReverse=self.progressReverseAni and 0.5 or 0
local addLv=self.addLv


if self.addLv>0 then
self.refinelevelinfo:setText(FMT.fmt("精炼等级：{0} +{1}",jinglianlv,self.addLv))
else
self.refinelevelinfo:setText(FMT.fmt("精炼等级：{0}",jinglianlv))
end

self.addExpTip:setActive(self.addItemExp>0)
self.addExpTip:setText(FMT.fmt("+{0}",self.addItemExp))


self.progresstxt:setActive(true)
if curIsFull then
self.progressBar1:animateThreeParams(100,100,duration)
self.progressBar2:animateThreeParams(0,100,durationReverse)
self.progresstxt:setText('已满')
else
local curExp=jinglianexp
local curShowExp=curExp
local fillExp=self.leftExp
local maxExp=0
local targetlv=addLv+jinglianlv
local isFull=targetlv>=maxlv
local addItemExp=self.addItemExp
local tExp=0
if addLv<=0 then
maxExp=cfgHelper.get2(cfg_catequipjlxhconfig_get,jinglianlv+1,'needExp')
fillExp=curExp+fillExp
else
if not isFull then
maxExp=cfgHelper.get2(cfg_catequipjlxhconfig_get,jinglianlv+self.addLv,'needExp')
else
maxExp=cfgHelper.get2(cfg_catequipjlxhconfig_get,jinglianlv+self.addLv,'needExp')
fillExp=maxExp
end
if addLv>0 and not(addLv==1 and jinglianlv==maxlv-1)then
curShowExp=0
end
end
if addItemExp==0 then
fillExp=curShowExp
end
self.progressBar1:animateThreeParams(curShowExp,maxExp,duration,false)
self.progressBar2:animateFourParams(self.progressReverseAni and fillExp or curShowExp,maxExp,durationReverse,false)
self.progresstxt:setText(FMT.fmt('{0}/{1}',math.floor(fillExp),maxExp))
end

self.progressAni=false
self.progressReverseAni=false
end

function UIWanBaoXunBaoDui_EquipWin:setSelectItems()
for index,itemObj in ipairs(self.jlMetarial)do
local item=itemObj:getWidgetBase()
local data=self.selectList[index]

local hasItem=data~=nil

item:SetChildActive(CmpEquipItemIndex.add,not hasItem)
item:SetChildActive(CmpEquipItemIndex.item,hasItem)
if hasItem then
local itemguid=data[1]
local itemCount=data[2]
local itemData=wanBaoXunBaoDuiModel:getEquipDataByGuid(itemguid)
local itemID=itemData.itemid
local jl_lv=itemData.itemDta and itemData.itemDta.jl_lv or 0

local itemCountStr=jl_lv>0 and FMT.fmt("{0}级",jl_lv)or""



local conf={itemid=itemID,itemcount=itemCountStr,showCountBG=jl_lv>0,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(CmpEquipItemIndex.item,prop)
item:SetBaseItemClickEvent(CmpEquipItemIndex.item,function()

_this:showProvideSelectGrids(true)
end)
end

item:SetBaseItemClickEvent(-1,function()

if _this.selectEquipGuid~=nil then
if _this:checkMaxLv()then
_this:showProvideSelectGrids(true)
end
else
UIManager.error("请先选择需要精炼的装备")
end
end)
end
end

function UIWanBaoXunBaoDui_EquipWin:showProvideSelectGrids(freshData)
if self.showDialogue then return end
self.showDialogue=true
self.leftDialogue:setActive(true)
self.winlua:SetChildDOLocalMoveX(self.leftdialogueinfo:getID(),-320,0.5)
self.Dropdown1_Dialogue:setValue(self.colorIdx)
self:freshProvideSelectGrids(freshData)
end

function UIWanBaoXunBaoDui_EquipWin:closeProvideSelectGrids()
if not self.showDialogue then return end
self.showDialogue=false
self.curPageIndex=1
self.isSetZero=false
self.ScrollView:clearSlowItems()
local func=function(...)
self.leftDialogue:setActive(false)
self.Dropdown1_Dialogue:setValue(self.colorIdx)
end
self.winlua:SetChildDOLocalMoveX(self.leftdialogueinfo:getID(),-890,0.1,func)
end

function UIWanBaoXunBaoDui_EquipWin:onLeftDialogue()
self:onClickBg()
end

function UIWanBaoXunBaoDui_EquipWin:onClickBg()
self:closeProvideSelectGrids()
end

function UIWanBaoXunBaoDui_EquipWin:freshBagList(compareType,colorIdx)

local bagList=wanBaoXunBaoDuiModel:getJLItemdata(self.selectEquipGuid,compareType,colorIdx+1)or{}

local isPutItem=function(itemguid)
for i=1,_fillItemLen do
local info=_this.selectList[i]
if info and tostring(info[1])==tostring(itemguid)and info[2]and info[2]>0 then
return true
end
end
end

local list={}
local looupup={}
if#bagList>0 then
for i=#bagList,1,-1 do
local item=bagList[i]
if not looupup[tostring(item.itemguid)]and isPutItem(item.itemguid)then
list[#list+1]=item
looupup[tostring(item.itemguid)]=true
table.remove(bagList,i)
end
end

for i,v in ipairs(list)do
table.insert(bagList,1,v)
end
end




local widghtDataList={}
for index,bagData in ipairs(bagList)do
local itemCfg=itemsConfig.getConfig(bagData.itemid)
local exp=0
local jl_lv=0
if itemsConfig.isMaoMao(bagData.itemid)then


jl_lv=bagData.itemData.jl_lv or 0
local jl_exp=bagData.itemData.jl_exp or 0
if jl_lv>0 then
exp=cfgHelper.get2(cfg_catequipjlxhconfig_get,jl_lv,'totalExp')
end
if jl_exp>0 then
exp=exp+jl_exp
end
exp=exp+itemCfg.jlExp
elseif itemsConfig.isMaterials(bagData.itemid)then

exp=itemCfg.jlExp
end

table.insert(widghtDataList,{data=bagData,jlExp=exp,jl_lv=jl_lv})
end

table.sort(widghtDataList,function(a,b)

local aCfg=itemsConfig.getConfig(a.data.itemid)
local bCfg=itemsConfig.getConfig(b.data.itemid)

local aSel=_this.selectItemsLookup[tostring(a.data.itemguid)]and 1 or 0
local bSel=_this.selectItemsLookup[tostring(b.data.itemguid)]and 1 or 0

if aSel==bSel then


if aCfg.color==bCfg.color then





if a.data.itemid==b.data.itemid then
if a.jl_lv==b.jl_lv then
return tonumber(tostring(a.data.itemguid))>tonumber(tostring(b.data.itemguid))
else
return a.jl_lv>b.jl_lv
end
else
return a.data.itemid>b.data.itemid
end
else
return aCfg.color>bCfg.color
end





else
return aSel>bSel
end

end)

return widghtDataList

end

function UIWanBaoXunBaoDui_EquipWin:freshProvideSelectGrids(freshData)
if not self.showDialogue then return end
if freshData then
self.bagList=self:freshBagList(ITEM_FILTER_COMPARE.eLessEqulas,7)
end
local list=self.bagList
local rNum=#list
local isShowMaterial=rNum>0
self.materialRoot:setActive(isShowMaterial)
self.goGetMaterial:setActive(not isShowMaterial)

if isShowMaterial then
local showRow=math.ceil(rNum/_colomn)
self.ScrollView:clearSlowItems()
self.ScrollView:freshSlowGrids(rNum,showRow,_colomn,not self.isSetZero)
self.isSetZero=true
end
end

function UIWanBaoXunBaoDui_EquipWin:bindGrid(index,widget)
local itemInfo=self.bagList[index].data

if itemInfo~=nil then
local count=itemInfo.itemcount
local itemcount=itemInfo.itemcount or 0
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid or-1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=itemsModel.getIconName(itemInfo)
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=''

local num=self:getSelectNum(itemguid)
local jinglianlv=itemInfo.itemData and itemInfo.itemData.jl_lv or 0
local jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
local countStr=jinglianlv>0 and jinglianStr or num>0 and FMT.fmt('{0}/{1}',itemcount,num)or itemcount>1 and itemcount or''
local has=num>0
local showbg=true
local isLock=bagHelper.isLock(itemInfo)
local isFabao=itemsConfig.isFabao(itemid)
local showStage=false
local isSelect=tostring(self.selectItemguid)==tostring(itemguid)
local isLock=bagHelper.isLock(itemInfo)
widget:SetChildActive(0,true)
widget:SetChildActive(1,isSelect)
widget:SetChildQulaity(2,color)
widget:SetChildIcon(3,iconName,false)
widget:SetChildText(4,countStr)
widget:SetChildActive(5,countStr~='')
widget:SetChildText(6,stageStr)
widget:SetChildText(7,'')
widget:SetChildActive(8,showStage)
widget:SetChildActive(9,isLock)
widget:SetChildActive(10,has)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid)
widget:SetChildLongPress(10,index,function(idx)self:longPressAction(idx)end,function(idx)self:finishlongPressAction(idx)end)
widget:SetChildLongPress(11,index,function(idx)self:longPressAction(idx,true)end,function(idx)self:finishlongPressAction(idx,true)end)
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
widget:SetChildLongPress(11,index,nil,nil)
widget:SetChildLongPress(10,index,nil,nil)
end
end

function UIWanBaoXunBaoDui_EquipWin:freshProvideSelectSingleGirid(itemguid,flag)
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(10,flag)
if not flag then
widget:SetChildLongPressStop(10)
self.useGoodTime=nil
end
end
end

end

function UIWanBaoXunBaoDui_EquipWin:freshProvideSingleGiridText(itemguid)
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
local num=self:getSelectNum(itemguid)
local info=self.bagList[idx].data
local itemcount=info.itemcount or 0
local jinglianlv=info.itemData and info.itemData.jinglianlv or 0
local jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
local countStr=jinglianlv>0 and jinglianStr or num>0 and FMT.fmt('{0}/{1}',itemcount,num)or itemcount>1 and itemcount or''
widget:SetChildText(4,countStr)
widget:SetChildActive(5,countStr~='')
end
end

end

function UIWanBaoXunBaoDui_EquipWin:freshProvideGridLock(itemguid,isUnlock)
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(9,isUnlock)
end
end
end

function UIWanBaoXunBaoDui_EquipWin:getBagItemIdx(itemguid)
local list=self.bagList or{}
for i,v in ipairs(list)do
if tostring(v.data.itemguid)==tostring(itemguid)then
return i,v
end
end
end

function UIWanBaoXunBaoDui_EquipWin:setDropdowns()
self.Dropdown1_Dialogue:setOption(_bag_filter_color_desc_1)
self.Dropdown2_Dialogue:setOption(_bag_filter_color_desc_1)

self.Dropdown1_Dialogue:setValue(self.colorIdx)
self.Dropdown2_Dialogue:setValue(self.colorIdx)


self:freshProvideSelectGrids(true)
end



function UIWanBaoXunBaoDui_EquipWin:onDropdownChange(idx)
self.colorIdx=idx

self.Dropdown1_Dialogue:setValue(self.colorIdx)
self.Dropdown2_Dialogue:setValue(self.colorIdx)
end

function UIWanBaoXunBaoDui_EquipWin:onEdgeEvent()

if self.curPageIndex>=self.tPage then return end
self.curPageIndex=self.curPageIndex+1
self:freshProvideSelectGrids()
end





function UIWanBaoXunBaoDui_EquipWin:onRefineBtn()
if self:getSelectListNum()>0 then
local temp={}
for k,v in pairs(self.selectList)do
table.insert(temp,{v[1],v[2]})
end
local equipguid=self.selectEquipGuid
local catguid=0
local isCatEquip,guid=wanBaoXunBaoDuiModel:checkHasCatEquip(equipguid)
if isCatEquip then
catguid=tonumber(guid)
end

wanBaoXunBaoDuiController:reqRefineEquipment(catguid,equipguid,#temp,temp)
else
if self.selectEquipGuid~=nil then
if self:checkMaxLv()then
self:showProvideSelectGrids(true)
end
else
UIManager.info('请先放入精炼装备')
end
end
end


function UIWanBaoXunBaoDui_EquipWin:onBtnQuickPut()
local equipGuid=self.selectEquipGuid
local filterColorIdx=self.colorIdx+1

if not self:checkMaxLv()then
return
end

local bagQuickSelctList=self:freshBagList(ITEM_FILTER_COMPARE.eLessEqulas,filterColorIdx)

local residueNum=WBXBD_JINGLIAN_SELECT_MATERIAL_NUM-self:getSelectListNum()
local list,errType,errArgs=self:getSelfAdaptionExpMaterials(bagQuickSelctList,equipGuid,filterColorIdx,residueNum,self.addExp)

if list and#list>0 then
self.onJinglianFinish=false
for _,v in ipairs(list)do
local itemguid=v[1]
local num=v[2]
local idx=self:getNextFillIdx(itemguid)
self:setSelectNum(itemguid,idx,num)
self:freshProvideSelectSingleGirid(itemguid,true)
end
self:setSelectItems()
self:setProgressPart()
self:closeProvideSelectGrids()
else
if errType then
if errType==WBXBD_JINGLIAN_QuiCkPUT_ERR_TYPE.noMaterial then
UIManager.error('没有可以精炼的装备')
elseif errType==WBXBD_JINGLIAN_QuiCkPUT_ERR_TYPE.noFillSlot then
UIManager.error('当前无空位可放入')
end
end
end
end

function UIWanBaoXunBaoDui_EquipWin:onBtnReset()
self:resetData()
self:setSelectItems()
self:setProgressPart()
self:freshProvideSelectGrids(true)
end

function UIWanBaoXunBaoDui_EquipWin:onQuickFillBtn()
if self.selectEquipGuid==nil then
UIManager.info("请先放入精炼装备")
return
end


local equipGuid=self.selectEquipGuid
local filterColorIdx=self.colorIdx+1
local bagQuickSelctList=self:freshBagList(ITEM_FILTER_COMPARE.eLessEqulas,filterColorIdx)

if not self:checkMaxLv()then
return
end

local residueNum=WBXBD_JINGLIAN_SELECT_MATERIAL_NUM-self:getSelectListNum()
local list,errType,errArgs=self:getSelfAdaptionExpMaterials(bagQuickSelctList,equipGuid,filterColorIdx,residueNum,self.addExp)

if list and#list>0 then
self.onJinglianFinish=false
for _,v in ipairs(list)do
local itemguid=v[1]
local num=v[2]
local idx=self:getNextFillIdx(itemguid)
self:setSelectNum(itemguid,idx,num)
self:freshProvideSelectSingleGirid(itemguid,true)
end
self:setSelectItems()
self:setProgressPart()
self:closeProvideSelectGrids()
else
if errType then
if errType==WBXBD_JINGLIAN_QuiCkPUT_ERR_TYPE.noMaterial then
UIManager.error('没有可以精炼的材料')
self:showProvideSelectGrids(true)
elseif errType==WBXBD_JINGLIAN_QuiCkPUT_ERR_TYPE.noFillSlot then
UIManager.error('当前无空位可放入')
end
end
end
end


function UIWanBaoXunBaoDui_EquipWin:onGoGetMaterialBtn()
self:closeProvideSelectGrids()
UIFullWanBaoXunBaoDuiController:showWanBaoXunBaoDuiMTWindow()
end




function UIWanBaoXunBaoDui_EquipWin:longPressAction(idx,isAdd)
if isAdd and not self.islong then
return
end
local info=self.bagList[idx].data
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
if not self:putItem(info.itemguid,num)then
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


function UIWanBaoXunBaoDui_EquipWin:finishlongPressAction(idx,isAdd)
if isAdd then
self.islong=false
end
self.useGoodTime=nil
end

function UIWanBaoXunBaoDui_EquipWin:StopItemLongPress(idx,index)
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildLongPressStop(index)
end
end

function UIWanBaoXunBaoDui_EquipWin:onClickGrid(itemid,index,itemguid,attach)
if itemid==-1 then return end
self:putItem(itemguid)
end

function UIWanBaoXunBaoDui_EquipWin:onClickLongGridButton(itemid,index,itemguid,attach)
if itemid~=-1 then

self.islong=true
end
end



function UIWanBaoXunBaoDui_EquipWin:putItem(itemguid,addnum)
local num=self:getSelectNum(itemguid)
local item=equipsHelper.getEquip(itemguid)
local itemcount=item.itemcount
if not self:checkMaxLv()then
return
end
if num>=itemcount then
UIManager.error('物品已达上限')
return
end
local fillIdx=self:getNextFillIdx(itemguid)
if fillIdx==nil then
UIManager.error('当前无空位可放入')
return
end
if bagHelper.isLock(item)then
self.dialog=UIDialogManager.getConfirmDialog(self.dialog,'装备锁定','该装备已锁定，是否解锁并进行精炼消耗？')
self.dialog.okcallback=function()
bagProtocolControl.req_change_bag_item_lockflag(itemguid,true)
if self and not self.isClose then
self:onUnlockItem(itemguid)
end
end
self.dialog:show()
return
end
if not self:tryPutItem(itemguid,true)then
return
end
self.onJinglianFinish=false
local lastNum=num
if lastNum==0 then
self:freshProvideSelectSingleGirid(itemguid,true)
end
addnum=addnum or 1
num=num+addnum
self:setSelectNum(itemguid,fillIdx,num)
self:freshProvideSingleGiridText(itemguid)
self:setSelectItems()
self:setProgressPart()
return true
end

function UIWanBaoXunBaoDui_EquipWin:onClickGridButton(itemid,index,itemguid,attach,delnum)
if itemid==-1 then return end
local num=self:getSelectNum(itemguid)
if num<=0 then
UIManager.error('物品已达下限')
return
end
self.onJinglianFinish=false
delnum=delnum or 1
num=num-delnum
local selectIdx=self:getSelectIndex(itemguid)
self:setSelectNum(itemguid,selectIdx,num)
if num<=0 then
self:freshProvideSelectSingleGirid(itemguid,false)
end
self:freshProvideSingleGiridText(itemguid)
self:setSelectItems()
self:setProgressPart()
return true
end

function UIWanBaoXunBaoDui_EquipWin:getSelectNum(itemguid)
if self.selectList==nil then self.selectList={}end
if self.selectItemsLookup==nil then self.selectItemsLookup={}end
local selectItemsLookup=self.selectItemsLookup
local selectList=self.selectList
local index=selectItemsLookup[tostring(itemguid)]
if index then
local selectTable=selectList[index]or{}
return selectTable[2]or 0
end
return 0
end

function UIWanBaoXunBaoDui_EquipWin:checkMaxLv()
local upItem=wanBaoXunBaoDuiModel:getEquipDataByGuid(self.selectEquipGuid)
local jinglianlv=upItem.itemData and upItem.itemData.jl_lv or 0
local maxlv=wanBaoXunBaoDuiModel:getEquipMaxJlLevel(self.selectEquipGuid)
if self.addLv+jinglianlv>=maxlv then
UIManager.error('装备精炼等级达到上限')
return false
end
return true
end

function UIWanBaoXunBaoDui_EquipWin:getNextFillIdx(itemguid)
if self.selectList==nil then self.selectList={}end
if self.selectItemsLookup==nil then self.selectItemsLookup={}end
local selectItemsLookup=self.selectItemsLookup
local selectList=self.selectList
local index=selectItemsLookup[tostring(itemguid)]
if index then return index end
for i=1,_fillItemLen do
local info=selectList[i]
if not info then
return i
end
end
end

function UIWanBaoXunBaoDui_EquipWin:tryPutItem(itemguid,canOverExp)
local addExp=wanBaoXunBaoDuiModel.getJinglianValue(itemguid,1)
local addTExp=self.addItemExp or 0
local selectEquipItemData=wanBaoXunBaoDuiModel:getEquipDataByGuid(self.selectEquipGuid)
local needMaxExp=wanBaoXunBaoDuiModel.getJinglianValueToMaxLevelOnItem(selectEquipItemData)
local lastIsFull=addTExp>=needMaxExp

if lastIsFull then
UIManager.error('已达到最大经验，无法添加')
return false
end
addTExp=addTExp+addExp
local leftExp=addTExp-needMaxExp
if leftExp>0 then
if not canOverExp then
UIManager.error('已达到最大经验，无法添加')
return false
end
end
return true
end

function UIWanBaoXunBaoDui_EquipWin:setSelectNum(itemguid,index,num)
if self.selectItemsLookup==nil then self.selectItemsLookup={}end
if self.selectList==nil then self.selectList={}end
if num==0 then
self.selectList[index]=nil
self.selectItemsLookup[tostring(itemguid)]=nil
else
self.selectList[index]={itemguid,num}
self.selectItemsLookup[tostring(itemguid)]=index
end
self:freshAddExp()
self.progressReverseAni=true
self.progressAni=false
end

function UIWanBaoXunBaoDui_EquipWin:freshAddExp()
local selectItems=self.selectList or{}
local addItemExp,addExp,addLv,leftExp,overExp,randNum=self:getJinglianData(selectItems)

self.lastLeftExp=self.leftExp
self.addItemExp=addItemExp
self.addExp=addExp
self.addLv=addLv
self.leftExp=leftExp
self.randNum=randNum
self.overExp=overExp
end

function UIWanBaoXunBaoDui_EquipWin:getJinglianData(selectItems)
local addItemExp=0
if selectItems then
for k,v in pairs(selectItems)do
local itemguid=v[1]
local num=v[2]
local item=wanBaoXunBaoDuiModel:getEquipDataByGuid(itemguid)
if item then
addItemExp=addItemExp+wanBaoXunBaoDuiModel.getJinglianValue(itemguid,num)
end
end
end
local item=wanBaoXunBaoDuiModel:getEquipDataByGuid(self.selectEquipGuid)
local itemid=item.itemid
local jinglianlv=item.itemData and item.itemData.jl_lv or 0
local jinglianexp=item.itemData and item.itemData.jl_exp or 0
local addLv,leftExp,overExp=wanBaoXunBaoDuiModel.getAddJinglianLv(itemid,jinglianlv,jinglianexp,addItemExp)
local addExp=addItemExp-leftExp

local randNum=0

return addItemExp,addExp,addLv,leftExp,overExp,randNum
end

function UIWanBaoXunBaoDui_EquipWin:getSelectIndex(itemguid)
if self.selectItemsLookup==nil then self.selectItemsLookup={}end
if self.selectList==nil then self.selectList={}end
return self.selectItemsLookup[tostring(itemguid)]
end

function UIWanBaoXunBaoDui_EquipWin:getSelfAdaptionExpMaterials(baglist,equipGuid,filterColorIdx,residueNum,curAddExp)
if residueNum<=0 then
return{},WBXBD_JINGLIAN_QuiCkPUT_ERR_TYPE.noFillSlot
end

local equipData=wanBaoXunBaoDuiModel:getEquipDataByGuid(equipGuid)

local bagDataList=table.reverse(baglist)

if#bagDataList==0 then
return{},WBXBD_JINGLIAN_QuiCkPUT_ERR_TYPE.noMaterial
end


local toMaxLvNeedExp=wanBaoXunBaoDuiModel.getJinglianValueToMaxLevelOnItem(equipData)
toMaxLvNeedExp=toMaxLvNeedExp-curAddExp

local selectList={}

for index,equipWidgetData in ipairs(bagDataList)do
if toMaxLvNeedExp>0 then
if residueNum<=0 then
break
end

if toMaxLvNeedExp>0 then
if itemsConfig.isMaoMao(equipWidgetData.data.itemid)then
if self.selectItemsLookup[tostring(equipWidgetData.data.itemguid)]==nil then
residueNum=residueNum-1
toMaxLvNeedExp=toMaxLvNeedExp-equipWidgetData.jlExp
table.insert(selectList,{equipWidgetData.data.itemguid,1})
end
end

if itemsConfig.isMaterials(equipWidgetData.data.itemid)then
if self.selectItemsLookup[tostring(equipWidgetData.data.itemguid)]==nil then
local needNum=Mathf.Floor(toMaxLvNeedExp/equipWidgetData.jlExp)

local okNum=Mathf.Min(needNum,equipWidgetData.data.itemcount)

residueNum=residueNum-1
table.insert(selectList,{equipWidgetData.data.itemguid,okNum})
toMaxLvNeedExp=toMaxLvNeedExp-equipWidgetData.jlExp
end
end
end
end
end





return selectList
end

function UIWanBaoXunBaoDui_EquipWin:getSelectListNum()
local num=0
if self.selectList then
for k,v in pairs(self.selectList)do
num=num+1
end
end
return num
end
