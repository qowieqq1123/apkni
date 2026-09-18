







def_class("UICatEntrustSelectWtWin",UIWindowBase)









function UICatEntrustSelectWtWin:bindComponents()

self.okBtn=UIButton.get(self,0)
self.Root=UIObject.get(self,1)
self.tipbtn=UIButton.get(self,2)
self.uiRoot=UIObject.get(self,3)
self.wtTypeList=UIObject.get(self,4)
self.wtTypeScrollView=UIObject.get(self,5)

self.okBtn:setButtonClick(function()self:onOkBtn()end)

self.tipbtn:setButtonClick(function()self:onTipbtn()end)



end


function UICatEntrustSelectWtWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.okBtn);self.okBtn=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.tipbtn);self.tipbtn=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.wtTypeList);self.wtTypeList=nil;
_UIObject_release(self.wtTypeScrollView);self.wtTypeScrollView=nil;
end
















local typeSlotTtileSizeY=50
local typeSlotTipSizeY=30
local typeSlotNoTipSizeY=30
local typeSlotWtListSizeX=1004
local wtInfoSlotItemSizeX=186
local wtInfoSlotItemSizeY=180
local lineNum=Mathf.Floor(typeSlotWtListSizeX/wtInfoSlotItemSizeX)


local CmpTypeSelectSlotItemIndex={
title=0,
list=1,
tip=2,
tipBtn=3,
noTip=4,
}

local CmpWtSlotItemIndex={
exInfo=0,
icon=1,
mjType=2,
yyhyModel=3,
name=4,
select=5,
lock=6,
unlockTip=7,
Probenum=8,
black=9,
}


local wtSlotType={
ZMMJ=1,
ZMSW=2,
YYHY=3,
SGXD=4,
}

local fillZMMJItem=function(index,item,slotData)
local wtFuncObj=catEntrustConfig.getEntrustFuncObj(slotData.type)


local iconNameId=wtFuncObj.getIcon(slotData.data)
item:SetChildCSImageIcon(CmpWtSlotItemIndex.icon,iconNameId,true)


item:SetChildActive(CmpWtSlotItemIndex.mjType,true)
local exIconName,exAb=wtFuncObj.getExInfoIcon(slotData.data)
item:SetChildCSImageSprite(CmpWtSlotItemIndex.mjType,exAb,exIconName)


local nameInfo=wtFuncObj.getName(slotData.data)
item:SetChildText(CmpWtSlotItemIndex.name,nameInfo)
local probenum,probeNumtext=wtFuncObj.getProbenum(slotData.data)
if probenum==-1 then
item:SetChildActive(CmpWtSlotItemIndex.Probenum,false)
else
item:SetChildActive(CmpWtSlotItemIndex.Probenum,true)
item:SetChildText(CmpWtSlotItemIndex.Probenum,probeNumtext)
if probenum==0 then
item:SetChildActive(CmpWtSlotItemIndex.black,true)
end
end


end

local fillZMSWItem=function(index,item,slotData)
local type=slotData.type
local wtFuncObj=catEntrustConfig.getEntrustFuncObj(type)


local iconName,ab=wtFuncObj.getIcon(slotData.data)
item:SetChildCSImageSprite(CmpWtSlotItemIndex.icon,ab,iconName)


local nameInfo=wtFuncObj.getName(slotData.data)
item:SetChildText(CmpWtSlotItemIndex.name,nameInfo)
item:SetChildActive(CmpWtSlotItemIndex.Probenum,false)
end

local fillYYHYItem=function(index,item,slotData)
local wtFuncObj=catEntrustConfig.getEntrustFuncObj(Entrust_Type.YYHY)


local iconName=wtFuncObj.getIcon(slotData.data)
item:SetChildCSImageIcon(CmpWtSlotItemIndex.icon,iconName)


item:SetChildActive(CmpWtSlotItemIndex.yyhyModel,true)
local exIconName,exAb=wtFuncObj.getExInfoIcon(slotData.data)
item:SetChildCSImageSprite(CmpWtSlotItemIndex.yyhyModel,exAb,exIconName)


local nameInfo=wtFuncObj.getName(slotData.data)
item:SetChildText(CmpWtSlotItemIndex.name,nameInfo)
item:SetChildActive(CmpWtSlotItemIndex.Probenum,false)
end

local fillSGXDItem=function(index,item,slotData)
local data=slotData.data
local fbData=data.fbData
local wtFuncObj=catEntrustConfig.getEntrustFuncObj(Entrust_Type.SGXD)
local iconid=wtFuncObj.getIcon(data)
item:SetChildCSImageIcon(CmpWtSlotItemIndex.icon,iconid,true)
item:SetChildText(CmpWtSlotItemIndex.name,fbData.name)
item:SetChildActive(CmpWtSlotItemIndex.Probenum,false)
end

