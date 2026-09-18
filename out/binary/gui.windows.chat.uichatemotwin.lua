







def_class("UIChatEmotWin",UIWindowBase)









function UIChatEmotWin:bindComponents()

self.root=UIObject.get(self,0)
self.unlockTxt=UIText.get(self,1)
self.unlock=UIButton.get(self,2)
self.unlockTitle=UIText.get(self,3)
self.defineNum=UIText.get(self,4)
self.btnDefineEditor=UIButton.get(self,5)
self.defineZhengli=UIButton.get(self,6)
self.defineEditorFinish=UIButton.get(self,7)
self.defineDelete=UIButton.get(self,8)
self.lockRoot=UIObject.get(self,9)
self.packageScrollView=UIScrollView.get(self,10)
self.bagScrollView=UIScrollView.get(self,11)
self.defineScrollView=UIScrollView.get(self,12)
self.editorRoot=UIObject.get(self,13)
self.emotScrollView=UIScrollView.get(self,14)
self.emotRoot=UIObject.get(self,15)
self.defineRoot=UIObject.get(self,16)
self.bagRoot=UIObject.get(self,17)
self.packageRoot=UIObject.get(self,18)
self.btnBag=UIButton.get(self,19)
self.btnGubaoBag=UIButton.get(self,20)
self.btnEquipBag=UIButton.get(self,21)
self.btnMetrailsBag=UIButton.get(self,22)
self.btnItemBag=UIButton.get(self,23)
self.btnFubaoBag=UIButton.get(self,24)
self.btnFabaoBag=UIButton.get(self,25)
self.creater=UIObject.get(self,26)
self.unlockitemroot=UIObject.get(self,27)
self.btnview=UIObject.get(self,28)
self.unlockreddot=UIObject.get(self,29)
self.itemPackageRoot=UIObject.get(self,30)
self.itemlockRoot=UIObject.get(self,31)
self.itemPckageUnlockTitle=UIText.get(self,32)
self.itempackageScrollView=UIScrollView.get(self,33)

self.unlock:setButtonClick(function()self:onUnlock()end)

self.btnDefineEditor:setButtonClick(function()self:onBtnDefineEditor()end)

self.defineZhengli:setButtonClick(function()self:onDefineZhengli()end)

self.defineEditorFinish:setButtonClick(function()self:onDefineEditorFinish()end)

self.defineDelete:setButtonClick(function()self:onDefineDelete()end)

self.btnBag:setButtonClick(function()self:onBtnBag()end)

self.btnGubaoBag:setButtonClick(function()self:onBtnGubaoBag()end)

self.btnEquipBag:setButtonClick(function()self:onBtnEquipBag()end)

self.btnMetrailsBag:setButtonClick(function()self:onBtnMetrailsBag()end)

self.btnItemBag:setButtonClick(function()self:onBtnItemBag()end)

self.btnFubaoBag:setButtonClick(function()self:onBtnFubaoBag()end)

self.btnFabaoBag:setButtonClick(function()self:onBtnFabaoBag()end)



end


function UIChatEmotWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.unlockTxt);self.unlockTxt=nil;
_UIObject_release(self.unlock);self.unlock=nil;
_UIObject_release(self.unlockTitle);self.unlockTitle=nil;
_UIObject_release(self.defineNum);self.defineNum=nil;
_UIObject_release(self.btnDefineEditor);self.btnDefineEditor=nil;
_UIObject_release(self.defineZhengli);self.defineZhengli=nil;
_UIObject_release(self.defineEditorFinish);self.defineEditorFinish=nil;
_UIObject_release(self.defineDelete);self.defineDelete=nil;
_UIObject_release(self.lockRoot);self.lockRoot=nil;
_UIObject_release(self.packageScrollView);self.packageScrollView=nil;
_UIObject_release(self.bagScrollView);self.bagScrollView=nil;
_UIObject_release(self.defineScrollView);self.defineScrollView=nil;
_UIObject_release(self.editorRoot);self.editorRoot=nil;
_UIObject_release(self.emotScrollView);self.emotScrollView=nil;
_UIObject_release(self.emotRoot);self.emotRoot=nil;
_UIObject_release(self.defineRoot);self.defineRoot=nil;
_UIObject_release(self.bagRoot);self.bagRoot=nil;
_UIObject_release(self.packageRoot);self.packageRoot=nil;
_UIObject_release(self.btnBag);self.btnBag=nil;
_UIObject_release(self.btnGubaoBag);self.btnGubaoBag=nil;
_UIObject_release(self.btnEquipBag);self.btnEquipBag=nil;
_UIObject_release(self.btnMetrailsBag);self.btnMetrailsBag=nil;
_UIObject_release(self.btnItemBag);self.btnItemBag=nil;
_UIObject_release(self.btnFubaoBag);self.btnFubaoBag=nil;
_UIObject_release(self.btnFabaoBag);self.btnFabaoBag=nil;
_UIObject_release(self.creater);self.creater=nil;
_UIObject_release(self.unlockitemroot);self.unlockitemroot=nil;
_UIObject_release(self.btnview);self.btnview=nil;
_UIObject_release(self.unlockreddot);self.unlockreddot=nil;
_UIObject_release(self.itemPackageRoot);self.itemPackageRoot=nil;
_UIObject_release(self.itemlockRoot);self.itemlockRoot=nil;
_UIObject_release(self.itemPckageUnlockTitle);self.itemPckageUnlockTitle=nil;
_UIObject_release(self.itempackageScrollView);self.itempackageScrollView=nil;
end




















local ab="ui/windows/chat/chatemo_atlas_pak.ab"

local EmotBtnType={
eSystem=1,
eDefine=2,
ePackage=3,
eItemPackage=4,
}

local EmotBtnList={
[EmotBtnType.eSystem]={
getReddot=function()return false end,
isUnLock=function()return true end,
},
[EmotBtnType.eDefine]={
getReddot=function()return false end,
isUnLock=function()
return not chatConfig.getCommonConfig().lockdefine
end,
},
[EmotBtnType.ePackage]={
getReddot=function(cfg)
return chatEmotModel.reddotUnLockEmoById(cfg.idx)
end,
isUnLock=function(cfg)
return chatEmotModel.isUnlockPackageEmot(cfg.idx)
end,
},
[EmotBtnType.eItemPackage]={
getReddot=function(cfg)
return chatEmotModel.reddotUnLockItemPackageEmot(cfg.idx)
end,
isUnLock=function(cfg)return cfg.show or chatEmotModel.reddotUnLockItemPackageEmot(cfg.idx)or chatEmotModel.isShowItemEmotPackage(cfg.idx)end,
},
}


function UIChatEmotWin:onLoaded(...)
self:bindComponents()
self.emotScrollView:setClickAction(function(...)self:onEmotItemClick(...)end)
self.packageScrollView:setClickAction(function(...)self:onPackageItemClick(...)end)
self.defineScrollView:setClickAction(function(...)self:onDefineItemClick(...)end)
self.bagScrollView:setClickAction(function(...)self:onBagItemClick(...)end)
self.itempackageScrollView:setClickAction(function(...)self:onItemPackageItemLick(...)end)

self.packageScrollView:setLongTouchAction(function(...)self:onPackageItemLongClick(...)end)
self.defineScrollView:setLongTouchAction(function(...)self:onDefineItemLongClick(...)end)
self.itempackageScrollView:setLongTouchAction(function(...)self:onItemPackageItemLongClick(...)end)

self.bagScrollView:setLongTouchAction(function(...)self:onBagItemLongClick(...)end)

self.packageIdx=1
self.defineEditorList={}
self.defineEditorLookup={}
self.isDefineEditor=false
end

function UIChatEmotWin:__delete()
self:unbindComponents()

