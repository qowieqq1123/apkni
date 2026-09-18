







def_class("UISettingYunZhouSelectWin",UIWindowBase)









function UISettingYunZhouSelectWin:bindComponents()

self.attr_1=UIObject.get(self,0)
self.attr_2=UIObject.get(self,1)
self.attrRoot=UIObject.get(self,2)
self.canRenewal=UIObject.get(self,3)
self.canUnlock=UIObject.get(self,4)
self.costItem=UIBaseItem.get(self,5)
self.curName=UIText.get(self,6)
self.detailBtn=UIButton.get(self,7)
self.icon=UIImage.get(self,8)
self.layout=UIObject.get(self,9)
self.leftoverTime=UIText.get(self,10)
self.leftoverTimeBg=UIObject.get(self,11)
self.model=UIObject.get(self,12)
self.renewalBtn=UIButton.get(self,13)
self.renewalCostItem=UIBaseItem.get(self,14)
self.rightScrollerView=UIScrollView.get(self,15)
self.root=UIObject.get(self,16)
self.starScrollView=UIObject.get(self,17)
self.stateText=UIText.get(self,18)
self.tipsBtn=UIButton.get(self,19)
self.tipsRoot=UIObject.get(self,20)
self.unLockBtn=UIButton.get(self,21)
self.unLockBtnTxt=UIText.get(self,22)
self.unLockRedot=UIObject.get(self,23)
self.upStarBtn=UIButton.get(self,24)
self.upStarReddot=UIObject.get(self,25)
self.useBtn=UIButton.get(self,26)

self.detailBtn:setButtonClick(function()self:onDetailBtn()end)

self.renewalBtn:setButtonClick(function()self:onRenewalBtn()end)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)

self.unLockBtn:setButtonClick(function()self:onUnLockBtn()end)

self.upStarBtn:setButtonClick(function()self:onUpStarBtn()end)

self.useBtn:setButtonClick(function()self:onUseBtn()end)
self.attr={
self.attr_1,
self.attr_2,
}



end


function UISettingYunZhouSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attr_1);self.attr_1=nil;
_UIObject_release(self.attr_2);self.attr_2=nil;
_UIObject_release(self.attrRoot);self.attrRoot=nil;
_UIObject_release(self.canRenewal);self.canRenewal=nil;
_UIObject_release(self.canUnlock);self.canUnlock=nil;
_UIObject_release(self.costItem);self.costItem=nil;
_UIObject_release(self.curName);self.curName=nil;
_UIObject_release(self.detailBtn);self.detailBtn=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.layout);self.layout=nil;
_UIObject_release(self.leftoverTime);self.leftoverTime=nil;
_UIObject_release(self.leftoverTimeBg);self.leftoverTimeBg=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.renewalBtn);self.renewalBtn=nil;
_UIObject_release(self.renewalCostItem);self.renewalCostItem=nil;
_UIObject_release(self.rightScrollerView);self.rightScrollerView=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.starScrollView);self.starScrollView=nil;
_UIObject_release(self.stateText);self.stateText=nil;
_UIObject_release(self.tipsBtn);self.tipsBtn=nil;
_UIObject_release(self.tipsRoot);self.tipsRoot=nil;
_UIObject_release(self.unLockBtn);self.unLockBtn=nil;
_UIObject_release(self.unLockBtnTxt);self.unLockBtnTxt=nil;
_UIObject_release(self.unLockRedot);self.unLockRedot=nil;
_UIObject_release(self.upStarBtn);self.upStarBtn=nil;
_UIObject_release(self.upStarReddot);self.upStarReddot=nil;
_UIObject_release(self.useBtn);self.useBtn=nil;
self.attr=nil;
end

















local _onClickCostItem
local kuangHideType=KUANGE_HIDE_TYPE
local unlockType=KUANGE_UNLOCK_TYPE


