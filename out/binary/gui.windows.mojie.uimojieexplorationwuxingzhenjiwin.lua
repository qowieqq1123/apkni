







def_class("UIMoJieExplorationWuXingZhenJiWin",UIWindowBase)









function UIMoJieExplorationWuXingZhenJiWin:bindComponents()

self.lvltips=UIButton.get(self,0)
self.noSign=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.tabtn=UIButton.get(self,3)
self.taskScroller=UIObject.get(self,4)
self.uiPanel=UIObject.get(self,5)

self.lvltips:setButtonClick(function()self:onLvltips()end)

self.tabtn:setButtonClick(function()self:onTabtn()end)



end


function UIMoJieExplorationWuXingZhenJiWin:unbindComponents()
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
countStr=6,
}

local abname="ui/windows/xianjie/xianjiehud2icons_atlas_pak.ab"



function UIMoJieExplorationWuXingZhenJiWin:onLoaded(...)
_this=self
self:bindComponents()
self.selectId=1
self.monster_type=0
self.monster_check_idx=1
self:addNotify(notifyConfig.onXianJieWuXingZhenJiChange,self.onXianJieWuXingZhenJiChange)
end


function UIMoJieExplorationWuXingZhenJiWin:__delete()
self:unbindComponents()
_this=nil
end




function UIMoJieExplorationWuXingZhenJiWin:onShow(argtable,afterOnloaded)
if afterOnloaded and argtable.isInit then
self:playEnterAnim()
end
self.extra=argtable.extra
if self.extra then
self.selectId=self.extra.selectId or self.selectId
self.isdo=self.extra.isdo
end
self.wuxingTypeList={}
for i,type in pairs(mjWuXingZhenJiType)do
table.insert(self.wuxingTypeList,type)
end

self:updateData()
self:inititem()
self.root:setChildCanvasGroupAlpha(1)

if self.isdo then

self:handlejump()
self.isdo=false
end


local isopenbtn=false
self.lvltips:setActive(isopenbtn)
end


function UIMoJieExplorationWuXingZhenJiWin:onHide()

end


function UIMoJieExplorationWuXingZhenJiWin:playEnterAnim()
if not newbieControl.isInNewbie()then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
self.uiPanel:setChildAnchoredPosition(Vector2(-508,1))
self.uiPanel:setChildDOAnchorPosX(0,0.2,nil)
end
UIManager:invokeUIMethod('UIMoJieExplorationWin','playEnterAnim')
end

function UIMoJieExplorationWuXingZhenJiWin:playLeaveAnim()
self.uiPanel:setChildDOAnchorPosX(-508,0.2,nil)
self.closeLock=true
self:delayDo(0.2,function()
self.closeLock=nil

xianjieController:closeWin(self.__name)
end)
end


function UIMoJieExplorationWuXingZhenJiWin.onXianJieWuXingZhenJiChange(changeType,infoguid)
local infoguid_str=tostring(infoguid)
if changeType==CHANGE_TYPE.eAdd then
if not _this.zjSortLookup or not _this.zjSortLookup[infoguid_str]then
_this:refreshMJZJ()
end
elseif changeType==CHANGE_TYPE.eDelete then
if _this.zjSortLookup and _this.zjSortLookup[infoguid_str]~=nil then
_this:refreshMJZJ()
end
end
end

function UIMoJieExplorationWuXingZhenJiWin:refreshMJZJ()
if not _this.refreshTimer then
_this.refreshTimer=_this:delayDo(0.2,function()
_this:updateData()
_this:refreshAllItem()
_this.refreshTimer=nil
end)
end
end

function UIMoJieExplorationWuXingZhenJiWin:updateData()
local list=xianjieController:getEntitysByEntityType(XJ_ENTITY_TYPE.ePuTongZhenJi)
local zmData=xianjieModel:getMyZongMenData()

self.zjSortLookup={}
self.zjSortList={}
self.zjSortTypeLookup={}
for i,entity in ipairs(list)do
local infoguid=entity.infoguid
local zhenjiData=xianjieModel:getPuTongZhenJiData(infoguid)
if not entity.dead and zhenjiData and zhenjiData.entitytype==xjServerEnityType.eMoJingZhenJi_Normal then
table.insert(self.zjSortList,infoguid)
local infoguid_str=tostring(infoguid)
self.zjSortLookup[infoguid_str]=infoguid

