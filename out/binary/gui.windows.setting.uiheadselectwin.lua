







def_class("UIHeadSelectWin",UIWindowBase)









function UIHeadSelectWin:bindComponents()

self.unLockRedot=UIObject.get(self,0)
self.costItem=UIBaseItem.get(self,1)
self.unLockBtn=UIButton.get(self,2)
self.curName=UIText.get(self,3)
self.headIcon=UIImage.get(self,4)
self.headKuang=UIImage.get(self,5)
self.useBtn=UIButton.get(self,6)
self.stateText=UIText.get(self,7)
self.rightScrollerView=UIObject.get(self,8)
self.canLock=UIObject.get(self,9)
self.leftoverTime=UIText.get(self,10)
self.leftoverTimeBg=UIObject.get(self,11)
self.Content=UIObject.get(self,12)
self.root=UIObject.get(self,13)
self.detailBtn=UIButton.get(self,14)
self.attrRoot=UIObject.get(self,15)
self.attr_1=UIObject.get(self,16)
self.attr_2=UIObject.get(self,17)
self.tipsRoot=UIObject.get(self,18)
self.tipsBtn=UIButton.get(self,19)

self.unLockBtn:setButtonClick(function()self:onUnLockBtn()end)

self.useBtn:setButtonClick(function()self:onUseBtn()end)

self.detailBtn:setButtonClick(function()self:onDetailBtn()end)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)
self.attr={
self.attr_1,
self.attr_2,
}



end


function UIHeadSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.unLockRedot);self.unLockRedot=nil;
_UIObject_release(self.costItem);self.costItem=nil;
_UIObject_release(self.unLockBtn);self.unLockBtn=nil;
_UIObject_release(self.curName);self.curName=nil;
_UIObject_release(self.headIcon);self.headIcon=nil;
_UIObject_release(self.headKuang);self.headKuang=nil;
_UIObject_release(self.useBtn);self.useBtn=nil;
_UIObject_release(self.stateText);self.stateText=nil;
_UIObject_release(self.rightScrollerView);self.rightScrollerView=nil;
_UIObject_release(self.canLock);self.canLock=nil;
_UIObject_release(self.leftoverTime);self.leftoverTime=nil;
_UIObject_release(self.leftoverTimeBg);self.leftoverTimeBg=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.detailBtn);self.detailBtn=nil;
_UIObject_release(self.attrRoot);self.attrRoot=nil;
_UIObject_release(self.attr_1);self.attr_1=nil;
_UIObject_release(self.attr_2);self.attr_2=nil;
_UIObject_release(self.tipsRoot);self.tipsRoot=nil;
_UIObject_release(self.tipsBtn);self.tipsBtn=nil;
self.attr=nil;
end

















local menuIndex=
{
headIcon=1,
headKuang=2,
}

local itemIndex=
{
bg=0,
kuang=1,
icon=2,
select=3,
using=4,
lock=5,
reddot=6,
}

local kuangHideType=KUANGE_HIDE_TYPE
local unlockType=KUANGE_UNLOCK_TYPE
local titleStr={'头像选择','头像框选择'}
local menu_slot_name='button_dytab'


function UIHeadSelectWin:onLoaded(...)
self:bindComponents()
UISettingModel:checkShowExperienceWin()



self.dOFade=true
self.root:setChildCanvasGroupDOFade(1,1,function()
self.dOFade=false
end)
local _OnClickItemCallback=function(...)
self:OnClickItemCallback(...)
end
self.rightScrollerView:setChildScrollViewInit(-1,true,_OnClickItemCallback,nil)
self.curMenuIndex=menuIndex.headIcon
self.gainTable={}
end


function UIHeadSelectWin:__delete()
self:unbindComponents()
self.curMenuIndex=nil
self.curUseIndex=nil
self.selectItemIndex=nil
self.curUseHeadCfg=nil
self.curUseKuangCfg=nil
self.curConfig=nil
self.menu_anim=nil
end




function UIHeadSelectWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.menuPageIndex then
self.curMenuIndex=argtable.menuPageIndex
end
if argtable.itemId and argtable.itemId~=-1 then
self.jumpItemId=argtable.itemId
end
end

