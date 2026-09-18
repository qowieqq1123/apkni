







def_class("UIAutoBuildingLvlupWin",UIWindowBase)









function UIAutoBuildingLvlupWin:bindComponents()

self.btnOnekey=UIButton.get(self,0)
self.btnReset=UIButton.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.Content=UIObject.get(self,3)
self.costItems=UIObject.get(self,4)
self.root=UIObject.get(self,5)
self.Dropdown1=UIDropdownEx.get(self,6)
self.item1=UIBaseItem.get(self,7)
self.item2=UIBaseItem.get(self,8)
self.item3=UIBaseItem.get(self,9)
self.item4=UIBaseItem.get(self,10)
self.item5=UIBaseItem.get(self,11)
self.costpanel=UIObject.get(self,12)
self.leftpanel=UIObject.get(self,13)
self.ScrollView=UIScrollViewSlow.get(self,14)
self.selectBg=UIButton.get(self,15)
self.selectPanel=UIObject.get(self,16)
self.selpanelttxt=UIText.get(self,17)
self.userbtn=UIButton.get(self,18)
self.icon=UIObject.get(self,19)
self.taskScroller=UIObject.get(self,20)
self.proName=UIText.get(self,21)
self.proExpProgressbar=UIProgressBarAni.get(self,22)
self.proAddExp=UIProgressBarAni.get(self,23)
self.progressText=UIText.get(self,24)
self.uptips=UIText.get(self,25)

self.btnOnekey:setButtonClick(function()self:onBtnOnekey()end)

self.btnReset:setButtonClick(function()self:onBtnReset()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.selectBg:setButtonClick(function()self:onSelectBg()end)

self.userbtn:setButtonClick(function()self:onUserbtn()end)



end


function UIAutoBuildingLvlupWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnOnekey);self.btnOnekey=nil;
_UIObject_release(self.btnReset);self.btnReset=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.costItems);self.costItems=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.Dropdown1);self.Dropdown1=nil;
_UIObject_release(self.item1);self.item1=nil;
_UIObject_release(self.item2);self.item2=nil;
_UIObject_release(self.item3);self.item3=nil;
_UIObject_release(self.item4);self.item4=nil;
_UIObject_release(self.item5);self.item5=nil;
_UIObject_release(self.costpanel);self.costpanel=nil;
_UIObject_release(self.leftpanel);self.leftpanel=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.selectBg);self.selectBg=nil;
_UIObject_release(self.selectPanel);self.selectPanel=nil;
_UIObject_release(self.selpanelttxt);self.selpanelttxt=nil;
_UIObject_release(self.userbtn);self.userbtn=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.taskScroller);self.taskScroller=nil;
_UIObject_release(self.proName);self.proName=nil;
_UIObject_release(self.proExpProgressbar);self.proExpProgressbar=nil;
_UIObject_release(self.proAddExp);self.proAddExp=nil;
_UIObject_release(self.progressText);self.progressText=nil;
_UIObject_release(self.uptips);self.uptips=nil;
end
















local leftitem=
{
selectspine=1,
iconspine=2,
namebg=3,
name=4,
btn=5,
element=6,
bxReddot=7,
dotween=8,
}
local builditemid=
{
[81]=1,
[84]=2,
[85]=3,
[86]=4,
[82]=5,
[83]=6,
}
local alldjjz={81,82,83,84,85,86}
local buildstate=
{
weidoing=0,
doing=1,
finish=2
}
local feishengtaiid=81
local buildelement=
{
[84]=2,
[85]=4,
[86]=5,
[82]=1,
[83]=3,
}
local buildleftname=
{
[84]="太清葫芦",
[85]="真阳宝幡",
[86]="坤仪玄盾",
[82]="辟天神剑",
[83]="山海悬镜",
}
local _abname="ui/windows/feishengtai/flyupxiufu_atlas_pak.ab"
local _costid=10
local _colomn=4
local _row=6
local _bag_filter_desc={}
local _dropItemHeight=40
local _dropViewHeight=150

local _equipIdxArray={1,6,2,3,4,5,7}
local _materialIdxArray={1,2,3,4,5}
local _equipIdxOneKeyArray={1,6,2,3,4,5}
local _materialIdxOneKeyArray={1,2,3,4,5}
local sortTypeName={'所有','道具','图纸','材料',}
local _this
local itemindex=
{
selfitem=0,
icon=1,
name=2,
lvl=3,
locking=4,
unlocking=5
}
local autoTypeName=
{
[1]="所有",
[2]="道具",
[3]="图纸",
[4]="材料",
}

local autoBagType=
{
[0]=BAG_TYPE.eItemBag,
[1]=BAG_TYPE.eItemBag,
[2]=BAG_TYPE.eItemBag,
[3]=BAG_TYPE.eItemBag,
[4]=BAG_TYPE.eMaterialsBag,
}



function UIAutoBuildingLvlupWin:onLoaded(...)
self:bindComponents()
_this=self


self.leftitems={self.leftitem,self.leftitem1,self.leftitem2,self.leftitem3,self.leftitem4,self.leftitem5}
self.allZhenWudata={}
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)

self.ScrollView:setSlowClickAction(nil)
self.Dropdown1:setChangeAction(function(...)self:onDropdownChange(1,...)end)

self.Dropdown1:setDropdownLayoutedAction(function(...)self:onDropdownCreate(1,...)end)

local itemsList={}
itemsList={self.item1,self.item2,self.item3,self.item4,self.item5}
self.itemsList=itemsList
for _,v in ipairs(itemsList)do
v:setBaseItemClickEvent(function(...)
if not self.isClose then
self:onSelectItemClick(...)
end
end)
end

local list=table.toTable(1,3)
self.nomalStageVal=list
self.nomalStageDesc=itemsFilterHelper.getFilterNames(list,function(stage)
return FMT.fmt('{0}',autoTypeName[stage])
end)
self.jingcaiStageDesc={'道具'}
_bag_filter_desc[ITEM_FILTER_TYPE.eStage]=self.nomalStageDesc
self.filter={}
self.filter[ITEM_FILTER_TYPE.eElement]=0
self.filter[ITEM_FILTER_TYPE.eStage]=0
self.filter[ITEM_FILTER_TYPE.eColor]=0
self.noweStage=1
self.nowelement=1

self.chooseidx=1
self.Dropdown1:setOption(sortTypeName)
self.Dropdown1:setValue(self.chooseidx-1)

self.selectBagType=BAG_TYPE.eMaterialsBag
self.selectList={}
self.selectNumList={}
self.showAttrPanel=false

self.selectBg:setActive(false)
self.unlockItem={}
self.ScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)
self.curPageIndex=1
self.selectItemguid=nil
self.isSetZero=false
self.selectItemguidIdx=nil
self.isSelectGrid=nil
self.funcFilter=0

self.closeidx=false
self.closeitemguid=false
end


