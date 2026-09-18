







def_class("UIChatKuangSettingWin",UIWindowBase)









function UIChatKuangSettingWin:bindComponents()

self.leftoverTime=UIText.get(self,0)
self.costItem=UIBaseItem.get(self,1)
self.unLockBtn=UIButton.get(self,2)
self.renewalCostItem=UIBaseItem.get(self,3)
self.renewalBtn=UIButton.get(self,4)
self.unLockRedot=UIObject.get(self,5)
self.icon=UIImage.get(self,6)
self.model=UIObject.get(self,7)
self.layout=UIObject.get(self,8)
self.curName=UIText.get(self,9)
self.rightScrollerView=UIScrollView.get(self,10)
self.stateText=UIText.get(self,11)
self.leftoverTimeBg=UIObject.get(self,12)
self.useBtn=UIButton.get(self,13)
self.canUnlock=UIObject.get(self,14)
self.canRenewal=UIObject.get(self,15)
self.root=UIObject.get(self,16)
self.detailBtn=UIButton.get(self,17)
self.attrRoot=UIObject.get(self,18)
self.attr_1=UIObject.get(self,19)
self.attr_2=UIObject.get(self,20)
self.tipsRoot=UIObject.get(self,21)
self.tipsBtn=UIButton.get(self,22)

self.unLockBtn:setButtonClick(function()self:onUnLockBtn()end)

self.renewalBtn:setButtonClick(function()self:onRenewalBtn()end)

self.useBtn:setButtonClick(function()self:onUseBtn()end)

self.detailBtn:setButtonClick(function()self:onDetailBtn()end)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)
self.attr={
self.attr_1,
self.attr_2,
}



end


function UIChatKuangSettingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.leftoverTime);self.leftoverTime=nil;
_UIObject_release(self.costItem);self.costItem=nil;
_UIObject_release(self.unLockBtn);self.unLockBtn=nil;
_UIObject_release(self.renewalCostItem);self.renewalCostItem=nil;
_UIObject_release(self.renewalBtn);self.renewalBtn=nil;
_UIObject_release(self.unLockRedot);self.unLockRedot=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.layout);self.layout=nil;
_UIObject_release(self.curName);self.curName=nil;
_UIObject_release(self.rightScrollerView);self.rightScrollerView=nil;
_UIObject_release(self.stateText);self.stateText=nil;
_UIObject_release(self.leftoverTimeBg);self.leftoverTimeBg=nil;
_UIObject_release(self.useBtn);self.useBtn=nil;
_UIObject_release(self.canUnlock);self.canUnlock=nil;
_UIObject_release(self.canRenewal);self.canRenewal=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.detailBtn);self.detailBtn=nil;
_UIObject_release(self.attrRoot);self.attrRoot=nil;
_UIObject_release(self.attr_1);self.attr_1=nil;
_UIObject_release(self.attr_2);self.attr_2=nil;
_UIObject_release(self.tipsRoot);self.tipsRoot=nil;
_UIObject_release(self.tipsBtn);self.tipsBtn=nil;
self.attr=nil;
end

















local _onClickCostItem
local kuangHideType=KUANGE_HIDE_TYPE
local unlockType=KUANGE_UNLOCK_TYPE

function UIChatKuangSettingWin:onLoaded(...)
self:bindComponents()
UISettingModel:checkShowExperienceWin()
self.dOFade=true
self.root:setChildCanvasGroupDOFade(1,1,function()
self.dOFade=false
end)
self.rightScrollerView:setClickAction(function(...)self:OnClickItemCallback(...)end)
self.gainTable={}
self.defaultId=1
self:addNotify(notifyConfig.chatBgExperience,function(...)self:onChatBgExperience(...)end)
_onClickCostItem=function(...)
self:onClickCostItem(...)
end
end

function UIChatKuangSettingWin:__delete()
self:unbindComponents()
end

function UIChatKuangSettingWin:onShow(argtable,afterOnloaded)
local itemid
local kuangid
if argtable then
if argtable.itemId and argtable.itemId~=-1 then
itemid=argtable.itemId
oneTabScreenController:changeArgs({itemId=-1},true)
elseif argtable.kuangid then
kuangid=argtable.kuangid
end
end