local cfg=zhenjiData:getCfg()
if not self.zjSortTypeLookup[cfg.wxType]then
self.zjSortTypeLookup[cfg.wxType]={}
end
local d=mathHelper.distance2(zhenjiData.gridX,zhenjiData.gridZ,zmData.gridX,zmData.gridZ)
table.insert(self.zjSortTypeLookup[cfg.wxType],{infoguid,d})
end
end
end


function UIMoJieExplorationWuXingZhenJiWin:inititem()
local dataNum=#self.wuxingTypeList
self.taskScroller:setChildScrollViewCreateGrids(dataNum,1)
local grids=self.taskScroller:getChildScrollViewItemWidgets()
for i=1,dataNum do
local item=grids[i-1]
if item then
local wxType=self.wuxingTypeList[i]
local name=mjWuXingZhenJiNameByType[wxType]

item:SetChildText(itemidx.name,name)

if not self.zjSortTypeLookup[wxType]then
self.zjSortTypeLookup[wxType]={}
end
local count=#self.zjSortTypeLookup[wxType]
if count>0 then
local countStr=FMT.fmt("剩余：{0}",count)
item:SetChildText(itemidx.countStr,countStr)
else
item:SetChildText(itemidx.countStr,"全部攻破")
end




local isSelect=self.selectId==i
item:SetChildActive(itemidx.choose,isSelect)

item:SetChildButtonClick(itemidx.btn,function()
if _this==nil then return end
self:onChooseBtn(i)
end)
end
end
end

function UIMoJieExplorationWuXingZhenJiWin:refreshAllItem()
local dataNum=#self.wuxingTypeList
local grids=self.taskScroller:getChildScrollViewItemWidgets()
for i=1,dataNum do
local item=grids[i-1]
if item then
local wxType=self.wuxingTypeList[i]
if not self.zjSortTypeLookup[wxType]then
self.zjSortTypeLookup[wxType]={}
end
local count=#self.zjSortTypeLookup[wxType]
if count>0 then
local countStr=FMT.fmt("剩余：{0}",count)
item:SetChildText(itemidx.countStr,countStr)
else
item:SetChildText(itemidx.countStr,"全部攻破")
end
end
end
end


function UIMoJieExplorationWuXingZhenJiWin:handlejump()

local wxtype=self.wuxingTypeList[self.selectId]
local getlist={}
if self.zjSortTypeLookup[wxtype]then
for i,v in ipairs(self.zjSortTypeLookup[wxtype])do
local infoguid=v[1]
local d=v[2]
local zhenjiData=xianjieModel:getPuTongZhenJiData(infoguid)
if zhenjiData and zhenjiData.infoid~=0 then
table.insert(getlist,{infoguid,d})
end
end
table.sort(getlist,function(a,b)
return a[2]<b[2]
end)
end

if#getlist==0 then
local xyisopen=seasonController:checkSeasonStageBegined(0,2)
local sysopen=systemModel.isOpen(SYSTEM_DEFINE.eMonsterFind)

if sysopen and xyisopen then
UIManager.info("搜寻不到所选五行阵基")
self.monster_type=0
self.monster_check_idx=1
return
end
end


if self.monster_type==wxtype then
else
self.monster_type=wxtype
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
local zhenjiData=xianjieModel:getPuTongZhenJiData(chooseguid)
if zhenjiData and zhenjiData.infoid~=0 then
local info_guid=zhenjiData.infoguid
if self.monster_check_idx==1 and#getlist==1 then
UIManager.info("搜寻不到所选五行阵基")
end


xianjieController:openPuTongZhenJiInfoWin(info_guid)
else
istips=true
end
else
istips=true
end
if istips then
UIManager.info("搜寻不到所选五行阵基")
self.monster_type=0
self.monster_check_idx=1
end
end




function UIMoJieExplorationWuXingZhenJiWin:onLvltips()
UIManager.info("点击tips")
end



function UIMoJieExplorationWuXingZhenJiWin:onTabtn()

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


function UIMoJieExplorationWuXingZhenJiWin:onChooseBtn(idx)
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