function UIAutoBuildingLvlupWin:__delete()
UIManager:hideWindow('UITopMoneyWin')
self:unbindComponents()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
_this=nil



end

function UIAutoBuildingLvlupWin.on_building_event(etype,sfId,bdId,arg1,arg2)

end


function UIAutoBuildingLvlupWin:onTipsbtn()
tipsManager.closeTips()
local d={}
d.title='规则说明'
d.mode=3
d.name='dujiezhibao_repair_rule_%d'
d.closeCB=function()
end
UIManager:showWindow('UIRuleWin',d)
end

function UIAutoBuildingLvlupWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil})
end





function UIAutoBuildingLvlupWin:onShow(argtable,afterOnloaded)
self.bdData=argtable.bdData
self.sfId=argtable.sfId

self.build_id=self.bdData.build_id
self.un_build_id=self.bdData.un_build_id

self:refreshModel()
self:freshRightListPanel()
self:freshLevelUpPanel()
end


function UIAutoBuildingLvlupWin:onHide()
end

function UIAutoBuildingLvlupWin:onClickClose()
self:closeSelf()
end

function UIAutoBuildingLvlupWin:refreshModel()
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,self.build_id)
local scale=isometricMapSystem:getModelScale(cfg.model[1],true)
local scales2Pram=isometricMapSystem:getModelScales2Pram(cfg.model[1],2)
scale=scale*scales2Pram[1]
local offset={scales2Pram[2],scales2Pram[3]}
self.icon:setChildUIModelShowTarget(cfg.model[1],scale,nil,eAnimationID.stand)
self.icon:setChildUIModelShowTargetOffset(offset[1],offset[2])
end

function UIAutoBuildingLvlupWin:freshRightListPanel()
local buildlvl=AutoBuildModel:getAutoBuildingLvl(self.un_build_id)
self.proName:setText(FMT.fmt("{0}级",buildlvl))
local _cfg=cfg_autocreatebuildconfig()
local list={}
for id,data in ipairs(_cfg)do
table.insert(list,data.updesc)
end

local dataNum=#list
self.taskScroller:setActive(dataNum>0)
if dataNum>0 then
self.taskScroller:setChildScrollViewCreateGrids(dataNum,1)
local grids=self.taskScroller:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
item:SetChildText(itemindex.lvl,FMT.fmt("{0}级",i))

local desc=list[i]
item:SetChildText(itemindex.name,desc)

local flag=buildlvl>=i
item:SetChildActive(itemindex.locking,not flag)
item:SetChildActive(itemindex.unlocking,flag)
end
end
end
end

function UIAutoBuildingLvlupWin:freshLevelUpPanel()

local buildlvl=AutoBuildModel:getAutoBuildingLvl(self.un_build_id)
local cfg=cfg_autocreatebuildconfig_get(buildlvl)
local now_exp=AutoBuildModel:getAutoBuildingExp(self.un_build_id)
local max_exp=cfg.exp

if not max_exp then

self.uptips:setActive(true)
self.uptips:setText("已经满级")
self.costItems:setActive(false)
self.userbtn:setActive(false)


self.proExpProgressbar:animateThreeParams(1,1,0)

self.progressText:setText("已满级")
else

local unlock,needlvl=self:isUnLockUp(buildlvl)

if not unlock then
self.uptips:setActive(true)
self.uptips:setText(FMT.fmt("宗门等级达到{0}级可升级",needlvl))
self.costItems:setActive(false)
self.userbtn:setActive(false)

self:refreshnowjindu(now_exp,max_exp,true,true)
else
self.uptips:setActive(false)
self.costItems:setActive(true)
self.userbtn:setActive(true)

self:refreshnowjindu(now_exp,max_exp,true,true)
self:setSelectItems()
end
end
end

function UIAutoBuildingLvlupWin:isUnLockUp(buildlvl)

local nextlvl=buildlvl+1
local cfg=cfg_autocreatebuildconfig_get(nextlvl)
if cfg and cfg.need_level then
local zmLevel=zongmenModel:getLevel()
return zmLevel>=cfg.need_level,cfg.need_level
end
return true,0
end


function UIAutoBuildingLvlupWin:changedjzbRewardReddot()
for k,v in pairs(self.allZhenWudata)do
local _jzid=v.jzid
if _jzid==feishengtaiid then
self:refreshDailyReward()
else
self:djzbRewardReddot(_jzid)
end
end
end

function UIAutoBuildingLvlupWin.on_item_changed(changeType,itemguid,itemid,lastcount,itemcount)
if _this==nil then
return
end
_this:changedjzbRewardReddot()
if _this._buildid then
if _this._buildid==feishengtaiid then
else
_this:refreshRight()
end
end
end



function UIAutoBuildingLvlupWin:refreshnowjindu(ltexp,nxltexp,init,reverse)
local curexp=ltexp
local maxexp=nxltexp
local allAddValue=self:getjd()


if false then
self.proAddExp:animateThreeParams(curexp+allAddValue,maxexp,0)
self.proExpProgressbar:animateThreeParams(curexp,maxexp,0)
else
if reverse then
self.proAddExp:animateFourParams(curexp+allAddValue,maxexp,0.5,reverse)
else
self:useHideAddProgress(curexp,maxexp,allAddValue)
end
self.proExpProgressbar:animateFourParams(curexp,maxexp,0.5,reverse)
end

local progressStr=''
if curexp>=maxexp then
progressStr=FMT.fmt('{0}/{1}',maxexp,maxexp)
else
if allAddValue>0 then
progressStr=FMT.fmt('{0}<color=#549327>（+{1}）</color>/{2}',curexp,allAddValue,maxexp)
else
progressStr=FMT.fmt('{0}/{1}',curexp,maxexp)
end
end
self.progressText:setText(progressStr)
end


function UIAutoBuildingLvlupWin:onCloseBtn()
self:closeProvideSelectGrids()
tipsManager.closeTips()
end

function UIAutoBuildingLvlupWin:onSelectBg()
if UIManager:isActive("UITipsWin")then
tipsManager.closeTips()
if self.bagList then
if self.closeitemguid and self.closeidx then
self:onSelectOneGrid(self.closeitemguid,false,self.closeidx)
end
end
else
self:closeProvideSelectGrids()
tipsManager.closeTips()
end
end

function UIAutoBuildingLvlupWin:onSelectItemClick(itemid,index,itemguid,attach)

local lastIndex=self.lastSelectIndex
if lastIndex and lastIndex==index and UIManager:isActive('UITipsWin',true)then
return
end
self.lastSelectIndex=index
local hasItem=itemid~=nil and itemid>0

local isEquip=hasItem and itemsConfig.isEquip(itemid)or false
local selectBagType=isEquip and BAG_TYPE.eEquipBag or BAG_TYPE.eMaterialsBag
local changeSelectBag=selectBagType~=self.selectBagType
self.selectBagType=selectBagType
if changeSelectBag or not self.showDialogue then
self.ScrollView:clearSlowItems()
self:showProvideSelectGrids()
end

