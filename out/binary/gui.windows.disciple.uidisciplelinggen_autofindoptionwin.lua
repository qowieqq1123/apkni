







def_class("UIDiscipleLinggen_AutoFindOptionWin",UIWindowBase)









function UIDiscipleLinggen_AutoFindOptionWin:bindComponents()

self.addBtn=UIButton.get(self,0)
self.bgModel=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.confirmBtn=UIButton.get(self,3)
self.handleImg=UIObject.get(self,4)
self.handleImg2=UIObject.get(self,5)
self.icon=UIObject.get(self,6)
self.maxText=UIText.get(self,7)
self.mibaofuroot=UIObject.get(self,8)
self.option_1=UIBaseItem.get(self,9)
self.option_2=UIBaseItem.get(self,10)
self.option_3=UIBaseItem.get(self,11)
self.optionRoot=UIObject.get(self,12)
self.Root=UIObject.get(self,13)
self.selectCntSlider=UIObject.get(self,14)
self.selectCntTxt=UIText.get(self,15)
self.sliderRect=UIObject.get(self,16)
self.sliderRoot=UIObject.get(self,17)
self.subBtn=UIButton.get(self,18)
self.tips=UILinkImageText.get(self,19)
self.uiRoot=UIObject.get(self,20)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.confirmBtn:setButtonClick(function()self:onConfirmBtn()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)
self.option={
self.option_1,
self.option_2,
self.option_3,
}



end


function UIDiscipleLinggen_AutoFindOptionWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.confirmBtn);self.confirmBtn=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.handleImg2);self.handleImg2=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.maxText);self.maxText=nil;
_UIObject_release(self.mibaofuroot);self.mibaofuroot=nil;
_UIObject_release(self.option_1);self.option_1=nil;
_UIObject_release(self.option_2);self.option_2=nil;
_UIObject_release(self.option_3);self.option_3=nil;
_UIObject_release(self.optionRoot);self.optionRoot=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.selectCntTxt);self.selectCntTxt=nil;
_UIObject_release(self.sliderRect);self.sliderRect=nil;
_UIObject_release(self.sliderRoot);self.sliderRoot=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
self.option=nil;
end
















local _this

local _CmpbriedSlotItemIndex={
bg=0,
dikuang=1,
icon=2,
name=3,
select=4,
}

local _modeType={
normal=1,
vary=2,
}

local _stageType={
gongfa=1,
commonHiddenSkill=2,
varyGongFa=3,
varyCommonHiddenSkill=4,
}

local _freshItemFuncs={
[_stageType.gongfa]={
frsehItem=function(self,index,item,data)
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,data[1])

item:SetChildText(_CmpbriedSlotItemIndex.name,cfg.name)
local gfIcon=iconHelper.getGongFaIcon(cfg.icon)
item:SetChildIcon(_CmpbriedSlotItemIndex.icon,gfIcon,false)
end,
showTips=function(self,data)
UIManager:showWindow("UIDiscipleLinggen_LookGFHideSkillWin",{gfID=data[1],disciple_guid=self.discipleGuid,varyVal=1})
end,
},
[_stageType.commonHiddenSkill]={
frsehItem=function(self,index,item,data)
item:SetChildText(_CmpbriedSlotItemIndex.name,data.name)
local iconName=iconHelper.getSkillIcon(data.icon)
item:SetChildIcon(_CmpbriedSlotItemIndex.icon,iconName,false)
end,
showTips=function(self,data)
local boardList={}

local commonList=UIDiscipleModel:get_hiddenSkillLookup_Common()

for groupId,group in pairs(commonList)do
if groupId~=0 then
boardList[#boardList+1]=group[1]
end
end

table.sort(boardList,function(a,b)
return a.id<b.id
end)

self:showWindow("UIDiscipleLinggen_LookHideSkillListWin",{
mcList=boardList,
index=1
})
end,
},
[_stageType.varyGongFa]={
frsehItem=function(self,index,item,data)



local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,data[1])
item:SetChildText(_CmpbriedSlotItemIndex.name,cfg.name)
local icon=iconHelper.getSkillIcon(cfg.icon)
item:SetChildIcon(_CmpbriedSlotItemIndex.icon,icon,false)
end,
showTips=function(self,data)
UIManager:showWindow("UIDiscipleLinggen_LookGFHideSkillWin",{gfID=data[1],disciple_guid=self.discipleGuid,varyVal=2})
end,
},
[_stageType.varyCommonHiddenSkill]={
frsehItem=function(self,index,item,data)
item:SetChildText(_CmpbriedSlotItemIndex.name,data.name)
local iconName=iconHelper.getSkillIcon(data.icon)
item:SetChildIcon(_CmpbriedSlotItemIndex.icon,iconName,false)
end,
showTips=function(self,data)
local boardList={}

local varyList=UIDiscipleModel:get_Vary_Common_HiddenSkillLookUp_Color(self.discipleGuid)

for groupId,group in pairs(varyList)do
boardList[#boardList+1]=group[1]
end

table.sort(boardList,function(a,b)
return a.id<b.id
end)

self:showWindow("UIDiscipleLinggen_LookHideSkillListWin",{
mcList=boardList,
index=1
})
end,
},
}



