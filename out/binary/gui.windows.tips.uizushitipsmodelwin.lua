







def_class("UIZuShiTipsModelWin",UIWindowBase)









function UIZuShiTipsModelWin:bindComponents()

self.model=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.model2=UIObject.get(self,2)
self.liandon=UIObject.get(self,3)
self.liandonImage=UIImage.get(self,4)
self.liandonTimeBg=UIImage.get(self,5)
self.liandonTimeText=UIText.get(self,6)



end


function UIZuShiTipsModelWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.model2);self.model2=nil;
_UIObject_release(self.liandon);self.liandon=nil;
_UIObject_release(self.liandonImage);self.liandonImage=nil;
_UIObject_release(self.liandonTimeBg);self.liandonTimeBg=nil;
_UIObject_release(self.liandonTimeText);self.liandonTimeText=nil;
end


















function UIZuShiTipsModelWin:onLoaded(...)
self:bindComponents()
end

function UIZuShiTipsModelWin:__delete()
self:unbindComponents()
end

function UIZuShiTipsModelWin:onShow(argtable,afterOnloaded)
local itemid=argtable.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local sex=playerModel:getActorSex()

local list=itemCfg.funcparam.list[sex]
local modelParams=itemCfg.funcparam.model or{}
local scale=modelParams.scale or 0.5
local offsetX=modelParams.offsetX or 0
local offsetY=modelParams.offsetY or 0
local show=itemCfg.funcparam.show


if#(list or 0)==1 and list[1][1]==10 then










local temp={}
temp[list[1][1]]=list[1][2]
comHelper.setChildPlayerImage2(self.winlua,self.model2:getID(),temp,sex,scale,eAnimationID.idle,offsetX,offsetY,playerController:supportDynamic())
elseif show then
local playerImage={}
local showParams=show[sex]
for _,v in pairs(showParams)do
playerImage[v[1]]=v[2]
end

for _,tabid in pairs(PLAYER_IMAGE_TYPE)do
playerImage[tabid]=playerImage[tabid]or 0

end

playerImageController.setPlayerModel(self.winlua,self.model:getID(),playerImage,scale,eAnimationID.idle,offsetX,offsetY,playerController:supportDynamic())
else
local selfImageList=playerImageModel:getDefaultImage()

local lookup={}
for i,v in ipairs(list)do
lookup[v[1]]=v[2]
end

local isSupport=function(tabid,id)
local mcfg=playerImageConfig.getSubConfig(tabid,id)
for k,v in pairs(list)do

if tabid==v[1]then return false end
local cfg=playerImageConfig.getSubConfig(v[1],v[2])
if cfg and not playerImageModel:isSupportTab(cfg.support,tabid)then
return false
end
if cfg and not playerImageModel:isSupportByCfg(cfg.support,tabid,id)then
return false
end

if mcfg and not playerImageModel:isSupportByCfg(mcfg.support,v[1],v[2])then
return false
end
end
return true
end

for tabid,id in pairs(selfImageList)do
if not isSupport(tabid,id)then
selfImageList[tabid]=nil
end
end

local playerImage={}
for _,tabid in pairs(PLAYER_IMAGE_TYPE)do
playerImage[tabid]=lookup[tabid]or selfImageList[tabid]
end
playerImageController.setPlayerModel(self.winlua,self.model:getID(),playerImage,scale,eAnimationID.idle,offsetX,offsetY,playerController:supportDynamic())
end

self.winlua:SetChildDOTweenAnimation_DOPlay(self.root:getID(),1,0,3)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.root:getID(),2,0,3)

self.liandon:setActive(false)
for i,v in pairs(list)do
local linkageId=liandonModel:getLianDonLinkageIdByPlayerImageItem(v[1],v[2])
if linkageId>0 then
self:showLianDon(linkageId)
break
end
end
end

function UIZuShiTipsModelWin:showLianDon(linkageId)
self.liandon:setActive(linkageId>0)
if linkageId>0 then
self.winlua:SetChildDOTweenAnimation_DOPlay(self.liandon:getID(),1,0,3)
local liandonCfg=liandonModel:getLianDonConfig(linkageId or 1)
self.liandonImage:setSprite(globalABLookup.liandonLogin,liandonCfg.image)
self.liandonTimeBg:setActive(false)


end
end

function UIZuShiTipsModelWin:onHide()

end



function UIZuShiTipsModelWin:onAniComplete()
self.winlua:SetChildDOLocalMoveX(self.root:getID(),-300,0.3)
end