if hasItem then
local isMakeByEquip=false
local isMain=false
tipsManager.showTips({formType=TIPS_FORM_TYPE.eOffAutoBuildMaterial,
itemid=itemid,
itemguid=itemguid,
backType=TIPS_BACK_TYPE.eNone,
attach={index=index,isMain=isMain,isMakeByEquip=isMakeByEquip},
move=TIPS_MOVE_POS.eLeft})

self:onSelectOneGrid(itemguid,false,index)
end
end

function UIAutoBuildingLvlupWin:onSelectOneGrid(itemguid,isBagGrid,index)
local lastSelectGrid=self.isSelectGrid
self.isSelectGrid=isBagGrid
local lastItemguid=self.selectItemguid
self.selectItemguid=itemguid
local lastSelectIndex=self.selectItemguidIdx
self.selectItemguidIdx=index

if itemguid==nil or isBagGrid==nil or index==nil then
loggerUtil.logErrFMT('传入参数有问题：itemguid：{0} isBagGrid：{1} index：{2}',itemguid,isBagGrid,index)
return
end
if lastSelectGrid==isBagGrid and tostring(lastItemguid)==tostring(itemguid)and lastSelectIndex==index then
return
end

if lastItemguid then
if lastSelectGrid then
self:freshProvideGridSelect(lastItemguid)
elseif lastSelectGrid==false then
if lastSelectIndex then
local _lastItemguid=self.selectList[lastSelectIndex]
if lastItemguid and tostring(_lastItemguid)==tostring(lastItemguid)then
self:freshOneSelectItemSelectBg(lastSelectIndex)
else
self:closeAllSelectItemSelectBg()
end
else
self:closeAllSelectItemSelectBg()
end
end
end
if isBagGrid then
self:freshProvideGridSelect(itemguid)
elseif isBagGrid==false then
if index then
self:freshOneSelectItemSelectBg(index)
else
loggerUtil.logErrFMT('传入选中序号为空')
end
end
end

function UIAutoBuildingLvlupWin:freshProvideGridSelect(itemguid)
local idx=self:getBagItemIdx(itemguid)

if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(1,tostring(self.selectItemguid)==tostring(itemguid)and self.isSelectGrid==true)
else
loggerUtil.logErrFMT('没找到序号的widget：{0}',tostring(itemguid))
end
end
end

function UIAutoBuildingLvlupWin:onClickGridButton(index,itemid,itemguid,selectIndex,isdeletall)
if itemid==-1 then return end
local num=self:getSelectItemNum(itemguid)
if num<=0 then
UIManager.error('物品已达下限')
return
end
tipsManager.closeTips()
local selectIdx=selectIndex or self:getSelectIndex(itemguid)
local isMainItem=self:isMainHole(selectIdx)
local deleteNum=1
if isdeletall then
if self.selectNumList and self.selectNumList[selectIdx]then
deleteNum=self.selectNumList[selectIdx]
end
end
local isFzHole=self:isFzHole(selectIdx)
if isMainItem then
deleteNum=num
elseif isFzHole then
deleteNum=self:getPutNum(selectIdx)
end

self:deleteSelectNum(selectIdx,deleteNum)
num=num-deleteNum
if self:isMainHole(selectIdx)then
if num<=0 or self:getPutNum(selectIdx)<=0 then
self.selectList={}
self.selectNumList={}
self.curPageIndex=1
self.isSetZero=false
self:freshProvideSelectGrids(true)
else
self:freshProvideSelectSingleItemNum(itemguid)
end
else
local onlyHasMainItem=false
local flag=false
if onlyHasMainItem then
flag=self.ScrollView:freshAllItems()
end
if not flag then
if num<=0 then
self:freshProvideSelectSingleGirid(itemguid,false)
self:onSelectOneGrid(self.closeitemguid,false,self.closeidx)
end
self:freshProvideSelectSingleItemNum(itemguid)
end
end
self:setSelectItems()
end

function UIAutoBuildingLvlupWin:closeAllSelectItemSelectBg()
for i,v in ipairs(self.itemsList)do
local widget=v:getWidgetBase()
widget:SetChildActive(1,false)
end
end

function UIAutoBuildingLvlupWin:freshOneSelectItemSelectBg(idx)
local slot=self.itemsList[idx]
local itemguid=self.selectList[idx]
local widget=slot:getWidgetBase()
widget:SetChildActive(1,self.isSelectGrid==false and
tostring(self.selectItemguid)==tostring(itemguid)and
self.selectItemguidIdx==idx)
end

function UIAutoBuildingLvlupWin:showProvideSelectGrids()
if self.showDialogue then
self:freshProvideSelectGrids(true)
return
end
self.showDialogue=true
self.selectBg:setActive(true)
self:freshProvideSelectGrids(true)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.selectPanel:getID(),'1',0,3)
self.winlua:SetChildLocalPosY(self.Content:getID(),0)



end

function UIAutoBuildingLvlupWin:closeProvideSelectGrids()
if not self.showDialogue then return end
self.showDialogue=false
if self.isSelectGrid==true then
self.selectItemguid=nil
self.selectItemguidIdx=nil
end
self.curPageIndex=1
self.isSetZero=false
self.selectBg:setActive(false)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.selectPanel:getID(),'2',0,3)
self.winlua:SetChildLocalPosY(self.Content:getID(),0)
end

function UIAutoBuildingLvlupWin:onDropdownChange(dropIdx,reIdx)
local isMaterials=self.selectBagType==BAG_TYPE.eMaterialsBag
local typo=isMaterials and(dropIdx==1 and ITEM_FILTER_TYPE.eStage or ITEM_FILTER_TYPE.eElement)or
dropIdx==1 and ITEM_FILTER_TYPE.eStage or ITEM_FILTER_TYPE.eItemType1AndType2
local len=#_bag_filter_desc[typo]
local idx=len-1-reIdx

self.curPageIndex=1
self.isSetZero=false
if self.isSelectGrid==true then
self.selectItemguid=nil
self.selectItemguidIdx=nil
end


reIdx=reIdx+1
self.noweStage=reIdx
self.chooseidx=reIdx

self:freshProvideSelectGrids(true)
tipsManager.closeTips()
end
function UIAutoBuildingLvlupWin:onDropdownCreate(dropIdx,scrollTrans,contentTrans)
local isMaterials=self.selectBagType==BAG_TYPE.eMaterialsBag
local typo=isMaterials and(dropIdx==1 and ITEM_FILTER_TYPE.eStage or ITEM_FILTER_TYPE.eElement)or
dropIdx==1 and ITEM_FILTER_TYPE.eStage or ITEM_FILTER_TYPE.eItemType1AndType2
local filterType=typo
local idx=self.filter[filterType]or 0
local lastPos=contentTrans.localPosition
local height=contentTrans.sizeDelta.y
local posY=lastPos.y
if height>_dropViewHeight then
posY=height-(idx)*_dropItemHeight-_dropViewHeight
else
posY=0
end
if posY<=0 then posY=0 end
contentTrans.localPosition=Vector3(lastPos.x,posY,lastPos.z)
end

