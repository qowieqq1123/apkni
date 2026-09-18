







def_class("UIDiscipleFashionClothResetWin",UIWindowBase)









function UIDiscipleFashionClothResetWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.costInfo=UILinkImageText.get(self,1)
self.curModel=UIObject.get(self,2)
self.curModelRoot=UIObject.get(self,3)
self.curStarList=UIObject.get(self,4)
self.desc=UIText.get(self,5)
self.infoRoot=UIObject.get(self,6)
self.resetBtn=UIButton.get(self,7)
self.resetDesc=UIText.get(self,8)
self.resetModel=UIObject.get(self,9)
self.resetModelRoot=UIObject.get(self,10)
self.resetScrollView=UIObject.get(self,11)
self.resetStarList=UIObject.get(self,12)
self.returnTip=UIText.get(self,13)
self.Root=UIObject.get(self,14)
self.title=UIText.get(self,15)
self.uiRoot=UIObject.get(self,16)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.resetBtn:setButtonClick(function()self:onResetBtn()end)



end


function UIDiscipleFashionClothResetWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.costInfo);self.costInfo=nil;
_UIObject_release(self.curModel);self.curModel=nil;
_UIObject_release(self.curModelRoot);self.curModelRoot=nil;
_UIObject_release(self.curStarList);self.curStarList=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.infoRoot);self.infoRoot=nil;
_UIObject_release(self.resetBtn);self.resetBtn=nil;
_UIObject_release(self.resetDesc);self.resetDesc=nil;
_UIObject_release(self.resetModel);self.resetModel=nil;
_UIObject_release(self.resetModelRoot);self.resetModelRoot=nil;
_UIObject_release(self.resetScrollView);self.resetScrollView=nil;
_UIObject_release(self.resetStarList);self.resetStarList=nil;
_UIObject_release(self.returnTip);self.returnTip=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _this
local _starLen=5




function UIDiscipleFashionClothResetWin:onLoaded(...)
self:bindComponents()

_this=self
end


function UIDiscipleFashionClothResetWin:__delete()
self:unbindComponents()

UIManager:closeWindow('UITopMoneyWin2')
end




function UIDiscipleFashionClothResetWin:onShow(argtable,afterOnloaded)
self.itemguid=argtable.itemguid
self.itemid=argtable.itemid

self.curStar=ClothingModel:getStarLv(self.itemguid)

self:refreshAll()

UIManager:showWindow('UITopMoneyWin2',{{eMoneyType.mtXianYu},{eMoneyType.mtLingYu},})

if argtable and argtable.cb then
argtable.cb()
end
end


function UIDiscipleFashionClothResetWin:onHide()

end

function UIDiscipleFashionClothResetWin:refreshAll()


self:refreshModels()


self:refreshResetInfo()
end

function UIDiscipleFashionClothResetWin:refreshModels()

local curModelParams=self:getModelParams(self.itemguid,self.itemid,self.curStar)
self:setModel(self.curModel:getID(),curModelParams)

self.curStarList:setChildLayoutGroupCreateItems(_starLen,function(index)
local item=self.curStarList:getChildLayoutGroupGridItem(index-1)

local isShowStar=index<=self.curStar
item:SetChildActive(0,isShowStar)
end)


local curModelParams=self:getModelParams(self.itemguid,self.itemid,0)
self:setModel(self.resetModel:getID(),curModelParams)

self.resetStarList:setChildLayoutGroupCreateItems(_starLen,function(index)
local item=self.resetStarList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(0,false)
end)
end

function UIDiscipleFashionClothResetWin:refreshResetInfo()

local format="<color=#ca631d>重置灵玉消耗与时装星级相关。</color>重置后，将<color=#ca631d>{0}</color>时装的\n星级重置为0星，并<color=#ca631d>返还</color>升星所消耗的<color=#ca631d>时装</color>"
local itemName=itemsModel.getName(self.itemid)
local desc=FMT.fmt(format,itemName)
self.desc:setText(desc)


local rewardList=self:getRewardList()
local rewardLen=#rewardList
self.resetScrollView:setChildScrollViewCreateGrids(rewardLen,rewardLen)
local grids=self.resetScrollView:getChildScrollViewItemWidgets()

for i=1,rewardLen do
local item=grids[i-1]
local data=rewardList[i]

local itemid=data[1]
local itemcount=data[2]
local showCountBG=itemcount>1

local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,propData)

item:SetBaseItemClickEvent(0,function()
itemsComponentHelper.onItemClick(itemid)
end)
end


local commonCfg=ClothingConfig.getCommonConfig()
local resetCost=commonCfg.reset[self.curStar]

local costItemId=resetCost[1]
local costItemNum=resetCost[2]
local hasNum=itemsModel.getCount(costItemId)
local iconname=iconHelper.getIconName(costItemId)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,30)
local numStr=hasNum>=costItemNum and costItemNum or toColorString(FONT_COLOR.eRedColor,costItemNum)
local str=FMT.fmt('{0}  {1}',iconStr,numStr)

self.costInfo:setText(str)
end