function UIDiscipleLinggen_AutoFindOptionWin:onLoaded(...)
self:bindComponents()

_this=self


self.optionDataList={}
self.colorList={}


self.selectCnt=1
self.isFirstInitSlider=true

local wb=self.mibaofuroot:getWidgetBase()
wb:SetBaseItemClickEvent(-1,function()
self:activeUseItemPanel()
end)
end


function UIDiscipleLinggen_AutoFindOptionWin:__delete()

_this=nil

self:unbindComponents()
end




function UIDiscipleLinggen_AutoFindOptionWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.bgModel:setChildUIModelShowTarget(6163,1,nil,eAnimationID.enter)
self.uiRoot:setChildCanvasGroupAlpha(0)
self:delayDo(0.4,function()
if self and not self.isClose then
self.uiRoot:setChildCanvasGroupDOFade(1,0.5)
end
end)
end

self.discipleGuid=argtable.discipleGuid
self.modeType=argtable.modeType
self.optionDataList=argtable.optionDataList or{}
self.colorList=argtable.colorDataList or{}
self.autoCountRecord=argtable.autoCountRecord
self.boardPosData=argtable.boardPosData
self.useItemData=argtable.useItemData

self.isVary=self.modeType==2
if self.isVary then
self.search=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'varysearch')
else
self.search=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'search')
end

self:freshAll()
end


function UIDiscipleLinggen_AutoFindOptionWin:onHide()

end

function UIDiscipleLinggen_AutoFindOptionWin:freshAll()
self:refreshOptions()
self:refreshSlider()
self:refreshButton()

self:refreshItemSlot()
end

function UIDiscipleLinggen_AutoFindOptionWin:refreshItemSlot()
local list=UIDiscipleModel:getUseItemList(self.discipleGuid,self.boardPosData.pos)
local hasItem=#list>0
local isFree=UIDiscipleModel:checkDiscipleHoardFree(self.discipleGuid,self.boardPosData.pos,true)
self.mibaofuroot:setActive(hasItem and not isFree and self.boardPosData.pos>0)
local wb=self.mibaofuroot:getWidgetBase()
wb:SetChildActive(0,self.useItemData==nil)
wb:SetChildActive(1,self.useItemData~=nil)
wb:SetChildActive(2,self.useItemData~=nil)
wb:SetChildActive(5,self.useItemData~=nil)
if#list>0 then
if self.useItemData then

local itemCfg=itemsConfig.getConfig(self.useItemData.itemid)
local desc=itemCfg.funcparam and itemCfg.funcparam.desc or''
wb:SetChildText(3,desc)
local itemIconName=itemsModel.getItemIconName(self.useItemData.itemid)
wb:SetChildIcon(1,itemIconName,false)

local count=itemsModel.getCount(self.useItemData.itemid)
local isShow=count>1
wb:SetChildActive(4,isShow)
if isShow then
wb:SetChildText(4,FMT.fmt("剩余数量：{0}",count))
end
wb:SetChildButtonClick(5,function()
if not _this then return end

_this.useItemData=nil

_this:refreshItemSlot()
_this:refreshSlider()
end,true)
else
wb:SetChildActive(4,false)
end
end
end