function UIAutoBuildingLvlupWin:freshProvideSelectGrids(freshData)
if not self.showDialogue then return end
if freshData then
self:freshBagList()
end
local list=self.bagList
local rNum=#list
local pageNum=_row*_colomn
if rNum<pageNum then rNum=pageNum end
local tRow=math.ceil(rNum/_colomn)
local tPage=math.ceil(rNum/pageNum)
self.tPage=tPage
local curPageIndex=self.curPageIndex
local showNum=curPageIndex*pageNum
local showRow=math.ceil(showNum/_colomn)
if curPageIndex==1 then
self.ScrollView:clearSlowItems()
end
self.ScrollView:freshSlowGrids(showNum,showRow,_colomn,not self.isSetZero)
self.isSetZero=true
end

function UIAutoBuildingLvlupWin:freshProvideSelectSingleItemNum(itemguid)
local idx=self:getBagItemIdx(itemguid)
if idx then
local num=self:getSelectItemNum(itemguid)
local item=bagModel.getItem(itemguid)

if not item then

else
local itemcount=num>0 and FMT.fmt('{0}/{1}',num,item.itemcount)or item.itemcount
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildText(4,itemcount)
end
end
end
end
function UIAutoBuildingLvlupWin:getBagItemIdx(itemguid)
local list=self.bagList or{}
for i,v in ipairs(list)do
if tostring(v.itemguid)==tostring(itemguid)then
return i
end
end
end

function UIAutoBuildingLvlupWin:freshProvideSelectSingleGirid(itemguid,flag)
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(10,flag)
end
end
end

function UIAutoBuildingLvlupWin:freshBagList()
local filter={}
local filter2={}



self.selectBagType=autoBagType[self.chooseidx]
local cfgrefine_conf=cfg_autocreatebuildconfig().const_def.cost_map

if self.chooseidx==1 then
filter={}
local _bagList=bagControl.getBagItemsByFilter(BAG_TYPE.eItemBag,filter)
local bagList={}
if _bagList then
for k,v in ipairs(_bagList)do
if cfgrefine_conf[v.itemid]then
table.insert(bagList,v)
end
end
end
local _bagList2=bagControl.getBagItemsByFilter(BAG_TYPE.eMaterialsBag,filter)
if _bagList2 then
for k,v in ipairs(_bagList2)do
if cfgrefine_conf[v.itemid]then
table.insert(bagList,v)
end
end
end
local sortTag={}
for i,v in ipairs(bagList)do
local itemid=v.itemid
local itemguidStr=tostring(v.itemguid)
local itemCfg=itemsConfig.getConfig(itemid)
local stage=itemCfg.stage or 1
sortTag[itemguidStr]=stage*1000000+itemCfg.color*100000+itemid
end
table.sort(bagList,function(a,b)
return sortTag[tostring(a.itemguid)]<sortTag[tostring(b.itemguid)]
end)
self.bagList=bagList
self.bagListonekey=bagList
else
if self.chooseidx==2 then
filter={[ITEM_FILTER_TYPE.eItemType1]={[ITEM_FILTER_COMPARE.eNot]={17}}}
filter2={[ITEM_FILTER_TYPE.eItemType1]={[ITEM_FILTER_COMPARE.eNot]={17}}}
elseif self.chooseidx==3 then
filter={[ITEM_FILTER_TYPE.eItemType1]={[ITEM_FILTER_COMPARE.eEquals]={17}}}
filter2={[ITEM_FILTER_TYPE.eItemType1]={[ITEM_FILTER_COMPARE.eNot]={17}}}
elseif self.chooseidx==4 then
filter={}
end


local _bagList=bagControl.getBagItemsByFilter(self.selectBagType,filter)
local bagList={}
if _bagList then
for k,v in ipairs(_bagList)do

if cfgrefine_conf[v.itemid]then
table.insert(bagList,v)
end
end
end
local sortTag={}
for i,v in ipairs(bagList)do
local itemid=v.itemid
local itemguidStr=tostring(v.itemguid)
local itemCfg=itemsConfig.getConfig(itemid)
local stage=itemCfg.stage or 1
sortTag[itemguidStr]=stage*1000000+itemCfg.color*100000+itemid
end
table.sort(bagList,function(a,b)
return sortTag[tostring(a.itemguid)]<sortTag[tostring(b.itemguid)]
end)
self.bagList=bagList


local _bagList2=bagControl.getBagItemsByFilter(self.selectBagType,filter2)
local bagList2={}
if _bagList2 then
for k,v in ipairs(_bagList2)do

if cfgrefine_conf[v.itemid]then
table.insert(bagList2,v)
end
end
end
local sortTag2={}
for i,v in ipairs(bagList2)do
local itemid=v.itemid
local itemguidStr=tostring(v.itemguid)
local itemCfg=itemsConfig.getConfig(itemid)
local stage=itemCfg.stage or 1
sortTag2[itemguidStr]=stage*1000000+itemCfg.color*100000+itemid
end
table.sort(bagList2,function(a,b)
return sortTag2[tostring(a.itemguid)]<sortTag2[tostring(b.itemguid)]
end)
self.bagListonekey=bagList2
end
end

function UIAutoBuildingLvlupWin:freshBagList2()
local filter={}
local filter2={}

local stage=0
local element=1
if self.noweStage then
stage=self.noweStage
end
if stage>5 then
stage=5
end

if self.nowelement then
element=self.nowelement
end
filter=
{
[ITEM_FILTER_TYPE.eStage]={[ITEM_FILTER_COMPARE.eLessEqulas]={5}},
[ITEM_FILTER_TYPE.eElement]={[ITEM_FILTER_COMPARE.eEquals]={element}}
}
filter2={
[ITEM_FILTER_TYPE.eStage]={[ITEM_FILTER_COMPARE.eLessEqulas]={stage}},
[ITEM_FILTER_TYPE.eElement]={[ITEM_FILTER_COMPARE.eEquals]={element}}
}




local buildid=_this._buildid
local cfgrefine_conf=cfg_dujietreasuresconfig_get(buildid).refine_conf