if itemid then
local kuangid=UISettingModel:getUnlockChatKuang(itemid)
self.selectId=kuangid
elseif kuangid then
self.selectId=kuangid
else
local ret,kuangid=UISettingModel:hasChatKuangReddot()
if ret then
self.selectId=kuangid
else
self.selectId=UISettingModel:getCurrentChatKuang()
end
end
self.selectId=self.selectId or self.defaultId
self:freshView(true)
end

function UIChatKuangSettingWin:onHide()
self.rightScrollerView:setActive(false)
end

function UIChatKuangSettingWin:freshView(isInit)
self:freshSelectInfo()
self:freshAllGrids(isInit)
self.rightScrollerView:setActive(true)
end

function UIChatKuangSettingWin:freshSelectInfo()
local kuangid=self.selectId
local kuangCfg=cfg_bubbleframeconfig_get(kuangid)
local name=kuangCfg.name
local kuangIconName=iconHelper.getChatKuangIcon(kuangCfg.icon)
local model=kuangCfg.model
local unlock=UISettingModel:isChatKuangUnlock(kuangid)
local unlockParams=kuangCfg.unlock
local useId=UISettingModel:getCurrentChatKuang()
local isUse=kuangid==useId

self.curName:setText(name)


local modelId=kuangCfg.setmodel

if modelId then
self.winlua:SetChildUIModelEnableInitUISpinePara(self.model:getID(),false,true)
if self.dOFade and api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.model:getID(),true,true,false)
end
self.model:setChildUIModelShowTarget(modelId,1,{},eAnimationID.stand)

else
self.model:setChildUIModelRemoveTarget()
self.icon:setImageIcon(kuangIconName,false)
end
self.winlua:SetChildActive(self.icon:getID(),modelId==nil)

local gainTable={}
if not unlock and unlockParams then
if unlockParams.type==KUANGE_UNLOCK_TYPE.eLevel then
self.canRenewal:setActive(false)
local needLevel=unlockParams.param
self.stateText:setText(FMT.fmt('宗门等级达到{0}级获得',needLevel))

self.canUnlock:setActive(false)
else
self.stateText:setText('')


local cost=unlockParams.param
local canUnLock,countStr=UISettingModel:isCanUnLockHead(cost)
local itemid=cost[1]
gainTable[itemid]=1


local isExperience=false

