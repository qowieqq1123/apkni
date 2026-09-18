







def_class("UIMoJieExplorationGateWin",UIWindowBase)









function UIMoJieExplorationGateWin:bindComponents()

self.lvltips=UIButton.get(self,0)
self.noSign=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.tabtn=UIButton.get(self,3)
self.taskScroller=UIObject.get(self,4)
self.uiPanel=UIObject.get(self,5)

self.lvltips:setButtonClick(function()self:onLvltips()end)

self.tabtn:setButtonClick(function()self:onTabtn()end)



end


function UIMoJieExplorationGateWin:unbindComponents()
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
selfMark=6,
state=7,
}
local _gateType={
eNotOwn=1,
eOwnButNotSelf=2,
eSelfOwn=3,
}
local itemList={
{
type=_gateType.eNotOwn,
name="关口要塞-上",
iconName="minimap_1",
},
{
type=_gateType.eOwnButNotSelf,
name="关口要塞-中",
iconName="minimap_2",
},
{
type=_gateType.eSelfOwn,
name="关口要塞-下",
iconName="minimap_2",
isShowSelfMark=true,
}
}

local abname="ui/windows/mojie/mojiegate_atlas_pak.ab"




function UIMoJieExplorationGateWin:onLoaded(...)
_this=self
self:bindComponents()
self.selectId=1
self.selectGateId=nil
end


function UIMoJieExplorationGateWin:__delete()
self:unbindComponents()
_this=nil
end




function UIMoJieExplorationGateWin:onShow(argtable,afterOnloaded)
if afterOnloaded and argtable.isInit then
self:playEnterAnim()
end
self.extra=argtable.extra
if self.extra then
self.selectId=self.extra.selectId or self.selectId
self.selectGateId=self.extra.selectGateId or self.selectGateId
self.isdo=self.extra.isdo
end

self:inititem()
self.root:setChildCanvasGroupAlpha(1)

if self.isdo then

self:handlejump()
self.isdo=false
end


local isopenbtn=false
self.lvltips:setActive(isopenbtn)
end


function UIMoJieExplorationGateWin:onHide()

end


function UIMoJieExplorationGateWin:playEnterAnim()
if not newbieControl.isInNewbie()then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
self.uiPanel:setChildAnchoredPosition(Vector2(-508,1))
self.uiPanel:setChildDOAnchorPosX(0,0.2,nil)
end
UIManager:invokeUIMethod('UIMoJieExplorationWin','playEnterAnim')
end

function UIMoJieExplorationGateWin:playLeaveAnim()
self.uiPanel:setChildDOAnchorPosX(-508,0.2,nil)
self.closeLock=true
self:delayDo(0.2,function()
self.closeLock=nil

xianjieController:closeWin(self.__name)
end)
end


function UIMoJieExplorationGateWin:inititem()
local gateList=xianjieModel:getMoJieGateIdListWithSelfXianYu()
local dataNum=#gateList
self.taskScroller:setChildScrollViewCreateGrids(dataNum,1)
local grids=self.taskScroller:getChildScrollViewItemWidgets()
for i=1,dataNum do
local item=grids[i-1]
if item then
local gateId=gateList[i]
local gateCfg=cfgHelper.get1(cfg_devildomscenegateconfig_get,gateId)


local gateName=gateCfg.name
local gateXYSceneIndex=gateCfg.area
local xyName=xianjieController:getCrossServerNamebySCidx(gateXYSceneIndex)
local nameStr=FMT.fmt("{0}·{1}",xyName,gateName)
item:SetChildText(itemidx.name,nameStr)


local gateEntityData=xianjieModel:getMoJieGateData(gateId)
local gateData=gateEntityData and gateEntityData.data or nil
local xmData=gateData and gateData.xmInfo or nil
local xmGuid=xmData and xmData.param_1 or nil
local hasOwn=xmGuid and not mathHelper.compareInt64(xmGuid,Int64_0)or false
local selfHasXM=xianmengModel:hasXM()
local isSelfXm=selfHasXM and hasOwn and xianmengModel:isMyXM(xmGuid)or false
item:SetChildActive(itemidx.selfMark,isSelfXm)

local season_id=gateData and gateData.seasonId or 1
local chapter_idx=gateData and gateData.stageIndex or 1
local isOpenGate=false
if gateData then
isOpenGate=seasonController:checkSeasonStageBegined(season_id,chapter_idx)
end
local stateStr=""
if not isOpenGate then
stateStr="未开启"
elseif hasOwn then
stateStr="已归属"
else
local atkState=xianjieModel:getMoJieGateAtkState(gateId)
if atkState==0 then
stateStr="可进攻"
elseif atkState==1 then
stateStr="攻打中"
elseif atkState==2 then
stateStr="修复中"
end
end
item:SetChildText(itemidx.state,stateStr)


local iconName=hasOwn and"image_gkys_5"or"image_gkys_6"
item:SetChildCSImageSprite(itemidx.icon,abname,iconName)

local isSelect=self.selectId==i
item:SetChildActive(itemidx.choose,isSelect)
if isSelect then
self.selectGateId=gateId
end

item:SetChildButtonClick(itemidx.btn,function()
if _this==nil then return end
self:onChooseBtn(i,gateId)
end)
end
end
end


function UIMoJieExplorationGateWin:handlejump()
local jumpGateId=self.selectGateId
if not jumpGateId then
UIManager.info("宗门附近搜寻不到所选关口要塞类型")
else


xianjieController:jumpMoJieGateByGateId(jumpGateId)
end
end




function UIMoJieExplorationGateWin:onLvltips()
UIManager.info("点击tips")
end



function UIMoJieExplorationGateWin:onTabtn()

local _selectid=self.selectId
local _selectGateId=self.selectGateId
local _fun=function()
local temp=
{
selectId=_selectid,
selectGateId=_selectGateId,
isdo=true,
}
UIManager:showWindow('UIMoJieExplorationWin',{page=1,extra=temp})
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


function UIMoJieExplorationGateWin:onChooseBtn(idx,gateId)
if idx==self.selectId then
return
end
local oldselect=self.selectId
self.selectId=idx
self.selectGateId=gateId
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