local wtFunc={
[wtSlotType.ZMMJ]={
titleName='资源秘境',
getItemData=function()
return catEntrustModel:getResourceMiJingData()
end,
fillItem=fillZMMJItem,
isShowTip=true,
tipInfo='(猫猫委托不会完成秘境中的随机事件哦)',
isShowInfoBtn=false,
checkClick=function(wtData)
if wtData.isLock then
local typeFuncs=catEntrustConfig.getEntrustFuncObj(wtData.type)
local name=typeFuncs.getName(wtData.data)
local tipInfo=FMT.fmt("挑战通关{0}后解锁",name)
UIManager.error(tipInfo)
end
if wtData.type==Entrust_Type.LSMJ then
local typeFuncs=catEntrustConfig.getEntrustFuncObj(wtData.type)
local num=typeFuncs.getProbenum(wtData.data)
if num==0 then

UIManager.error("当前已无探索次数，暂不可挑战")
return false
end
end

return not wtData.isLock
end,
noDataTip=function()return'暂无可委托资源秘境'end,
},
[wtSlotType.ZMSW]={
titleName='宗门事务',
getItemData=function()
return catEntrustModel:getZMAffairListData()
end,
fillItem=fillZMSWItem,
isShowTip=true,
tipInfo='',
isShowInfoBtn=false,
checkClick=function(wtData)
if wtData.isLock then
local typeFuncs=catEntrustConfig.getEntrustFuncObj(wtData.type)
local name=typeFuncs.getName(wtData.data)
local tipInfo
if wtData.type==Entrust_Type.WDLT then
tipInfo=FMT.fmt("{0}{1}",name,wtData.unlockTip)
elseif wtData.type==Entrust_Type.ZMTY then
tipInfo=FMT.fmt("{0}{1}",name,wtData.unlockTip)
end
if tipInfo then
UIManager.error(tipInfo)
end
end
return not wtData.isLock
end,
noDataTip=function()return'暂无宗门事务委托'end
},
[wtSlotType.YYHY]={
titleName='以渔会友',
getItemData=function()

return catEntrustModel:getYYHYListData()
end,
fillItem=fillYYHYItem,
isShowTip=true,
tipInfo='',
isShowInfoBtn=false,
checkClick=function(wtData)
if wtData.isLock then
local typeFuncs=catEntrustConfig.getEntrustFuncObj(wtData.type)
local name=typeFuncs.getName(wtData.data)
local tipInfo=FMT.fmt("{0}{1}",name,wtData.unlockTip)
UIManager.error(tipInfo)
end
return not wtData.isLock
end,
noDataTip=function()
local leftTime=limitActivitiesModel:getActStartLeftTime(LIMIT_ACT_TYPE.eYiYuHuiYou)
local noDataTip=catEntrustConfig.getWeakAndHourInfoToLeftTime(leftTime)
return noDataTip
end
},
[wtSlotType.SGXD]={
titleName='上古险地',
getItemData=function()

return catEntrustModel:getSGXD_Data()
end,
fillItem=fillSGXDItem,
isShowTip=true,
tipInfo='',
isShowInfoBtn=false,
checkClick=function(wtData)
return true
end,
noDataTip=function()
return'暂无宗门事务委托'
end
},
}






function UICatEntrustSelectWtWin:onLoaded(...)
self:bindComponents()

self.selectWt={}

self.selectWtTIndex=0
self.selectWtIdx=0
end


function UICatEntrustSelectWtWin:__delete()
self:unbindComponents()
end




function UICatEntrustSelectWtWin:onShow(argtable,afterOnloaded)
self.wtSlotId=argtable.wtSlotId
self.parentWin=argtable.parentWin
self.tempWt=argtable.tempWt

self.wtSlotData=self.tempWt or catEntrustModel:getWtSlotDataById(self.wtSlotId)

self:refreshList()
end


function UICatEntrustSelectWtWin:onHide()

end


function UICatEntrustSelectWtWin:refreshList()

self.typeList={}