local _bagList=bagControl.getBagItemsByFilter(self.selectBagType,filter)
local bagList={}
if _bagList then
for k,v in ipairs(_bagList)do
local config=itemsConfig.getConfig(v.itemid)
if config.element and cfgrefine_conf[v.itemid]then
table.insert(bagList,v)
end
end
end
local sortTag={}
for i,v in ipairs(bagList)do
local itemid=v.itemid
local itemguidStr=tostring(v.itemguid)
local itemCfg=itemsConfig.getConfig(itemid)
sortTag[itemguidStr]=itemCfg.stage*1000000+itemCfg.color*100000+itemid
end
table.sort(bagList,function(a,b)
return sortTag[tostring(a.itemguid)]<sortTag[tostring(b.itemguid)]
end)
self.bagList=bagList

local _bagList2=bagControl.getBagItemsByFilter(self.selectBagType,filter2)
local bagList2={}
if _bagList2 then
for k,v in ipairs(_bagList2)do
local config=itemsConfig.getConfig(v.itemid)
if config.element and cfgrefine_conf[v.itemid]then
table.insert(bagList2,v)
end
end
end
local sortTag2={}
for i,v in ipairs(bagList2)do
local itemid=v.itemid
local itemguidStr=tostring(v.itemguid)
local itemCfg=itemsConfig.getConfig(itemid)

sortTag2[itemguidStr]=itemCfg.stage*1000000+itemCfg.color*100000+itemid
end
table.sort(bagList2,function(a,b)
return sortTag2[tostring(a.itemguid)]<sortTag2[tostring(b.itemguid)]
end)
self.bagListonekey=bagList2
end

function UIAutoBuildingLvlupWin:isLock(itemid)
return false
end

function UIAutoBuildingLvlupWin:isPutAnyHoleByGUID(itemguid)
return false
end

function UIAutoBuildingLvlupWin:bindGrid(index,widget)
local itemInfo=self.bagList[index]
local isTemp=itemInfo==nil
local hasPutMainItem=true
local inGray=not hasPutMainItem or false
if not isTemp then
local count=itemInfo.itemcount
local itemcount=itemInfo.itemcount or 0
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid or-1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=iconHelper.getIconName(itemid)
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=itemConfig.stage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local num=self:getSelectItemNum(itemguid)
local has=num>0
local itemTxt=num>0 and FMT.fmt('{0}/{1}',num,itemInfo.itemcount)or itemInfo.itemcount>1 and itemInfo.itemcount or''
local showbg=true
local islock=not hasPutMainItem and self:isLock(itemid)or false
local showStage=itemConfig.stage~=nil
local needNum=0
local isGray=needNum>itemcount and inGray or islock or false
local isSelect=tostring(self.selectItemguid)==tostring(itemguid)and self.isSelectGrid==true

widget:SetChildActive(0,true)
widget:SetChildActive(1,isSelect)
widgetHelper.setItemQulaity(widget,itemid,2)
widget:SetChildImageExGray(2,isGray)
widget:SetChildIcon(3,iconName,false)
widget:SetChildImageExGray(3,isGray)
widget:SetChildText(4,itemTxt)
widget:SetChildActive(5,itemTxt~='')
widget:SetChildText(6,stageStr)
widget:SetChildText(7,'')
widget:SetChildActive(8,showStage)
widget:SetChildActive(9,islock)
widget:SetChildActive(10,has)
widget:SetChildButtonClick(10,function()self:onClickGridButton(index,itemid,itemguid)end,true)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid)
widget:SetChildButtonClick(-1,function()
self:onClickGrid(itemid,index,itemguid,nil)
end)
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
widget:SetChildButtonClick(-1,function()
self:onClickGrid(-1,index,-1,nil)
end)
end
end

function UIAutoBuildingLvlupWin:onClickGrid(itemid,index,itemguid,attach)
if itemid==-1 then return end
local comCfg=fabaoConfig.getCommonConfig()
local itemConfig=itemsConfig.getConfig(itemid)
local stage=itemConfig.stage
local isEquip=itemsConfig.isEquip(itemid)
local refstage=stage
if isEquip then
refstage=comCfg.stage[stage]or nil
end

local hasMain=self:hasPutMainItem()

if refstage and not hasMain then
local systemLimit=comCfg.system
local sysid=systemLimit[refstage]
if sysid then
local isOpen=systemModel.isOpen(sysid)
if not isOpen then
local tips=systemModel.getOpenTips(sysid)
UIManager.info(tips)
return
end
end
end

local item=bagModel.getItem(itemguid)
local num=item.itemcount
local hasPut=self:getSelectItemNum(itemguid)
num=num-hasPut
local needNum=self:getLeftPutNum(itemguid,index)

local maxNum=needNum
if needNum>num then
maxNum=num
end
maxNum=math.min(num,maxNum)

if maxNum<=0 then
UIManager.error("可放入材料已满")
return
end
local selectNumCmpArgs={numFormat='放入：<color=#f1ce78>{0}/{1}</color>',
min=1,max=maxNum,val=maxNum}

local isMain=false

tipsManager.showTips({formType=TIPS_FORM_TYPE.ePutAutoBuildMaterial,
itemid=itemid,
itemguid=itemguid,
backType=TIPS_BACK_TYPE.eNone,
attach={index=index,
selectNumCmpArgs=selectNumCmpArgs,
isMain=isMain,
isMakeByEquip=false},
move=TIPS_MOVE_POS.eLeft})
self.closeidx=index
self.closeitemguid=itemguid
self:onSelectOneGrid(itemguid,true,index)
end

function UIAutoBuildingLvlupWin:getLeftPutNum(itemguid,holeIdx)
local needNum=self:getNeedNumByGUID(nil,itemguid,holeIdx)
return needNum or 0
end

function UIAutoBuildingLvlupWin:getSelectItemNum(itemguid)
if self.selectList==nil then self.selectList={}end
local handle=tostring(itemguid)
local num=0
local array=self:getIdxArray()
for _,i in ipairs(array)do
if tostring(self.selectList[i])==handle then
num=num+self:getPutNum(i)
end
end
return num
end
function UIAutoBuildingLvlupWin:getIdxArray()
local array
if self:isMakeByEquip()then
array=_equipIdxArray
else
array=_materialIdxArray
end
return array
end
function UIAutoBuildingLvlupWin:getOneKeyIdxArray()
local array
if self:isMakeByEquip()then
array=_equipIdxOneKeyArray
else
array=_materialIdxOneKeyArray
end
return array
end
function UIAutoBuildingLvlupWin:isMakeByEquip()
return false
end
function UIAutoBuildingLvlupWin:getPutNum(idx)
return self.selectNumList[idx]or 0
end
function UIAutoBuildingLvlupWin:deletePutNum(idx,num)
local num1=self:getPutNum(idx)-num
if num1<=0 then num1=0 end
self.selectNumList[idx]=num1
end
function UIAutoBuildingLvlupWin:deleteSelectNum(index,num)