function UISettingYunZhouSelectWin:onLoaded(...)
self:bindComponents()
UISettingModel:checkShowExperienceWin()
self.dOFade=true
self.root:setChildCanvasGroupDOFade(1,1,function()
self.dOFade=false
end)
self.rightScrollerView:setClickAction(function(...)self:OnClickItemCallback(...)end)
self.gainTable={}
self.defaultId=1
self.settingType=KUANGE_TYPE.yunzhou
self:addNotify(notifyConfig.onSettingTypeExperience,function(...)self:onSettingTypeExperience(...)end)
_onClickCostItem=function(...)
self:onClickCostItem(...)
end
self.starScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UISettingYunZhouSelectWin:__delete()
self:unbindComponents()
self:stopExpireTimer()
end




function UISettingYunZhouSelectWin:onShow(argtable,afterOnloaded)
local itemid
local settingId
if argtable then
if argtable.itemId and argtable.itemId~=-1 then
itemid=argtable.itemId
oneTabScreenController:changeArgs({itemId=-1},true)
elseif argtable.settingId then
settingId=argtable.settingId
end
end

if itemid then
local settingId=UISettingModel:getunlockId(itemid)
self.selectId=settingId
elseif settingId then
self.selectId=settingId
else
local ret,settingId=UISettingModel:hasSettingTypeReddot(self.settingType)
if ret then
self.selectId=settingId
else
self.selectId=UISettingModel:getCurSettingId_Type(self.settingType)
end
end
self.selectId=self.selectId or self.defaultId
self:freshView(true)
end


function UISettingYunZhouSelectWin:onHide()
self.rightScrollerView:setActive(false)
end

function UISettingYunZhouSelectWin:freshView(isInit)
self:freshSelectInfo()
self:freshAllGrids(isInit)
self.rightScrollerView:setActive(true)
end


function UISettingYunZhouSelectWin:freshSelectInfo()
local selectId=self.selectId
local settingType=self.settingType
local settingcfg=UISettingConfig.getCfg(settingType,selectId)
local name=settingcfg.name


local unlock,activeType=UISettingModel:checkSettingIdUnlock_Type(settingType,selectId)

local unlockParams=settingcfg.unlock
local useId=UISettingModel:getCurSettingId_Type(self.settingType)

local isUse=selectId==useId

self.curName:setText(name)



local modelId=settingcfg.modelId
self.winlua:SetChildUIModelEnableInitUISpinePara(self.model:getID(),false,true)
if self.dOFade and api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.model:getID(),true,true,false)
end
self.model:setChildUIModelShowTarget(modelId,1,{},eAnimationID.stand)
local leftmodelcfg=settingcfg.leftmodelcfg
local scale=leftmodelcfg.scale
local offset=leftmodelcfg.offset
self.model:setScale(Vector3.New(scale,scale,scale))
self.model:setChildAnchoredPos(offset[1],offset[2])








self.winlua:SetChildActive(self.icon:getID(),false)

local gainTable={}
if not unlock and unlockParams then
self.unLockBtnTxt:setText("解锁")
if unlockParams.type==KUANGE_UNLOCK_TYPE.eLevel then
self.canRenewal:setActive(false)
local needLevel=unlockParams.param
self.stateText:setText(FMT.fmt('宗门等级达到{0}级获得',needLevel))

self.canUnlock:setActive(true)
self.costItem:setActive(false)
local isCan,unlocktype=UISettingModel:isCanUnlock(settingType,selectId)
self.unLockRedot:setActive(isCan)
elseif unlockParams.type==KUANGE_UNLOCK_TYPE.eFSRank then
self.canRenewal:setActive(false)
local needRank=unlockParams.param
self.stateText:setText(FMT.fmt('九重天劫前{0}名',mathHelper.numberToChinese(needRank)))

self.canUnlock:setActive(true)
self.costItem:setActive(false)
local isCan,unlocktype=UISettingModel:isCanUnlock(settingType,selectId)
self.unLockRedot:setActive(isCan)
elseif unlockParams.type==KUANGE_UNLOCK_TYPE.eItem then
self.stateText:setText('')

