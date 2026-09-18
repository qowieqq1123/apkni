







def_class("UIZongmenEarningsWin",UIWindowBase)









function UIZongmenEarningsWin:bindComponents()

self.scrollerView=UIObject.get(self,0)
self.notEarnings=UIText.get(self,1)
self.notHaveBuild=UIText.get(self,2)
self.jumpBtn=UIButton.get(self,3)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)



end


function UIZongmenEarningsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollerView);self.scrollerView=nil;
_UIObject_release(self.notEarnings);self.notEarnings=nil;
_UIObject_release(self.notHaveBuild);self.notHaveBuild=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
end

















local winIndex={
eShangpu=1,
eJiazu=2,
}


function UIZongmenEarningsWin:onLoaded(...)
self:bindComponents()
self.scrollerView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIZongmenEarningsWin:__delete()
self:unbindComponents()
end




function UIZongmenEarningsWin:onShow(argtable,afterOnloaded)
self.mode=argtable.mode
local index=argtable.menuPageIndex
if index==winIndex.eShangpu then
self:flushShangpuInfo()
else
self:flushJiaZuInfo()
end
end


function UIZongmenEarningsWin:onHide()

end


function UIZongmenEarningsWin:flushShangpuInfo()
local bdDatas=zongmenModel:getBuildingDataByBdType(zongmenModel:getMountainId(),24)
if#bdDatas==0 then
self.notHaveBuild:setActive(true)
self.notEarnings:setText('')
self.scrollerView:setActive(false)
else
if self.mode==1 then
self:showSellCount()
else
self:flushShangpuEarnings()
end
end
end

function UIZongmenEarningsWin:showSellCount()
local datas=UIShopControl:getSellCountData()
local list={}
for i,v in ipairs(datas.incomeList or{})do
local rw=v.incomeList[1]
table.insert(list,{param_1=v.build_id,param_2=rw.param_1,param_3=rw.param_2})
end
self:flushShangpuEarnings(list)
end

function UIZongmenEarningsWin:flushShangpuEarnings(datas)
datas=datas or UIDailyPaperModel:getOfflineDatasByType(eZMDailyPaperType.eShangPu)
local num=#datas
local notEarningsStr=num>0 and''or'当前无商铺收益'
self.notHaveBuild:setActive(num<=0)
self.notEarnings:setText(notEarningsStr)
self.scrollerView:setActive(num>0)

self.scrollerView:setChildScrollViewCreateGrids(#datas,2)
self.grids=self.scrollerView:getChildScrollViewItemWidgets()
local count=self.grids.Count
for i=1,count do
local item=self.grids[i-1]
local data=datas[i]
local ubdId=data.param_1
local moneyType=data.param_2
local moneyCnt=data.param_3

local build_id
local level
if self.mode==1 then
build_id=ubdId
level=1
else
local bdData=zongmenModel:getBuildingData(ubdId)
build_id=bdData.build_id
level=bdData.level
end

local model=cfgHelper.get3(cfg_monijybuildconfig_get,build_id,'model',level)
item:SetChildUIModelShowTarget(0,model,0.32,nil,eAnimationID.bd_stand)
item:SetChildUIModelShowTargetOffset(0,0,-30)

local buildConfig=cfgHelper.get1(cfg_monijybuildconfig_get,build_id)
local moneyName=moneyModel.getMoneyName(moneyType)
local iconName=iconHelper.getIconName(moneyType)
item:SetChildText(1,FMT.fmt('{0}',buildConfig.name))
item:SetChildCSImageIcon(2,iconName,false)
item:SetChildText(3,FMT.fmt('{0}+{1}',moneyName,moneyCnt))
end
end


function UIZongmenEarningsWin:flushJiaZuInfo()
self.notHaveBuild:setActive(false)
self:flushJiaZuEarnings()
end

function UIZongmenEarningsWin:flushJiaZuEarnings()
local datas=UIDailyPaperModel:getOfflineDatasByType(eZMDailyPaperType.eXiuZhenJiaZu)
local num=#datas
local notEarningsStr=num>0 and''or'当前无家族俸禄'
self.notEarnings:setText(notEarningsStr)
self.scrollerView:setActive(num>0)

self.scrollerView:setChildScrollViewCreateGrids(#datas,2)
self.grids=self.scrollerView:getChildScrollViewItemWidgets()
local count=self.grids.Count
for i=1,count do
local item=self.grids[i-1]
local data=datas[i]
local world=data.param_1
local guid=data.param_2
local moneyType=data.param_3
local moneyCnt=data.param_4

local familyData=worldXiuZhenJiaZuModel:getFamilyDataByGuid(guid)
local familyId=familyData.familyId
local familyCfg=worldXiuZhenJiaZuModel:getFamilyConfig(familyId)
local model=familyCfg.modelid

item:SetChildUIModelShowTarget(0,model,0.288,nil,eAnimationID.bd_stand)
item:SetChildUIModelShowTargetOffset(0,0,-30)

local name=worldXiuZhenJiaZuModel:getFamilyName(guid,true)
local moneyName=moneyModel.getMoneyName(moneyType)
local iconName=iconHelper.getIconName(moneyType)
item:SetChildText(1,FMT.fmt('{0}',name))
item:SetChildCSImageIcon(2,iconName,false)
item:SetChildText(3,FMT.fmt('{0}：+{1}',moneyName,moneyCnt))
end
end


function UIZongmenEarningsWin:onJumpBtn()
jumpManager:jump({id=901,args={model=1,bdType=3}})
end