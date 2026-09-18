







def_class("UICommonShowPrizeFiveWin",UIWindowBase)









function UICommonShowPrizeFiveWin:bindComponents()

self.daiziEffect=UIObject.get(self,0)
self.model=UIObject.get(self,1)
self.itemName=UIText.get(self,2)
self.goBtn=UIButton.get(self,3)
self.tipsText=UIText.get(self,4)
self.effect1=UIObject.get(self,5)
self.effect2=UIObject.get(self,6)
self.bgspine=UIObject.get(self,7)
self.timeBg=UIObject.get(self,8)
self.timeTxt=UIText.get(self,9)

self.goBtn:setButtonClick(function()self:onGoBtn()end)



end


function UICommonShowPrizeFiveWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.daiziEffect);self.daiziEffect=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.itemName);self.itemName=nil;
_UIObject_release(self.goBtn);self.goBtn=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.bgspine);self.bgspine=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
end


















function UICommonShowPrizeFiveWin:onLoaded(...)
self:bindComponents()
end

function UICommonShowPrizeFiveWin:__delete()
self:unbindComponents()
end

function UICommonShowPrizeFiveWin:onShow(argtable,afterOnloaded)
local itemid=argtable.itemid
self.itemid=argtable.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local sex=playerModel:getActorSex()
local stamp=timeHelper.getServerShortTime()

local list=itemCfg.funcparam.list[sex]
local modelParams=itemCfg.funcparam.modelreceive or{}
local scale=modelParams.scale or 0.5
local offsetX=modelParams.offsetX or 0
local offsetY=modelParams.offsetY or 0
if#(list or 0)==1 and list[1][1]==10 then
local temp={}
temp[list[1][1]]=list[1][2]
comHelper.setChildPlayerImage2(self.winlua,self.model:getID(),temp,sex,scale,eAnimationID.idle,offsetX,offsetY,playerController:supportDynamic())
local time=playerImageModel:getPiTime(list[1][1],list[1][2])
self.timeBg:setActive(time>stamp)
local timeStr=timeHelper.format_time_stamp18(time-stamp)
self.timeTxt:setText(timeStr)
else
local selfImageList=playerImageModel:getPlayerImage()or
playerImageModel:getDefaultImage()
local getImageId=function(tabid)
for i,v in ipairs(list)do
if v[1]==tabid then
return v[2]
end
end
end
local temp=nil
local playerImage={}
for _,tabid in pairs(PLAYER_IMAGE_TYPE)do
local imageId=getImageId(tabid)
playerImage[tabid]=imageId or selfImageList[tabid]
if imageId and temp==nil then
temp={tabid,imageId}
end
end
if temp then
local time=playerImageModel:getPiTime(temp[1],temp[2])
self.timeBg:setActive(time>stamp)
local timeStr=timeHelper.format_time_stamp18(time-stamp)
self.timeTxt:setText(timeStr)
else
self.timeBg:setActive(false)
end

playerImageController.setPlayerModel(self.winlua,self.model:getID(),playerImage,scale,eAnimationID.idle,offsetX,offsetY,playerController:supportDynamic())
end

self.tipsText:setText('点击空白区域关闭')
self.itemName:setText(itemCfg.name)

self.bgspine:setChildUIModelShowTarget(4735,1,{},eAnimationID.idle,false,false)



end

function UICommonShowPrizeFiveWin:onHide()

end



function UICommonShowPrizeFiveWin:onClickClose()
self:closeSelf()
end

function UICommonShowPrizeFiveWin:onGoBtn()
local itemCfg=itemsConfig.getConfig(self.itemid)
local sex=playerModel:getActorSex()
local list=itemCfg.funcparam.list[sex]

local temp={}
for k,v in pairs(list)do
temp[v[1]]=v[2]
end

local tabid,idx=next(temp)

local playerImage=playerImageModel:getPlayerImage()or
playerImageModel:getDefaultImage()

for k,v in pairs(temp)do
playerImage[k]=v
end


UIManager:showWindow('UIPlayerChangeImageWin',{tabid=tabid,playerImage=playerImage})
self:closeSelf()
end