







def_class("UITipsWin",UIWindowBase)









function UITipsWin:bindComponents()

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
self.nodeExt=UIObject.get(self,12)
self.extPage=UIObject.get(self,13)
self.colorFrame=UIImage.get(self,14)
self.frameBg=UIObject.get(self,15)
self.btnCreater=UIGameobjectClone.new(self,16)
self.followCreater=UIGameobjectClone.new(self,17)
self.frontClickMask=UIObject.get(self,18)
self.bg=UIButton.get(self,19)
self.bottomEffect=UIObject.get(self,20)
self.topEffect=UIObject.get(self,21)
self.nodeExMiddle=UIObject.get(self,22)
self.middleCreater=UIGameobjectClone.new(self,23)
self.root2=UIObject.get(self,24)
self.bgSpine=UIObject.get(self,25)

self.bg:setButtonClick(function()self:onBg()end)



end


function UITipsWin:unbindComponents()
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
_UIObject_release(self.nodeExt);self.nodeExt=nil;
_UIObject_release(self.extPage);self.extPage=nil;
_UIObject_release(self.colorFrame);self.colorFrame=nil;
_UIObject_release(self.frameBg);self.frameBg=nil;
self.btnCreater:deleteSelf();self.btnCreater=nil;
self.followCreater:deleteSelf();self.followCreater=nil;
_UIObject_release(self.frontClickMask);self.frontClickMask=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.bottomEffect);self.bottomEffect=nil;
_UIObject_release(self.topEffect);self.topEffect=nil;
_UIObject_release(self.nodeExMiddle);self.nodeExMiddle=nil;
self.middleCreater:deleteSelf();self.middleCreater=nil;
_UIObject_release(self.root2);self.root2=nil;
_UIObject_release(self.bgSpine);self.bgSpine=nil;
end















UITipsWin.movePosX=
{
[TIPS_MOVE_POS.eDefault]=226.2,
[TIPS_MOVE_POS.eRight]=276,
[TIPS_MOVE_POS.eLeft]=-276,
[TIPS_MOVE_POS.eCenter]=0,
[TIPS_MOVE_POS.eRightTwo]=330,
[TIPS_MOVE_POS.eLeftTwo]=-175,
[TIPS_MOVE_POS.eRightThree]=300,
}



function UITipsWin:onLoaded(...)
self:bindComponents()
self._onItemChanged=function(...)self:onItemChanged(...)end
notifySystem:listenNotify(notifyConfig.on_item_changed,self._onItemChanged)
end


function UITipsWin:__delete()
if self.closeCallback then
self.closeCallback()
self.closeCallback=nil
end
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_item_changed,self._onItemChanged)
if self.activeBackName then
UIManager:closeWindow(self.activeBackName)
end
local itemguid=self.itemguid
UIManager:callWindowFunc('UIBagWin','clearSelectFlag',itemguid)
tipsCompareManager.closeTips()
self.modelWin=nil
end


function UITipsWin:onShow(argtable,afterOnloaded)
local tipsType=argtable.tipsType
local cfgType=argtable.cfgType
local itemid=argtable.itemid
local itemguid=argtable.itemguid
local backType=argtable.backType or TIPS_BACK_TYPE.eNomal
local isExtraTips=argtable.isExtraTips
self.cfgType=cfgType

if tipsType==nil then
logErr('没有传递tips类型')
return
end
if itemid==nil then
logErr('没有传递itemid')
return
end

if afterOnloaded then
if argtable.openCallBack then
argtable.openCallBack()
end
end



self.closeCallback=argtable.closeCallback

local lastData=self.data
self.data=argtable



if self:compareData(lastData,argtable)then return end



self.itemguid=itemguid
self.itemid=itemid
self.tipsType=tipsType
self.move=argtable.move
self.movepos=argtable.movepos
self.backType=backType
self.offsetY=argtable.offsetY
self:freshConfig(argtable)




self:showModel(argtable)


self:showBack(argtable)


self:showColorBg(argtable)


self:showSpineBg(argtable)


self:showEffect(argtable)


self:showTips(argtable)
end

function UITipsWin:compareData(lastTable,nowTable)
if lastTable==nil or
lastTable.tipsType~=nowTable.tipsType or
lastTable.itemid~=nowTable.itemid or
not mathHelper.compareInt64(lastTable.itemguid,nowTable.itemguid)then
self.serializeStr=serializeHelper.serialize(nowTable)
return false
end
local lastSerialize=self.serializeStr
local nowSerialize=serializeHelper.serialize(nowTable)
self.serializeStr=nowSerialize
return lastSerialize==nowSerialize
end


function UITipsWin:freshConfig(argtable)
local tipsType=self.tipsType
self.bodyConfig=self:getBodysConfig(tipsType,argtable)
self.btnConfig=self:getBtnsConfig(tipsType,argtable)
self.extConfig=self:getExtConfig(tipsType,argtable)
self.extMidConfig=self:getMiddleExtConfig(tipsType,argtable)
end


function UITipsWin:getBodysConfig(tipsType,argtable)
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


function UITipsWin:getBtnsConfig(tipsType,argtable)
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


function UITipsWin:getCreatConfig(nodeidx,childType,order,args)
local childInfo=tipsConfig.getTipsChildConfig(childType)
local temp={}
temp.name=childInfo.src
temp.parentIdx=nodeidx
temp.order=order or 0
temp.args=args
return temp
end