self.canRenewal:setActive(isExperience)
self.canUnlock:setActive(not isExperience)
if not isExperience then
self.unLockRedot:setActive(canUnLock)
local conf={itemid=itemid,itemcount=countStr,showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.costItem:setChildPropData(prop)
self.costItem:setBaseItemChildID(itemid)
self.costItem:setBaseItemClickEvent(_onClickCostItem)
else
local conf={itemid=itemid,itemcount=countStr,showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.renewalCostItem:setChildPropData(prop)
self.renewalCostItem:setBaseItemChildID(itemid)
self.renewalCostItem:setBaseItemClickEvent(_onClickCostItem)
end
end
else
local isRenewal=false

self.canRenewal:setActive(false)
self.canUnlock:setActive(false)
self.stateText:setText('')
if isRenewal then
local cost=unlockParams.param
local itemid=cost[1]
gainTable[itemid]=1
local canUnLock,countStr=UISettingModel:isCanUnLockHead(cost)

local conf={itemid=itemid,itemcount=countStr,showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.renewalCostItem:setChildPropData(prop)
self.renewalCostItem:setBaseItemChildID(itemid)
self.renewalCostItem:setBaseItemClickEvent(_onClickCostItem)
end
end
self.gainTable=gainTable

if isUse then
self.stateText:setText('已启用')

end
self.useBtn:setActive(unlock and not isUse)

self:freshExpireTimer()


self:setHeadAttr(kuangCfg)
end

function UIChatKuangSettingWin:freshAllGrids(isInit)
local col=2
self:initSortCfgList()
local len=#self.configList
local row=math.ceil(len/col)
self.rightScrollerView:freshGridsNum(len,row,col,true)
local useId=UISettingModel:getCurrentChatKuang()
for i=1,len do
local item=self.rightScrollerView:getGridObjectByindex(i-1)
local cfg=self.configList[i].cfg
local id=cfg.id
local icon=cfg.icon
local unlock=UISettingModel:isChatKuangUnlock(id)
local canUnLock=UISettingModel:isCanChatKuangUnlockByItem(id)
local isSelect=self.selectId==id
if isSelect then
self.selectIdx=i
end


item:SetChildActive(1,self.selectId==id)
item:SetChildActive(2,useId==id)
item:SetChildActive(3,not unlock)
item:SetChildActive(4,canUnLock)
item:SetBaseItemChildID(-1,id)


local color=unlock and Color.white or Color.gray
local modelId=cfg.setmodel
if modelId then
if self.dOFade and api_Available_SetChildUIModelEnableInitUISpineParaEx()then
item:SetChildUIModelEnableInitUISpineParaEx(5,true,true,false)
end
item:SetChildUIModelShowTarget(5,modelId,2.25,{},eAnimationID.stand)
item:SetChildUIModelShowColor(5,color)
else
item:SetChildUIModelRemoveTarget(5)
item:SetChildIcon(0,iconHelper.getChatKuangIcon(icon),false)
end
end

if isInit then

self.rightScrollerView:jumpToLockX(self.selectIdx)
end
end


function UIChatKuangSettingWin:test_jump(index)
self.rightScrollerView:jumpToLockX(index)
end

function UIChatKuangSettingWin:freshGridsUse()

local len=#self.configList
local useId=UISettingModel:getCurrentChatKuang()
for i=1,len do
local item=self.rightScrollerView:getGridObjectByindex(i-1)
local cfg=self.configList[i].cfg
local id=cfg.id
local canUnLock=UISettingModel:isCanChatKuangUnlockByItem(id)
item:SetChildActive(2,useId==id)
item:SetChildActive(4,canUnLock)
end
end

function UIChatKuangSettingWin:freshGridsExperience()

local len=#self.configList
local useId=UISettingModel:getCurrentChatKuang()
for i=1,len do
local item=self.rightScrollerView:getGridObjectByindex(i-1)
local cfg=self.configList[i].cfg
local id=cfg.id
local unlock=UISettingModel:isChatKuangUnlock(id)
local canUnLock=UISettingModel:isCanChatKuangUnlockByItem(id)
item:SetChildImageExGray(0,not unlock)
item:SetChildActive(3,not unlock)
item:SetChildActive(4,canUnLock)

local modelId=cfg.setmodel
local color=unlock and Color.white or Color.gray
if modelId then
item:SetChildUIModelShowColor(5,color)
end
item:SetChildActive(0,modelId==nil)
end
end

function UIChatKuangSettingWin:OnClickItemCallback(id,index,guid,attach)
if self.selectId==id then return end
local old=self.selectIdx
self.selectIdx=index
self.selectId=id
if old then
local item=self.rightScrollerView:getGridObjectByindex(old-1)
item:SetChildActive(1,false)
end
local item=self.rightScrollerView:getGridObjectByindex(index-1)
item:SetChildActive(1,true)

self:freshSelectInfo()
end

function UIChatKuangSettingWin:onClickCostItem(itemid,index,guid,attach)

if itemid==-1 or itemid==0 then
return
end
local need=self.gainTable[itemid]or 0
if gainControl:showGainWin(itemid,1)then return end
tipsManager.showTips({itemid=itemid,itemguid=guid})
end


function UIChatKuangSettingWin:freshExpireTimer()
self:stopExpireTimer()
self.leftoverTimeBg:setActive(false)
self.leftoverTime:setText('')
local func=function()
local kuangid=self.selectId
local lerp,type=UISettingModel:getLeftChatKuangExpireTime(kuangid)
if type==nil then
if lerp>=0 then
self.leftoverTimeBg:setActive(true)
if lerp>=3600 then

local str
if lerp>86400 and lerp%86400==0 then

str=timeHelper.format_time_stamp11(lerp-1,true)
else
str=timeHelper.format_time_stamp11(lerp,true)
end
self.leftoverTime:setText(FMT.fmt("<color=#7D3B17>限时：</color> {0}",timeHelper.format_time_stamp11(lerp,true)))
else

self.leftoverTime:setText(FMT.fmt("<color=#7D3B17>限时：</color> {0}",timeHelper.format_time_stamp7(lerp)))
end
else
self.leftoverTimeBg:setActive(false)
self.leftoverTime:setText('')
end
else
self.leftoverTimeBg:setActive(false)
self.leftoverTime:setText('')
self:stopExpireTimer()
end
end

self.timer=self:setTimer(1,0,func)

func()
end


function UIChatKuangSettingWin:stopExpireTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UIChatKuangSettingWin:initSortCfgList()
self.configList={}
local cfgs=cfg_bubbleframeconfig()
for i,v in ipairs(cfgs)do
if v then
local unlock=UISettingModel:isChatKuangUnlock(v.id)
local isInsert=false
local isCanUnLock=false
local hideType=v.hideType or kuangHideType.eNotHide
if hideType==kuangHideType.eNotHide then

isInsert=true
isCanUnLock=not unlock and UISettingModel:isCanChatKuangUnlockByItem(v.id)
elseif hideType==kuangHideType.eLockHide then

if unlock then

isInsert=true
else

local canUnLock=UISettingModel:isCanChatKuangUnlockByItem(v.id)
isInsert=canUnLock
isCanUnLock=canUnLock
end
elseif hideType==kuangHideType.eAlwaysHide then

isInsert=false
end

if isInsert then
local weight=1000-v.id
if unlock then
weight=weight+10000
else
weight=weight-10000
end

if isCanUnLock then
weight=weight+10000000
end
self.configList[#self.configList+1]={cfg=v,weight=weight}
end
end
end
table.sort(self.configList,function(a,b)
return a.weight>b.weight
end)
end


function UIChatKuangSettingWin:onKuangUseChanged(kuangid)
self:freshGridsUse()
if kuangid==self.selectId then
self:freshSelectInfo()
end
end

function UIChatKuangSettingWin:onKuangUnlock(kuangid)
self:freshAllGrids()
if kuangid==self.selectId then
self:freshSelectInfo()
end
end

function UIChatKuangSettingWin:onChatBgExperience(kuangidList)
self:freshGridsExperience()
local has=false
for i,v in ipairs(kuangidList)do
if v==self.selectId then
has=true
break
end
end
if has then
self:freshSelectInfo()
end
end


function UIChatKuangSettingWin:onUnLockBtn()
local kuangid=self.selectId
local unlock=UISettingModel:isChatKuangUnlock(kuangid)
if unlock then
UIManager.error('已解锁')
return
end
local kuangCfg=cfg_bubbleframeconfig_get(kuangid)
local unlockParams=kuangCfg.unlock
if unlockParams then
local cost=unlockParams.param
local itemid=cost[1]
local needCount=cost[2]
local have=itemsModel.getCount(itemid)
if have<needCount then
UIManager.error('道具不足')
gainControl:showGainWin(itemid)
return
end
UISettingController:req_unlock(KUANGE_TYPE.chatKuang,kuangid)
end
end

function UIChatKuangSettingWin:onUseBtn()
local useid=UISettingModel:getCurrentChatKuang()
local kuangid=self.selectId
if useid==kuangid then
UIManager.info('正在使用中')
return
end
local unlock=UISettingModel:isChatKuangUnlock(kuangid)
if not unlock then
UIManager.error('未解锁')
return
end
UISettingController:reqUseKuang(KUANGE_TYPE.chatKuang,kuangid)
end

function UIChatKuangSettingWin:onRenewalBtn()
local kuangid=self.selectId
local kuangCfg=cfg_bubbleframeconfig_get(kuangid)
local unlockParams=kuangCfg.unlock
if unlockParams then
local cost=unlockParams.param
local itemid=cost[1]
local need=cost[2]
if itemsModel.getCount(itemid)<need then
UIManager.error('道具不足')
gainControl:showGainWin(itemid)
return
end
UISettingController:req_unlock(KUANGE_TYPE.chatKuang,kuangid)
end
end


function UIChatKuangSettingWin:onDetailBtn()
self.settingType=KUANGE_TYPE.chatKuang
UIManager:showWindow("UISettingAttrAddWin",{settingType=self.settingType})
end
function UIChatKuangSettingWin:onTipsBtn()
end

function UIChatKuangSettingWin:setHeadAttr(settingcfg)



















local attr=settingcfg.attr
local jzattr=settingcfg.jzattr
local haveAttr=false
if attr or jzattr then
haveAttr=true
end
self.detailBtn:setActive(true)
self.tipsRoot:setActive(true)
if haveAttr then
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