if self.nameList[self.selectIndex].type==CHAT_EMOT_TYPE.eItemEmot then
self:resetNew()
end
end

function UIChatEmotWin:onShow(argtable,afterOnloaded)
local selectIndex=chatEmotModel.getSelectPage()
if argtable then
selectIndex=argtable.selectIndex or selectIndex
if argtable.pivot then
self.root:setChildPivot(argtable.pivot)
end
if argtable.rootPos then
self.root:setChildAnchoredPosition(argtable.rootPos)
end
if argtable.anchor then
local rt=self.root:getCommonComponent('RectTransform')
rt.anchorMin=Vector2.New(argtable.anchor[1],argtable.anchor[2])
rt.anchorMax=Vector2.New(argtable.anchor[3],argtable.anchor[4])
end
end
self:onSelect(selectIndex)
end

function UIChatEmotWin:onHide()

end

function UIChatEmotWin:onSelect(selectIndex)
if selectIndex==self.selectIndex then return end
self:createBtnsList()
if self.nameList[selectIndex]==nil then
selectIndex=1
end
self.selectIndex=selectIndex
chatEmotModel.setSelectPage(selectIndex)
self:freshActive()
self:freshGrids()
self:freshBtns()
end

function UIChatEmotWin:freshActive()
local selectIndex=self.selectIndex
local type=self.nameList[selectIndex].type
local activeSmallEmot=type==CHAT_EMOT_TYPE.eSystem
local activeDefineEmot=type==CHAT_EMOT_TYPE.eDefine
local activePackageEmot=type==CHAT_EMOT_TYPE.ePacakge
local activeItemPackageEmot=type==CHAT_EMOT_TYPE.eItemEmot
self.emotRoot:setActive(activeSmallEmot)
self.defineRoot:setActive(activeDefineEmot)
self.packageRoot:setActive(activePackageEmot)
self.itemPackageRoot:setActive(activeItemPackageEmot)
end

function UIChatEmotWin:freshGrids()
local selectIndex=self.selectIndex
local type=self.nameList[selectIndex].type
self:freshActive()
if type~=CHAT_EMOT_TYPE.eDefine then
self:resetDefineData()
end
if type==CHAT_EMOT_TYPE.eSystem then
self:freshEmotGrids()
elseif type==CHAT_EMOT_TYPE.eDefine then
self:freshDefineBtns()
self:freshDefineEmotGrids()
elseif type==CHAT_EMOT_TYPE.ePacakge then
self:freshPackageEmotGrids()
elseif type==CHAT_EMOT_TYPE.eItemEmot then
self:freshItemPackageEmotGrids()
end
end



function UIChatEmotWin:freshEmotGrids()
if self.isInitEmotGrids==nil then
self.isInitEmotGrids=true
local configs=cfg_chatesystemmotconfig()
local propArray={}
local len=#configs
for i,v in ipairs(configs)do
propArray[i]=self:getEmotFillData(i,v)
end
local row=math.ceil(len/7)
self.emotScrollView:freshGridsNum(len,row,7,false)
self.emotScrollView:initPropData(propArray)
end
end

function UIChatEmotWin:getEmotFillData(index,info)
local prop={}
local icon=info.icon
prop[PropIndex(DataPropKey.eWidgetIcon,0)]=iconHelper.getEmotIcon(icon)
prop[DataPropKey.eItemID]=info.id
return prop
end