function UITipsWin:getExtConfig(tipsType,argtable)
local exBodysConfig=argtable.exBodysConfig
if exBodysConfig==nil or#exBodysConfig==0 then return end
local nodeidx=self.nodeExt:getID()
local outConfig={}
for i,childType in ipairs(exBodysConfig)do
local args={
argtable=self.data,
childType=childType,
parentIdx=nodeidx,
}
outConfig[#outConfig+1]=self:getCreatConfig(nodeidx,childType,i,args)
end

return outConfig
end


function UITipsWin:getMiddleExtConfig(tipsType,argtable)
local exMidBodysConfig=argtable.exMidBodysConfig
if exMidBodysConfig==nil or#exMidBodysConfig==0 then return end
local nodeidx=self.nodeExMiddle:getID()
local outConfig={}
for i,childType in ipairs(exMidBodysConfig)do
local args={
argtable=self.data,
childType=childType,
parentIdx=nodeidx,
}
outConfig[#outConfig+1]=self:getCreatConfig(nodeidx,childType,i,args)
end

return outConfig
end


function UITipsWin:showModel(argtable)
local itemid=argtable.itemid
local showModel=argtable.showModel or false
local modelArgs=argtable.modelArgs
if showModel then
self.modelWin=modelArgs.win
self:showWindow(modelArgs.win,modelArgs.args)
else
self:closeModel()
end
end



function UITipsWin:showBack(argtable)

local backType=self.backType
if backType==TIPS_BACK_TYPE.eSelfBack then
self.bg:setActive(true)
else
self.bg:setActive(false)
local backName=tipsConfig.getTipsBackWinName(backType)
if backName and not UIManager:isActive(backName,true)then
self.activeBackName=backName
self:showWindow(backName)
end
end
end


function UITipsWin:showColorBg(argtable)
local defaultBg=argtable.bg
local itemid=argtable.itemid
if defaultBg~=false then
if argtable.colorType then
local color=argtable.attach.color or itemsConfig.getConfig(itemid,self.cfgType).color
self:setColorFrameByType(argtable.colorType,color)
else
self:setColorFrame(itemid,argtable.attach.color)
end
end
end

function UITipsWin:setColorFrame(itemid,color)
local bundleName,assetName=tipsConfig.getTitleAsset(itemid,color)
if bundleName==nil or assetName==nil then
self.colorFrame:setActive(false)
return
end
self.colorFrame:setActive(true)
self.colorFrame:setSprite(bundleName,assetName)
end

function UITipsWin:setColorFrameByType(colorType,color)
local bundleName,assetName=tipsConfig.getTipsAssetNameByType(colorType,color)
self.colorFrame:setActive(true)
self.colorFrame:setSprite(bundleName,assetName)
end


function UITipsWin:showSpineBg(argtable)
local bgSpine
if self.tipsType~=TIPS_TYPE.eChiSeJinDiWeapon then
local itemid=argtable.itemid
local cfg,cfg2=itemsConfig.getConfig(itemid,self.cfgType)

if cfg and cfg.bgSpine then
bgSpine=cfg.bgSpine
elseif cfg2 and cfg2.bgSpine then
bgSpine=cfg2.bgSpine
elseif argtable and argtable.bgSpine then
bgSpine=argtable.bgSpine
end
end

if bgSpine then
local model=bgSpine[1]
local size=bgSpine[2]or 1
local anim=bgSpine[3]or eAnimationID.enter
self.bgSpine:setChildUIModelShowTarget(model,size,{},anim)
else
self.bgSpine:setChildUIModelRemoveTarget()
end
end

function UITipsWin:showEffect(argtable)
local effect=argtable.effect or{}
local topEffect=effect.top
local bottom=effect.bottom
local show=false
if topEffect then
self.topEffect:setChildShowEffect(topEffect,true)
show=true
else
self.topEffect:setChildShowEffect(0,false)
end

if bottom then
self.bottomEffect:setChildShowEffect(bottom,true)
show=true
else
self.bottomEffect:setChildShowEffect(0,false)
end
if show then
self.winlua:SetChildCanvasEx(11,'',1001)
end
end



function UITipsWin:showTips(argtable)
local tipsType=self.tipsType
local bodyConfig=self.bodyConfig
local btnConfig=self.btnConfig
local extConfig=self.extConfig
local extMidConfig=self.extMidConfig
self.winlua:SetChildDOTweenAnimation_DOPlay(self.root:getID(),1,0,3)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.root:getID(),2,0,3)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.root2:getID(),1,0,3)
self.btnCreater:createObjectList(btnConfig)
self.creater:createObjectList(bodyConfig)
self.followCreater:createObjectList(extConfig)
self.middleCreater:createObjectList(extMidConfig)
end



function UITipsWin:freshAllBtnReddot()
self.btnCreater:callAllChildFunc('refreshReddot')
end


function UITipsWin:onAniComplete()
if self.offsetY then
self.winlua:SetChildAnchoredPos(self.root:getID(),0,self.offsetY)
end
if self.move then
self.winlua:SetChildDOLocalMoveX(self.root:getID(),self.movePosX[self.move],0.3)
end
end

function UITipsWin:onItemChanged(changeType,itemguid)
if changeType==CHANGE_TYPE.eDelete and tostring(itemguid)==tostring(self.itemguid)then
self:closeSelf()
end
end

function UITipsWin:closeSelf()
tipsManager.clearCache()
UIManager:closeWindow('UITipsWin')
end

function UITipsWin:closeModel()
if self.modelWin then
UIManager:closeWindow(self.modelWin)
end
self.modelWin=nil
end

function UITipsWin:onBg()
tipsManager.closeTips()
end

function UITipsWin:onClickOutArea()

end