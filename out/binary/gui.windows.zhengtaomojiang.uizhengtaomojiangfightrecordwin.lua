







def_class("UIZhengTaoMoJiangFightRecordWin",UIWindowBase)









function UIZhengTaoMoJiangFightRecordWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.none=UIObject.get(self,2)
self.scrollView=UILoopListView.new(self,3)
self.tabList=UIObject.get(self,4)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.scrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIZhengTaoMoJiangFightRecordWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.none);self.none=nil;
self.scrollView:deleteSelf();self.scrollView=nil;
_UIObject_release(self.tabList);self.tabList=nil;
end















local _this=nil
local _tabCmp={
root=-1,
name=0,
flag=1,
select=2,
}
local _itemCmp={
new=0,
icon=1,
time=2,
desc=3,
check=4,
}
local _abName="ui/windows/zhengtaomojiang/zhengtaomojiang_info_atlas_pak.ab"



function UIZhengTaoMoJiangFightRecordWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
self:addProNotify(39,14,self.on_39_14)
end


function UIZhengTaoMoJiangFightRecordWin:__delete()
self:unbindComponents()
_this=nil
end




function UIZhengTaoMoJiangFightRecordWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.seasonType=argtable.seasonType
self.stageIndex=argtable.stageIndex
self.build_id=argtable.build_id
self:updateData()
self:refreshTabList()
self:openRecordView()
end


function UIZhengTaoMoJiangFightRecordWin:onHide()

end




function UIZhengTaoMoJiangFightRecordWin:onBackground()
self:onCloseBtn()
end


function UIZhengTaoMoJiangFightRecordWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UIZhengTaoMoJiangFightRecordWin:onStartAction()

end

function UIZhengTaoMoJiangFightRecordWin:onFreshAction(index,item)
local recordData=self.records[index]
local recordType=recordData.recordtype
local recordTime=recordData.sec
local recordParams=jsonHelper.decode(recordData.params)
local recordCfg=cfgHelper.get1(cfg_seasonchaptermojiangrecordconfig_get,recordType)
local iconName=recordCfg.icon
local descContent=recordCfg.str
descContent=string.replace(descContent,"{mojiang_name}",self.selectCfg.name)
if recordType==eMoJiangRecordType.scmjrtDamage then
recordParams[1]=loginModel:getServerName(recordParams[1])
recordParams[3]=mathHelper.formatNumber4(recordParams[3]*10000,2)
recordParams[4]=mathHelper.formatNumber4(recordParams[4],2)
elseif recordType==eMoJiangRecordType.scmjrtRecover then
recordParams[1]=recordParams[1]/100
end
local descStr=FMT.fmt(descContent,unpack(recordParams))
local obj=item:GetChildGameObject(_itemCmp.check)
local width=item:GetChildSizeDeltaX(_itemCmp.check)
local recordDesc=comHelper.getCheckLayoutStr(obj,width,descStr)
item:SetChildActive(_itemCmp.new,recordTime>self.lastTime)
item:SetChildCSImageSprite(_itemCmp.icon,_abName,iconName)
item:SetChildText(_itemCmp.time,timeHelper.getFormatByShortStamp3(recordTime))
item:SetChildText(_itemCmp.desc,recordDesc)
end

function UIZhengTaoMoJiangFightRecordWin:onClickTab(index)
if self.selectTab~=index then
if self.selectTab then
local item=self.tabList:getChildLayoutGroupGridItem(self.selectTab-1)
item:SetChildActive(_tabCmp.select,false)
end

self.selectTab=index
self.selectCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.tabData[self.selectTab].id)

local item=self.tabList:getChildLayoutGroupGridItem(self.selectTab-1)
item:SetChildActive(_tabCmp.select,true)

self:openRecordView()
end
end

function UIZhengTaoMoJiangFightRecordWin:updateData()
self.lastTimes=userActorArraySetting.get(ACTOR_SETTING_TYPE.eMoJiang,"recordTime",{})
self.haveDatas={}
self.tabData=xianjieModel:getMoJiangSortList(self.seasonType,self.stageIndex)
for i,v in ipairs(self.tabData)do
if v.id==self.build_id then
self.selectTab=i
break
end
end
self.selectTab=self.selectTab or 1
self.selectCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.tabData[self.selectTab].id)
end

function UIZhengTaoMoJiangFightRecordWin:refreshTabList()
self.tabList:setChildLayoutGroupCreateItems(#self.tabData,function(index)
local item=self.tabList:getChildLayoutGroupGridItem(index-1)
local build_id=self.tabData[index].id
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,build_id)
local entity=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,build_id)
local flag=entity.killTime>0
item:SetChildButtonClick(_tabCmp.root,function()
self:onClickTab(index)
end)
item:SetChildActive(_tabCmp.select,self.selectTab==index)
item:SetChildText(_tabCmp.name,buildCfg.name)
item:SetChildActive(_tabCmp.flag,flag)
end)
end

function UIZhengTaoMoJiangFightRecordWin:refreshTabsFlag()
for i,v in ipairs(self.tabData)do
local item=self.tabList:getChildLayoutGroupGridItem(i-1)
local build_id=v.id
local entity=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,build_id)
local flag=entity.killTime>0
item:SetChildActive(_tabCmp.flag,flag)
end
end

function UIZhengTaoMoJiangFightRecordWin:openRecordView()
local build_id=self.tabData[self.selectTab].id
local mark=false

local seasonTypeStr=tostring(self.seasonType)
local stageIndexStr=tostring(self.stageIndex)
local build_idStr=tostring(build_id)
if not self.haveDatas[build_id]then
self.haveDatas[build_id]=true
xianjieController:reqMoJiangFightRecordList(self.seasonType,self.stageIndex,build_id)
mark=true

self.lastTime=self.lastTimes[seasonTypeStr]and self.lastTimes[seasonTypeStr][stageIndexStr]and self.lastTimes[seasonTypeStr][stageIndexStr][build_idStr]or 0
end

self.records=xianjieModel:getMoJiangRecord(self.seasonType,self.stageIndex,build_id)
self.records=self.records or defaultT
local createList={}
for i,v in ipairs(self.records)do
createList[#createList+1]=i
end
self.scrollView:initData('item',createList)
self.none:setActive(#self.records<=0)

if mark then
if self.lastTimes[seasonTypeStr]==nil then
self.lastTimes[seasonTypeStr]={}
end
if self.lastTimes[seasonTypeStr][stageIndexStr]==nil then
self.lastTimes[seasonTypeStr][stageIndexStr]={}
end
self.lastTimes[seasonTypeStr][stageIndexStr][build_idStr]=timeHelper.getServerShortTime()
userActorArraySetting.set(ACTOR_SETTING_TYPE.eMoJiang,"recordTime",self.lastTimes)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eMoJiang)
end
end

function UIZhengTaoMoJiangFightRecordWin.onSeasonChange()
local stage=seasonModel:getStage(_this.seasonType,_this.stageIndex)
if not stage then
_this:onCloseBtn()
else
_this:refreshTabsFlag()
end
end

function UIZhengTaoMoJiangFightRecordWin.onSeasonStageChange(seasonType,stageIndex)
if _this.seasonType==seasonType and _this.stageIndex==stageIndex then
_this:refreshTabsFlag()
end
end

function UIZhengTaoMoJiangFightRecordWin.on_39_14(seasonType,stageIndex,build_id)
if _this.seasonType==seasonType and _this.stageIndex==stageIndex then
local _build_id=_this.tabData[_this.selectTab].id
if _build_id==build_id then
_this:openRecordView()
end
end
end