function UIChatEmotWin:freshPackageEmotGrids()
local id=self.nameList[self.selectIndex].idx
local isUnlock=chatEmotModel.isUnlockPackageEmot(id)
local packageConfig=chatConfig.getPackageEmotConfigById(id)
local list=packageConfig.package
local len=#list
local propArray={}
for i,v in ipairs(list)do
propArray[i]=self:getPackageEmotFillData(i,v,packageConfig,isUnlock)
end
self.lockRoot:setActive(not isUnlock)
if not isUnlock then
local rechargeid=packageConfig.rechargeid
if rechargeid then
local rmb=cfgHelper.get2(cfg_rechargeconfig_get,rechargeid,'rmb')
self.unlockTxt:setText(FMT.fmt('¥{0}',rmb))
self.unlockitemroot:setActive(false)
self.unlockreddot:setActive(false)
elseif packageConfig.unlockitem then
self.unlockitemroot:setActive(true)
self.unlockTxt:setText('解锁')
local itemconfig=itemsConfig.getConfig(packageConfig.unlockitem)
local itemicon=iconHelper.getIconName(packageConfig.unlockitem)
local itemcount=bagModel.getItemCountById(packageConfig.unlockitem)
local widget=self.unlockitemroot:getWidgetBase()
widget:SetChildQulaity(0,itemconfig.color)
widget:SetChildIcon(1,itemicon,false)
widget:SetChildButtonClick(3,function()
tipsManager.showTips({itemid=packageConfig.unlockitem})
end,true,0)
local txtcolor=itemcount>=1 and"#171311"or"#C84C49"
widget:SetChildText(2,FMT.fmt("<color={0}>({1}/{2})</color>",txtcolor,itemcount,1))
self.unlockreddot:setActive(chatEmotModel.reddotUnLockEmoById(id))
end
else
self.unlockTxt:setText('')
end
self.packageScrollView:freshGridsNum(len,math.ceil(len/4),4,true)
self.packageScrollView:initPropData(propArray)
end

function UIChatEmotWin:getPackageEmotFillData(index,bigEmotId,packageConfig,isUnlock)
local prop={}
local bigEmotConfig=chatConfig.getBigEmotConfigById(bigEmotId)
prop[PropIndex(DataPropKey.eWidgetIcon,0)]=iconHelper.getBigEmotIcon(bigEmotConfig.icon)
prop[PropIndex(DataPropKey.eWidgetActive,1)]=not isUnlock
prop[DataPropKey.eItemID]=bigEmotConfig.id
return prop
end

function UIChatEmotWin:isSelectPackage()
return self.selectIndex>0
end


function UIChatEmotWin:freshDefineEmotGrids()
local max=chatConfig.getMaxDefineEmotNum()
local list=chatEmotModel.getDefineEmotList(true)
local propArray={}
local len=#list
local raw=math.ceil(max/7)
self.defineScrollView:freshGridsNum(max,raw,7,false)
for i=1,max do
local info=list[i]
if info then
propArray[i]=self:getDefineEmotFillData(i,info)
else
propArray[i]=self:getDefineRecyleData()
end
end
self.defineScrollView:initPropData(propArray)
self.defineNum:setText(FMT.fmt('（{0}/{1}）',len,max))
self:freshDefineNumPos()
end

function UIChatEmotWin:freshDefineNumPos()
local posx=self.isDefineEditor and 100 or 190
self.winlua:SetChildLocalPos(self.defineNum:getID(),posx,0,0)
end

function UIChatEmotWin:getDefineEmotFillData(index,info)
local prop={}

local emotguid=info.param_1
local emotid=info.param_2

local emotConfig=chatConfig.getDefineEmotConfigById(emotid)

local desc=chatEmotModel.getDefineEmotDesc(emotguid)
prop[PropIndex(DataPropKey.eWidgetIcon,0)]=iconHelper.getBigEmotIcon(emotConfig.icon)
prop[PropIndex(DataPropKey.eWidgetActive,1)]=self.isDefineEditor==true
prop[PropIndex(DataPropKey.eWidgetText,2)]=desc
prop[PropIndex(DataPropKey.eWidgetActive,3)]=self.defineEditorLookup[emotguid]==true

prop[DataPropKey.eItemID]=emotid
prop[DataPropKey.eItemAttach]=emotguid

local item=self.defineScrollView:getGridObjectByindex(index-1)
local position=emotConfig.position
local size=emotConfig.size
item:SetChildLocalPos(4,position[1],position[2],0)
item:SetChildSizeDelta(4,size[1],size[2])
return prop
end

