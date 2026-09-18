







def_class("UIAirGameSelectMountWin",UIWindowBase)









function UIAirGameSelectMountWin:bindComponents()

self.infoPanel=UIObject.get(self,0)
self.noDataTipRoot=UIObject.get(self,1)
self.Root=UIObject.get(self,2)
self.scrollView=UILoopListView.new(self,3)
self.uiRoot=UIObject.get(self,4)

self.scrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIAirGameSelectMountWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.noDataTipRoot);self.noDataTipRoot=nil;
_UIObject_release(self.Root);self.Root=nil;
self.scrollView:deleteSelf();self.scrollView=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local CmpMountItemSlotIndex={
item=0,
name=1,
desc=2,
removeBtn=3,
equipBtn=4,
equipedImg=5,
}




function UIAirGameSelectMountWin:onLoaded(...)
self:bindComponents()
end


function UIAirGameSelectMountWin:__delete()
self:unbindComponents()
end




function UIAirGameSelectMountWin:onShow(argtable,afterOnloaded)
self.selectMount=argtable and argtable.selectMount
self.parentWin=argtable and argtable.parentWin

local selectDiscipleGuid=airGameEnterModel:getSelectDisciple()
local voc=UIDiscipleModel:getDiscipleJob(selectDiscipleGuid)
self.mountDataList=equipListManager.getMountFilterFunc(selectDiscipleGuid,nil,ITEM_MAIN_TYPE.eMount,voc,nil)or{}

local mountLen=#self.mountDataList


local isShowScrollView=mountLen>0

self.scrollView:setActive(isShowScrollView)
self.noDataTipRoot:setActive(not isShowScrollView)
if isShowScrollView then
self.scrollView:initData('Temp',self.mountDataList,mountLen)
else

end
end


function UIAirGameSelectMountWin:onHide()

end

function UIAirGameSelectMountWin:onFreshAction(id,item)
local index=id
local data=self.mountDataList[index]


local itemGuid=data.itemguid
local itemId=data.itemid


local conf={itemid=itemId,showCountBG=false,itemcount="",showStage=true,showname=false,
itemguid=itemGuid,itemIndex=id}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(CmpMountItemSlotIndex.item,propData)
item:SetBaseItemClickEvent(CmpMountItemSlotIndex.item,function()

end)

local isEquiped=self.selectMount and mathHelper.compareInt64(itemGuid,self.selectMount)or false
item:SetChildActive(CmpMountItemSlotIndex.equipedImg,isEquiped)
item:SetChildActive(CmpMountItemSlotIndex.removeBtn,isEquiped)
item:SetChildActive(CmpMountItemSlotIndex.equipBtn,not isEquiped)

local itemCfg=itemsConfig.getConfig(itemId)
local itemName=itemsConfig.getColorName(itemId)
item:SetChildText(CmpMountItemSlotIndex.name,itemName)

local itemDesc=""
local itemConfig=itemsConfig.getConfig(itemId)
local mountSkillId=itemConfig and itemConfig.airgameMountSkillid
if mountSkillId then
local mountSkillCfg=cfgHelper.get1(cfg_airskillconfig_get,mountSkillId)
itemDesc=mountSkillCfg.desc
if mountSkillCfg.descParams then
local descParams=mountSkillCfg.descParams
itemDesc=FMT.fmt(itemDesc,unpack(descParams[1]))
end
if mountSkillCfg.cd then
itemDesc=FMT.fmt("{0},冷却{1}秒",itemDesc,mountSkillCfg.cd)
end
end
item:SetChildText(CmpMountItemSlotIndex.desc,itemDesc)

local removeMountFunc=function()
airGameEnterModel:removeMount(data)
self.parentWin:onBtnClose()
end

local setMountFunc=function()
airGameEnterModel:setMount(data)
self.parentWin:onBtnClose()
end

local dialougeFunc=function(func)
if airGameEnterModel:checkShowChangeInfoDialouge()then
local showdata=
{
type='UIDialouge',
title='提示',
content='当前有未完成的挑战，切换坐骑将清除记录，是否切换？',
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function()
airGameEnterModel:setCancelContinueFlag(true)
airController:clearActorDataAndProcessData()
func()
end,
showclosebtn=true,
}
local comfirmDialogEnter=UIDialogManager.newDialog(showdata)
comfirmDialogEnter:show()
else
func()
end
end

item:SetChildButtonClick(CmpMountItemSlotIndex.removeBtn,function()
dialougeFunc(removeMountFunc)
end,true)

item:SetChildButtonClick(CmpMountItemSlotIndex.equipBtn,function()
dialougeFunc(setMountFunc)
end,true)
end

function UIAirGameSelectMountWin:onStartAction()

end




