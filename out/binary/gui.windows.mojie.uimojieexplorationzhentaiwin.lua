







def_class("UIMoJieExplorationZhenTaiWin",UIWindowBase)









function UIMoJieExplorationZhenTaiWin:bindComponents()

self.lvltips=UIButton.get(self,0)
self.noSign=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.tabtn=UIButton.get(self,3)
self.taskScroller=UIObject.get(self,4)
self.uiPanel=UIObject.get(self,5)

self.lvltips:setButtonClick(function()self:onLvltips()end)

self.tabtn:setButtonClick(function()self:onTabtn()end)



end


function UIMoJieExplorationZhenTaiWin:unbindComponents()
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

local abname="ui/windows/mojiezhentai/mojiezhentai_atlas_pak.ab"




function UIMoJieExplorationZhenTaiWin:onLoaded(...)
_this=self
self:bindComponents()
self.selectId=1
self.selectGateId=nil
end


function UIMoJieExplorationZhenTaiWin:__delete()
self:unbindComponents()
_this=nil
end




function UIMoJieExplorationZhenTaiWin:onShow(argtable,afterOnloaded)
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


function UIMoJieExplorationZhenTaiWin:playEnterAnim()
if not newbieControl.isInNewbie()then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
self.uiPanel:setChildAnchoredPosition(Vector2(-508,1))
self.uiPanel:setChildDOAnchorPosX(0,0.2,nil)
end
UIManager:invokeUIMethod('UIMoJieExplorationWin','playEnterAnim')
end

function UIMoJieExplorationZhenTaiWin:playLeaveAnim()
self.uiPanel:setChildDOAnchorPosX(-508,0.2,nil)
self.closeLock=true
self:delayDo(0.2,function()
self.closeLock=nil

xianjieController:closeWin(self.__name)
end)
end


function UIMoJieExplorationZhenTaiWin:inititem()
local stage=seasonModel:findStage(seasonStageType.eMJZT)
self.seasonType=stage.handle.id
self.stageIndex=stage.index
local configs=seasonModel:getStageConfigEx(self.seasonType,self.stageIndex)
local client_build_list=configs.client_build_list
local build_icon_list=configs.build_icon_list
local dataNum=#client_build_list
self.taskScroller:setChildScrollViewCreateGrids(dataNum,1)
local grids=self.taskScroller:getChildScrollViewItemWidgets()
for i=1,dataNum do
local item=grids[i-1]
if item then
local build_id=i
local client_build_id=client_build_list[i]
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,client_build_id)


item:SetChildText(itemidx.name,buildCfg.name)
item:SetChildActive(itemidx.selfMark,false)
item:SetChildText(itemidx.state,'')


local iconName=build_icon_list[i]
item:SetChildCSImageSprite(itemidx.icon,abname,iconName)

local isSelect=self.selectId==i
item:SetChildActive(itemidx.choose,isSelect)
if isSelect then
self.selectGateId=build_id
end

item:SetChildButtonClick(itemidx.btn,function()
if _this==nil then return end
self:onChooseBtn(i,build_id)
end)
end
end
end


function UIMoJieExplorationZhenTaiWin:handlejump()
local jumpGateId=self.selectGateId
if not jumpGateId then
UIManager.info("宗门附近搜寻不到所选镇台")
else


xianjieController:jumpMoJieZhenTai(self.seasonType,self.stageIndex,jumpGateId,true)
end
end

function UIMoJieExplorationZhenTaiWin:onLvltips()

end



function UIMoJieExplorationZhenTaiWin:onTabtn()

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


function UIMoJieExplorationZhenTaiWin:onChooseBtn(idx,gateId)
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
