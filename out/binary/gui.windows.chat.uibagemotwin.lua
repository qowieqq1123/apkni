







def_class("UIBagEmotWin",UIWindowBase)









function UIBagEmotWin:bindComponents()

self.root=UIObject.get(self,0)
self.bagScrollView=UIScrollView.get(self,1)
self.bagRoot=UIObject.get(self,2)
self.btns=UIObject.get(self,3)
self.bagBtnScrollView=UIScrollView.get(self,4)
self.btnContent=UIObject.get(self,5)
self.dressStateRoot=UIObject.get(self,6)
self.dressStateBtn=UIButton.get(self,7)
self.selectImg=UIObject.get(self,8)
self.bagBtnLeftMove=UIButton.get(self,9)
self.bagBtnRightMove=UIButton.get(self,10)
self.line=UIObject.get(self,11)

self.dressStateBtn:setButtonClick(function()self:onDressStateBtn()end)

self.bagBtnLeftMove:setButtonClick(function()self:onBagBtnLeftMove()end)

self.bagBtnRightMove:setButtonClick(function()self:onBagBtnRightMove()end)



end


function UIBagEmotWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.bagScrollView);self.bagScrollView=nil;
_UIObject_release(self.bagRoot);self.bagRoot=nil;
_UIObject_release(self.btns);self.btns=nil;
_UIObject_release(self.bagBtnScrollView);self.bagBtnScrollView=nil;
_UIObject_release(self.btnContent);self.btnContent=nil;
_UIObject_release(self.dressStateRoot);self.dressStateRoot=nil;
_UIObject_release(self.dressStateBtn);self.dressStateBtn=nil;
_UIObject_release(self.selectImg);self.selectImg=nil;
_UIObject_release(self.bagBtnLeftMove);self.bagBtnLeftMove=nil;
_UIObject_release(self.bagBtnRightMove);self.bagBtnRightMove=nil;
_UIObject_release(self.line);self.line=nil;
end















local btnType={
eItem=1,
eMeterials=2,
eEquip=3,
eFaBao=4,
eFuBao=5,
eGuBao=6,
eRare=7,
}




