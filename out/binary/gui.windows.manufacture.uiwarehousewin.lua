







def_class("UIWarehouseWin",UIWindowBase)









function UIWarehouseWin:bindComponents()

self.scrollview=UIObject.get(self,0)
self.level=UIText.get(self,1)
self.nextLevel=UIText.get(self,2)
self.levelUpBtn=UIButton.get(self,3)
self.levelUpTime=UIText.get(self,4)
self.speedUpBtn=UIButton.get(self,5)
self.finishLvUpBtn=UIButton.get(self,6)
self.mutiaoScroller=UIObject.get(self,7)
self.root=UIObject.get(self,8)
self.leftArrow=UIButton.get(self,9)
self.rightArrow=UIButton.get(self,10)
self.leftArrowImg=UIObject.get(self,11)
self.rightArrowImg=UIObject.get(self,12)

self.levelUpBtn:setButtonClick(function()self:onLevelUpBtn()end)

self.speedUpBtn:setButtonClick(function()self:onSpeedUpBtn()end)

self.finishLvUpBtn:setButtonClick(function()self:onFinishLvUpBtn()end)

self.leftArrow:setButtonClick(function()self:onLeftArrow()end)

self.rightArrow:setButtonClick(function()self:onRightArrow()end)




end


function UIWarehouseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.nextLevel);self.nextLevel=nil;
_UIObject_release(self.levelUpBtn);self.levelUpBtn=nil;
_UIObject_release(self.levelUpTime);self.levelUpTime=nil;
_UIObject_release(self.speedUpBtn);self.speedUpBtn=nil;
_UIObject_release(self.finishLvUpBtn);self.finishLvUpBtn=nil;
_UIObject_release(self.mutiaoScroller);self.mutiaoScroller=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.leftArrow);self.leftArrow=nil;
_UIObject_release(self.rightArrow);self.rightArrow=nil;
_UIObject_release(self.leftArrowImg);self.leftArrowImg=nil;
_UIObject_release(self.rightArrowImg);self.rightArrowImg=nil;
end

















local _this
local _format=string.format


local function formatNumWithUnit(num)
if num<10000 then
return tostring(num)
elseif num<100000000 then

local val=math.floor(num/100)/100
return _format('%.2f万',val)
else

local val=math.floor(num/1000000)/100
return _format('%.2f亿',val)
end
end


function UIWarehouseWin:onLoaded(...)
self:bindComponents()
_this=self
self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)

notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)


local func=function(id)
local widget=self:getChildExpandUI(-1,id)
if widget then
local pos=self:getChildCanvas(-1)
local sortLayer=pos[1]
local sortOrder=pos[2]
widget:SetChildCanvas(-1,sortLayer,sortOrder+3)
end
end
self.cloud_guid=self:setChildGreateExpandUI(-1,self.root:getID(),INSTANCE_TYPE.eCommonCloudUIExpand,func)

end


function UIWarehouseWin:__delete()
if self.cloud_guid~=nil then
self:setChildRemoveExpandUI(-1,self.cloud_guid)
self.cloud_guid=nil
end

self:unbindComponents()
self:stopLevelUpTimer()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
_this=nil
end


function UIWarehouseWin:onLeftTipsClick(index)
local data=self.limitData[index]
tipsManager.showTips({formType=TIPS_FORM_TYPE.eClearBtn,itemid=data[1]})
end


function UIWarehouseWin:onRightTipsClick(index,item)
local data=self.limitData[index]
local key=data[1]
local value=data[2]
local cfg=moneyModel.getMoneyConfig(key)
local have=moneyModel.getMoney(key)
UIManager:showWindow('UIDescribeTips5',{
posWidget=item,
pos={x=34,y=57},
title=cfg.name,
desc=_format('%s/%s',have,value),
})
end




function UIWarehouseWin:onShow(argtable,afterOnloaded)

if argtable then
local guid=argtable.entityId
self.sfId=zongmenModel:getMountainId()
self.bdData=zongmenModel:findBuildingByEntityId(guid)
end

self:refreshLevelUp()
self:refreshScrollView()
self:refreshInfo()
self:checkAndShowArrowBtn()
end


function UIWarehouseWin:OnEnable()

end


function UIWarehouseWin:OnDisable()

end




function UIWarehouseWin:refreshInfo()
local tips=''
local curLimit=0
if self.curLvCfg and self.curLvCfg.effects then
local cfg=self.curLvCfg.effects[1]
if cfg and cfg.type==5 then
for k,v in pairs(cfg.param)do
curLimit=v
end
end
end
local nextLimit=0
if self.nextLvCfg then
if self.nextLvCfg.effects then
local cfg=self.nextLvCfg.effects[1]
if cfg and cfg.type==5 then
for k,v in pairs(cfg.param)do
nextLimit=v
end
end
end
else
tips='已满级'
end
if nextLimit>curLimit then
tips=_format('升至%d级存储量+%s',self.bdData.level+1,mathHelper.formatNumber(nextLimit-curLimit))
end
self.level:setText(_format('仓库%d级',self.bdData.level))
self.nextLevel:setText(tips)
end

