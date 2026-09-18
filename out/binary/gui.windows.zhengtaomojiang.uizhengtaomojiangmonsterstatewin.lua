







def_class("UIZhengTaoMoJiangMonsterStateWin",UIWindowBase)









function UIZhengTaoMoJiangMonsterStateWin:bindComponents()

self.background=UIButton.get(self,0)
self.content_1=UIObject.get(self,1)
self.content_2=UIObject.get(self,2)
self.iconList=UIObject.get(self,3)
self.root=UIObject.get(self,4)
self.spine=UIObject.get(self,5)

self.background:setButtonClick(function()self:onBackground()end)
self.content={
self.content_1,
self.content_2,
}



end


function UIZhengTaoMoJiangMonsterStateWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.content_1);self.content_1=nil;
_UIObject_release(self.content_2);self.content_2=nil;
_UIObject_release(self.iconList);self.iconList=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.spine);self.spine=nil;
self.content=nil;
end















local _this=nil
local _iconCmp={
bg=0,
name=1,
arrow=2,
select=3,
}
local _content1Cmp={
title=0,
none=1,
descList=2,
}
local _content2Cmp={
title={0,1},
none={2,3},
descList={4,5},
cdTx=6,
}
local _abName="ui/windows/zhengtaomojiang/zhengtaomojiang_state_atlas_pak.ab"



function UIZhengTaoMoJiangMonsterStateWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)

self.contentWidget={}
for i,v in ipairs(self.content)do
self.contentWidget[i]=v:getWidgetBase()
end
end


function UIZhengTaoMoJiangMonsterStateWin:__delete()
self:unbindComponents()
_this=nil
self:stopCDTick()
end




function UIZhengTaoMoJiangMonsterStateWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.seasonType=argtable.seasonType
self.stageIndex=argtable.stageIndex
self.build_id=argtable.build_id
self:initData()
self:refreshList()
self:refreshDetail()
self:refreshSpine(afterOnloaded)
end


function UIZhengTaoMoJiangMonsterStateWin:onHide()

end




function UIZhengTaoMoJiangMonsterStateWin:onBackground()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UIZhengTaoMoJiangMonsterStateWin:initData()
self.entityData=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,self.build_id)
self.stage=seasonModel:getStage(self.seasonType,self.stageIndex)
self.stageCfg=self.stage:getConfig("mojiang",self.build_id)
self.stateCfg=self.stageCfg.stage
self.openTime=self.stage.beginTime+self.stageCfg.open
self:updateData()
end

function UIZhengTaoMoJiangMonsterStateWin:updateData()
local nowTime=timeHelper.getServerShortTime()
local deltaTime=nowTime-self.stage.beginTime
local stateCnt=#self.stateCfg
self.state=#self.stateCfg
for i,v in ipairs(self.stateCfg)do
if deltaTime<=v[1]then
self.state=i
break
end
end
self.stateTime=self.stage.beginTime+self.stateCfg[self.state][1]
end

function UIZhengTaoMoJiangMonsterStateWin:refreshSpine(init)
local animContent=init and"enter{0}"or"stand{0}"
local animName=FMT.fmt(animContent,self.state>1 and self.state or"")
if init then
self.spine:setChildUIModelShowTarget(6285,1,{},eAnimationID[animName],false,false,0,function()
self.root:setActive(true)
end)
else
self.spine:setChildModelAnimationState(eAnimationID[animName],1)
end
end

function UIZhengTaoMoJiangMonsterStateWin:refreshList()
self.iconList:setChildLayoutGroupCreateItems(#self.stateCfg,function(index)
local item=self.iconList:getChildLayoutGroupGridItem(index-1)
local config=self.stateCfg[index]
local bgImg=config[7]
local nameImg=config[8]
item:SetChildCSImageSprite(_iconCmp.bg,_abName,bgImg)
item:SetChildCSImageSprite(_iconCmp.name,_abName,nameImg)
item:SetChildActive(_iconCmp.select,index==self.state)
item:SetChildActive(_iconCmp.arrow,index>1)
end)
end