self:deletePutNum(index,num)
if self:getPutNum(index)<=0 then
self.selectList[index]=nil
end
end
function UIAutoBuildingLvlupWin:getSelectIndex(itemguid)
if self.selectList==nil then self.selectList={}end
local array=self:getIdxArray()
local len=#array
for i=len,1,-1 do
local index=array[i]
if tostring(self.selectList[index])==tostring(itemguid)then
return index
end
end
end
function UIAutoBuildingLvlupWin:isMainHole(idx)
return false
end
function UIAutoBuildingLvlupWin:isFzHole(idx)
return false
end
function UIAutoBuildingLvlupWin:isJHIdxHole(idx)
return false
end
function UIAutoBuildingLvlupWin:hasPutMainItem()
return true
end
function UIAutoBuildingLvlupWin:getMainGUID()
return nil
end

function UIAutoBuildingLvlupWin:setSelectItems()

local isNotSelectGrid=self.isSelectGrid==false
local hasSelect=false
local itemsList=self.itemsList
if self.selectList==nil then self.selectList={}end

for i,v in ipairs(itemsList)do
if not self:isMainHole(i)then
local itemguid=self.selectList[i]
local item=itemguid and bagModel.getItem(itemguid)or nil
local isSelect=itemguid and self.isSelectGrid==false and tostring(self.selectItemguid)==tostring(itemguid)and self.selectItemguidIdx==i or false
hasSelect=isSelect or hasSelect

local itemcount=''
local hasNum=self:getPutNum(i)

if hasNum>1 and item then

itemcount=hasNum
end
local conf={showname=false,itemcount=itemcount,showCountBG=itemcount~='',select=isSelect}
v:setChildPropData(self:getSelectFillData(i,item,conf))


if i==1 then
local isreddot=false
if not itemguid then
isreddot=AutoBuildController:checkAutoReddotByUnBuildid(self.un_build_id)
end
local _widget=v:getWidgetBase()
_widget:SetChildActive(11,isreddot)
end
end
end
if isNotSelectGrid and not hasSelect then
self.selectItemguidIdx=nil
self.selectItemguid=nil
end

self:refreshjdandzs()
end

function UIAutoBuildingLvlupWin:getNeedNumByGUID(mainguid,guid,fillIdx)
local _guid=self.selectList[fillIdx]
if _guid and tostring(guid)~=tostring(guid)then return end
local num=self:getMaxNumByItemguid(guid)
return num
end
function UIAutoBuildingLvlupWin:getSelectFillData(index,item,conf)
local prop
if item==nil then
prop=self:getSelectTempFillData(index)
prop[PropIndex(DataPropKey.eWidgetActive,8)]=false
prop[PropIndex(DataPropKey.eWidgetActive,9)]=false
prop[PropIndex(DataPropKey.eWidgetActive,10)]=true
else
prop=itemsComponentHelper.getCommonFillData(item,conf)
local itemConfig=itemsConfig.getConfig(item.itemid)
local showStage=itemConfig.stage~=nil
prop[PropIndex(DataPropKey.eWidgetActive,8)]=showStage
prop[PropIndex(DataPropKey.eWidgetActive,9)]=false
prop[PropIndex(DataPropKey.eWidgetActive,10)]=false
end
prop[DataPropKey.eItemIndex]=index
return prop
end
function UIAutoBuildingLvlupWin:getSelectTempFillData(index)
local conf={}
conf.showbg=true
return itemsComponentHelper.getTempFillData(conf)
end
function UIAutoBuildingLvlupWin:freshAllItems()
if self.selectBagType~=BAG_TYPE.eEquipBag then
self.curPageIndex=1
self.isSetZero=false
self:freshProvideSelectGrids(true)
return true
end
return false
end
function UIAutoBuildingLvlupWin:hasPutAny()
local array=self:getIdxArray()
for _,i in ipairs(array)do
if self:getPutNum(i)>0 then
return true
end
end
return false
end

function UIAutoBuildingLvlupWin:onBtnReset()
if self:hasPutAny()then
local selectList=table.deepCopy(self.selectList)
for _,itemguid in pairs(selectList)do
self:freshProvideSelectSingleGirid(itemguid,false)

self:freshProvideSelectSingleItemNum(itemguid)
end
self.selectList={}
self.selectNumList={}
self.lastSelectIndex=nil
self:setSelectItems()
self:freshAllItems()

tipsManager.closeTips()
end
end

function UIAutoBuildingLvlupWin:onBtnOnekey()

local isChange=false
local mainguid=self:getMainGUID()
local moniSelectList={}
local moniSelectNumList={}
local array=self:getIdxArray()
for _,i in ipairs(array)do
moniSelectList[i]=self.selectList[i]
moniSelectNumList[i]=self:getPutNum(i)
end
local buildlvl=AutoBuildModel:getAutoBuildingLvl(self.un_build_id)
local cfg=cfg_autocreatebuildconfig_get(buildlvl)
local now_exp=AutoBuildModel:getAutoBuildingExp(self.un_build_id)
local refine_rate=cfg.exp
local cfg_refine_conf=cfg_autocreatebuildconfig().const_def.cost_map


local getMaxNumByItemguid=function(guid)
local neednum=0
local allnumjd=0
for _,i in ipairs(array)do
local itemguid=moniSelectList[i]
local itemguid_num=moniSelectNumList[i]
if itemguid and itemguid_num then
local item=bagModel.getItem(itemguid)
if item then
local itemid=item.itemid
local refine_conf=cfg_refine_conf[itemid]or 0
local costnum=refine_conf
allnumjd=allnumjd+costnum*itemguid_num
end
end
end
local now_rate=now_exp or 0
now_rate=now_rate+allnumjd
local chaeNum=refine_rate-now_rate
if chaeNum<=0 then
return 0
end
local this_item=bagModel.getItem(guid)
local this_itemid=this_item.itemid
local this_refine_conf=cfg_refine_conf[this_itemid]or 0
local singlevalue=this_refine_conf
neednum=math.ceil(chaeNum/singlevalue)


return neednum
end


local _getSelectItemNum=function(itemguid)
local handle=tostring(itemguid)
local num=0
for _,i in ipairs(array)do
if tostring(moniSelectList[i])==handle then
num=num+(moniSelectNumList[i]or 0)
end
end
return num
end

local _getLeftNum=function(itemguid)
local num=_getSelectItemNum(itemguid)or 0
local item=bagModel.getItem(itemguid)
local itemcount=item.itemcount
return itemcount-num
end

local _getNextFillItemGuid=function(holeIdx)
local bagList=self.bagListonekey or{}
for i,v in ipairs(bagList)do
local left=_getLeftNum(v.itemguid)
local needNum=self:getNeedNumByGUID(nil,v.itemguid,holeIdx)
local addNum=needNum
if needNum>left then
addNum=left
end
local fillNum=math.min(left,addNum)
if fillNum>0 then
return v.itemguid,left,i
end
end
end

local _getMainFillGuid=function()
local bagList=self.bagList or{}
return nil
end
local _addItem=function(index,itemguid,num)