function UIChatEmotWin:getDefineRecyleData()
return
{
[PropIndex(DataPropKey.eWidgetActive,0)]=false,
[PropIndex(DataPropKey.eWidgetActive,1)]=false,
[PropIndex(DataPropKey.eWidgetText,2)]='',
[PropIndex(DataPropKey.eWidgetActive,3)]=false,
[PropIndex(DataPropKey.eWidgetActive,4)]=false,
[DataPropKey.eItemID]=-1,
[DataPropKey.eItemAttach]='',
}
end

function UIChatEmotWin:freshDefineBtns()
self.defineDelete:setActive(self.isDefineEditor)
self.defineEditorFinish:setActive(self.isDefineEditor)
self.defineZhengli:setActive(not self.isDefineEditor)
end

function UIChatEmotWin:startDefineEditor()
local list=chatEmotModel.getDefineEmotList(true)
for i,_ in ipairs(list)do
local item=self.defineScrollView:getGridObjectByindex(i-1)
item:SetChildActive(1,self.isDefineEditor==true)
end
end

function UIChatEmotWin:freshDefineSelectTag(emotguid)
local index=chatEmotModel.getDefineIndexByGuid(emotguid)
if index==nil then return end
local item=self.defineScrollView:getGridObjectByindex(index-1)
item:SetChildActive(3,self.defineEditorLookup[emotguid]==true)
end


function UIChatEmotWin:onSelectBag(bagType)
if self.bagType==bagType then return end
self.bagType=bagType
self:freshBagGrids(bagType)
self:freshBagBtns()
end

function UIChatEmotWin:freshBagGrids(bagType)
local items=bagControl.getBagItemsByFilter(bagType)or{}
local len=#items
local row=math.ceil(len/7)
local propArray={}
for i,v in ipairs(items)do
propArray[i]=self:getBagFillData(i,v)
end
self.bagScrollView:freshGridsNum(len,row,7,false)
if len>0 then
self.bagScrollView:initPropData(propArray)
end
end

function UIChatEmotWin:getBagFillData(index,item)
local conf={}
conf.showname=false
conf.showBg=false
conf.showStageBg=true
conf.showcount=item.itemcount>1
return itemsComponentHelper.getCommonFillData(item,conf)
end


