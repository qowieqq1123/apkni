







def_class("UITianMoJieMonsterListWin2",UIWindowBase)









function UITianMoJieMonsterListWin2:bindComponents()

self.arrow=UIObject.get(self,0)
self.background=UIButton.get(self,1)
self.infoList=UIObject.get(self,2)
self.root=UIObject.get(self,3)
self.scrollView=UIObject.get(self,4)

self.background:setButtonClick(function()self:onBackground()end)



end


function UITianMoJieMonsterListWin2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.infoList);self.infoList=nil;
_UIObject_release(self.root);self.root=nil;
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



function UITianMoJieMonsterListWin2:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onTianMoJieMonsterHPChange,self.onTianMoJieMonsterHPChange)
self:addNotify(notifyConfig.onTianMoJieMonsterChange,self.onTianMoJieMonsterChange)

self:initView()
end


function UITianMoJieMonsterListWin2:__delete()
self:unbindComponents()
_this=nil

self:stopCDTick()
end




function UITianMoJieMonsterListWin2:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.arrow:setChildAnchoredPosition(argtable.arrow)
self:refreshView()
self:startCDTick()
end


function UITianMoJieMonsterListWin2:onHide()

end




function UITianMoJieMonsterListWin2:onBackground()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
UIManager:closeWindow(self.__name)
end
end

function UITianMoJieMonsterListWin2.onTianMoJieMonsterChange(actorid)
if mathHelper.compareInt64(actorid,_this.actorId)then
_this:refreshView()
end
end

function UITianMoJieMonsterListWin2.onTianMoJieMonsterHPChange(actorid,tmguid)
if mathHelper.compareInt64(actorid,_this.actorId)then
_this:refreshView()
end
end

function UITianMoJieMonsterListWin2:initView()
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
self.strengthRecord={}
end

function UITianMoJieMonsterListWin2:refreshView()
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

local height=math.min(18+dataCnt*104+(dataCnt-1)*2,300)
self.root:setChildSizeDelta(418,height)
self.scrollView:setChildScrollRectEnable(dataCnt>3)
else
self:onBackground()
end
end

function UITianMoJieMonsterListWin2:onClickButton(index)
local data=self.datas[index]
local monsterGuid=data.data.guid
local sfId=zongmenModel:getMountainId()
tianMoJieController:lookAtMonster(sfId,monsterGuid)

self:closeSelf()
end

function UITianMoJieMonsterListWin2:refreshItemStrength(index,item,data,nowTime)
item=item or self.infoList:getChildLayoutGroupGridItem(index-1)
data=data or self.datas[index]
nowTime=nowTime or timeHelper.getServerShortTime()
local pass=nowTime-data.since
for i,v in ipairs(self.strengthDuration)do
if pass>v then
self.strengthRecord[index]=i
item:SetChildText(_itemCmp.strength,FMT.fmt("天魔强度：{0}",i))
return
end
end
self.strengthRecord[index]=0
item:SetChildText(_itemCmp.strength,FMT.fmt("天魔强度：{0}",0))
end

function UITianMoJieMonsterListWin2:startCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UITianMoJieMonsterListWin2:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UITianMoJieMonsterListWin2:updateCDTick()
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

function UITianMoJieMonsterListWin2:getStrengthen(since,nowTime)
nowTime=nowTime or timeHelper.getServerShortTime()
local pass=nowTime-since
for i,v in ipairs(self.strengthDuration)do
if pass>v then
return i
end
end
return 0
end