local handle=tostring(itemguid)
local ishasidx=false
for _,i in ipairs(array)do
local guid=moniSelectList[i]
local guidStr=tostring(guid)
if guid~=nil and guidStr==handle then
ishasidx=i
break
end
end
if ishasidx then
moniSelectNumList[ishasidx]=moniSelectNumList[ishasidx]+num
else
moniSelectList[index]=itemguid
moniSelectNumList[index]=moniSelectNumList[index]+num
end
end
local array_=self:getOneKeyIdxArray()
for _,i in ipairs(array_)do
local hasNum=moniSelectNumList[i]or 0
if self:isMainHole(i)then
local needNum=self:getNeedNumByGUID(nil,mainguid,i)
local canAddNum=needNum-hasNum
local leftNum=_getLeftNum(mainguid)
local fillNum=math.min(leftNum,canAddNum)
if fillNum>0 then
_addItem(i,mainguid,fillNum)
isChange=true
self:freshProvideSelectSingleItemNum(mainguid)
self:freshProvideSelectSingleGirid(mainguid,true)
end
else

local itemguid=moniSelectList[i]
if itemguid==nil then
local guid=_getNextFillItemGuid(i)
itemguid=guid
end
if itemguid then
local leftNum=_getLeftNum(itemguid)
local needNum=getMaxNumByItemguid(itemguid)

local addNum=needNum
if needNum>leftNum then
addNum=leftNum
end
local fillNum=math.min(leftNum,addNum)

if fillNum>0 then
_addItem(i,itemguid,fillNum)
self:freshProvideSelectSingleItemNum(itemguid)
self:freshProvideSelectSingleGirid(itemguid,true)
end
isChange=true
end
end
end
if isChange then
self.lastSelectIndex=nil
for _,i in ipairs(array)do
self.selectList[i]=moniSelectList[i]
self:setPutNum(i,moniSelectNumList[i]or 0)
end

self:freshAllItems()
self:setSelectItems()


end
tipsManager.closeTips()
end

function UIAutoBuildingLvlupWin:refreshjdandzs()
local buildlvl=AutoBuildModel:getAutoBuildingLvl(self.un_build_id)
local cfg=cfg_autocreatebuildconfig_get(buildlvl)
local now_exp=AutoBuildModel:getAutoBuildingExp(self.un_build_id)
local refine_rate=cfg.exp
local now_rate=now_exp or 0

if not refine_rate then

self.proExpProgressbar:animateThreeParams(1,1,0)

self.progressText:setText("已满级")
else
self:refreshnowjindu(now_rate,refine_rate,false,true)
end
end

function UIAutoBuildingLvlupWin:getjd()
local cfg_refine_conf=cfg_autocreatebuildconfig().const_def.cost_map
local allnumjd=0
local array=self:getIdxArray()
for _,i in ipairs(array)do
local itemguid=self.selectList[i]
local itemguid_num=self.selectNumList[i]
if itemguid and itemguid_num then
local item=bagModel.getItem(itemguid)
if item then
local itemid=item.itemid
local refine_conf=cfg_refine_conf[itemid]or 0
local costnum=refine_conf
allnumjd=allnumjd+costnum*itemguid_num
end
end
end

return allnumjd
end

function UIAutoBuildingLvlupWin:getzscost(now_rate,refine_rate)
local cfg_refine_conf=cfg_dujietreasuresconfig_get(self._buildid).refine_conf
local refine_money=cfg_dujietreasuresbasicconfig_get(1).refine_money
local allnumcost=0
local allnumjd=0
local array=self:getIdxArray()
for _,i in ipairs(array)do
local itemguid=self.selectList[i]
local itemguid_num=self.selectNumList[i]
if itemguid and itemguid_num then
local item=bagModel.getItem(itemguid)
if item then
local itemid=item.itemid
local refine_conf=cfg_refine_conf[itemid]
local costnum=refine_conf
allnumjd=allnumjd+costnum*itemguid_num
end
end
end
local chazhi=refine_rate-now_rate
if allnumjd>chazhi then
allnumjd=chazhi
end
allnumcost=allnumjd*refine_money

return allnumcost
end

function UIAutoBuildingLvlupWin:getMaxNumByItemguid(guid)





local neednum=0
local buildlvl=AutoBuildModel:getAutoBuildingLvl(self.un_build_id)
local cfg=cfg_autocreatebuildconfig_get(buildlvl)
local now_exp=AutoBuildModel:getAutoBuildingExp(self.un_build_id)
local refine_rate=cfg.exp
local now_rate=now_exp or 0


local cfg_refine_conf=cfg_autocreatebuildconfig().const_def.cost_map
local allnumjd=0
local array=self:getIdxArray()
for _,i in ipairs(array)do
local itemguid=self.selectList[i]
local itemguid_num=self.selectNumList[i]
if itemguid and itemguid_num then
local item=bagModel.getItem(itemguid)
if item then
local itemid=item.itemid
local refine_conf=cfg_refine_conf[itemid]or 0
local costnum=refine_conf
allnumjd=allnumjd+costnum*itemguid_num
end
end
end
now_rate=now_rate+allnumjd


local chaeNum=refine_rate-now_rate
if chaeNum<=0 then
return 0
end


local this_item=bagModel.getItem(guid)
local this_itemid=this_item.itemid
local this_refine_conf=cfg_refine_conf[this_itemid]or 0
local singlevalue=this_refine_conf
neednum=math.ceil(chaeNum/singlevalue)

return neednum
end

function UIAutoBuildingLvlupWin:getAllJinDuYiChu(_buildid)


local buildlvl=AutoBuildModel:getAutoBuildingLvl(self.un_build_id)
local cfg=cfg_autocreatebuildconfig_get(buildlvl)
local now_exp=AutoBuildModel:getAutoBuildingExp(self.un_build_id)
local refine_rate=cfg.exp
local now_rate=now_exp or 0

end

