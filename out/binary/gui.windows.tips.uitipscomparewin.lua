







def_class("UITipsCompareWin",UIWindowBase)









function UITipsCompareWin:bindComponents()

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
self.creater=UIGameobjectClone.new(self,10)
self.root=UIObject.get(self,11)
self.nodeDetail=UIObject.get(self,12)
self.detailPage=UIObject.get(self,13)
self.colorFrame=UIImage.get(self,14)
self.frameBg=UIObject.get(self,15)
self.btnCreater=UIGameobjectClone.new(self,16)
self.followCreater=UIGameobjectClone.new(self,17)
self.btnPage=UIObject.get(self,18)



end


function UITipsCompareWin:unbindComponents()
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
self.creater:deleteSelf();self.creater=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.nodeDetail);self.nodeDetail=nil;
_UIObject_release(self.detailPage);self.detailPage=nil;
_UIObject_release(self.colorFrame);self.colorFrame=nil;
_UIObject_release(self.frameBg);self.frameBg=nil;
self.btnCreater:deleteSelf();self.btnCreater=nil;
self.followCreater:deleteSelf();self.followCreater=nil;
_UIObject_release(self.btnPage);self.btnPage=nil;
end















local _movePosX=
{
[TIPS_MOVE_POS.eRight]=276,
[TIPS_MOVE_POS.eLeft]=-276,
[TIPS_MOVE_POS.eCenter]=0,
[TIPS_MOVE_POS.eRightTwo]=330,
}



function UITipsCompareWin:onLoaded(...)
self:bindComponents()
self.ani=self.root:getID()
self:addNotify(notifyConfig.on_item_changed,function(...)self:onItemChanged(...)end)
end


function UITipsCompareWin:__delete()
if self.closeCallback then
self.closeCallback()
self.closeCallback=nil
end
self:unbindComponents()
end


function UITipsCompareWin:onShow(argtable,afterOnloaded)
local tipsType=argtable.tipsType
local itemid=argtable.itemid
local itemguid=argtable.itemguid
local backType=argtable.backType or TIPS_BACK_TYPE.eNomal
local backName=tipsConfig.getTipsBackWinName(backType)
if backName and not UIManager:isActive(backName,true)then
self.activeBackName=backName
self:showWindow(backName)
end
self.isLeftBtn=argtable.isLeftBtn
self.move=argtable.move
self.movepos=argtable.movepos
self.closeCallback=argtable.closeCallback
self.tipsType=tipsType
local defaultBg=argtable.bg
if tipsType==nil then
logErr('没有传递tips类型')
return
end
if itemid==nil then
logErr('没有传递itemid')
return
end
local lastData=self.data
self.data=argtable
local bodyConfig=self:getBodysConfig(tipsType,argtable)
self.itemguid=itemguid
if defaultBg~=false then
self:setColorFrame(itemid)
end
self.bodyConfig=bodyConfig
self.btnConfig=self:getBtnsConfig(tipsType,argtable)
self:showTips(tipsType,argtable)
end

function UITipsCompareWin:showTips(tipsType,argtable)
local bodyConfig=self.bodyConfig
local btnConfig=self.btnConfig
local isLeftBtn=self.isLeftBtn
self.winlua:SetChildDOTweenAnimation_DOPlay(self.ani,1,0,3)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.ani,2,0,3)
self.creater:createObjectList(bodyConfig)
self.btnCreater:createObjectList(btnConfig)

if isLeftBtn then
local pos=self.winlua:GetChildLocalPosition(self.btnPage:getID())
self.winlua:SetChildLocalPosX(self.btnPage:getID(),pos.x-486)
end
end


function UITipsCompareWin:freshAllBtnReddot()
self.btnCreater:callAllChildFunc('refreshReddot')
end


function UITipsCompareWin:getBodysConfig(tipsType,argtable)
local tipsBodysConfig=argtable.tipsBodysConfig
local outConfig={}
if tipsBodysConfig==nil then return end
for nodeidx,childType in pairs(tipsBodysConfig)do
local args={
argtable=self.data,
childType=childType,
parentIdx=nodeidx,
order=0,
}
outConfig[#outConfig+1]=self:getCreatConfig(nodeidx,childType,0,args)
end
return outConfig
end


function UITipsCompareWin:getBtnsConfig(tipsType,argtable)
local btnsList=argtable.btnsList
local tipsBtnsConfig=argtable.tipsBtnsConfig
if tipsBtnsConfig==nil then return end
local outConfig={}
if btnsList and#btnsList>0 then
local idx=0
for nodeidx,childType in pairs(tipsBtnsConfig)do
for i,btnType in ipairs(btnsList)do
if verifyManager:checkItemBtnCanUse(btnType)then
local args={
argtable=self.data,
childType=childType,
btnType=btnType,
}
outConfig[#outConfig+1]=self:getCreatConfig(nodeidx,childType,i,args)
end
end

idx=idx+1
if idx>=1 then
break
end
end
end
return outConfig
end


function UITipsCompareWin:getCreatConfig(nodeidx,childType,order,args)
local childInfo=tipsConfig.getTipsChildConfig(childType)
local temp={}
temp.name=childInfo.src
temp.parentIdx=nodeidx
temp.order=order or 0
temp.args=args
return temp
end

function UITipsCompareWin:onAniComplete()
if self.move then
self.winlua:SetChildDOLocalMoveX(self.root:getID(),_movePosX[self.move],0.3)
end
end

function UITipsCompareWin:setColorFrame(itemid)
local bundleName,assetName=tipsConfig.getTitleAsset(itemid)
if bundleName==nil or assetName==nil then
self.colorFrame:setActive(false)
return
end
self.colorFrame:setActive(true)
self.colorFrame:setSprite(bundleName,assetName)
end

function UITipsCompareWin:setColorFrameByType(colorType,color)
local bundleName,assetName=tipsConfig.getTipsAssetNameByType(colorType,color)
self.colorFrame:setActive(true)
self.colorFrame:setSprite(bundleName,assetName)
end

function UITipsCompareWin:onItemChanged(changeType,itemguid)
if changeType==CHANGE_TYPE.eDelete and tostring(itemguid)==tostring(self.itemguid)then
self:closeSelf()
end
end

function UITipsCompareWin:closeSelf()
UIManager:closeWindow('UITipsCompareWin')
end