for type,funcs in ipairs(wtFunc)do
local data=funcs.getItemData()
if#data>0 then
self.typeList[#self.typeList+1]={type=type,data=data}
end
end

self:refreshScrollViewRectSize()

self.wtTypeList:setChildSizeDelta(0,self.totalSizeY)

local typeLen=#self.typeList
local _this=self
self.wtTypeList:setChildLayoutGroupCreateItems(typeLen,function(index)
local typeItem=self.wtTypeList:getChildLayoutGroupGridItem(index-1)

local typeData=self.typeList[index]
local funcs=wtFunc[typeData.type]


typeItem:SetChildText(CmpTypeSelectSlotItemIndex.title,funcs.titleName)


typeItem:SetChildActive(CmpTypeSelectSlotItemIndex.tip,funcs.isShowTip)
typeItem:SetChildText(CmpTypeSelectSlotItemIndex.tip,funcs.tipInfo)


typeItem:SetChildActive(CmpTypeSelectSlotItemIndex.tipBtn,funcs.isShowInfoBtn)
if funcs.isShowInfoBtn then
typeItem:SetChildButtonClick(CmpTypeSelectSlotItemIndex.tipBtn,funcs.clickInfoBtnFunc,true)
end


local wtInfoLen=#typeData.data
typeItem:SetChildLayoutGroupCreateItems(CmpTypeSelectSlotItemIndex.list,wtInfoLen,function(wtIndex)

local wtItem=typeItem:GetChildLayoutGroupGridItem(CmpTypeSelectSlotItemIndex.list,wtIndex-1)
local wtData=typeData.data[wtIndex]

funcs.fillItem(wtIndex,wtItem,wtData)

local isSelect=_this.selectWtTIndex==index and _this.selectWtIdx==wtIndex
wtItem:SetChildActive(CmpWtSlotItemIndex.select,isSelect)

wtItem:SetChildActive(CmpWtSlotItemIndex.lock,wtData.isLock)
if wtData.isLock then
wtItem:SetChildText(CmpWtSlotItemIndex.unlockTip,wtData.unlockTip or"")
end

wtItem:SetBaseItemClickEvent(-1,function()
if funcs.checkClick(wtData)then
if _this.selectWtTIndex~=index or _this.selectWtIdx~=wtIndex then
if self.selectWtTIndex~=0 and self.selectWtIdx~=0 then
local preTypeItem=self.wtTypeList:getChildLayoutGroupGridItem(_this.selectWtTIndex-1)
local preWtItem=preTypeItem:GetChildLayoutGroupGridItem(CmpTypeSelectSlotItemIndex.list,_this.selectWtIdx-1)
preWtItem:SetChildActive(CmpWtSlotItemIndex.select,false)
end

_this.selectWtType=typeData.type
_this.selectWtTIndex=index
_this.selectWtIdx=wtIndex
wtItem:SetChildActive(CmpWtSlotItemIndex.select,true)
end
end
end)
end)


local isShowNotTip=wtInfoLen==0
typeItem:SetChildActive(CmpTypeSelectSlotItemIndex.noTip,isShowNotTip)
if isShowNotTip then
typeItem:SetChildText(CmpTypeSelectSlotItemIndex.noTip,funcs.noDataTip())
end


typeItem:SetChildSizeDelta(-1,typeSlotWtListSizeX,_this.slotHeightList[index])
end)

end

function UICatEntrustSelectWtWin:refreshScrollViewRectSize()
self.slotHeightList={}
self.totalSizeY=0

for index,typeData in ipairs(self.typeList)do
local dataLen=#typeData.data
local funcs=wtFunc[typeData.type]

local sizeY=typeSlotTtileSizeY



sizeY=sizeY+(dataLen==0 and typeSlotNoTipSizeY or 0)

local listYLen=Mathf.Ceil(dataLen/lineNum)
sizeY=sizeY+listYLen*wtInfoSlotItemSizeY

self.slotHeightList[index]=sizeY
self.totalSizeY=self.totalSizeY+sizeY
end
end





function UICatEntrustSelectWtWin:onOkBtn()
if self.selectWtTIndex==0 and self.selectWtIdx==0 then
UIManager.info('请先选择委托')
return
end
local _this=self

local typeData=_this.typeList[_this.selectWtTIndex]
local slotData=typeData.data[_this.selectWtIdx]
local wtSlotData=_this.wtSlotData
local typeFuncs=catEntrustConfig.getEntrustFuncObj(slotData.type)

if not typeFuncs.checkComfireWt(wtSlotData)then
return
end

local callback=function()
if _this==nil then return end
catEntrustModel:setFillWtSlotData(wtSlotData,slotData.type,slotData.data)

_this.parentWin:onClickClose()
catEntrustConfig.doNextProgress(wtSlotData)
end


if typeFuncs.checkSelectWtIsCanNext(slotData.data)then
typeFuncs.checkShowGoUnlockNextDialouge(slotData.data,callback)
else
callback()
end
end



function UICatEntrustSelectWtWin:onTipbtn()
local d={}
d.mode=3
d.title="说明"
d.name='cat_entrust_select_wt_rule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end