function UIAutoBuildingLvlupWin:putItem(index,itemid,itemguid,fillnum)
if itemid==-1 then return end
local putFinish=itemid~=nil
local handle=tostring(itemguid)
local num=self:getSelectItemNum(itemguid)
local item=bagModel.getItem(itemguid)
local lastHasMain=self:hasPutMainItem()
local itemcount=item.itemcount
if num>=itemcount then
UIManager.error('物品已达上限')
tipsManager.closeTips()
return
end
local fillIdx=self:getNextFillIdx(itemguid)
if fillIdx==nil then
UIManager.error('可放入材料已满')
tipsManager.closeTips()
return
end
local lastFillNum=self:getPutNum(fillIdx)
local isMainHole=self:isMainHole(fillIdx)
local fillBagType=BAG_TYPE.eMaterialsBag
local isFzHole=self:isFzHole(fillIdx)
local isJhHole=self:isJHIdxHole(fillIdx)
local changeBagType=false
if itemsConfig.isEquip(item.itemid)and not isMainHole then
UIManager.error('装备只能作为主材料')
return
end
local lastNum=num
local addNum=1
local curNum=num+addNum
if isMainHole or isFzHole or isJhHole then
local mainItemguid=self:getMainGUID()
local needNum=self:getNeedNumByGUID(mainItemguid,itemguid,fillIdx)
local leibie=isMainHole and'主材料'or
isFzHole or'副材料'or
'炼化材料'
if needNum and itemcount<needNum then
local itemName=itemsConfig.getConfig(itemid).name
UIManager.error(FMT.fmt('{0}数量不足以作为{3}({1}/{2})',itemName,itemcount,needNum,leibie))
gainControl:showGainWin(itemid)
return
end
addNum=needNum
curNum=addNum
else
addNum=fillnum
end
if lastNum==0 then
self:freshProvideSelectSingleGirid(itemguid,true)
end

self:addSelectHole(itemguid,fillIdx,addNum)
self:freshProvideSelectSingleItemNum(itemguid)
self:setSelectItems()



tipsManager.closeTips()
local isMain=isMainHole and not lastHasMain





if changeBagType then
self:freshProvideGrids(fillBagType)
elseif not lastHasMain then

self.ScrollView:freshAllItems()
end
end

function UIAutoBuildingLvlupWin:getNextFillIdx(itemguid,containsJh)
local handle=tostring(itemguid)
local array=self:getIdxArray()
for _,i in ipairs(array)do
local isJHIdxHole=self:isJHIdxHole(i)
if not isJHIdxHole or isJHIdxHole and containsJh then
local guid=self.selectList[i]
if guid==nil or tostring(guid)==handle and not self:isfull(i)then
return i
end
end
end
end
function UIAutoBuildingLvlupWin:isfull(fillIdx)
local guid=self.selectList[fillIdx]
if guid==nil then return false end
local mainItemguid=self:getMainGUID()
local needNum=self:getNeedNumByGUID(mainItemguid,guid,fillIdx)
local hasNum=self:getPutNum(fillIdx)
return hasNum>=needNum
end

function UIAutoBuildingLvlupWin:addSelectHole(itemguid,index,num)
if num<=0 then return end
local array=self:getIdxArray()
local handle=tostring(itemguid)
local mainItemguid=self:getMainGUID()
for _,i in ipairs(array)do
local needNum=self:getNeedNumByGUID(mainItemguid,itemguid,i)
local hasNum=self:getPutNum(i)
local guid=self.selectList[i]
local guidStr=tostring(guid)

if guid==nil or guidStr==handle and needNum>0 then

local add=math.min(num,needNum)
self:addSelectNum(itemguid,i,add)
num=num-add
if num<=0 then
break
end
end
end
end
function UIAutoBuildingLvlupWin:addSelectNum(itemguid,index,num)

local array=self:getIdxArray()
local handle=tostring(itemguid)
local ishasidx=false
for _,i in ipairs(array)do
local guid=self.selectList[i]
local guidStr=tostring(guid)
if guid~=nil and guidStr==handle then
ishasidx=i
break
end
end
if ishasidx then
self:addPutNum(ishasidx,num)
else
self.selectList[index]=itemguid
self:addPutNum(index,num)
end
end
function UIAutoBuildingLvlupWin:addPutNum(idx,num)
self.selectNumList[idx]=self:getPutNum(idx)+num
end
function UIAutoBuildingLvlupWin:setPutNum(idx,num)
self.selectNumList[idx]=num
end

function UIAutoBuildingLvlupWin:takeOffByTips(index,itemid,itemguid)
self.lastSelectIndex=nil
if self.isSelectGrid==false then
if index==self.selectItemguidIdx then
self.selectItemguid=nil
self.selectItemguidIdx=nil
end
end
self:onClickGridButton(nil,itemid,itemguid,index,true)
end

function UIAutoBuildingLvlupWin:onUserbtn()
local list={}

local allnumcost=0
local cfg_refine_conf=cfg_autocreatebuildconfig().const_def.cost_map
local array=self:getIdxArray()
for _,i in ipairs(array)do
local itemguid=self.selectList[i]
local itemguid_num=self.selectNumList[i]
if itemguid and itemguid_num then
local item=bagModel.getItem(itemguid)
if item then
local itemid=item.itemid
local temp={itemid,itemguid_num}
list[#list+1]=temp

local refine_conf=cfg_refine_conf[itemid]
local costnum=refine_conf
allnumcost=allnumcost+costnum*itemguid_num
end
end
end
if#list==0 then
UIManager.error("请放入升级材料")
return
end


local buildlvl=AutoBuildModel:getAutoBuildingLvl(self.un_build_id)
local cfg=cfg_autocreatebuildconfig_get(buildlvl)
local now_exp=AutoBuildModel:getAutoBuildingExp(self.un_build_id)
local refine_rate=cfg.exp
local now_rate=now_exp or 0
local chanum=now_rate+allnumcost-refine_rate


local addvalue=0
if chanum>0 then
addvalue=refine_rate-now_rate
else
addvalue=allnumcost
end
local _func=function()
local str=FMT.fmt('经验+{0}',addvalue)
commonTipsHelper.addThrowOutAndSliderTipsEx({3,str})
end

if chanum>0 then

local tips=FMT.fmt("当前材料增加的经验进度会溢出<color=#c82c2c>{0}</color>点，\n溢出值在升级后将损耗，是否继续？",chanum)
local show_data=
{
title='提示',
_okText="确认",
_cancelText="取消",
tipsText=tips,
closetopbtn=true,
cellcallback=function()
_func()


XianMengBaoXiaController:send_6_197(self.sfId,self.un_build_id,#list,list)
end,
}
UIManager:showWindow('UIDialougeNormalTip',show_data)
else
_func()

XianMengBaoXiaController:send_6_197(self.sfId,self.un_build_id,#list,list)
end
end

function UIAutoBuildingLvlupWin:refreshLHdata(_buid)
_this:onBtnReset()
_this:closeProvideSelectGrids()





_this:freshRightListPanel()
_this:freshLevelUpPanel()
end




function UIAutoBuildingLvlupWin:refreshDailyReward()

local ishave=FeiShengTaiModel:judeCanRepairFST()or FeiShengTaiModel:GetFSTreddot()


if not ishave then
self.feishengtaiReddot:setActive(false)
self:doPunchRotation(false)
else
self.feishengtaiReddot:setActive(true)
self:doPunchRotation(true)
end
end

function UIAutoBuildingLvlupWin:doPunchRotation(reddot)
if reddot then
if self.reddotTweener==nil then
self.feishengtaiReddot:setRotation(0,0,0)
local tweener=self.feishengtaiReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self.feishengtaiReddot:setRotation(0,0,0)
end
end
end
