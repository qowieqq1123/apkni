
def_class("UIMoJieExplorationZhenYanWin",UIWindowBase)








function UIMoJieExplorationZhenYanWin:bindComponents()

self.lvltips=UIButton.get(self,0)
self.noSign=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.tabtn=UIButton.get(self,3)
self.taskScroller=UIObject.get(self,4)
self.uiPanel=UIObject.get(self,5)

self.lvltips:setButtonClick(function()self:onLvltips()end)

self.tabtn:setButtonClick(function()self:onTabtn()end)



end


function UIMoJieExplorationZhenYanWin:unbindComponents()
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
}

local itemList={
{
type=xjServerEnityType.eMoJieZhenYan_Small,
name="低级阵眼",
iconName="icon_zhenyan_1",
},
{
type=xjServerEnityType.eMoJieZhenYan_Big,
name="高级阵眼",
iconName="icon_zhenyan_2",
},
{
type=xjServerEnityType.eMoJieZhenYan_Spe,
name="特殊阵眼",
iconName="icon_zhenyan_3",
}
}

local abname="ui/windows/xianjie/xianjiehud2icons_atlas_pak.ab"

function UIMoJieExplorationZhenYanWin:onLoaded(...)
_this=self
self:bindComponents()
self.selectId=1
self.monster_type=0
self.monster_check_idx=1
end


function UIMoJieExplorationZhenYanWin:__delete()
self:unbindComponents()
_this=nil
end


function UIMoJieExplorationZhenYanWin:onHide()

end




function UIMoJieExplorationZhenYanWin:onShow(argtable,afterOnloaded)
if afterOnloaded and argtable.isInit then
self:playEnterAnim()
end
self.extra=argtable.extra
if self.extra then
self.selectId=self.extra.selectId or self.selectId
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


function UIMoJieExplorationZhenYanWin:playEnterAnim()
if not newbieControl.isInNewbie()then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
self.uiPanel:setChildAnchoredPosition(Vector2(-508,1))
self.uiPanel:setChildDOAnchorPosX(0,0.2,nil)
end
UIManager:invokeUIMethod('UIMoJieExplorationWin','playEnterAnim')
end

function UIMoJieExplorationZhenYanWin:playLeaveAnim()
self.uiPanel:setChildDOAnchorPosX(-508,0.2,nil)
self.closeLock=true
self:delayDo(0.2,function()
self.closeLock=nil

xianjieController:closeWin(self.__name)
end)
end


function UIMoJieExplorationZhenYanWin:inititem()
local dataNum=#itemList
self.taskScroller:setChildScrollViewCreateGrids(dataNum,1)
local grids=self.taskScroller:getChildScrollViewItemWidgets()
for i=1,dataNum do
local item=grids[i-1]
if item then

local type=itemList[i].type
local name=itemList[i].name
local iconName=itemList[i].iconName
item:SetChildText(itemidx.name,name)
item:SetChildCSImageSprite(itemidx.icon,abname,iconName)
item:SetChildActive(itemidx.choose,self.selectId==i)
item:SetChildButtonClick(itemidx.btn,function()
if _this==nil then return end
self:onChooseBtn(i)
end)
end
end
end


function UIMoJieExplorationZhenYanWin:onChooseBtn(idx)
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



function UIMoJieExplorationZhenYanWin:onLvltips()

local d={}
d.title='说明'
d.mode=3
d.name='ui_mozongsuoxun_help_%d'
self:showWindow('UIRuleWin',d)
end

function UIMoJieExplorationZhenYanWin:onTabtn()

local _selectid=self.selectId
local _fun=function()
local temp=
{
selectId=_selectid,
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


function UIMoJieExplorationZhenYanWin:handlejump()



local allMonsterData=xianjieModel:getAllMonsterData()
local zmData=xianjieModel:getMyZongMenData()

local monstertype=itemList[self.selectId].type
local getlist={}
if allMonsterData then
for i,monsterData in pairs(allMonsterData)do
if monsterData and monsterData.infoid~=0 then
local cfg=monsterData:getCfg()
local type=cfg.type
local stage=cfg.stage

if monstertype==type then
local d=mathHelper.distance2(monsterData.gridX,monsterData.gridZ,zmData.gridX,zmData.gridZ)
table.insert(getlist,{monsterData.infoguid,d})
end
end
end
end
table.sort(getlist,function(a,b)
return a[2]<b[2]
end)

if#getlist==0 then
local xyisopen=seasonController:checkSeasonStageBegined(0,2)
local sysopen=systemModel.isOpen(SYSTEM_DEFINE.eMonsterFind)

if sysopen and xyisopen then
UIManager.info("搜寻不到所选阵眼")
self.monster_type=0
self.monster_check_idx=1
return
end
end


if self.monster_type==monstertype then
else
self.monster_type=monstertype
self.monster_check_idx=1
end

local istips=false
local chooseguid
if getlist[self.monster_check_idx]then
chooseguid=getlist[self.monster_check_idx][1]
self.monster_check_idx=self.monster_check_idx+1
else
if getlist[1]then
chooseguid=getlist[1][1]
self.monster_check_idx=1
end
end
if chooseguid then
local monsterData=xianjieModel:getMonsterData(chooseguid)
if monsterData and monsterData.infoid~=0 then
local info_guid=monsterData.infoguid
if self.monster_check_idx==1 and#getlist==1 then
UIManager.info("搜寻不到所选阵眼")
end


xianjieController:openMonsterInfoWin(info_guid)
else
istips=true
end
else
istips=true
end
if istips then
UIManager.info("搜寻不到所选阵眼")
self.monster_type=0
self.monster_check_idx=1
end
end