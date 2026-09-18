







def_class("UIXianJie_monsterTeamWin",UIWindowBase)









function UIXianJie_monsterTeamWin:bindComponents()

self.background=UIButton.get(self,0)
self.baseTime=UIText.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.monsterIcon=UIObject.get(self,3)
self.monsterKuang=UIImage.get(self,4)
self.monsterModel=UIObject.get(self,5)
self.monsterName=UIText.get(self,6)
self.teamList=UIObject.get(self,7)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXianJie_monsterTeamWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.baseTime);self.baseTime=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.monsterIcon);self.monsterIcon=nil;
_UIObject_release(self.monsterKuang);self.monsterKuang=nil;
_UIObject_release(self.monsterModel);self.monsterModel=nil;
_UIObject_release(self.monsterName);self.monsterName=nil;
_UIObject_release(self.teamList);self.teamList=nil;
end















local _this=nil
local _itemCmp={
no=0,
mate=1,
content=2,
desc=3,
timeBg=4,
time=5,
people=6,
}
local _stateType={
eGathering=1,
eOnTheWay=2,
eInBattle=3,
}
local _stateColor={
[_stateType.eGathering]="#3172C0",
[_stateType.eOnTheWay]="#55942A",
[_stateType.eInBattle]="#CC6C2A",
}
local _stateName={
[_stateType.eGathering]="集结中",
[_stateType.eOnTheWay]="出击中",
[_stateType.eInBattle]="战斗中",
}
local _colorKuang={
[xjServerEnityType.eMonster]={
[0]="image_gwtouxiangpjk_2",
[1]="image_gwtouxiangpjk_3",
[2]="image_gwtouxiangpjk_3",
},
[xjServerEnityType.eBossMonster]={
[0]="image_gwtouxiangpjk_4",
[1]="image_gwtouxiangpjk_3",
[2]="image_gwtouxiangpjk_3",
},
[xjServerEnityType.eMonsterHouse]={
[0]="image_gwtouxiangpjk_5",
[1]="image_gwtouxiangpjk_5",
[2]="image_gwtouxiangpjk_5",
},

[xjServerEnityType.eMoJieMoZong_Small]={
[0]="image_gwtouxiangpjk_4",
[1]="image_gwtouxiangpjk_3",
[2]="image_gwtouxiangpjk_3",
},
[xjServerEnityType.eMoJieMoZong_Big]={
[0]="image_gwtouxiangpjk_5",
[1]="image_gwtouxiangpjk_5",
[2]="image_gwtouxiangpjk_5",
},
[xjServerEnityType.eMoJieMoster]={
[0]="image_gwtouxiangpjk_2",
[1]="image_gwtouxiangpjk_3",
[2]="image_gwtouxiangpjk_3",
},
[xjServerEnityType.eMoJieShangGuMoster]={
[0]="image_gwtouxiangpjk_3",
[1]="image_gwtouxiangpjk_3",
[2]="image_gwtouxiangpjk_3",
},
[xjServerEnityType.eMoJieZhenYan_Small]={
[0]="image_gwtouxiangpjk_4",
[1]="image_gwtouxiangpjk_3",
[2]="image_gwtouxiangpjk_3",
},
[xjServerEnityType.eMoJieZhenYan_Spe]={
[0]="image_gwtouxiangpjk_4",
[1]="image_gwtouxiangpjk_3",
[2]="image_gwtouxiangpjk_3",
},
[xjServerEnityType.eMoJieZhenYan_Big]={
[0]="image_gwtouxiangpjk_5",
[1]="image_gwtouxiangpjk_5",
[2]="image_gwtouxiangpjk_5",
},
}
local _showModel={
[xjServerEnityType.eMonster]=false,
[xjServerEnityType.eBossMonster]=false,
[xjServerEnityType.eMonsterHouse]=false,

[xjServerEnityType.eMoJieMoZong_Small]=false,
[xjServerEnityType.eMoJieMoZong_Big]=false,
[xjServerEnityType.eMoJieMoster]=false,
[xjServerEnityType.eMoJieShangGuMoster]=false,
[xjServerEnityType.eMoJieZhenYan_Spe]=false,
[xjServerEnityType.eMoJieZhenYan_Big]=false,
[xjServerEnityType.eMoJieZhenYan_Small]=false,
}



function UIXianJie_monsterTeamWin:onLoaded(...)
self:bindComponents()
_this=self

self:addProNotify(35,63,self.on_35_63)

self.itemDatas={}
end


function UIXianJie_monsterTeamWin:__delete()
self:unbindComponents()
_this=nil

self:stopCDTick()
end




function UIXianJie_monsterTeamWin:onShow(argtable,afterOnloaded)
self.closeFunc=argtable.closeFunc
self.parentWin=argtable.parentWin
self.infoguid=argtable.infoguid
self.monsterData=xianjieModel:getMonsterData(self.infoguid)
self:refreshMonsterInfo()
self:refreshTeamList()
end


function UIXianJie_monsterTeamWin:onHide()

end




function UIXianJie_monsterTeamWin:onBackground()
self:onCloseBtn()
end


function UIXianJie_monsterTeamWin:onCloseBtn()
if self.closeFunc then
self.closeFunc()
elseif self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self.closeSelf()
end
end

function UIXianJie_monsterTeamWin.on_35_63(infoguid)
if _this.infoguid==infoguid then
_this:refreshTeamList()
end
end

function UIXianJie_monsterTeamWin:refreshMonsterInfo()
local cfg=self.monsterData:getCfg()
local group=cfg.monster[1]
local groupCfg=cfgHelper.get1(cfg_monstergroup_get,group)


