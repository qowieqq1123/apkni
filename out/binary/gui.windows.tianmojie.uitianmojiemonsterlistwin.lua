







def_class("UITianMoJieMonsterListWin",UIWindowBase)









function UITianMoJieMonsterListWin:bindComponents()

self.background=UIButton.get(self,0)
self.infoList=UIObject.get(self,1)
self.scrollView=UIObject.get(self,2)

self.background:setButtonClick(function()self:onBackground()end)



end


function UITianMoJieMonsterListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.infoList);self.infoList=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
end















local _this=nil
local _itemCmp={
widget=-1,
name=0,
button=1,
strength=2,
kuang=3,
icon=4,
progressBar=5,
}
local _colorKuang={
[monType.LittleMonster]="image_gwtouxiangpjk_2",
[monType.EliteMonster]="image_gwtouxiangpjk_3",
[monType.Boss]="image_gwtouxiangpjk_5",
[monType.BigBoss]="image_gwtouxiangpjk_5",
[monType.GodAnimal]="image_gwtouxiangpjk_5",
}



function UITianMoJieMonsterListWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onTianMoJieMonsterHPChange,self.onTianMoJieMonsterHPChange)
self:addNotify(notifyConfig.onTianMoJieMonsterChange,self.onTianMoJieMonsterChange)

self:initView()
end


function UITianMoJieMonsterListWin:__delete()
self:unbindComponents()
_this=nil

self:stopCDTick()
end




function UITianMoJieMonsterListWin:onShow(argtable,afterOnloaded)
self:refreshView()
end


function UITianMoJieMonsterListWin:onHide()

end




function UITianMoJieMonsterListWin:onBackground()
self:closeSelf()
end

function UITianMoJieMonsterListWin.onTianMoJieMonsterChange(actorid)
if mathHelper.compareInt64(actorid,_this.actorId)then
_this:refreshView()
end
end

function UITianMoJieMonsterListWin.onTianMoJieMonsterHPChange(actorid,tmguid)
if mathHelper.compareInt64(actorid,_this.actorId)then
_this:refreshView()
end
end

function UITianMoJieMonsterListWin:refreshView()
local monsters=tianMoJieModel:getMonstersByActor(self.actorId)
self.datas={}
local nowTime=timeHelper.getServerShortTime()
local tick=false
for i,v in pairs(monsters)do
local strength=self:getStrengthen(v.since,nowTime)
table.insert(self.datas,{data=v,strength=strength})
tick=tick or strength>1
end

local dataCnt=#self.datas
if dataCnt>1 then
table.sort(self.datas,function(a,b)
if a.data.percent~=b.data.percent then
return a.data.percent<b.data.percent
else
return a.strength<b.strength
end
end)
end

if dataCnt>0 then
self.infoList:setChildLayoutGroupCreateItems(dataCnt,function(index)
local item=self.infoList:getChildLayoutGroupGridItem(index-1)
local data=self.datas[index]
local monsterData=data.data
local strength=data.strength
local monsterCfg=cfgHelper.get1(cfg_tianmojiemonconfig_get,monsterData.id)
local monsterGroup=cfgHelper.get1(cfg_monstergroup_get,monsterCfg.monster)
item:SetChildText(_itemCmp.name,monsterGroup.name)
item:SetChildCSImageSprite(_itemCmp.kuang,globalABLookup.global,_colorKuang[monsterGroup.monType])
comHelper.setChildModelRawImage_monsterGroup(item,monsterCfg.monster,_itemCmp.icon,0,eHeadCenterType.eHead)
item:SetChildProgressValue(_itemCmp.progressBar,monsterData.percent,10000)
item:SetChildProgressText(_itemCmp.progressBar,FMT.fmt("血量:{0}%",monsterData.percent/100))
item:SetChildButtonClick(_itemCmp.button,function()
self:onClickButton(index)
end)
item:SetChildText(_itemCmp.strength,FMT.fmt("天魔强度：<color=#549327>{0}</color>",strength))
end)
self.scrollView:setChildSizeDelta(418,math.min(dataCnt*104+(dataCnt-1)*2+18,300))
self.winlua:ForceLayoutRect(self.scrollView:getID())
else
self:onBackground()
end

if tick then
self:startCDTick()
else
self:stopCDTick()
end
end

function UITianMoJieMonsterListWin:initView()
local sfId=zongmenModel:getMountainId()
self.actorId=sfId==mapIdType.zhufeng_hy and visitControl:getCurrentActor()or playerModel:getActorID()

self.baseCfg=cfgHelper.get1(cfg_tianmojiebaseconfig_get,1)
local weakCnt=#self.baseCfg.faze
self.strengthDuration={}
for index=1,self.baseCfg.strength do
local weakIndx=self.baseCfg.strength-index
local cfg=self.baseCfg.faze[weakIndx]
local duration=cfg and cfg[1]or 0
self.strengthDuration[index]=duration
end
end

function UITianMoJieMonsterListWin:onClickButton(index)
local data=self.datas[index]
local monsterGuid=data.data.guid
local sfId=zongmenModel:getMountainId()
tianMoJieController:lookAtMonster(sfId,monsterGuid)

self:closeSelf()
end

function UITianMoJieMonsterListWin:getStrengthen(since,nowTime)
nowTime=nowTime or timeHelper.getServerShortTime()
local pass=nowTime-since
for i,v in ipairs(self.strengthDuration)do
if pass>v then
return i
end
end
return 0
end

function UITianMoJieMonsterListWin:startCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UITianMoJieMonsterListWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UITianMoJieMonsterListWin:updateCDTick()
local nowTime=timeHelper.getServerShortTime()
for i,v in ipairs(self.datas)do
local monsterData=v.data
local nStrength=self:getStrengthen(monsterData.since,nowTime)
if v.strength~=nStrength then
self:refreshView()
return
end
end
end