function UIZhengTaoMoJiangMonsterStateWin:showContent1()
local widget=self.contentWidget[1]
local cConfig=self.stateCfg[self.state]
local nameStr=FMT.fmt("当前状态：{0}",cConfig[5])
local fazeList=cConfig[2]
local fazeCnt=#fazeList
widget:SetChildText(_content1Cmp.title,nameStr)
widget:SetChildActive(_content1Cmp.none,fazeCnt<=0)
widget:SetChildLayoutGroupCreateItems(_content1Cmp.descList,fazeCnt,function(index)
local item=widget:GetChildLayoutGroupGridItem(_content1Cmp.descList,index-1)
local fzData=fazeList[index]
local fzId=fzData[1]
local fzLv=fzData[2]
local fazeCfg=cfgHelper.getSSlawRule(fzId)
local descparm=fazeCfg.descparm
local str=descparm and string.format(fazeCfg.desc,unpack(descparm[fzLv]))or fazeCfg.desc
local obj=item:GetChildGameObject(1)
local width=item:GetChildSizeDeltaX(1)
str=comHelper.getCheckLayoutStr(obj,width,str)
item:SetChildText(0,str)
item:ForceLayoutRect(0)
end)
widget:ForceLayoutRect(_content1Cmp.descList)
self:stopCDTick()
end

function UIZhengTaoMoJiangMonsterStateWin:showContent2()
local widget=self.contentWidget[2]
for i=1,2 do
local cConfig=self.stateCfg[self.state+i-1]
local nameContent=i==1 and"当前状态：{0}"or"下一状态：{0}"
local nameStr=FMT.fmt(nameContent,cConfig[5])
local fazeList=cConfig[2]
local fazeCnt=#fazeList
widget:SetChildText(_content2Cmp.title[i],nameStr)
widget:SetChildActive(_content2Cmp.none[i],fazeCnt<=0)
widget:SetChildLayoutGroupCreateItems(_content2Cmp.descList[i],fazeCnt,function(index)
local item=widget:GetChildLayoutGroupGridItem(_content2Cmp.descList[i],index-1)
local fzData=fazeList[index]
local fzId=fzData[1]
local fzLv=fzData[2]
local fazeCfg=cfgHelper.getSSlawRule(fzId)
local descparm=fazeCfg.descparm
local str=descparm and string.format(fazeCfg.desc,unpack(descparm[fzLv]))or fazeCfg.desc
local obj=item:GetChildGameObject(1)
local width=item:GetChildSizeDeltaX(1)
str=comHelper.getCheckLayoutStr(obj,width,str)
item:SetChildText(0,str)
item:ForceLayoutRect(0)
end)
widget:ForceLayoutRect(_content2Cmp.descList[i])
end
self:refreshTimeInfo()
end

function UIZhengTaoMoJiangMonsterStateWin:refreshDetail()
local isLast=self.state>=#self.stateCfg
self.content_1:setActive(isLast)
self.content_2:setActive(not isLast)
if isLast then
self:showContent1()
else
self:showContent2()
end
end

function UIZhengTaoMoJiangMonsterStateWin:refreshTimeInfo()
local widget=self.contentWidget[2]
local nowTime=timeHelper.getServerShortTime()
if nowTime<self.openTime then
widget:SetChildText(_content2Cmp.cdTx,FMT.fmt("开启魔将\n{0}后",timeHelper.formatSimpleTime(self.stateTime-self.openTime)))
self:startCDTick(self.openTime,0)
return
end

widget:SetChildText(_content2Cmp.cdTx,FMT.fmt("{0}后",timeHelper.formatSimpleTime(self.stateTime-nowTime)))
self:startCDTick(self.stateTime,1)
end

function UIZhengTaoMoJiangMonsterStateWin:startCDTick(cdTime,cdType)
self.cdTime=cdTime
self.cdType=cdType
if self.cdTick==nil then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UIZhengTaoMoJiangMonsterStateWin:stopCDTick()
if self.cdTick~=nil then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UIZhengTaoMoJiangMonsterStateWin:updateCDTick()
local nowTime=timeHelper.getServerShortTime()
local leastTime=self.cdTime-nowTime
if leastTime>0 then
if self.cdType==1 then
local widget=self.contentWidget[2]
widget:SetChildText(_content2Cmp.cdTx,FMT.fmt("{0}后",timeHelper.formatSimpleTime(leastTime)))
end
else
if self.cdType==1 then
self:updateData()
self:refreshList()
self:refreshDetail()
self:refreshSpine()
end
self:refreshTimeInfo()
end
end

function UIZhengTaoMoJiangMonsterStateWin.onSeasonChange()
_this.stage=seasonModel:getStage(_this.seasonType,_this.stageIndex)
if _this.stage then
_this.entityData=xianjieModel:getMoJiangEntity(_this.seasonType,_this.stageIndex,_this.build_id)
if _this.entityData.killTime>0 then
_this:onCloseBtn()
end
else
_this:onCloseBtn()
end
end

function UIZhengTaoMoJiangMonsterStateWin.onSeasonStageChange(seasonType,stageIndex)
if seasonType==_this.seasonType and stageIndex==_this.stageIndex then
if _this.entityData.killTime>0 then
_this:onCloseBtn()
end
end
end