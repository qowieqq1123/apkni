







def_class("UIWorldXiuZhenJiaZuListWin",UIWindowBase)









function UIWorldXiuZhenJiaZuListWin:bindComponents()

self.hideButton=UIButton.get(self,0)
self.CSGUIScrollView=UIComboScrollView.get(self,1)
self.NullTxt=UIText.get(self,2)
self.NullImg=UIObject.get(self,3)
self.CDTxt=UIText.get(self,4)
self.uiRoot=UIObject.get(self,5)
self.root=UIObject.get(self,6)

self.hideButton:setButtonClick(function()self:onHideButton()end)



end


function UIWorldXiuZhenJiaZuListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.hideButton);self.hideButton=nil;
_UIObject_release(self.CSGUIScrollView);self.CSGUIScrollView=nil;
_UIObject_release(self.NullTxt);self.NullTxt=nil;
_UIObject_release(self.NullImg);self.NullImg=nil;
_UIObject_release(self.CDTxt);self.CDTxt=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.root);self.root=nil;
end

















local main_index=
{
name=0,
jiantou1=1,
jiantou2=2,
reddot=3,




}
local sub_index=
{
select=0,
name=1,
state=2,
jianzhuzhong=3,
icon=4,
rewardIcon=5,
reddot=6,
root=7,
kong=8,
}


function UIWorldXiuZhenJiaZuListWin:onLoaded(...)
self:bindComponents()
local _mainClickAction=function(...)self:mainClickAction(...)end
local _subClickAction=function(...)self:subClickAction(...)end
local _mainCreateAction=function(...)self:mainCreateAction(...)end
local _subCreateAction=function(...)self:subCreateAction(...)end
local _onExpandAction=function(...)self:onExpandAction(...)end
self.CSGUIScrollView:setAction(_mainClickAction,_subClickAction,_mainCreateAction,_subCreateAction,_onExpandAction)

self.init=true
end


function UIWorldXiuZhenJiaZuListWin:__delete()
self:unbindComponents()
self.init=false
end




function UIWorldXiuZhenJiaZuListWin:onShow(argtable,afterOnloaded)
self.winlua:SwitchChildParent(self.root:getID(),worldController:isInWorld()and-1 or self.uiRoot:getID(),false)
local allCfg=worldXiuZhenJiaZuModel:getFamilyAreaList()
self.allFamilyCfg=allCfg
if next(self.allFamilyCfg)then
self.CSGUIScrollView:setActive(true)
self.NullTxt:setActive(false)
if not self.init then





