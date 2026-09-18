







def_class("UIXianJieExp_mijinWin",UIWindowBase)









function UIXianJieExp_mijinWin:bindComponents()

self.uiPanel=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.noSign=UIObject.get(self,2)
self.taskScroller=UIObject.get(self,3)
self.monname=UIText.get(self,4)
self.gwlvl=UIText.get(self,5)
self.selectCntSlider=UIObject.get(self,6)
self.handleImg=UIObject.get(self,7)
self.subBtn=UIButton.get(self,8)
self.addBtn=UIButton.get(self,9)
self.tabtn=UIButton.get(self,10)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.tabtn:setButtonClick(function()self:onTabtn()end)



end


function UIXianJieExp_mijinWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.uiPanel);self.uiPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.taskScroller);self.taskScroller=nil;
_UIObject_release(self.monname);self.monname=nil;
_UIObject_release(self.gwlvl);self.gwlvl=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.tabtn);self.tabtn=nil;
end
















local _this
local itemidx=
{
itemself=0,
back=1,
choose=2,
iconbg=3,
ibgchoose=4,
icon=5,
name=6,
btn=7,
tag=8,
desc=9,
moneyicon=10,
}
local montertype=
{
{id=1,name="秘境1",tag="icon_dsjmijingtp_7"},
{id=2,name="秘境2",tag="icon_dsjmijingtp_8"},
{id=3,name="秘境3",tag="icon_dsjmijingtp_7"},
}
local abname="ui/windows/xianjie/xianjiemain_explora_atlas_pak.ab"

function UIXianJieExp_mijinWin:onLoaded(...)
_this=self
self:bindComponents()
self.selectid=1
self.selectCnt=1
self.min=1
self.max=5
self.monster_type=0
self.monster_stage=0
self.monster_check_idx=1
end

function UIXianJieExp_mijinWin:getMapView()
return self.mapView
end


function UIXianJieExp_mijinWin:__delete()
self:unbindComponents()
_this=nil
end


function UIXianJieExp_mijinWin:onHide()

end




function UIXianJieExp_mijinWin:onShow(argtable,afterOnloaded)
if afterOnloaded then

self:inititem()
self:freshsilder()
end
if afterOnloaded and argtable.isInit then
self:playEnterAnim()
end
end


function UIXianJieExp_mijinWin:playEnterAnim()
if not newbieControl.isInNewbie()then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
self.uiPanel:setChildAnchoredPosition(Vector2(-508,1))
self.uiPanel:setChildDOAnchorPosX(0,0.2,nil)
end
UIManager:invokeUIMethod('UIXianJieExplorationWin','playEnterAnim')
end

function UIXianJieExp_mijinWin:playLeaveAnim()
self.uiPanel:setChildDOAnchorPosX(-508,0.2,nil)
self.closeLock=true
self:delayDo(0.2,function()
self.closeLock=nil
self:closeSelf()
end)
end


function UIXianJieExp_mijinWin:onChooseBtn(idx)
if idx==self.selectid then
return
end
local oldselect=self.selectid
self.selectid=idx
local grids=self.taskScroller:getChildScrollViewItemWidgets()
if grids then
local olditem=grids[oldselect-1]
if olditem then
olditem:SetChildActive(itemidx.choose,false)
olditem:SetChildActive(itemidx.iconbg,true)
olditem:SetChildActive(itemidx.ibgchoose,false)
end
local item=grids[self.selectid-1]
if item then
item:SetChildActive(itemidx.choose,true)
item:SetChildActive(itemidx.iconbg,false)
item:SetChildActive(itemidx.ibgchoose,true)
end
end
self.monname:setText(montertype[self.selectid].name)
end
function UIXianJieExp_mijinWin:onSliderChange(value)
self.selectCnt=value
local str=FMT.fmt('{0}阶',self.selectCnt)
self.gwlvl:setText(str)
end
function UIXianJieExp_mijinWin:onSubBtn()
if self.selectCnt<=self.min then
return
end
self.selectCnt=self.selectCnt-1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end
function UIXianJieExp_mijinWin:onAddBtn()
if self.min>=self.max then
return
end
if self.selectCnt>=self.max then
return
end
self.selectCnt=self.selectCnt+1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UIXianJieExp_mijinWin:onTabtn()
local selectCnt=self.selectCnt
if selectCnt>self.max then
selectCnt=self.max
end
if selectCnt<self.min then
selectCnt=self.min
end

UIManager.info(FMT.fmt('{0}--{1}阶，秘境',self.selectid,selectCnt))
end

function UIXianJieExp_mijinWin:inititem()
local dataNum=#montertype
self.taskScroller:setChildScrollViewCreateGrids(dataNum,1)
local grids=self.taskScroller:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then

item:SetChildText(itemidx.name,montertype[i].name)
item:SetChildCSImageSprite(itemidx.tag,abname,montertype[i].tag)
if self.selectid==i then
item:SetChildActive(itemidx.choose,true)
item:SetChildActive(itemidx.iconbg,false)
item:SetChildActive(itemidx.ibgchoose,true)
else
item:SetChildActive(itemidx.choose,false)
item:SetChildActive(itemidx.iconbg,true)
item:SetChildActive(itemidx.ibgchoose,false)
end
item:SetChildButtonClick(itemidx.btn,function()
if _this==nil then return end
self:onChooseBtn(i)
end)
end
end
self.monname:setText(montertype[self.selectid].name)
end

function UIXianJieExp_mijinWin:freshsilder()
self.selectCnt=1
self.min=1
self.max=5
local func=function(...)
self:onSliderChange(...)
end
self.winlua:SetChildImageRaycast(self.handleImg:getID(),self.max>self.min)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,self.min,self.max,func)
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end


function UIXianJieExp_mijinWin:handlejump(_monstertype,_jjid)
local list=xianjieModel:findMonsterByDistance(20)


local monstertype=_monstertype
local jjid=_jjid
local getlist={}
for i,infoguid in ipairs(list)do
local monsterData=xianjieModel:getMonsterData(infoguid)
if monsterData and monsterData.infoid~=0 then
local cfg=monsterData:getCfg()
local type=cfg.type
local stage=cfg.stage

if monstertype==type and jjid==stage then
table.insert(getlist,infoguid)
end
end
end
if#getlist==0 then
UIManager.info("宗门附近探查不到所选等级魔物，建议探查其他的魔物")
self.monster_type=0
self.monster_stage=0
self.monster_check_idx=1
return
end


if self.monster_type==monstertype and self.monster_stage==jjid then
else
self.monster_type=monstertype
self.monster_stage=jjid
self.monster_check_idx=1
end

local istips=false
local chooseguid
if getlist[self.monster_check_idx]then
chooseguid=getlist[self.monster_check_idx]
self.monster_check_idx=self.monster_check_idx+1
else
if getlist[1]then
chooseguid=getlist[1]
self.monster_check_idx=1
end
end
if chooseguid then
local monsterData=xianjieModel:getMonsterData(chooseguid)
if monsterData and monsterData.infoid~=0 then
local info_guid=monsterData.infoguid
xianjieController:openMonsterInfoWin(info_guid)
else
istips=true
end
else
istips=true
end
if istips then
UIManager.info("宗门附近探查不到所选等级魔物，建议探查其他的魔物")
self.monster_type=0
self.monster_stage=0
self.monster_check_idx=1
end
end