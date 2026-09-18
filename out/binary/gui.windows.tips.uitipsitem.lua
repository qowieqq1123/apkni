







def_class("UITipsItem",UICloneObject)





UITipsItem.abName="ui/windows/tips/uitipsitem.ab"

UITipsItem.assetName="UITipsItem"


function UITipsItem:bindComponents()

self.nodeTopTop=UIObject.get(self,0)
self.nodeTopMiddle=UIObject.get(self,1)
self.nodeTopBottom=UIObject.get(self,2)
self.nodeMiddleTop=UIObject.get(self,3)
self.nodeMiddleMiddle=UIObject.get(self,4)
self.nodeMiddleBottom=UIObject.get(self,5)
self.nodeBottomTop=UIObject.get(self,6)
self.nodeBottomMiddle=UIObject.get(self,7)
self.nodeBottomBottom=UIObject.get(self,8)
self.nodeBtn=UIObject.get(self,9)
self.btnCreater=UIGameobjectClone.new(self,10)
self.creater=UIGameobjectClone.new(self,11)
self.colorFrame=UIImage.get(self,12)

end


function UITipsItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.nodeTopTop);self.nodeTopTop=nil;
_UIObject_release(self.nodeTopMiddle);self.nodeTopMiddle=nil;
_UIObject_release(self.nodeTopBottom);self.nodeTopBottom=nil;
_UIObject_release(self.nodeMiddleTop);self.nodeMiddleTop=nil;
_UIObject_release(self.nodeMiddleMiddle);self.nodeMiddleMiddle=nil;
_UIObject_release(self.nodeMiddleBottom);self.nodeMiddleBottom=nil;
_UIObject_release(self.nodeBottomTop);self.nodeBottomTop=nil;
_UIObject_release(self.nodeBottomMiddle);self.nodeBottomMiddle=nil;
_UIObject_release(self.nodeBottomBottom);self.nodeBottomBottom=nil;
_UIObject_release(self.nodeBtn);self.nodeBtn=nil;
self.btnCreater:deleteSelf();self.btnCreater=nil;
self.creater:deleteSelf();self.creater=nil;
_UIObject_release(self.colorFrame);self.colorFrame=nil;
end








function UITipsItem:onLoaded(...)
self:bindComponents()
end

function UITipsItem:__delete()
self.data=nil
self.serializeStr=nil
self:unbindComponents()
end

function UITipsItem:onShow(args,afterOnloaded)
local argstable=args.argtable
local isExtraTips=argstable.isExtraTips

if isExtraTips then
tipsExManager.handleArgs(argstable)
else
tipsManager.handleItemArgs(argstable)
end

tipsManager.handleCommonArgs(argstable)

tipsManager.handleTipsBody(argstable)

local attach=argstable.attach
if attach and attach.insertBtnList then
tipsBtnManager.insertBtn(argstable,attach.insertBtnList)
end

local lastData=self.data

if self:compareData(lastData,argstable)then return end

self:showTips(argstable)
end

function UITipsItem:onHide()

end



function UITipsItem:showColorBg(argtable)
local defaultBg=argtable.bg
local itemid=argtable.itemid
if defaultBg~=false then
if argtable.colorType then
local color=itemsConfig.getConfig(itemid).color
self:setColorFrameByType(argtable.colorType,color)
else
self:setColorFrame(itemid)
end
end
end

function UITipsItem:setColorFrame(itemid)
local bundleName,assetName=tipsConfig.getTitleAsset(itemid)
if bundleName==nil or assetName==nil then
self.colorFrame:setActive(false)
return
end
self.colorFrame:setActive(true)
self.colorFrame:setSprite(bundleName,assetName)
end

function UITipsItem:setColorFrameByType(colorType,color)
local bundleName,assetName=tipsConfig.getTipsAssetNameByType(colorType,color)
self.colorFrame:setActive(true)
self.colorFrame:setSprite(bundleName,assetName)
end



function UITipsItem:showTips(argtable)
local itemid=argtable.itemid
local itemguid=argtable.itemguid

self.data=argtable

self:showColorBg(argtable)

self:createTipsItem(argtable)

self:createBtnItem(argtable)
end

function UITipsItem:createTipsItem(argtable)
local tipsBodysConfig=argtable.tipsBodysConfig
if tipsBodysConfig==nil then return end
local outConfig={}
for nodeidx,childType in pairs(tipsBodysConfig)do
local args={
argtable=self.data,
childType=childType,
parentIdx=nodeidx,
order=0,
}
outConfig[#outConfig+1]=self:getCreatConfig(nodeidx,childType,0,args)
end
self.creater:createObjectList(outConfig)
end

function UITipsItem:createBtnItem(argtable)
local btnsList=argtable.btnsList
if btnsList==nil then return end
local outConfig={}
if btnsList and#btnsList>0 then
local nodeidx=self.nodeBtn:getID()
for i,childType in ipairs(btnsList)do
local args={
argtable=self.data,
childType=childType,
}
outConfig[#outConfig+1]=self:getCreatConfig(nodeidx,childType,i,args)
end
end

self.btnCreater:createObjectList(outConfig)
end

function UITipsItem:getCreatConfig(nodeidx,childType,order,args)
local childInfo=tipsConfig.getTipsChildConfig(childType)
local temp={}
temp.name=childInfo.src
temp.parentIdx=nodeidx
temp.order=order or 0
temp.args=args
return temp
end

function UITipsItem:compareData(lastTable,nowTable)
if lastTable==nil or
lastTable.tipsType~=nowTable.tipsType or
lastTable.itemid~=nowTable.itemid or
lastTable.itemguid~=nowTable.itemguid then
self.serializeStr=serializeHelper.serialize(nowTable)
return false
end
local lastSerialize=self.serializeStr
local nowSerialize=serializeHelper.serialize(nowTable)
self.serializeStr=nowSerialize
return lastSerialize==nowSerialize
end