function UIChatEmotWin:createBtnsList()
if self.createPackage then return end
self.createPackage=true
local packageEmot=chatEmotControl.getActivePackageEmot()
self.nameList=packageEmot
self.btnview:setChildScrollRectEnable(#packageEmot>7)
self.creater:setChildLayoutGroupCreateItems(#packageEmot)
end

function UIChatEmotWin:getNameListByType(type)
local index
for k,v in pairs(self.nameList)do
if v.type==type then
index=k
return index
end
end
end

function UIChatEmotWin:freshBtns()
local len=#self.nameList
local widgetList=self.creater:getChildLayoutGroupGridList()
for i=1,len do
local selectIndex=i
local isSelect=selectIndex==self.selectIndex
local btnData=EmotBtnList[self.nameList[i].type]
local widget=widgetList[i-1]
local islock=not btnData.isUnLock(self.nameList[i])

widget:SetChildActive(0,isSelect)
widget:SetChildActive(1,not isSelect)
widget:SetChildActive(4,islock)
widget:SetChildActive(5,islock)

widget:SetChildCSImageSprite(2,ab,self.nameList[i].icon)
widget:SetChildGray(2,islock)
local reddot=btnData.getReddot(self.nameList[i])
widget:SetChildActive(6,reddot)
widget:SetChildButtonClick(3,function()
if self.selectIndex==selectIndex then return end
self.selectIndex=selectIndex
chatEmotModel.setSelectPage(selectIndex)
self:freshBtnActive()
self:resetNew()
self:freshGrids()
end)
end
end

function UIChatEmotWin:resetNew()
if self.itemEmotPackageList then
for k,v in pairs(self.itemEmotPackageList)do
if v.isNew then
chatEmotModel.setItemEmotNew(v.cfg.tabid,v.cfg.tabidx)
end
end
end
UIManager:invokeUIMethod("UIChatWin","freshEmoReddot")
UIManager:invokeUIMethod("UIMain","freshChatReddot")
end

function UIChatEmotWin:freshBtnActive()
local len=#self.nameList
local widgetList=self.creater:getChildLayoutGroupGridList()
for i=1,len do

local isSelect=i==self.selectIndex
local widget=widgetList[i-1]
widget:SetChildActive(0,isSelect)
widget:SetChildActive(1,not isSelect)
end
end


function UIChatEmotWin:freshItemPackageEmotGrids()
local emotdata=self.nameList[self.selectIndex]
local cfgs=cfg_itemchatemotpackageconfig_get(emotdata.idx)

if self.itemEmotPackageList then
table.clear(self.itemEmotPackageList)
else
self.itemEmotPackageList={}
end

for k,cfg in pairs(cfgs)do
local temp={}
temp.cfg=cfg
temp.isUnlock=chatEmotModel.getItemEmotState(cfg.tabid,cfg.tabidx)
temp.isNew=chatEmotModel.getItemEmotNew(cfg.tabid,cfg.tabidx)
temp.reddot=false
if not temp.isUnlock then
temp.reddot=chatEmotModel.isCanUnlockItemPackage(cfg.tabid,cfg.tabidx)
end

temp.widght=cfg.tabidx

if temp.isUnlock then
temp.widght=100+200-cfg.tabidx
end

if temp.isNew then
temp.widght=1000+200-cfg.tabidx
end

if temp.reddot then
temp.widght=10000+200-cfg.tabidx
end


table.insert(self.itemEmotPackageList,temp)
end

table.sort(self.itemEmotPackageList,function(a,b)
return a.widght>b.widght
end)

local propArray={}
for k,data in pairs(self.itemEmotPackageList)do
local prop={}






local bigEmotConfig=cfgHelper.get1(cfg_chatebigmotconfig_get,data.cfg.emoid)
prop[PropIndex(DataPropKey.eWidgetIcon,0)]=iconHelper.getBigEmotIcon(bigEmotConfig.icon)
prop[PropIndex(DataPropKey.eWidgetActive,1)]=not data.isUnlock
prop[PropIndex(DataPropKey.eWidgetActive,2)]=data.reddot
prop[PropIndex(DataPropKey.eWidgetActive,3)]=data.isNew
prop[DataPropKey.eItemID]=data.cfg.tabid

propArray[#propArray+1]=prop
end

self.itempackageScrollView:freshGridsNum(#propArray,Mathf.Ceil(#propArray/4),4,not self.itemScrollSetZero)
self.itempackageScrollView:initPropData(propArray)
self.itemScrollSetZero=true

local state=chatEmotModel.isUnlockAllEmotByItemPackageid(emotdata.idx)
self.itemlockRoot:setActive(not state)
end

function UIChatEmotWin:onItemPackageItemLick(tabid,index,tabidx,attach)
local data=self.itemEmotPackageList[index]
local tabid=data.cfg.tabid
local tabidx=data.cfg.tabidx


local isUnlock=chatEmotModel.getItemEmotState(tabid,tabidx)
local reddot=chatEmotModel.isCanUnlockItemPackage(tabid,tabidx)
if isUnlock then

local mesg=chatEmotHelper.getBigEmotMesg(tabid,tabidx,'',EmotBtnType.eItemPackage)
chatControl.invokeSelectHandlerFunc('sendMesg',mesg)
chatEmotModel.setItemEmotNew(tabid,tabidx)
UIManager:invokeUIMethod("UIChatWin","freshEmoReddot")
self:closeSelf()
else
if reddot then

chatProtocolControl.sendUnLockItemEmot(tabid,tabidx)
else

UIManager.info("表情解锁后方能使用")
local itemid=data.cfg.consume[1][1]
local needNum=data.cfg.consume[1][2]
gainControl:showGainWin(itemid)
end
end
end



function UIChatEmotWin:freshBagBtns()
for typo,v in pairs(self.bagBtnList)do
self:freshSingleBtn(v,_bagTypeMatch[self.bagType]==typo)
end
end

function UIChatEmotWin:freshBagState()
self:freshSingleBtn(self.btnBag,self.selectIndex==_clickType.eBag)
end

function UIChatEmotWin:freshSingleBtn(btn,flag)
local widget=btn:getChildWidgetBase()
widget:SetChildActive(0,flag)
widget:SetChildActive(1,not flag)
end


function UIChatEmotWin:previewPackageEmot(id,posx,posy)
UIManager:showWindow('UIChatPackageEmotInfoPanel',{id,posx,posy})
end

function UIChatEmotWin:previewDefineEmot(id,posx,posy)
UIManager:showWindow('UIChatDefineEmotInfoPanel',{id,posx,posy})
end

function UIChatEmotWin:selectDefineEmotOnEditor(emotguid)
local lastIsSelect=self.defineEditorLookup[emotguid]or false
self.defineEditorLookup[emotguid]=not lastIsSelect
self:freshDefineSelectList(emotguid)
self:freshDefineSelectTag(emotguid)
end

function UIChatEmotWin:freshDefineSelectList(emotguid)
local isSelect=self.defineEditorLookup[emotguid]
if not isSelect then
for i,v in ipairs(self.defineEditorList)do
if v==emotguid then
table.remove(self.defineEditorList,i)
break
end
end
else
self.defineEditorList[#self.defineEditorList+1]=emotguid
end
end


function UIChatEmotWin:onEmotItemClick(id,index,guid,attach)
local mesg=chatEmotHelper.getSmallEmotMesg(id)
chatControl.invokeSelectHandlerFunc('addMesg',CHAT_DECODE_TYPE.eEmot,mesg)
end

function UIChatEmotWin:onPackageItemClick(id,index,guid,attach)
local packageId=self.nameList[self.selectIndex].idx
if not chatEmotModel.isUnlockPackageEmot(packageId)then
UIManager.info('表情包解锁后方可使用')
return
end
local mesg=chatEmotHelper.getBigEmotMesg(packageId,index,'',EmotBtnType.ePackage)
chatControl.invokeSelectHandlerFunc('sendMesg',mesg)
self:closeSelf()
end

function UIChatEmotWin:onPackageItemLongClick(id,index,guid,attach)
local array=string.split(attach,',')
self:previewPackageEmot(id,tonumber(array[2]),tonumber(array[3]))
end

function UIChatEmotWin:onItemPackageItemLongClick(id,index,guid,attach)
local data=self.itemEmotPackageList[index]
local tabid=data.cfg.tabid
local tabidx=data.cfg.tabidx
local emotid=cfgHelper.get3(cfg_itemchatemotpackageconfig_get,tabid,tabidx,"emoid")
local array=string.split(attach,',')

self:previewPackageEmot(emotid,tonumber(array[2]),tonumber(array[3]))
chatEmotModel.setItemEmotNew(tabid,tabidx)
self.itempackageScrollView:freshGirdDisplayByPropKey(index-1,DataPropKey.eWidgetActive,3,false)
self:freshBtns()
UIManager:invokeUIMethod("UIChatWin","freshEmoReddot")
end

function UIChatEmotWin:onDefineItemClick(id,index,guid,attach)
if id==-1 then return end
local emotguid=tonumber(attach)
if self.isDefineEditor then
self:selectDefineEmotOnEditor(emotguid)
else
local desc=chatEmotModel.getDefineEmotDesc(emotguid)
local mesg=chatEmotHelper.getBigEmotMesg(_clickType.eDefineEmot,id,desc,EmotBtnType.eDefine)
chatControl.invokeSelectHandlerFunc('sendMesg',mesg)
self:closeSelf()
end
end

function UIChatEmotWin:onDefineItemLongClick(id,index,guid,attach)
if id==-1 then return end
local array=string.split(attach,',')
self:previewDefineEmot(tonumber(array[1]),tonumber(array[2]),tonumber(array[3]))
end

function UIChatEmotWin:onBagItemClick(itemid,index,itemguid,attach)
local key,mesg=chatLinkHelper.getItemText(itemguid,itemid)
chatControl.invokeSelectHandlerFunc('addMesg',CHAT_DECODE_TYPE.eLink,{key,mesg})
end

function UIChatEmotWin:onBagItemLongClick(itemid,index,itemguid,attach)
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
end

function UIChatEmotWin:onUnlock()
local packageId=self.nameList[self.selectIndex].idx
if packageId>0 and not chatEmotModel.isUnlockPackageEmot(packageId)then

local cfg=chatConfig.getPackageEmotConfigById(packageId)
if cfg.unlockitem then
local itemid=cfg.unlockitem
local itemName=itemsModel.getName(itemid)
local has=itemsModel.getCount(itemid)
if has==0 then
UIManager.error(FMT.fmt('{0}不足',itemName))
gainControl:showGainWin(itemid)
else

if itemsLookup:checkUseItemCondition(itemid)then
bagProtocolControl.req_use_item(itemid,1)
end



end
elseif cfg.rechargeid then
payControl.reqPay(cfg.rechargeid)
end
end
end

function UIChatEmotWin:onDefineDelete()
local guidlist=self.defineEditorList
if#guidlist==0 then
UIManager.error('尚未选择自定义表情')
return
end
chatEmotControl.sendDeleteDefineEmot(guidlist)
end

function UIChatEmotWin:onDefineEditorFinish()
if not self.isDefineEditor then return end
self:resetDefineData()
self:freshDefineBtns()
self:freshGrids()
end

function UIChatEmotWin:onDefineZhengli()
local num=chatEmotModel.getDefineEmotNum()
if num==0 then
UIManager.info('暂无自定义表情整理')
return
end
if self.isDefineEditor==true then return end
self.isDefineEditor=true
self:startDefineEditor()
self:freshDefineBtns()
self:freshDefineNumPos()
end

function UIChatEmotWin:onBtnDefineEditor()
if self.isDefineEditor==true then
self.isDefineEditor=false
self:clearDefineSelectData()
self:freshGrids()
end
UIManager:showWindow('UIChatDefineEmotEditorPanel')
end

function UIChatEmotWin:onRecvDefineAdd()
if self.selectIndex~=_clickType.eDefineEmot then return end
self:freshGrids()
end

function UIChatEmotWin:onRecvDefineChanged()
self:clearDefineSelectData()
if self.selectIndex~=_clickType.eDefineEmot then return end
self:freshGrids()
end

function UIChatEmotWin:onRecvUnlockPackage()



self:freshGrids()

self:freshBtns()
end

function UIChatEmotWin:freshBtn(packageId)
local index=self:getNameListByType(packageId)
local widget=self.creater:getChildLayoutGroupGridItem(index-1)
if widget then
local selectIndex=self.nameList[index].type
local isSelect=selectIndex==self.selectIndex
widget:SetChildActive(0,isSelect)
widget:SetChildActive(1,not isSelect)
widget:SetChildActive(4,false)
widget:SetChildActive(5,false)
widget:SetChildGray(2,false)
widget:SetChildActive(6,false)
end
end

function UIChatEmotWin:clearDefineSelectData()
self.defineEditorLookup={}
self.defineEditorList={}
end

function UIChatEmotWin:resetDefineData()
self:clearDefineSelectData()
self.isDefineEditor=false
end