self:upDateView(true)

end


function UIHeadSelectWin:onHide()
self.rightScrollerView:setActive(false)
end

function UIHeadSelectWin:upDateView(isInit)
self:refreshCurData()
self:refreshCurInfo()
self:initScrollerView(isInit)
self.rightScrollerView:setActive(true)
end

function UIHeadSelectWin:refreshCurData(isRecv)


local typeStr=""
self.curUseHeadCfg=cfgHelper.get1(cfg_headportraitconfig_get,UISettingModel:get_cur_head())
self.curUseKuangCfg=cfgHelper.get1(cfg_headportraitframeconfig_get,UISettingModel:get_cur_head_kuang())
local selectIndex=nil
if self.curMenuIndex==menuIndex.headIcon then
self.curConfig=self:getSortCfgListByType(menuIndex.headIcon)
self.curUseIndex,selectIndex=self:getCurUseIndexByType(self.curMenuIndex)
typeStr="头像"
elseif self.curMenuIndex==menuIndex.headKuang then
self.curConfig=self:getSortCfgListByType(menuIndex.headKuang)
self.curUseIndex,selectIndex=self:getCurUseIndexByType(self.curMenuIndex)
typeStr="头像框"
end

if self.jumpItemId then
local jumpItemIndex=nil

for i,v in ipairs(self.curConfig)do
if v.cfg.unlock and v.cfg.unlock.type==2 then
local itemId=v.cfg.unlock.param[1]
if itemId==self.jumpItemId then
jumpItemIndex=i
break
end
end
end

if not jumpItemIndex then
logErr(FMT.fmt("找不到道具id:{0}对应激活的{1}",self.jumpItemId,typeStr))
end

oneTabScreenController:changeArgs({itemId=-1},true)
self.jumpItemId=nil
self.selectItemIndex=jumpItemIndex or self.curUseIndex
else
if isRecv then
self.selectItemIndex=self.curUseIndex
else
self.selectItemIndex=selectIndex
end
end
end



function UIHeadSelectWin:refreshCurInfo()

local headIcon
local kuangIcon
local kuangCfg
local name=''

local curSelectCfg=self.curConfig[self.selectItemIndex].cfg
local unlockLimit=curSelectCfg.unlock
local headid
if self.curMenuIndex==menuIndex.headIcon then
kuangIcon=self.curUseKuangCfg.icon

headid=curSelectCfg.id
kuangCfg=self.curUseKuangCfg
elseif self.curMenuIndex==menuIndex.headKuang then

headid=self.curUseHeadCfg.id
kuangIcon=curSelectCfg.icon
kuangCfg=curSelectCfg
end
self.curName:setText(curSelectCfg.name)





local kuangAnimType,kuangAnim,enterAnimId=playerModel:getActorFrameAnimById(kuangCfg.id)

playerController:setWidgetHeadKuang(self.widget,self.headKuang:getID(),kuangIcon,kuangAnimType,kuangAnim,nil,enterAnimId)

self:setWidgetHead(self.widget,self.headIcon:getID(),headid)

local unLock=UISettingModel:isUnlockHead(self.curMenuIndex,curSelectCfg.id)

self.gainTable={}
local stateStr=''
local stateY=-95
self.stateText:setActive(false)
if unlockLimit and not unLock then
if unlockLimit.type==unlockType.eLevel then

local needLevel=unlockLimit.param
local level=zongmenModel:getLevel()

unLock=level>needLevel
stateStr=FMT.fmt('宗门等级达到{0}级获得',needLevel)
stateY=-175
self.stateText:setActive(true)
else

local cost=unlockLimit.param
local itemid=cost[1]
self.gainTable[itemid]=1
local canUnLock,countStr=UISettingModel:isCanUnLockHead(cost)
self.unLockRedot:setActive(canUnLock)