function UIWarehouseWin:refreshScrollView()
local bcfg=cfgHelper.get1(cfg_monijybasicconfig_get,1)
local limit=zongmenModel:getWarehouseAllLimitList()
self.limitData=limit
self.scrollview:setChildScrollViewCreateGrids(#limit,2)
local num=math.ceil(#limit/2)
num=num<=3 and 3 or num
self.mutiaoScroller:setChildScrollViewCreateGrids(num,1)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local key=limit[i][1]
local value=limit[i][2]
local cfg=moneyModel.getMoneyConfig(key)
local have=moneyModel.getMoney(key)
item:SetChildIcon(0,iconHelper.getIconName(cfg.id),true)
item:SetChildText(1,cfg.name)
local haveStr=formatNumWithUnit(have)
local valueStr=formatNumWithUnit(value)
if have>=value then
item:SetChildText(2,_format('<color=#c82c2c>%s/%s</color>',haveStr,valueStr))
item:SetChildActive(4,true)
item:SetChildText(5,bcfg.store_limit_tips[key])
else
item:SetChildText(2,_format('%s/%s',haveStr,valueStr))
item:SetChildActive(4,false)
end
item:SetChildProgressValue(3,have,value)

local index=i
item:SetChildButtonClick(6,function()
_this:onLeftTipsClick(index)
end,true)
item:SetChildButtonClick(7,function()
_this:onRightTipsClick(index,item)
end,true)
end
end

function UIWarehouseWin.on_building_event(etype,sfId,bdId)
if etype==buildingEvent.levelUpStart then
_this:refreshLevelUp()
elseif etype==buildingEvent.levelUpComplete then
_this:refreshLevelUp()
_this:refreshScrollView()
_this:refreshInfo()
elseif etype==buildingEvent.speedUpComplete then
_this:refreshLevelUp()
end
end

function UIWarehouseWin:refreshLevelUp()
self.curLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level)
self.nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level+1)
if self.nextLvCfg then
local is_normal=self.bdData.flag==0
local is_levelup=self.bdData.flag==2
self.levelUpBtn:setActive(is_normal)
self.speedUpBtn:setActive(is_levelup)
self.finishLvUpBtn:setActive(false)
self.levelUpTime:setActive(is_levelup)
self:stopLevelUpTimer()
if is_levelup then
local cddata=buildingCDControl:getCDData(buildingCDType.build,self.bdData.un_build_id)
if cddata then
local func=function()
if not cddata.complete then
self.levelUpTime:setText(_format('%s',timeHelper.format_time_stamp4(cddata.cd)))
else
local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level+1)
self:stopLevelUpTimer()
self.finishLvUpBtn:setActive(nextLvCfg~=nil)
self.speedUpBtn:setActive(false)
self.levelUpTime:setActive(false)
end
end
func()
self.levelUpTimer=self:setTimer(1,0,func)
end
end
else
self.speedUpBtn:setActive(false)
self.levelUpBtn:setActive(false)
self.finishLvUpBtn:setActive(false)
self.levelUpTime:setActive(false)
end
end

function UIWarehouseWin:stopLevelUpTimer()
if self.levelUpTimer then
self:stopTimerByID(self.levelUpTimer)
self.levelUpTimer=nil
end
end

function UIWarehouseWin:onLevelUpBtn()
UIManager:showWindow('UIBuildingInfoWin',self.bdData)
end

function UIWarehouseWin:onSpeedUpBtn()
self:onLevelUpBtn()
end

function UIWarehouseWin:onFinishLvUpBtn()
zongmenControl:reqBuildingLevelUpComplete(self.sfId,self.bdData.un_build_id)
end

function UIWarehouseWin:onClickClose()
self:closeSelf()
end

function UIWarehouseWin:onLeftArrow()
self:toNextWin(-1)
end

function UIWarehouseWin:onRightArrow()
self:toNextWin(1)
end

function UIWarehouseWin:toNextWin(arrow)

local ubdId=self.bdData.un_build_id
local index
for i,v in ipairs(self.otherBDData)do
if v.un_build_id==ubdId then
index=i
break
end
end

if not index then
return
end

index=index+arrow
local len=#self.otherBDData
if index>len then
index=index-len
elseif index<1 then
index=index+len
end

self.leftArrow:setActive(false)
self.rightArrow:setActive(false)

local bdData=self.otherBDData[index]
self:stopLevelUpTimer()
self:onShow(bdData)
end

function UIWarehouseWin:checkAndShowArrowBtn()
local bdId=self.bdData.build_id
local bdDatas=zongmenModel:getAllBuildingData(self.sfId)
local list={}
for k,v in pairs(bdDatas)do
if v.build_id==bdId and v.isLinkRoad then
table.insert(list,v)
end
end
local len=#list
local showArrow=len>1
self.otherBDData=list
self.leftArrow:setActive(showArrow)
self.rightArrow:setActive(showArrow)
if showArrow and not self.showArrowAnim then
self.showArrowAnim=true
local tween1=self.leftArrowImg:setChildDOLocalMoveX(-15,0.75,nil)
tween1:SetEase(_Ease.InOutSine)
tween1:SetLoops(-1,_LoopType.Yoyo)
local tween2=self.rightArrowImg:setChildDOLocalMoveX(-15,0.75,nil)
tween2:SetEase(_Ease.InOutSine)
tween2:SetLoops(-1,_LoopType.Yoyo)
end
end