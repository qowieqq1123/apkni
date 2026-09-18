







def_class("UIMoJieExplorationBenYuanZhenJiWin",UIWindowBase)









function UIMoJieExplorationBenYuanZhenJiWin:bindComponents()

self.lvltips=UIButton.get(self,0)
self.noSign=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.tabtn=UIButton.get(self,3)
self.taskScroller=UIObject.get(self,4)
self.uiPanel=UIObject.get(self,5)

self.lvltips:setButtonClick(function()self:onLvltips()end)

self.tabtn:setButtonClick(function()self:onTabtn()end)



end


function UIMoJieExplorationBenYuanZhenJiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.lvltips);self.lvltips=nil;
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tabtn);self.tabtn=nil;
_UIObject_release(self.taskScroller);self.taskScroller=nil;
_UIObject_release(self.uiPanel);self.uiPanel=nil;
end
















local _this

local itemidx=
{
itemself=0,
back=1,
choose=2,
icon=3,
name=4,
btn=5,
desc=6,
}
local buildIdList={xjClientBuildType.flcbZhenJi1,xjClientBuildType.flcbZhenJi2,xjClientBuildType.flcbZhenJi3,xjClientBuildType.flcbZhenJi4}

local abname="ui/windows/xianjie/xianjiehud2icons_atlas_pak.ab"



function UIMoJieExplorationBenYuanZhenJiWin:onLoaded(...)
_this=self
self:bindComponents()
self.selectId=1
end


function UIMoJieExplorationBenYuanZhenJiWin:__delete()
self:unbindComponents()
_this=nil
end




function UIMoJieExplorationBenYuanZhenJiWin:onShow(argtable,afterOnloaded)
if afterOnloaded and argtable.isInit then
self:playEnterAnim()
end
self.extra=argtable.extra
if self.extra then
self.selectId=self.extra.selectId or self.selectId
self.isdo=self.extra.isdo
end
local curTime=gameUtilityModel.getServerShortTime()
local lastReqBYZJListTime=xianjieModel:getLastReqBYZJListTime()
if lastReqBYZJListTime and curTime<lastReqBYZJListTime+10 then
self:inititem()
else
local stage=seasonModel:findStage(seasonStageType.eMJZJ)
local seasonType=stage.handle.id
local stageIndex=stage.index
xianjieController:reqBenYuanZhenJiList(seasonType,stageIndex)
end
self.root:setChildCanvasGroupAlpha(1)

if self.isdo then

self:handlejump()
self.isdo=false
end


local isopenbtn=false
self.lvltips:setActive(isopenbtn)
end


function UIMoJieExplorationBenYuanZhenJiWin:onHide()

end


function UIMoJieExplorationBenYuanZhenJiWin:playEnterAnim()
if not newbieControl.isInNewbie()then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
self.uiPanel:setChildAnchoredPosition(Vector2(-508,1))
self.uiPanel:setChildDOAnchorPosX(0,0.2,nil)
end
UIManager:invokeUIMethod('UIMoJieExplorationWin','playEnterAnim')
end

function UIMoJieExplorationBenYuanZhenJiWin:playLeaveAnim()
self.uiPanel:setChildDOAnchorPosX(-508,0.2,nil)
self.closeLock=true
self:delayDo(0.2,function()
self.closeLock=nil

xianjieController:closeWin(self.__name)
end)
end


function UIMoJieExplorationBenYuanZhenJiWin:inititem()
local curTime=gameUtilityModel.getServerShortTime()
local dataNum=#buildIdList
self.taskScroller:setChildScrollViewCreateGrids(dataNum,1)
local grids=self.taskScroller:getChildScrollViewItemWidgets()
for i=1,dataNum do
local item=grids[i-1]
if item then
local buildId=buildIdList[i]
local stage=seasonModel:findStage(seasonStageType.eMJZJ)
local seasonType=stage.handle.id
local stageIndex=stage.index
local netData=xianjieModel:getBenYuanZhenJiNetData(seasonType,stageIndex,buildId)
local cfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,buildId)
local config=seasonModel:getStageConfigEx(seasonType,stageIndex)
local countdownTime=netData and netData.countdownTime or 0


item:SetChildText(itemidx.name,cfg.name)

local posY=-15
local descStr=""
if not netData then
descStr="未开启"
elseif netData.hpVal==0 then
descStr="已攻破"
elseif countdownTime==0 then
local curMQ=netData.ptzjDieNum

local maxMQ=config.byZhenJi[buildId][3]
descStr=FMT.fmt("魔气值：{0}/{1}",math.max(0,maxMQ-curMQ),maxMQ)
elseif countdownTime>0 then
if curTime<countdownTime then
local timeStr=timeHelper.format_time_stamp3(countdownTime-curTime)
descStr=FMT.fmt("魔气消散中：{0}",timeStr)
else
local maxMJ=config.byZhenJi[buildId][10][2]
descStr=FMT.fmt("魔阵遗核储量：\n{0}/{1}",maxMJ-netData.useMoJing,maxMJ)
posY=-25
end
end
item:SetChildText(itemidx.desc,descStr)
item:SetChildLocalPosY(itemidx.desc,posY)





local isSelect=self.selectId==i
item:SetChildActive(itemidx.choose,isSelect)

item:SetChildButtonClick(itemidx.btn,function()
if _this==nil then return end
self:onChooseBtn(i)
end)
end
end
end


function UIMoJieExplorationBenYuanZhenJiWin:handlejump()
local buildId=buildIdList[self.selectId]
local data=xianjieModel:findBenYuanZhenJiDataByBuildId(buildId)
xianjieController:reqBenYuanZhenJiData(data.season_id,data.chapter_idx,data.entityId,true)
end




function UIMoJieExplorationBenYuanZhenJiWin:onLvltips()
UIManager.info("点击tips")
end



function UIMoJieExplorationBenYuanZhenJiWin:onTabtn()

local _selectid=self.selectId
local _fun=function()
local temp=
{
selectId=_selectid,
isdo=true,
}
UIManager:showWindow('UIMoJieExplorationWin',{page=7,extra=temp})
end

local check=false
local zmData=xianjieModel:getMyZongMenData()
if zmData~=nil and not zmData:checkInCurScene()then
check=true
end
if check then



UIManager:invokeUIMethod('UIMoJieExplorationWin',"onCloseBtn")
xianjieModel:jumpMyZongMen(_fun,false)
else
self:handlejump()
end
end


function UIMoJieExplorationBenYuanZhenJiWin:onChooseBtn(idx)
if idx==self.selectId then
return
end
local oldselect=self.selectId
self.selectId=idx
local grids=self.taskScroller:getChildScrollViewItemWidgets()
if grids then
local olditem=grids[oldselect-1]
if olditem then
olditem:SetChildActive(itemidx.choose,false)
end
local item=grids[self.selectId-1]
if item then
item:SetChildActive(itemidx.choose,true)
end
end
end