local conf={itemid=itemid,itemcount=countStr,showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.costItem:setChildPropData(prop)

local _onClickCostItem=function(...)
self:onClickCostItem(...)
end
self.costItem:setBaseItemChildID(itemid)
self.costItem:setBaseItemClickEvent(_onClickCostItem)
end
self.stateText:setActive(unlockLimit.type==unlockType.eLevel)
self.canLock:setActive(unlockLimit.type==unlockType.eItem)
else
self.canLock:setActive(false)
end
if self.selectItemIndex==self.curUseIndex then
if self.curMenuIndex==menuIndex.headIcon then
stateStr='已启用'
stateY=-95
elseif self.curMenuIndex==menuIndex.headKuang then
stateStr='已启用'
stateY=-95
end
self.stateText:setActive(true)
end
self.useBtn:setActive(unLock and self.selectItemIndex~=self.curUseIndex)
self.stateText:setText(stateStr)


self:setLeftoverTimeTimer()


self:setHeadAttr(kuangCfg)
end

function UIHeadSelectWin:setWidgetHead(widget,index,iconid)
widget:SetChildUIModelRemoveTarget(index)
widget:SetChildIcon(index,"",false)
local scale=0.53
local offsetX=0
local offsetY=-43
local ani=eAnimationID.idle
local isdefault=cfgHelper.get2(cfg_headportraitconfig_get,iconid,'isdef')==1
local playerImage=playerImageModel:getPlayerImage()
if isdefault and playerImage~=nil then
playerImageController.setPlayerModel(widget,index,playerImage,scale,ani,offsetX,offsetY)
else
local headicon=playerModel:getActorIconById(iconid)
local iconname=iconHelper.getHeadIcon(headicon)
widget:SetChildIcon(index,iconname,false)
end
end

function UIHeadSelectWin:initScrollerView(isInit)
local col=4
local row=math.floor(#self.curConfig/col)
if isInit then
self.Content:setChildAnchoredPos(0,0)
end
self.rightScrollerView:setChildScrollViewCreateGrids(#self.curConfig,col)

local grids=self.rightScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local config=self.curConfig[i].cfg
local iconName=''
item:SetChildActive(itemIndex.icon,self.curMenuIndex==menuIndex.headIcon)
item:SetChildActive(itemIndex.kuang,self.curMenuIndex==menuIndex.headKuang)
item:SetChildActive(itemIndex.bg,self.curMenuIndex==menuIndex.headIcon)
if self.curMenuIndex==menuIndex.headIcon then
local headIcon=config.icon
iconName=iconHelper.getHeadIcon(headIcon)
item:SetChildIcon(itemIndex.icon,iconName,false)
elseif self.curMenuIndex==menuIndex.headKuang then
iconName=iconHelper.getHeadKuangIcon(config.icon)
item:SetChildIcon(itemIndex.kuang,iconName,false)
end
item:SetChildActive(itemIndex.select,self.selectItemIndex==i)
item:SetChildActive(itemIndex.using,self.curUseIndex==i)

local unLock=UISettingModel:isUnlockHead(self.curMenuIndex,config.id)
item:SetChildImageExGray(itemIndex.kuang,not unLock)
item:SetChildImageExGray(itemIndex.icon,not unLock)
item:SetChildActive(itemIndex.lock,not unLock)

local canUnLock=false
if not unLock then
local unlockLimit=config.unlock
if unlockLimit and unlockLimit.type==unlockType.eItem then
canUnLock=UISettingModel:isCanUnLockHead(unlockLimit.param)
end
end
item:SetChildActive(itemIndex.reddot,canUnLock)
end

if isInit then

self.rightScrollerView:setChildScrollViewSelectItem(self.selectItemIndex-1,false,false,false)
end
end

function UIHeadSelectWin:refreshScrollerView()
local grids=self.rightScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
item:SetChildActive(itemIndex.select,self.selectItemIndex==i)
item:SetChildActive(itemIndex.using,self.curUseIndex==i)

local curSelectCfg=self.curConfig[i].cfg
local unLock=UISettingModel:isUnlockHead(self.curMenuIndex,curSelectCfg.id)
item:SetChildImageExGray(itemIndex.kuang,not unLock)
item:SetChildImageExGray(itemIndex.icon,not unLock)
item:SetChildActive(itemIndex.lock,not unLock)

local iconName=''
if self.curMenuIndex==menuIndex.headIcon then
local headIcon=curSelectCfg.icon
iconName=iconHelper.getHeadIcon(headIcon)
item:SetChildIcon(itemIndex.icon,iconName,false)
elseif self.curMenuIndex==menuIndex.headKuang then
iconName=iconHelper.getHeadKuangIcon(curSelectCfg.icon)
item:SetChildIcon(itemIndex.kuang,iconName,false)
end

local canUnLock=false
if not unLock then
local unlockLimit=curSelectCfg.unlock
if unlockLimit and unlockLimit.type==unlockType.eItem then
canUnLock=UISettingModel:isCanUnLockHead(unlockLimit.param)
end
end
item:SetChildActive(itemIndex.reddot,canUnLock)
end
end

function UIHeadSelectWin:OnClickItemCallback(clickCount,index)

if self.selectItemIndex==index+1 then
return
end
local lastItemIndex=self.selectItemIndex
self.selectItemIndex=index+1
local lastItem=self.rightScrollerView:getChildScrollViewItemWidget(lastItemIndex-1)
if lastItem then
lastItem:SetChildActive(itemIndex.select,lastItemIndex==index+1)
end
local curItem=self.rightScrollerView:getChildScrollViewItemWidget(self.selectItemIndex-1)
if curItem then
curItem:SetChildActive(itemIndex.select,self.selectItemIndex==index+1)
end
self:refreshCurInfo()
end

function UIHeadSelectWin:onClickCostItem(itemid,index,guid,attach)

if itemid==-1 or itemid==0 then
return
end
local need=self.gainTable[itemid]or 0
if gainControl:showGainWin(itemid,1)then return end
tipsManager.showTips({itemid=itemid,itemguid=guid})
end


function UIHeadSelectWin:setLeftoverTimeTimer()

self:clearTimer()
local func
func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local itemId=self.curConfig[self.selectItemIndex].id

if UISettingModel:isUnlockHead(self.curMenuIndex,itemId)then


local endTime=UISettingModel:isExpireHeadType(self.curMenuIndex,itemId)
local lerp=(endTime and endTime~=-1)and endTime-nowTime or 0
if lerp>0 then

self.leftoverTimeBg:setActive(true)
if lerp>=3600 then

local str
if lerp>86400 and lerp%86400==0 then

str=timeHelper.format_time_stamp11(lerp-1,true)
else
str=timeHelper.format_time_stamp11(lerp,true)
end
self.leftoverTime:setText(FMT.fmt("<color=#7D3B17>限时：</color> {0}",str))
else

self.leftoverTime:setText(FMT.fmt("<color=#7D3B17>限时：</color> {0}",timeHelper.format_time_stamp7(lerp)))
end
else

self.leftoverTimeBg:setActive(false)

self:clearTimer()
end
else

self.leftoverTimeBg:setActive(false)

self:clearTimer()
end
end

self.timer=self:setTimer(1,0,func)

func()
end


function UIHeadSelectWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UIHeadSelectWin:getSortCfgListByType(type)
local cfgList={}
local originalCfg=nil
if type==menuIndex.headIcon then
originalCfg=UISettingModel:get_head_config()
elseif type==menuIndex.headKuang then
originalCfg=cfg_headportraitframeconfig()
end

for i,v in ipairs(originalCfg)do
local isActive=UISettingModel:isUnlockHead(type,v.id)
local isInsert=false
local isCanUnLock=false
local hideType=v.hideType or kuangHideType.eNotHide
if hideType==kuangHideType.eNotHide then

isInsert=true
if not isActive then
local unlockLimit=v.unlock
if unlockLimit.type==unlockType.eItem then
local cost=unlockLimit.param
local canUnLock,countStr=UISettingModel:isCanUnLockHead(cost)
isCanUnLock=canUnLock
end
end
elseif hideType==kuangHideType.eLockHide then

if isActive then

isInsert=true
else

local unlockLimit=v.unlock
if unlockLimit.type==unlockType.eItem then

local cost=unlockLimit.param
local canUnLock,countStr,isEnough,isCanUse=UISettingModel:isCanUnLockHead(cost)
isInsert=isEnough
isCanUnLock=canUnLock
end
end
elseif hideType==kuangHideType.eAlwaysHide then

isInsert=false
end

if isInsert then
local weight=1000-v.id
if isActive then
weight=weight+10000
else
weight=weight-10000
end

if isCanUnLock then
weight=weight+10000000
end
cfgList[#cfgList+1]={id=v.id,cfg=v,weight=weight}
end
end

table.sort(cfgList,function(a,b)
return a.weight>b.weight
end)

return cfgList
end



function UIHeadSelectWin:getCurUseIndexByType(type)
local curId=nil
local selectId=nil
local ret=nil
if type==menuIndex.headIcon then
curId=UISettingModel:get_cur_head()
ret,selectId=UISettingModel:checkReddotHead()
if not ret then
selectId=curId
end
elseif type==menuIndex.headKuang then
curId=UISettingModel:get_cur_head_kuang()
ret,selectId=UISettingModel:checkReddotHeadKuang()
if not ret then
selectId=curId
end
end

local curUseIndex=nil
local selectIndex=nil

for i,v in ipairs(self.curConfig)do
if v.id==curId then
curUseIndex=i
end

if v.id==selectId then
selectIndex=i
end

if curUseIndex and selectIndex then
break
end
end

return curUseIndex or 1,selectIndex or 1
end




function UIHeadSelectWin:onUseBtn()
if self.curUseIndex==self.selectItemIndex then
UIManager.info('正在使用中')
return
end
local config=self.curConfig[self.selectItemIndex].cfg
local unLock=UISettingModel:isUnlockHead(self.curMenuIndex,config.id)
if not unLock then
UIManager.error('未解锁')
return
end
UISettingController:reqUseKuang(self.curMenuIndex,config.id)
end


function UIHeadSelectWin:onUnLockBtn()
local curSelectCfg=self.curConfig[self.selectItemIndex].cfg
local unLock=UISettingModel:isUnlockHead(self.curMenuIndex,curSelectCfg.id)
if unLock then
UIManager.error('已解锁')
return
end
local unLockLimit=curSelectCfg.unlock
if unLockLimit then
local cost=unLockLimit.param
local itemid=cost[1]
local needCount=cost[2]
local have=0
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
else

have=itemBagModel:getItemCountByItemID(itemid)
end
if have<needCount then
UIManager.error('道具不足')
gainControl:showGainWin(itemid)
return
end

if itemsLookup:checkUseItemCondition(itemid)then
UISettingController:req_unlock(self.curMenuIndex,curSelectCfg.id)
end
end
end


function UIHeadSelectWin:onDetailBtn()
self.settingType=KUANGE_TYPE.headKuang
UIManager:showWindow("UISettingAttrAddWin",{settingType=self.settingType})
end
function UIHeadSelectWin:onTipsBtn()
end

function UIHeadSelectWin:setHeadAttr(settingcfg)



















local attr=settingcfg.attr
local jzattr=settingcfg.jzattr
local haveAttr=false
if attr or jzattr then
haveAttr=true
end
if self.curMenuIndex==menuIndex.headKuang then
self.detailBtn:setActive(true)
self.tipsRoot:setActive(true)
else
self.detailBtn:setActive(false)
self.tipsRoot:setActive(false)
end
if self.curMenuIndex==menuIndex.headKuang and haveAttr then
local attrList
if attr then
attrList={}
for i,v in ipairs(attr)do
table.insert(attrList,v)
end
end
if jzattr then
if not attrList then
attrList={}
end
for i,v in ipairs(jzattr)do
table.insert(attrList,v)
end
end
if attrList then
self.attrRoot:setActive(true)
for i,v in ipairs(self.attr)do
if attrList[i]then
local attr=attrList[i]
v:setActive(true)
local item=v:getChildWidgetBase()
local name,value=equipsHelper.getAttr(attr[1],attr[2])
local nameStr=FMT.fmt("{0} +{1}",name,value)

item:SetChildText(1,nameStr)


else
v:setActive(false)
end
end
else
self.attrRoot:setActive(false)
end
else
self.attrRoot:setActive(false)
end
end