function UIDiscipleFashionClothResetWin:setModel(objId,modelParams)
local modelID=modelParams.model
local defsize=cfgHelper.get2(cfg_dbbodyconfig_get,modelID,'scales')or{}

local size=0.7
local componnets=modelParams.component or{}
local animationID=modelParams.ani or 0
local offset=modelParams.offset
self.winlua:SetChildUIModelShowTarget(objId,modelID,size*2,componnets,animationID)
if offset then
self.winlua:SetChildUIModelShowTargetOffset(objId,offset[1],offset[2])
end
end


function UIDiscipleFashionClothResetWin:getModelParams(itemguid,itemid,star)
local model
if itemguid then
local diziguid=ClothingModel:getDiziguidByItemguid(itemguid)
local switchidx=ClothingModel:getEquipSwitchIdx(itemguid)
model=self:getModelArgs(itemid,star,diziguid,switchidx)
else
model=self:getModelArgs(itemid,star)
end
return model
end

function UIDiscipleFashionClothResetWin:getModelArgs(itemid,star,diziguid,switchidx)
if diziguid then
local modelInfo=UIDiscipleModel:getDiscipleOutsideModelInfo(diziguid,nil,nil,{clothingId=itemid,clothingStar=star},switchidx)
return{model=modelInfo.body,component=modelInfo.componets}
else
star=star or 0
if ClothingConfig.isStarMaxLv(itemid,star)then
return itemsConfig.getConfig(itemid).model[2]
else
return itemsConfig.getConfig(itemid).model[1]
end
end

end


function UIDiscipleFashionClothResetWin:getRewardList()
local baseCfg=ClothingConfig.getCommonConfig()
local isEquiped=ClothingModel:isEquipedOnAnyDizi(_this.itemguid)
local costList={}
local itemDataStruct

if isEquiped then
local dzguid=ClothingModel:getDiziguidByItemguid(_this.itemguid)
local equip=ClothingModel:getEquipByDizi(dzguid)



itemDataStruct=equip
else
itemDataStruct=itemsModel.getItem(self.itemguid)
end

if itemDataStruct then
local itemData=itemDataStruct.itemData
if itemData and itemData.consumeListLen and itemData.consumeListLen>0 then
costList=itemData.consumeLlist
end
end


local rewardList={}
local rewardLooup={}

local reset_spe_ret=baseCfg.reset_spe_ret or{}


if reset_spe_ret[self.itemid]then
local ritemid=reset_spe_ret[self.itemid]
local consume=ClothingConfig.getCommonConfig().consume
for index=0,self.curStar-1 do
for cindex=1,consume[index]do
table.insert(rewardList,{ritemid,1})
end
end
else
local consume=ClothingConfig.getCommonConfig().consume
for index=0,self.curStar-1 do
for cindex=1,consume[index]do
table.insert(rewardList,{self.itemid,1})
end
end
end
for itemId,itemNum in pairs(rewardLooup)do
table.insert(rewardList,{itemId,itemNum})
end

for dindex,item in pairs(costList)do
table.insert(rewardList,{item.param_1,item.param_2})
end


table.sort(rewardList,function(a,b)
return a[1]>b[1]
end)

return rewardList
end





function UIDiscipleFashionClothResetWin:onCloseBtn()
self:closeSelf()
end



function UIDiscipleFashionClothResetWin:onResetBtn()
if not self:checkIsNowSwitchDisciple()then
UIManager.error("该弟子并非当前使用的职业，无法重置星级")
return
end

local commonCfg=ClothingConfig.getCommonConfig()
local resetCost=commonCfg.reset[self.curStar]
local costItemId=resetCost[1]
local costItemNum=resetCost[2]

local hasNum=itemsModel.getCount(costItemId)
local iconname=iconHelper.getIconName(costItemId)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,30)
local numStr=hasNum>=costItemNum and costItemNum or toColorString(FONT_COLOR.eRedColor,costItemNum)

local content=FMT.fmt('是否花费{0}{1}进行时装重置',iconStr,numStr)

local dialougeCallBack=function()
local cb=function()
local isEquiped=ClothingModel:isEquipedOnAnyDizi(_this.itemguid)
if isEquiped then
local dzguid=ClothingModel:getDiziguidByItemguid(_this.itemguid)
ClothingController.reqDiscipleFashionReset(dzguid,1)
else
ClothingController.reqDiscipleFashionReset(_this.itemguid,0)
end
end

moneySystem:useMoney(costItemId,costItemNum,cb,WARNING_TYPE.eWarning)
end

local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eDiscipleFashionReset)
if flag then
dialougeCallBack()
return
end

local choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eDiscipleFashionReset,flag)
end

local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=content,
oktext="确定",
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
dialougeCallBack()
end,
showclosebtn=true,
choosetext="今日不再显示",
choosecallback=choosecallback,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()

end



function UIDiscipleFashionClothResetWin:checkIsNowSwitchDisciple()
local itemguid=self.itemguid
if itemguid then
local diziguid=ClothingModel:getDiziguidByItemguid(itemguid)
if diziguid then
local switchidx=ClothingModel:getEquipSwitchIdx(itemguid)
if switchidx and switchidx~=0 then
return false
end
end
end
return true
end