if self.mainIndex then
self.CSGUIScrollView:clickItem(self.mainIndex-1)
end
self:refreshMainItem(self.mainIndex)
if self.mainIndex then
self.CSGUIScrollView:clickItem(self.mainIndex-1)
end
else
local defaultClick=0
for i,v in ipairs(self.allFamilyCfg)do
local areaCfg=cfgHelper.get1(cfg_worldareaconfig_get,i)
if worldModel:isSameWorld(areaCfg.world)then
defaultClick=i-1
break
end
end
self.CSGUIScrollView:removeAllGrids()
self.CSGUIScrollView:createMainGrids(#allCfg,1,true)
self.CSGUIScrollView:clickItem(defaultClick)
end
else
self.CSGUIScrollView:setActive(false)
self.NullTxt:setActive(true)
end
self:refreshCount()
self.init=false
end


function UIWorldXiuZhenJiaZuListWin:onHide()
if self.mainIndex then
self.CSGUIScrollView:clickItem(self.mainIndex-1)
end
self.CSGUIScrollView:removeAllGrids()
self.init=true
end

function UIWorldXiuZhenJiaZuListWin:getOpenListIndexByUnFamilyId(unFamilyId)
local allFamilyCfg=self.allFamilyCfg
for i,list in ipairs(allFamilyCfg)do
for j,v in ipairs(list)do
if v.unFamilyId==unFamilyId then
return i,j
end
end
end
end

function UIWorldXiuZhenJiaZuListWin:refreshMainItemByGuid(guid)
local mainIndex,subIndex=worldXiuZhenJiaZuModel:getOpenListIndexByGuid(guid)

if mainIndex then
self:refreshMainItem(mainIndex)
end
end

function UIWorldXiuZhenJiaZuListWin:refreshMainItemReddotByGuid(guid)
local mainIndex,subIndex=self:getOpenListIndexByGuid(guid)

if mainIndex then
local allFamilyCfg=self.allFamilyCfg
local mainItemList=self.CSGUIScrollView:getMainItemsList()
for i=1,mainItemList.Count do
local mainItem=mainItemList[i-1]
local areaFamily=allFamilyCfg[i]
local reddot=false
for i,v in ipairs(areaFamily)do
if v.firstRewardFlag~=0 then
reddot=true
break
end
end
mainItem:SetChildActive(main_index.reddot,reddot)
end
end
end

function UIWorldXiuZhenJiaZuListWin:refreshMainItem(mainIndex)
local allFamilyCfg=self.allFamilyCfg
if mainIndex then
local familyAreaData=allFamilyCfg[mainIndex]
local num=#familyAreaData
self.CSGUIScrollView:rebuildSubItems(mainIndex-1,num,nil)
end

local mainItemList=self.CSGUIScrollView:getMainItemsList()
for i=1,mainItemList.Count do
local mainItem=mainItemList[i-1]
local areaFamily=allFamilyCfg[i]
local reddot=false
for i,v in ipairs(areaFamily)do
if v.firstRewardFlag~=0 then
reddot=true
break
end
end
mainItem:SetChildActive(main_index.reddot,reddot)
end
end

function UIWorldXiuZhenJiaZuListWin:refreshSubItem(guid)
local mainIndex,subIndex=self:getOpenListIndexByGuid(guid)
if mainIndex then
local subItem=self.CSGUIScrollView:getSubItem(mainIndex-1,subIndex-1)
if subItem then
self:refreshSubItemInfo(subItem,guid)
end
end
end

function UIWorldXiuZhenJiaZuListWin:getOpenListIndexByGuid(guid)
local allFamilyCfg=self.allFamilyCfg
for i,list in ipairs(allFamilyCfg)do
for j,v in ipairs(list)do
if mathHelper.compareInt64(v.guid,guid)then
return i,j
end
end
end
end



function UIWorldXiuZhenJiaZuListWin:mainClickAction(mainItem)
local lastMainItem=self.selectMainItem
local index=mainItem.Index+1

local isExpanded=self.showType==index
if isExpanded then
self.selectMainItem=mainItem
end
mainItem:SetChildActive(main_index.jiantou1,not isExpanded)
mainItem:SetChildActive(main_index.jiantou2,isExpanded)







end

function UIWorldXiuZhenJiaZuListWin:subClickAction(subItem)
local lastSubItem=self.selectSubItem
local index=subItem.Index+1

self.subIndex=index
self.selectSubItem=subItem
local mainIndex=subItem.Mainindex+1

local familyAreaData=self.allFamilyCfg[mainIndex]
local openFamily=familyAreaData[index]

if not openFamily then
return
end


if lastSubItem then
lastSubItem:SetChildActive(sub_index.select,false)
end
subItem:SetChildActive(sub_index.select,true)


local key=worldXiuZhenJiaZuModel:convertKey(openFamily.guid)
if key then
if worldModel:isSameWorld(openFamily.world)then
worldController:lookAtUnit(key)
worldController:changeRightView("UIWorldXiuZhenJiaZuInfoWin",openFamily.guid)
local win=UIManager:findActiveWindow('UIWorldXiuZhenJiaZuInfoWin')
if win then
win:onShow(openFamily.guid)
end


if openFamily.firstRewardFlag~=0 then
UIManager:showWindow("UIWorldXiuZhenJiaZuFirstRewardWin",openFamily.guid)
end
else




local worldName=cfgHelper.get2(cfg_worldconfig_get,openFamily.world,'name')
local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt('确认前往<color=#18a736>{0}</color>？',worldName),
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
local args={lookAtUnit=key,}
mainControl:enterWorld({openFamily.world,args},function()
worldController:changeRightView("UIWorldXiuZhenJiaZuInfoWin",openFamily.guid)
local win=UIManager:findActiveWindow('UIWorldXiuZhenJiaZuInfoWin')
if win then
win:onShow(openFamily.guid)
end
end)


end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end
end
end

function UIWorldXiuZhenJiaZuListWin:mainCreateAction(mainItem)
local index=mainItem.Index+1
local areaFamily=self.allFamilyCfg[index]
if areaFamily then
local areaCfg=cfgHelper.get1(cfg_worldareaconfig_get,index)
local widget=mainItem
widget:SetChildText(main_index.name,areaCfg and areaCfg.name or index)

widget:SetChildActive(main_index.jiantou1,true)
widget:SetChildActive(main_index.jiantou2,false)
local reddot=false
for i,v in ipairs(areaFamily)do
if v.firstRewardFlag~=0 then
reddot=true
break
end
end
widget:SetChildActive(main_index.reddot,reddot)
local num=#areaFamily
mainItem:SetAddExpandColumCount(#areaFamily)





end
end

function UIWorldXiuZhenJiaZuListWin:subCreateAction(subItem)
local index=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local familyAreaData=self.allFamilyCfg[mainIndex]
local openFamily=familyAreaData[index]

if openFamily then
subItem:SetChildActive(sub_index.root,true)
subItem:SetChildActive(sub_index.kong,false)




local name=worldXiuZhenJiaZuModel:getFamilyName2(openFamily.guid,true)
subItem:SetChildText(sub_index.name,name)
subItem:SetChildActive(sub_index.select,false)



local index,preNameList=worldXiuZhenJiaZuModel:getFamilyScaleData(openFamily.guid)
local scaleCfg=cfgHelper.get(cfg_xiuzhenfamilyscaleconfig_get,index)
local icon
local familyCfg=worldXiuZhenJiaZuModel:getFamilyConfig(openFamily.familyId)
if familyCfg.icon then
icon=FMT.fmt("icon_family_{0}",familyCfg.icon[index])
subItem:SetChildCSImageIcon(sub_index.icon,icon,true)
else
if scaleCfg then
icon=scaleCfg.icon
subItem:SetChildCSImageIcon(sub_index.icon,icon,true)
end
end


self:refreshSubItemInfo(subItem,openFamily.guid)

else
subItem:SetChildActive(sub_index.root,false)
subItem:SetChildActive(sub_index.kong,true)
end


self:refreshSubItemInfo(subItem,openFamily.guid)
subItem:SetChildNewBieComponentId(-1,FMT.fmt('UIWorldXiuZhenJiaZuListWin.itemPrefab.subItem.{0}',index))
subItem:SetChildWeakGuideComponentId(10,FMT.fmt('UIWorldXiuZhenJiaZuListWin.itemPrefab.subItem.{0}',index))
end


function UIWorldXiuZhenJiaZuListWin:onExpandAction(index)
self.subIndex=nil
if index>=0 then
self.showType=index+1
else
self.showType=nil
end
end

function UIWorldXiuZhenJiaZuListWin:refreshSubItemInfo(subItem,guid)
local familyData=worldXiuZhenJiaZuModel:getFamilyDataByGuid(guid)

local state=familyData.state
local stateStr=''
local jinzhuzhong=worldXiuZhenJiaZuModel:isJinZhuZhong(guid)
if jinzhuzhong then
stateStr='中立'
elseif state==familyState.neutral then
stateStr='中立'
elseif state==familyState.player then
stateStr=FMT.fmt('<color=#685BC0>附庸：{0}</color>',UISettingModel:getZMName())
elseif state==familyState.system then
stateStr='<color=#685BC0>附庸：系统宗门</color>'
end
subItem:SetChildText(sub_index.state,stateStr)

subItem:SetChildActive(sub_index.jianzhuzhong,jinzhuzhong)
if jinzhuzhong then
subItem:SetChildText(sub_index.jianzhuzhong,"（已进驻）")
end

local reddot=familyData.firstRewardFlag~=0

subItem:SetChildActive(sub_index.reddot,reddot)

end

function UIWorldXiuZhenJiaZuListWin:refreshCount()
local limitCnt=worldXiuZhenJiaZuModel:getFamilyLimit()
local data=worldXiuZhenJiaZuModel:getAllSelfFamilyData()
self.CDTxt:setText(FMT.fmt("附庸家族数量：{0}/{1}",#data,limitCnt))
end




function UIWorldXiuZhenJiaZuListWin:onHideButton()
worldController:resetLeftView()
end