function UIDiscipleLinggen_AutoFindOptionWin:activeUseItemPanel()
local args={
disciple_guid=self.discipleGuid,
boardPosData=self.boardPosData,
parentWin=self,
useItemData=self.useItemData,
}
self:showWindow("UIDiscipleLinggen_SelectMiBaoFuSelectWin",args)
end

function UIDiscipleLinggen_AutoFindOptionWin:setUseItemData(useItemData)
self.useItemData=useItemData

if next(_this.optionDataList)and self.useItemData and self.useItemData.condition.element then

local result,tempList=self:checkGFElementToUseItem()

if result then

local showdata=
{
type='UIDialouge',
title='提示',
content="存在功法与明灵符互斥，是否继续使用，继续使用将剔除互斥功法",
oktext='确定',
canceltext='取消',
allowclickBG='false',
showclosebtn=true,
okcallback=function()
_this.optionDataList=tempList
_this:refreshOptions()
_this:refreshItemSlot()
_this:refreshSlider()
end,
cancelcallback=function()
_this.useItemData=nil
end
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()

return
end
end

self:refreshItemSlot()
self:refreshSlider()
end





function UIDiscipleLinggen_AutoFindOptionWin:onAddBtn()
if self.selectCnt==0 then
gainControl:showGainWin(self.search[1][1])
return
end
local cnt=self.selectCnt
if cnt>=self.max then
return
end
self.widget:SetChildSliderValue(self.selectCntSlider:getID(),cnt+1)
end



function UIDiscipleLinggen_AutoFindOptionWin:onConfirmBtn()

if self.selectCnt==0 then
gainControl:showGainWin(self.search[1][1])
return
end

if#self.optionDataList>0 then

self:showWindow("UIDiscipleLinggen_SelectAutoFindQualityWin",{
discipleGuid=self.discipleGuid,
optionDataList=self.optionDataList,
colorList=self.colorList,
autoCount=self.selectCnt,
modeType=self.modeType,
useItemData=self.useItemData,
})
else
UIManager.error("请先选择功法秘藏或通用秘藏")
end
end



function UIDiscipleLinggen_AutoFindOptionWin:onSubBtn()
local cnt=self.selectCnt
if cnt<=self.min then
return
end
self.widget:SetChildSliderValue(self.selectCntSlider:getID(),cnt-1)
end

function UIDiscipleLinggen_AutoFindOptionWin:onCloseBtn()
self:closeSelf()
end

function UIDiscipleLinggen_AutoFindOptionWin:onReturnBtn()






local args={}
args.titleName='选择秘藏'
args.extraWin='UIDiscipleLinggen_SelectAutoFindOptionWin'
local extraParams={
discipleGuid=self.discipleGuid,
optionDataList=table.weakCopy(self.optionDataList),
modeType=self.modeType,
useItemData=self.useItemData
}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageTwoWin',args)
end


function UIDiscipleLinggen_AutoFindOptionWin:freshOptionData(optionDataList)
self.optionDataList=optionDataList

self:refreshOptions()
end



function UIDiscipleLinggen_AutoFindOptionWin:refreshOptions()
local data
for opIndex,opItem in ipairs(self.option)do
data=self.optionDataList[opIndex]
self:freshOption(opIndex,opItem,data)
end
end

function UIDiscipleLinggen_AutoFindOptionWin:freshOption(opIndex,opItem,data)
local isHasData=data~=nil

local opItemWidget=opItem:getWidgetBase()

opItemWidget:SetChildActive(0,not isHasData)
opItemWidget:SetChildActive(1,isHasData)
opItemWidget:SetChildActive(2,isHasData)

local type
if isHasData then
type=data[2]
local item=opItemWidget:GetChildWidgetBase(1)
_freshItemFuncs[type].frsehItem(self,opIndex,item,data)

item:SetChildActive(1,self.modeType==1)
item:SetChildActive(4,self.modeType==2)
end

local func=function()



self:onReturnBtn()

end

local changeFunc=function()
if isHasData then
self:onReturnBtn()
end
end

local longfunc=function()
if isHasData then
_freshItemFuncs[type].showTips(self,data)
end
end

opItemWidget:SetBaseItemClickEvent(-1,func)
opItemWidget:SetBaseItemClickEvent(1,func)
opItemWidget:SetBaseItemLongTouchEvent(1,longfunc)
opItemWidget:SetChildButtonClick(2,changeFunc)
end


function UIDiscipleLinggen_AutoFindOptionWin:refreshSlider()

local min,max,cnt=self:getSliderInitData()

if self.useItemData then
local itemCount=itemsModel.getCount(self.useItemData.itemid)
max=Mathf.Min(itemCount,max)

cnt=Mathf.Min(itemCount,self.selectCnt)
end

self.min=min
self.max=max
self.selectCnt=cnt

self:setSliderVal(self.min,self.max)

self:refreshCost()
end

function UIDiscipleLinggen_AutoFindOptionWin:getSliderInitData()

local moneyId=self.search[1][1]
local needNum=self.search[1][2]

local discount=mzbkModel:getTeQuanFindMoneyDiscount(self.isVary)
needNum=needNum*discount
local hasNum=itemsModel.getCount(moneyId)

local maxCount=mathHelper.safe_floor(hasNum/needNum)
maxCount=Mathf.Max(1,maxCount)
local autoFindCountMax=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'autoFindCountMax')
maxCount=Mathf.Min(autoFindCountMax,maxCount)