local bagBtnList={
[btnType.eItem]={
name="道具",
type=ITEM_MAIN_TYPE.eItem,
getItemData=function()
return bagControl.getBagItemsByFilter(ITEM_MAIN_TYPE.eItem)
end,
getDiscipleGuid=function(data)

end,
isShowDressOption=false,
getItemShowConf=function(item)
local conf={}
conf.showname=false
conf.showBg=false
conf.showStageBg=true
conf.showcount=item.itemcount>1
return conf
end,
scrollHeight=440,
},
[btnType.eMeterials]={
name="材料",
type=ITEM_MAIN_TYPE.eMaterials,
getItemData=function()
return bagControl.getBagItemsByFilter(ITEM_MAIN_TYPE.eMaterials)
end,
getDiscipleGuid=function(data)

end,
isShowDressOption=false,
getItemShowConf=function(item)
local conf={}
conf.showname=false
conf.showBg=false
conf.showStageBg=true
conf.showcount=item.itemcount>1
return conf
end,
scrollHeight=440,
},
[btnType.eEquip]={
name="装备",
type=ITEM_MAIN_TYPE.eEquip,
getItemData=function(isShowDress)
local temp=bagControl.getBagItemsByFilter(ITEM_MAIN_TYPE.eEquip)
local dztemp=equipsModel.getAllEquipToBagEmot()
local sortFunc=function(a,b)
local acfg=itemsConfig.getConfig(a.itemid)
local bcfg=itemsConfig.getConfig(b.itemid)
if acfg.stage==bcfg.stage then
return acfg.color>bcfg.color
else
return acfg.stage>bcfg.stage
end
end
local total=temp
table.sort(temp,sortFunc)
if isShowDress then
table.sort(dztemp,sortFunc)
total=table.concatTable(dztemp,temp)
end
return total
end,
getDiscipleGuid=function(data)
return equipsModel.getDiziguidByItemguid(data.itemguid)
end,
isShowDressOption=true,
getItemShowConf=function(item)
local conf={}
conf.showname=false
conf.showBg=false
conf.showStageBg=true
conf.itemcount=nil
conf.showjinglian=true
conf.showcount=true
return conf
end,
scrollHeight=394.74,
},
[btnType.eFaBao]={
name="法宝",
type=ITEM_MAIN_TYPE.eFabao,
getItemData=function(isShowDress)
local temp=bagControl.getBagItemsByFilter(ITEM_MAIN_TYPE.eFabao)
local dztemp=fabaoModel.getAllFaBaoToBagEmot()
local sortFunc=function(a,b)
local acfg=itemsConfig.getConfig(a.itemid)
local bcfg=itemsConfig.getConfig(b.itemid)
if acfg.stage==bcfg.stage then
return acfg.color>bcfg.color
else
return acfg.stage>bcfg.stage
end
end
local total=temp
table.sort(temp,sortFunc)
if isShowDress then
table.sort(dztemp,sortFunc)
total=table.concatTable(dztemp,temp)
end
return total
end,
getDiscipleGuid=function(data)
return fabaoModel.getDiziguidByItemguid(data.itemguid)
end,
isShowDressOption=true,
getItemShowConf=function(item)
local conf={}
conf.showname=false
conf.showBg=false
conf.showStageBg=true
conf.itemcount=nil
conf.showjinglian=true
conf.showcount=true
return conf
end,
scrollHeight=394.74,
},
[btnType.eFuBao]={
name="玉符",
type=ITEM_MAIN_TYPE.eFubao,
getItemData=function(isShowDress)
local temp=bagControl.getShowBagItemsByFilter(SHOW_BAG_TYPE.eFubaoBag)
local total=temp
if isShowDress then
local dztemp=UIFuLuFangModel.getAllFuBaoToBagEmot()
total=table.concatTable(dztemp,temp)
end
return total
end,
getDiscipleGuid=function(data)
return UIFuLuFangModel:getDzGuidByItemGuid(data.itemguid)
end,
isShowDressOption=true,
getItemShowConf=function(item)
local conf={}
conf.showname=false
conf.showBg=false
conf.showStageBg=true
conf.itemcount=nil
conf.showjinglian=true
conf.showcount=false
return conf
end,
scrollHeight=394.74,
},
[btnType.eGuBao]={
name="古宝",
type=ITEM_MAIN_TYPE.eGubao,
getItemData=function()
return bagControl.getBagItemsByFilter(ITEM_MAIN_TYPE.eGubao)
end,
getDiscipleGuid=function(data)

end,
isShowDressOption=false,
getItemShowConf=function(item)
local conf={}
conf.showname=false
conf.showBg=false
conf.showStageBg=true
conf.showcount=item.itemcount>1
return conf
end,
scrollHeight=440,
},
[btnType.eRare]={
name="珍稀",
type=ITEM_MAIN_TYPE.eClothing,
getItemData=function()
return bagControl.getShowBagItemsByFilter(SHOW_BAG_TYPE.eRareBag)
end,
getDiscipleGuid=function(data)

end,
isShowDressOption=false,
getItemShowConf=function(item)
local conf={}
conf.showname=false
conf.showBg=false
conf.showStageBg=true
conf.showcount=item.itemcount>1
return conf
end,
scrollHeight=440,
},
}




function UIBagEmotWin:onLoaded(...)
self:bindComponents()
self.bagScrollView:setClickAction(function(...)self:onBagItemClick(...)end)
self.bagScrollView:setLongTouchAction(function(...)self:onBagItemLongClick(...)end)
self.bagBtnScrollView:setClickAction(function(...)self:onBagBtnItemClick(...)end)
self.bagScrollView:bindScrollWidget(function(...)self:bindBagItemWeight(...)end)

self.jumpIndex=1
self.maxjumpIndex=#bagBtnList
end


function UIBagEmotWin:__delete()
self:unbindComponents()
end




function UIBagEmotWin:onShow(argtable,afterOnloaded)
self.isShowDress=userActorSetting.get("isShowDressTable",false)


self.selectIndex=1
self:refresh()
end


function UIBagEmotWin:onHide()

