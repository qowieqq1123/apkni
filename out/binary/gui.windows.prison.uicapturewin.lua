







def_class("UICaptureWin",UIWindowBase)









function UICaptureWin:bindComponents()

self.applyBtn=UIButton.get(self,0)
self.descText=UIText.get(self,1)
self.fanren=UIObject.get(self,2)
self.jiuyou_left=UIObject.get(self,3)
self.jiuyou_right=UIObject.get(self,4)
self.jumpBtn=UIButton.get(self,5)
self.jyCost=UIText.get(self,6)
self.jyicon=UIButton.get(self,7)
self.moneyText=UIText.get(self,8)
self.scrollview=UIObject.get(self,9)
self.talk=UIObject.get(self,10)

self.applyBtn:setButtonClick(function()self:onApplyBtn()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.jyicon:setButtonClick(function()self:onJyicon()end)
self.jiuyou={
["left"]=self.jiuyou_left,
["right"]=self.jiuyou_right,
}



end


function UICaptureWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.applyBtn);self.applyBtn=nil;
_UIObject_release(self.descText);self.descText=nil;
_UIObject_release(self.fanren);self.fanren=nil;
_UIObject_release(self.jiuyou_left);self.jiuyou_left=nil;
_UIObject_release(self.jiuyou_right);self.jiuyou_right=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.jyCost);self.jyCost=nil;
_UIObject_release(self.jyicon);self.jyicon=nil;
_UIObject_release(self.moneyText);self.moneyText=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.talk);self.talk=nil;
self.jiuyou=nil;
end



















function UICaptureWin:onLoaded(...)
self:bindComponents()

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
end


function UICaptureWin:__delete()
self:unbindComponents()
end




function UICaptureWin:onShow(argtable,afterOnloaded)
local list
local data
local isMonster

if argtable.list then
list=argtable.list
end

if argtable.data then
data=argtable.data
end

if argtable.isMonster then
isMonster=argtable.isMonster
end

self.closeCallback=argtable.closeCallback

if systemModel.isOpen(SYSTEM_DEFINE.eXianJieXianYu)then
if isMonster then
self.descText:setText("俘虏已被自动押送到宗门魔狱")
else
self.descText:setText("俘虏已被自动押送到宗门仙狱")
end
else
self.descText:setText("俘虏已被自动押送到宗门牢狱")
end

if list then
self.scrollview:setActive(true)
self:refreshLaoLong(list,isMonster)
else
self.scrollview:setActive(false)
end

if data then
self:refreshSjjy(data)
end
end


function UICaptureWin:onHide()

end

function UICaptureWin:refreshSjjy(data)
local scale=1
local baseCfg=cfg_laoyubaseconfig_get(1)
local jyCfg=baseCfg.sjjy
local cost=jyCfg[2][1][3]
cost=cost[1]
local itemId=cost[1]
local itemCount=cost[2]
self.moneyText:setActive(true)
self.jyicon:setIcon(iconHelper.getIconName(itemId),false)
self.jyCost:setText(itemCount)

self.talk:setActive(true)
self.jumpBtn:setActive(true)
self.descText:setText("仙狱暂无可关押的合适牢位，现已上交九幽")

self.jiuyou_left:setActive(true)
self.jiuyou_left:setChildUIModelShowTarget(1113029,scale,{},eAnimationID.stand)

self.jiuyou_right:setActive(true)
self.jiuyou_right:setChildUIModelShowTarget(1113024,scale,{},eAnimationID.stand)

self.fanren:setActive(true)
local info=UIDiscipleModel:getDiscipleOutsideModelInfo(data.discipleguid)
local scale=isometricMapSystem:getModelScale(info.body,true)
self.fanren:setChildUIModelShowTarget(info.body,scale,info.componets,eAnimationID.stand)
end

function UICaptureWin:refreshLaoLong(datas,isMonster)
local len=#datas
self.scrollview:setChildScrollViewCreateGrids(len,len)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=datas[i]
if not isMonster then
local info=UIDiscipleModel:getDiscipleOutsideModelInfo(data.discipleguid)
local scale=isometricMapSystem:getModelScale(info.body,true)
item:SetChildUIModelShowTarget(0,info.body,scale,info.componets,eAnimationID.stand)
else
local mowuId=tonumber(tostring(data.fuluGuid))
local mowuCfg=cfgHelper.get(cfg_fairylandinfoconfig003_get,mowuId)
local monsterGroupid=mowuCfg.monster[1]
local monsterGroupCfg=cfgHelper.get(cfg_monstergroup_get,monsterGroupid)
local monsterid
for k,v in ipairs(monsterGroupCfg.monList)do
if v>0 then
monsterid=v
break
end
end

local monsterCfg=cfgHelper.get(cfg_monsterconfig_get,monsterid)
local scaleParam=monsterCfg.laoyuModelParam or{}
local scale=scaleParam.scale or(monsterCfg.scale~=nil and monsterCfg.scale*0.8)or 0.6
local modelParams=comHelper.getMonsterGroupModelParams(monsterGroupid)

item:SetChildUIModelShowTarget(0,modelParams.body,scale,modelParams.componets,eAnimationID.stand)
end
end
end





function UICaptureWin:onApplyBtn()
self:onCloseClick()
end

function UICaptureWin:onCloseClick()
if self.closeCallback then
self.closeCallback()
end
self:closeSelf()
end

function UICaptureWin:onJumpBtn()
jumpManager:jump({id=JUMP_TYPE.eBuilding,
args={type=SLG_SYSTEM_TYPE.eLaoYu}},
nil,JUMP_BACK.eNoBack)
end