







def_class("UIWuXingDianShouTongWin",UIWindowBase)









function UIWuXingDianShouTongWin:bindComponents()

self.Content=UIObject.get(self,0)



end


function UIWuXingDianShouTongWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Content);self.Content=nil;
end

















local _wxdCMP={2,3,4,5,6}

function UIWuXingDianShouTongWin:onLoaded(...)
self:bindComponents()
local cfgs=cfg_fiveelementstempleshoutongconfig()
self.cfgs=cfgs
self.init=true
end

function UIWuXingDianShouTongWin:__delete()
self:unbindComponents()
self.init=false
end

function UIWuXingDianShouTongWin:onShow(argtable,afterOnloaded)
if not wuXingDianController:send_25_22()then
self:freshInfo()
end
end

function UIWuXingDianShouTongWin:onHide()

end




function UIWuXingDianShouTongWin:freshInfo()

local cfgs=self.cfgs
local len=#cfgs
self.winlua:SetChildLayoutGroupCreateItems(self.Content:getID(),len,function(index)
self:fillItem(index)
end)

if self.init then
self.init=false
local selectIdx
for i=1,len do
local cfg=cfgs[i]
local id=cfg.id
local layer=cfg.layer
local canPrize=wuXingDianModel:isCanPrizeShouTong(id)
if canPrize then
selectIdx=i
break
end
end

if selectIdx==nil then selectIdx=1 end
selectIdx=selectIdx or 1
self:jumpIndex(selectIdx,0.5)
end
end

function UIWuXingDianShouTongWin:fillItem(index)
local cfgs=self.cfgs
local cfg=cfgs[index]
local id=cfg.id
local layer=cfg.layer
local reward=cfg.rewards

local widget=self.winlua:GetChildLayoutGroupGridItem(self.Content:getID(),index-1)
widget:SetChildText(0,FMT.fmt('{0}层',layer))

local widget1=widget:GetChildWidgetBase(1)
local widget2=widget1:GetChildWidgetBase(0)

local isPrize=wuXingDianModel:isAllPrizeShouTong(id)
local canPrize=wuXingDianModel:isCanPrizeShouTong(id)
local actorInfoLookup=wuXingDianModel:getShouTongInfo(id)or{}
local recordlen=wuXingDianModel:getShouTongLen(id)
local recordprizelen=wuXingDianModel:getShouTongPrizeLen(id)
local left=recordlen-recordprizelen

local num=0
for _,wxdId in pairs(wuXingDianBaseType)do
local actorinfo=actorInfoLookup[wxdId]
local cmp=_wxdCMP[wxdId]
local widget3=widget:GetChildWidgetBase(cmp)
widget3:SetChildActive(3,actorinfo==nil)
if actorinfo then
num=num+1
local name=playerModel:getOtherActorName(actorinfo.name)
if actorinfo.name and actorinfo.name~=''then
widget3:SetChildActive(0,true)
playerController:setHeadIcon(widget3,0,{iconInfo=actorinfo.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
widget3:SetChildText(1,FMT.fmt('<color=#ca631d>{0}</color>\n{1}',actorinfo.zm_name,actorinfo.name))
widget3:SetChildActive(4,true)
widget3:SetChildButtonClick(4,function()
otherPlayerController:reqOtherZRInfo(actorinfo.actor_id,otherPlayerInfoType.eSDShouTong,{wxdId=wxdId,id=id})
end,true)
else
widget3:SetChildActive(3,true)
widget3:SetChildText(3,name)
widget3:SetChildIcon(2,'image_txdk_1',false)
widget3:SetChildText(1,'')
widget3:SetChildActive(0,false)
widget3:SetChildActive(4,false)
end
else
widget3:SetChildIcon(2,'image_txdk_1',false)
widget3:SetChildText(1,'')
widget3:SetChildActive(0,false)
widget3:SetChildActive(4,false)
end
end

local data={}
local itemid=reward[1]
data[1]=itemid
data[2]=reward[2]
data.showStage=true
data.clickFunc=function()
if canPrize then
socketManager:send_25_23()
else
tipsManager.showTips({formType=TIPS_FORM_TYPE.eClearBtn,
itemid=itemid})
end
end
widgetHelper.setNormalRewardItem(widget1,0,data)




widget1:SetChildActive(1,num>=5 and isPrize)
widget1:SetChildActive(2,canPrize)
widget1:SetChildActive(3,num>=5 and isPrize)
widget1:SetChildActive(4,left>=1)
widget1:SetChildText(5,left)
end

function UIWuXingDianShouTongWin:jumpIndex(index,delay)
local jump=function()
if self==nil or self.isClose then return end
local r=index
local viewHeight=463
local contentHeight=self.winlua:GetChildSizeDeltaY(self.Content:getID())
local itemHeight=130
local posY=(r-1)*itemHeight
if posY<=0 then posY=0 end
local div=contentHeight-viewHeight
if div<0 then div=0 end
if posY>div then posY=div end
self.winlua:SetChildAnchoredPos(self.Content:getID(),0,posY)
end
if self.jumpTimer then
self:stopTimerByID(self.jumpTimer)
end
self.jumpTimer=self:delayDo(delay,function()
jump()
end)
end