self.monsterName:setText(groupCfg.name)
local time=math.ceil(self.monsterData:getBaseWayTime())
self.baseTime:setText(timeHelper.format_time_stamp3(time))

if not _showModel[self.monsterData.entitytype]then

self.monsterKuang:setActive(true)
self.monsterModel:setChildUIModelRemoveTarget()
self.monsterKuang:setSprite(globalABLookup.global,_colorKuang[self.monsterData.entitytype][cfg.flag or 0])
comHelper.setChildModelRawImage_monsterGroup(self.winlua,group,self.monsterIcon:getID(),0,eHeadCenterType.eHead)
else
self.monsterKuang:setActive(false)

local uiModelParam=cfg.uiModelParam or{}
local size=uiModelParam.size or groupcfg.model[2]*0.4
self.monsterModel:setChildUIModelShowTarget(cfg.modelSet.model,size,cfg.modelSet.components,eAnimationID.stand,false,false,0)
local offset=uiModelParam.offset or{0,0}
self.monsterModel:setChildUIModelShowTargetOffset(offset[1],offset[2])
local isFlip=uiModelParam.isFlip and uiModelParam.isFlip==1 or false
self.monsterModel:setChildUIModelShowFlipX(isFlip)
end
end

function UIXianJie_monsterTeamWin:refreshTeamList()
table.clear(self.itemDatas)
local teamInfos=xianjieModel:readMonsterTeamInfo(self.infoguid)
local needCD=false
if teamInfos then
for idx,info in ipairs(teamInfos.data)do
local data=nil
local zmData=xianjieModel:getZongMenData(info.actorid)
local xmId=zmData.guildid
local actorName=zmData.actorname
local mate=xianmengModel:checkActorInXM(info.actorid)
local xmData=xianjieModel:getXianMengData(xmId)
local xmName=xmData and xmData.guildname or nil
local count=info.teamnum
if info.marchguid>0 then
local marchData=xianjieModel:getMarchTeamData(info.marchguid)
if marchData then
local teamHandle=marchData:getTeamHandle()
if teamHandle and teamHandle.teamType==xjTeamHandleType.eMarchKill or teamHandle.teamType==xjTeamHandleType.eJiJieChuZheng then
local state,times=teamHandle:getTeamState()
if state==xjMarchTeamStateType.eGoto then
data={
index=idx,
xmName=xmName,
actorName=actorName,
mate=mate,
count=count,
state=_stateType.eOnTheWay,
endTime=times[2],
}
needCD=true
elseif state==xjMarchTeamStateType.eBattle then
data={
index=idx,
xmName=xmName,
actorName=actorName,
count=count,
mate=mate,
state=_stateType.eInBattle,
}
end
end
end
else
data={
index=idx,
xmName=xmName,
actorName=actorName,
count=count,
mate=mate,
state=_stateType.eGathering,
}
end
if data then
table.insert(self.itemDatas,data)
end
end
end
table.sort(self.itemDatas,function(a,b)
if a.state~=b.state then
return a.state>b.state
else
return a.index<b.index
end
end)

local num=#self.itemDatas
local nowTime=timeHelper.getServerShortTime()
self.teamList:setChildLayoutGroupCreateItems(num,function(index)
local item=self.teamList:getChildLayoutGroupGridItem(index-1)
local itemData=self.itemDatas[index]
local stateColor=_stateColor[itemData.state]
local stateName=_stateName[itemData.state]
local xmNameStr=itemData.xmName and FMT.fmt("[{0}]",itemData.xmName)or""
local desc=FMT.fmt("<color=#7B3A15>{0}{1}</color>率<color=#C66019>{2}</color>支队伍<color={3}>{4}</color>",xmNameStr,itemData.actorName,itemData.count,stateColor,stateName)
local showTime=itemData.endTime~=nil
item:SetChildText(_itemCmp.no,index)
item:SetChildActive(_itemCmp.mate,itemData.mate)
item:SetChildText(_itemCmp.desc,desc)
item:SetChildActive(_itemCmp.timeBg,showTime)
if showTime then
local leastTime=math.ceil(itemData.endTime-nowTime)
item:SetChildText(_itemCmp.time,timeHelper.format_time_stamp(leastTime))
end
item:ForceLayoutRect(_itemCmp.timeBg)
item:ForceLayoutRect(_itemCmp.content)
end)

if needCD then
self:startCDTick()
else
self:stopCDTick()
end
end

function UIXianJie_monsterTeamWin:startCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UIXianJie_monsterTeamWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UIXianJie_monsterTeamWin:updateCDTick()
local continue=false
local nowTime=timeHelper.getServerShortTime()
for index,itemData in ipairs(self.itemDatas)do
if itemData.endTime then
local item=self.teamList:getChildLayoutGroupGridItem(index-1)
local leastTime=math.ceil(math.max(0,itemData.endTime-nowTime))

if leastTime<=0 then
itemData.endTime=nil
itemData.state=_stateType.eInBattle
local stateColor=_stateColor[itemData.state]
local stateName=_stateName[itemData.state]
local desc=FMT.fmt("<color=#7D3B17>[{0}]{1}</color>率<color=#7D3B17>{2}</color>支队伍<color={3}>{4}</color>",itemData.xmName,itemData.actorName,itemData.count,stateColor,stateName)
item:SetChildText(_itemCmp.desc,desc)
item:SetChildActive(_itemCmp.timeBg,false)
else
continue=true
item:SetChildText(_itemCmp.time,timeHelper.format_time_stamp(leastTime))
end
item:ForceLayoutRect(_itemCmp.timeBg)
item:ForceLayoutRect(_itemCmp.content)
end
end
if not continue then
self:stopCDTick()
end
end