local cost=unlockParams.param
local canUnLock,countStr=UISettingModel:isCanUnLockHead(cost)
local itemid=cost[1]
gainTable[itemid]=1


local isExperience=false

self.canRenewal:setActive(isExperience)
self.canUnlock:setActive(not isExperience)
if not isExperience then
self.costItem:setActive(true)
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
elseif unlockParams.type==KUANGE_UNLOCK_TYPE.eItemChange then
local isCan,unlocktype,paramIndex=UISettingModel:isCanUnlock(settingType,selectId)
self.stateText:setText('')
local cost=unlockParams.param[paramIndex or#unlockParams.param]






local canUnLock,countStr=UISettingModel:isCanUnLockHead(cost)
local itemid=cost[1]
gainTable[itemid]=1
self.canRenewal:setActive(false)
self.canUnlock:setActive(true)
self.costItem:setActive(true)
self.unLockRedot:setActive(canUnLock)
local conf={itemid=itemid,itemcount=countStr,showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.costItem:setChildPropData(prop)
self.costItem:setBaseItemChildID(itemid)
self.costItem:setBaseItemClickEvent(_onClickCostItem)
end
else
self.canRenewal:setActive(false)
self.canUnlock:setActive(false)
self.stateText:setText('')
end
self.gainTable=gainTable

if isUse then
self.stateText:setText('已启用')

end
self.useBtn:setActive(unlock and not isUse)
local starNum=UISettingModel:getStarNum(settingType,selectId)
self.starScrollView:setActive(unlock and starNum>0)
local canShowUpStar=unlock and activeType==SETTING_ACTIVE_TYPE.eForever and settingcfg.star~=nil
self.upStarBtn:setActive(canShowUpStar)

local canUpStar=UISettingModel:isCanUpStar(settingType,selectId)
self.upStarReddot:setActive(canUpStar)

if unlock and starNum>0 then
self.starScrollView:setChildSizeDelta(starNum*40,40)
self.starScrollView:setChildScrollViewCreateGrids(starNum,0)
end

if unlock and activeType==SETTING_ACTIVE_TYPE.eLimit then
local isCan,unlocktype=UISettingModel:isCanUnlock(settingType,selectId)
if isCan and unlocktype==SETTING_ACTIVE_TYPE.eForever then
self.stateText:setText('')
self.useBtn:setActive(false)
self.canRenewal:setActive(false)
self.canUnlock:setActive(true)
self.costItem:setActive(false)
self.unLockRedot:setActive(true)
self.unLockBtnTxt:setText("永久解锁")
end
end

local attrList
local attr=settingcfg.attr
if attr then
attrList={}
for i,v in ipairs(attr)do
table.insert(attrList,v)
end
if starNum>0 then
local star_attr=settingcfg.star_attr[starNum]
attrList=table.concatTableXX(attrList,star_attr)
end
end
local jzattr=settingcfg.jzattr
if jzattr then
if not attrList then
attrList={}
end
for i,v in ipairs(jzattr)do
table.insert(attrList,v)
end

if starNum>0 then
local star_jzattr=settingcfg.star_jzattr[starNum]
attrList=table.concatTableXX(attrList,star_jzattr)
end
end
if attrList then
self.attrRoot:setActive(true)
self.tipsRoot:setActive(true)
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
self.tipsRoot:setActive(true)
end
self:freshExpireTimer()
end


function UISettingYunZhouSelectWin:stopExpireTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UISettingYunZhouSelectWin:freshExpireTimer()
self:stopExpireTimer()
self.leftoverTimeBg:setActive(false)
self.leftoverTime:setText('')
local func=function()
local settingId=self.selectId
local settingType=self.settingType
local lerp=UISettingModel:getLeftExpireTime(settingType,settingId)
if lerp then
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
self:stopExpireTimer()
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


function UISettingYunZhouSelectWin:initSortCfgList()
self.configList={}
local settingType=self.settingType
local cfgs=UISettingConfig.getSelfAllCfg(settingType)
for i,v in pairs(cfgs)do
if v then
local unlock=UISettingModel:checkSettingIdUnlock_Type(settingType,v.id)
local isInsert=false
local isCanUnLock=false
local hideType=v.hideType or kuangHideType.eNotHide
if hideType==kuangHideType.eNotHide then

isInsert=true
isCanUnLock=not unlock and UISettingModel:isCanUnlock(settingType,v.id)
elseif hideType==kuangHideType.eLockHide then

if unlock then

isInsert=true
else

local canUnLock=UISettingModel:isCanUnlock(settingType,v.id)
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

function UISettingYunZhouSelectWin:freshAllGrids(isInit)
local col=2
self:initSortCfgList()
local len=#self.configList
local row=math.ceil(len/col)
self.rightScrollerView:freshGridsNum(len,row,col,true)
local type=self.settingType
local useId=UISettingModel:getCurSettingId_Type(self.settingType)
for i=1,len do
local item=self.rightScrollerView:getGridObjectByindex(i-1)
local cfg=self.configList[i].cfg
local id=cfg.id

local unlock=UISettingModel:checkSettingIdUnlock_Type(type,id)
local canUnLock=UISettingModel:isCanUnlock(type,id)
local canUpStar=UISettingModel:isCanUpStar(type,id)
local isSelect=self.selectId==id
if isSelect then
self.selectIdx=i
end


item:SetChildActive(1,self.selectId==id)
item:SetChildActive(2,useId==id)
item:SetChildActive(3,not unlock)
item:SetChildActive(4,canUnLock or canUpStar)
item:SetBaseItemChildID(-1,id)


local color=unlock and Color.white or Color.gray

local modelId=cfg.modelId
if self.dOFade and api_Available_SetChildUIModelEnableInitUISpineParaEx()then
item:SetChildUIModelEnableInitUISpineParaEx(5,true,true,false)
end
item:SetChildUIModelShowTarget(5,modelId,1,{},eAnimationID.stand)
item:SetChildUIModelShowColor(5,color)
local rightmodelcfg=cfg.rightmodelcfg
local scale=rightmodelcfg.scale
local offset=rightmodelcfg.offset
item:SetChildScale(5,Vector3.New(scale,scale,scale))
item:SetChildAnchoredPos(5,offset[1],offset[2])








local starNum=UISettingModel:getStarNum(type,id)
item:SetChildActive(6,starNum>0)
if starNum>0 then
item:SetChildSizeDelta(6,starNum*26,26)
item:SetChildScrollViewCreateGrids(6,starNum,0)
end
end

if isInit then

self.rightScrollerView:jumpToLockX(self.selectIdx)
end
end

function UISettingYunZhouSelectWin:freshGridsUse()
local len=#self.configList
local useId=UISettingModel:getCurSettingId_Type(self.settingType)
for i=1,len do
local item=self.rightScrollerView:getGridObjectByindex(i-1)
local cfg=self.configList[i].cfg
local id=cfg.id
local canUnLock=UISettingModel:isCanUnlock(self.settingType,id)
local canUpStar=UISettingModel:isCanUpStar(self.settingType,id)
item:SetChildActive(2,useId==id)
item:SetChildActive(4,canUnLock or canUpStar)
end
end

function UISettingYunZhouSelectWin:freshGridsExperience()

local len=#self.configList
local useId=UISettingModel:getCurSettingId_Type(self.settingType)
for i=1,len do
local item=self.rightScrollerView:getGridObjectByindex(i-1)
local cfg=self.configList[i].cfg
local id=cfg.id
local unlock=UISettingModel:checkSettingIdUnlock_Type(self.settingType,id)
local canUnLock=UISettingModel:isCanUnlock(self.settingType,id)
local canUpStar=UISettingModel:isCanUpStar(self.settingType,id)
item:SetChildImageExGray(0,not unlock)
item:SetChildActive(3,not unlock)
item:SetChildActive(4,canUnLock or canUpStar)

local modelId=cfg.modelId
local color=unlock and Color.white or Color.gray
if modelId then
item:SetChildUIModelShowColor(5,color)
end
item:SetChildActive(0,modelId==nil)
end
end


function UISettingYunZhouSelectWin:onSettingUseChanged(settingId)
self:freshGridsUse()
if settingId==self.selectId then
self:freshSelectInfo()
end
end

function UISettingYunZhouSelectWin:onSettingUnlock(settingId)
self:freshAllGrids()
if settingId==self.selectId then
self:freshSelectInfo()
end
end

function UISettingYunZhouSelectWin:onSettingTypeExperience(settingType,experienceList)
if settingType~=self.settingType then
return
end
self:freshGridsExperience()
local has=false
for i,v in ipairs(experienceList)do
if v==self.selectId then
has=true
break
end
end
if has then
self:freshSelectInfo()
end
end

function UISettingYunZhouSelectWin:OnClickItemCallback(id,index,guid,attach)
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

function UISettingYunZhouSelectWin:onClickCostItem(itemid,index,guid,attach)

if itemid==-1 or itemid==0 then
return
end
local need=self.gainTable[itemid]or 0
if gainControl:showGainWin(itemid,1)then return end
tipsManager.showTips({itemid=itemid,itemguid=guid})
end





function UISettingYunZhouSelectWin:onUnLockBtn()
local settingId=self.selectId
local unlock,activeType=UISettingModel:checkSettingIdUnlock_Type(self.settingType,settingId)
if unlock and activeType==SETTING_ACTIVE_TYPE.eForever then
UIManager.error('已解锁')
return
end
local settingcfg=UISettingConfig.getCfg(self.settingType,settingId)
local unlockParams=settingcfg.unlock
local isCan,unlocktype,idx=UISettingModel:isCanUnlock(self.settingType,settingId)
if isCan then




UISettingController:req_unlock(self.settingType,settingId,idx)
return
end
if unlockParams then
if unlockParams.type==KUANGE_UNLOCK_TYPE.eLevel or unlockParams.type==KUANGE_UNLOCK_TYPE.eFSRank then
UIManager.error('未达到解锁条件')
elseif unlockParams.type==KUANGE_UNLOCK_TYPE.eItem then
local cost=unlockParams.param
local itemid=cost[1]
local needCount=cost[2]
local have=itemsModel.getCount(itemid)
if have<needCount then
UIManager.error('道具不足')
gainControl:showGainWin(itemid)
end
elseif unlockParams.type==KUANGE_UNLOCK_TYPE.eItemChange then
local cost=unlockParams.param[1]
local itemid=cost[1]
local needCount=cost[2]
local have=itemsModel.getCount(itemid)
if have<needCount then
UIManager.error('道具不足')
gainControl:showGainWin(itemid)
end
end
end
end



function UISettingYunZhouSelectWin:onRenewalBtn()

end



function UISettingYunZhouSelectWin:onUseBtn()
local useid=UISettingModel:getCurSettingId_Type(self.settingType)
local settingId=self.selectId
if useid==settingId then
UIManager.info('正在使用中')
return
end
local unlock=UISettingModel:checkSettingIdUnlock_Type(self.settingType,settingId)
if not unlock then
UIManager.error('未解锁')
return
end
UISettingController:reqUseKuang(self.settingType,settingId)
end



function UISettingYunZhouSelectWin:onDetailBtn()
UIManager:showWindow("UISettingAttrAddWin",{settingType=self.settingType})
end

function UISettingYunZhouSelectWin:onTipsBtn()
end

function UISettingYunZhouSelectWin:onUpStarBtn()
UIManager:showWindow("UISettingUpStarWin",{settingType=self.settingType,settingId=self.selectId})
end