end

function UIBagEmotWin:refresh()
self:refreshBtns()
self:freshBagGrids()
end

function UIBagEmotWin:refreshBtns()
local len=#bagBtnList
local propdata={}
for k,v in pairs(bagBtnList)do
local prop={}
prop[PropIndex(DataPropKey.eWidgetActive,0)]=self.selectIndex==k
prop[PropIndex(DataPropKey.eWidgetText,2)]=v.name

propdata[k]=prop
end
self.bagBtnScrollView:freshGridsNum(len,1,len,false)
self.bagBtnScrollView:initPropData(propdata)


end

function UIBagEmotWin:freshBagGrids()
local data=bagBtnList[self.selectIndex]

self.bagScrollView:setChildSizeDelta(703,data.scrollHeight)

self.items=data.getItemData(self.isShowDress)or{}
local len=#self.items
local row=math.ceil(len/7)



self.bagScrollView:freshGridsNum(len,row,8,self.bagScrollViewZero)
self.bagScrollViewZero=true















self.dressStateRoot:setActive(data.isShowDressOption)
self.line:setActive(data.isShowDressOption)
local state=self.isShowDress
self.selectImg:setActive(state)
end

function UIBagEmotWin:getBagFillData(index,item,data)





local conf=data.getItemShowConf(item)

local propdata=itemsComponentHelper.getCommonFillData(item,conf)
return propdata
end

function UIBagEmotWin:bindBagItemWeight(index,item)
local data=self.items[index]
local bagBtnCfg=bagBtnList[self.selectIndex]

item:SetChildActive(-1,data~=nil)

if data then
local initprop=self:getBagFillData(index,data,bagBtnCfg)
item:SetChildPropData(-1,initprop)

local discipleguid=bagBtnCfg.getDiscipleGuid(data)
item:SetChildActive(14,self.isShowDress and discipleguid~=nil)
item:SetChildActive(15,self.isShowDress and discipleguid~=nil)
if self.isShowDress and discipleguid~=nil then
comHelper.setChildModelRawImage(item,discipleguid,14,0,eHeadCenterType.eHead,0.2)
end
end
end




function UIBagEmotWin:onBagItemClick(itemid,index,itemguid,attach)
local data=bagBtnList[self.selectIndex]
local discipleguid=data.getDiscipleGuid({itemguid=itemguid})
local key,mesg=chatLinkHelper.getItemText(itemguid,itemid,discipleguid)
chatControl.invokeSelectHandlerFunc('addMesg',CHAT_DECODE_TYPE.eLink,{key,mesg})
end

function UIBagEmotWin:onBagItemLongClick(itemid,index,itemguid,attach)
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
end

function UIBagEmotWin:onBagBtnItemClick(itemid,index,itemguid,attach)
self.bagBtnScrollView:freshGirdDisplayByPropKey(self.selectIndex-1,DataPropKey.eWidgetActive,0,false)

self.selectIndex=index
self:freshBagGrids()

self.bagBtnScrollView:freshGirdDisplayByPropKey(index-1,DataPropKey.eWidgetActive,0,true)
end

function UIBagEmotWin:onDressStateBtn()
self.isShowDress=not self.isShowDress
userActorSetting.set("isShowDressTable",self.isShowDress)
userActorSetting.flush()
self:refresh()
end

function UIBagEmotWin:onBagBtnLeftMove()
if self.jumpIndex-5>0 then
self.jumpIndex=self.jumpIndex-5
self.bagBtnScrollView:jumpToLockY(self.jumpIndex)

if self.selectIndex+1<self.maxjumpIndex then
self.selectIndex=self.selectIndex-1
self:freshBagGrids()
self:refreshBtns()
end
end
end

function UIBagEmotWin:onBagBtnRightMove()
if self.jumpIndex+5<=self.maxjumpIndex then
self.jumpIndex=self.jumpIndex+5


self.bagBtnScrollView:jumpToLockY(self.jumpIndex)

if self.selectIndex+1<=self.maxjumpIndex then
self.selectIndex=self.selectIndex+1
self:freshBagGrids()
self:refreshBtns()
end
end
end