local defaultCnt=self.autoCountRecord and Mathf.Min(maxCount,self.autoCountRecord)or 1
if not itemsModel:canUseItem(moneyId,needNum)then
defaultCnt=0
end

return 1,maxCount,defaultCnt
end

function UIDiscipleLinggen_AutoFindOptionWin:setSliderVal(min,max)
self.widget:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,min,max,function(val)self:onSliderChange(val)end)
self.maxText:setText(max)
self.selectCntTxt:setText(self.selectCnt)









end

function UIDiscipleLinggen_AutoFindOptionWin:onSliderChange(value)
if self.selectCnt==0 then

return
end
local oldCnt=self.selectCnt
self.selectCnt=value
if oldCnt~=self.selectCnt then
self:refreshCost()
end
end


function UIDiscipleLinggen_AutoFindOptionWin:refreshCost()
local moneyId=self.search[1][1]
local needNum=self.search[1][2]

local discount=mzbkModel:getTeQuanFindMoneyDiscount(self.isVary)
local totalNum=self.selectCnt*needNum*discount
local hasNum=itemsModel.getCount(moneyId)

local isEnough=hasNum>=totalNum
local costColor=mzbkModel:checkActiveTeQuan()and"#f1ce78"or'#76d81e'
local color=isEnough and costColor or'#c82c2c'
local itemIcon=itemsModel.getItemIconName(moneyId)
self.icon:setIcon(itemIcon,false)

local tips=FMT.fmt("将花费<color=#00000000>____</color>{0}自动搜寻{1}次选择的秘藏",toColorStringX(color,totalNum),toColorStringX('#fd8950',self.selectCnt))
self.tips:setText(tips)

self.selectCntTxt:setText(self.selectCnt)
end


function UIDiscipleLinggen_AutoFindOptionWin:refreshButton()
self.confirmBtn:setGray(self.selectCnt==0)
end

function UIDiscipleLinggen_AutoFindOptionWin:checkGFElementToUseItem()
local tempList={}

local isPass
local isHasNoPass
for index,gfData in pairs(self.optionDataList)do
isPass=true
local type=gfData[2]
if type==_stageType.gongfa then
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfData[1])
local isOK=table.containsValue(cfg.element,self.useItemData.condition.element)
isPass=isOK
if not isOK then
isHasNoPass=true
end
end

if type==_stageType.commonHiddenSkill then
if self.useItemData and self.useItemData.condition.element then
isPass=false
isHasNoPass=true
end
end

if isPass then
tempList[#tempList+1]=gfData
end
end

return isHasNoPass,tempList
end

