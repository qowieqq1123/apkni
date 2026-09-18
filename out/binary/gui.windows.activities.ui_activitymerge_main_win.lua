







def_class("UI_activityMerge_main_Win",UIWindowBase)









function UI_activityMerge_main_Win:bindComponents()

self.blackImg=UIObject.get(self,0)
self.maskBlock=UIObject.get(self,1)
self.bgImg=UIImage.get(self,2)
self.root=UIObject.get(self,3)
self.dayScrollView=UIObject.get(self,4)



end


function UI_activityMerge_main_Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.maskBlock);self.maskBlock=nil;
_UIObject_release(self.bgImg);self.bgImg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.dayScrollView);self.dayScrollView=nil;
end















local _this


function UI_activityMerge_main_Win:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onActivityStateChange,self.onActivityStateChange)
self:addNotify(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)
self:addNotify(notifyConfig.onSubActivityReddotChange,self.onSubActivityReddotChange)
self:addNotify(notifyConfig.onSubActivityOpen,self.onSubActivityOpen)
self:addNotify(notifyConfig.onSubActUnlock,self.onSubActUnlock)
self:addNotify(notifyConfig.onSubActivityFlagChange,self.listenChangTag)
end


function UI_activityMerge_main_Win:__delete()
_this=nil
self:unbindComponents()

activitiesController:resetBgmByCloseActivitiesMainWin()
self:clearSubWin()
if self.showMoney then
self:hideWindow('UITopMoneyWin')
end
end


function UI_activityMerge_main_Win:onHide()

end

function UI_activityMerge_main_Win.onActivityStateChange(actID,state)
if _this==nil then return end
if activityEnterMergeController:checkMergeActivityEx(actID,_this.mergeId)then
if state==activitiesModel.activityFinishState then

if activityEnterMergeController:checkMergeActivityRemove(_this.mergeId)then
_this:onClickClose()
end
end
end
end

function UI_activityMerge_main_Win.onSubActivityOpen(actID,subType,subid,flag,args)
if _this==nil then return end

if flag then
local check=activityEnterMergeController:findSubActInMergeAct(_this.mergeId,actID,subType,subid)
if args and args.hideRefreshSubList then
check=false
end
if check then
local old_select_key=_this.select_key
_this:initSubList()
_this:refreshMenu()
if _this.select_key==nil then
_this:onClickClose()
elseif old_select_key~=_this.select_key then
_this:refreshSubWin()
end
end
end
end

function UI_activityMerge_main_Win.onSubActivityStateChange(actID,subType,subid,state)
if _this==nil then return end

local flag=activityEnterMergeController:findSubActInMergeAct(_this.mergeId,actID,subType,subid)
if flag then
local old_select_key=_this.select_key
_this:initSubList()
_this:refreshMenu()
if _this.select_key==nil then
_this:onClickClose()
elseif old_select_key~=_this.select_key then
_this:refreshSubWin()
end
end
end

function UI_activityMerge_main_Win.onSubActivityReddotChange(actID,subType,subID)
if _this==nil then return end

local idx=_this:getMenuItemIndex(actID,subType,subID)
if idx then
_this:refreshMenuItemState(nil,idx)
end
end

function UI_activityMerge_main_Win.onSubActUnlock(actID,subType,subID)
if _this==nil then return end

local idx=_this:getMenuItemIndex(actID,subType,subID)
if idx then
_this:refreshMenuItemState(nil,idx)
end
end




function UI_activityMerge_main_Win:onShow(argtable,afterOnloaded)
self:clearSubWin()
self.showParams=argtable
self.extraParams=argtable.extraParams
local isFull=argtable.isFull
self.isFull=isFull
self.clickAnyClose=argtable.clickAnyClose
local lastMergeId=self.mergeId
self.mergeId=argtable.mergeId
self.enterCfg=cfg_activityentermergeconfig_get(self.mergeId)
if afterOnloaded or(lastMergeId and lastMergeId~=self.mergeId)then

local bgmParam=self.enterCfg.actBgmParam
activitiesController:checkBgmByOpenActivitiesMainWin(nil,bgmParam)
end


self.select_act_id=argtable.select_act_id
self.sub_act_type=argtable.sub_act_type
self.sub_act_id=argtable.sub_act_id
self.select_key=FMT.fmt('{0}_{1}_{2}',self.select_act_id,self.sub_act_type,self.sub_act_id)

self:initSubList()

self.maskBlock:setActive(not isFull)
self.default_bgname=argtable.bgname
self:changeBG(argtable.bgname)

self.default_moneytypes=argtable.moneytypes
self:changeMoney(argtable.moneytypes)

self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.25,nil)

self:refreshMenu()
self:refreshSubWin()

self.extraParams=nil
end

function UI_activityMerge_main_Win:onShowArgRecv(argtable)
self:onShow(argtable)
end

function UI_activityMerge_main_Win:changeBG(bgname)
bgname=bgname or self.default_bgname
local showBG=bgname~=nil
self.bgImg:setActive(showBG)
if showBG and self.bgname~=bgname then
self.bgname=bgname
local abname=activitiesModel.getActBgABName(bgname)
self.bgImg:setSprite(abname,bgname)
self.winlua:SetChildCanvasGroupAlpha(self.bgImg:getID(),0)
self.winlua:SetChildCanvasGroupDOFade(self.bgImg:getID(),1,0.5)
end
end

function UI_activityMerge_main_Win:changeMoney(moneytypes)
moneytypes=moneytypes or self.default_moneytypes
local showMoney=moneytypes~=nil
if self.isFull then
fullScreenUI.activeUI.moneyArgs=moneytypes
fullScreenUI.activeUI:showMoneyTopWin(true)
else
local moneytypes=moneytypes
if moneytypes then
showMoney=true
self:showWindow('UITopMoneyWin',moneytypes)
else
self:hideWindow('UITopMoneyWin')
end
end
self.showMoney=showMoney
end

function UI_activityMerge_main_Win:initSubList()
self.sublist=activityEnterMergeController:getMergeActSubList_open_doing(self.mergeId)
if self.sub_act_type~=nil then
local f=nil
for i,v in ipairs(self.sublist)do
if self.select_act_id==v.act_id and self.sub_act_type==v.sub_act_type and self.sub_act_id==v.sub_act_id then
f=i
break
end
end
if f then
self.curSelectIndex=f
else
self.select_act_id=nil
self.sub_act_type=nil
self.sub_act_id=nil
self.curSelectIndex=nil
self.select_key=nil
end
end
if self.sub_act_type==nil then

if#self.sublist>0 then
local f
for i,v in ipairs(self.sublist)do
if activitiesModel:checkSubActUnlock(v.act_id,v.sub_act_type,v.sub_act_id)then
f=i
break
end
end
if f then
self.curSelectIndex=f
local data=self.sublist[self.curSelectIndex]
self.select_act_id=data.act_id
self.sub_act_type=data.sub_act_type
self.sub_act_id=data.sub_act_id
self.select_key=FMT.fmt('{0}_{1}_{2}',self.select_act_id,self.sub_act_type,self.sub_act_id)
end
end
end
if self.enterCfg.checkHideMenu then
self.isHideMenu=#self.sublist<=1
end
end

function UI_activityMerge_main_Win:refreshMenu()
if self.isHideMenu then
self.dayScrollView:setChildScrollViewCreateGrids(0,1)
return
end

local c=#self.sublist
self.dayScrollView:setChildScrollViewCreateGrids(c,1)
local grids=self.dayScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local item=grids[i-1]
self:refreshMenuItem(item,i)
end
end

function UI_activityMerge_main_Win:getMenuItemIndex(actID,subType,subID)
for i,v in ipairs(self.sublist)do
if actID==v.act_id and subType==v.sub_act_type and subID==v.sub_act_id then
return i
end
end
return nil
end

function UI_activityMerge_main_Win:refreshMenuItem(item,idx)
if self.isHideMenu then
return
end
if item==nil then
item=self.dayScrollView:getChildScrollViewItemWidget(idx-1)
end

local data=self.sublist[idx]
local act_id_=data.act_id
local sub_act_type_=data.sub_act_type
local sub_act_id_=data.sub_act_id


self:refreshMenuItemFlag(item,idx,act_id_,sub_act_type_,sub_act_id_)

self:refreshMenuItemSelect(item,idx,self.curSelectIndex==idx)

self:refreshMenuItemState(item,idx)

item:SetChildButtonClick(4,function()
self:onItemClick(idx)
end)

item:SetChildNewBieComponentId(4,FMT.fmt('UI_activityMerge_main_Win.actMenuItem_{0}',idx))
end

function UI_activityMerge_main_Win:refreshMenuItemSelect(item,idx,flag)
if self.isHideMenu then
return
end
if item==nil then
item=self.dayScrollView:getChildScrollViewItemWidget(idx-1)
end

local data=self.sublist[idx]
local act_id_=data.act_id
local sub_act_type_=data.sub_act_type
local sub_act_id_=data.sub_act_id

local sub_actcfg=activitiesModel:getSubActivityConfig(sub_act_type_,sub_act_id_)

item:SetChildActive(2,not flag)
item:SetChildActive(3,flag)

local name_str=sub_actcfg.sub_name or'活动名称'
if flag then
name_str=toColorString(FONT_COLOR.eGrayWhiteTxtColor,name_str)
else
name_str=toColorString(FONT_COLOR.eGrayWhiteTxtColor,name_str)
end





item:SetChildText(0,name_str)


local tabIcons=sub_actcfg.sub_tabIcons or cfgHelper.get2(cfg_subactivitytypeconfig_get,sub_act_type_,'tabIcons')
local showIcon=false
item:SetChildActive(5,showIcon)
if showIcon then
local iconname=flag==true and tabIcons[1]or tabIcons[2]
item:SetChildCSImageSprite(5,globalABLookup.activieSprites,iconname)
end
end

function UI_activityMerge_main_Win:refreshMenuItemState(item,idx)
if self.isHideMenu then
return
end
if item==nil then
item=self.dayScrollView:getChildScrollViewItemWidget(idx-1)
end
local data=self.sublist[idx]
local actID=data.act_id
local subType=data.sub_act_type
local subID=data.sub_act_id
local isReddot=activitiesModel:checkSubActReddot(actID,subType,subID)
local isUnlock=activitiesModel:checkSubActUnlock(actID,subType,subID)
item:SetChildActive(1,isReddot)
item:SetChildActive(7,isUnlock)
item:SetChildActive(8,not isUnlock)
end

function UI_activityMerge_main_Win:onItemClick(idx)
if _this.lockClick==true then return end
if _this.curSelectIndex==idx then
return
end
local data=_this.sublist[idx]
local actID=data.act_id
local subType=data.sub_act_type
local subID=data.sub_act_id

if not activitiesModel:checkSubActUnlock(actID,subType,subID,true)then
return
end

if _this.curSelectIndex then
_this:refreshMenuItemSelect(nil,_this.curSelectIndex,false)
end
_this:refreshMenuItemSelect(nil,idx,true)
_this.curSelectIndex=idx
_this.select_act_id=actID
_this.sub_act_type=subType
_this.sub_act_id=subID
_this.select_key=FMT.fmt('{0}_{1}_{2}',_this.select_act_id,_this.sub_act_type,_this.sub_act_id)

_this:refreshSubWin()
end

function UI_activityMerge_main_Win:refreshSubWin()
self:hideSubWin()
if self.sub_act_type==nil then return end
if self.showWinLookup==nil then
self.showWinLookup={}
end

local subwinLookup=activitiesModel:getSubPanelLookup(self.select_act_id,self.sub_act_type,self.sub_act_id)
self.subwinLookup=subwinLookup
local bgname,moneytypes
local blackImg=true
if subwinLookup then
for winName,v in pairs(subwinLookup)do
local sub_args=table.deepCopy(v)
self:changeParam(sub_args)
self:showWindow(winName,sub_args)
self.showWinLookup[winName]=true
if sub_args.bgname~=nil then
bgname=sub_args.bgname
end
if sub_args.moneytypes~=nil then
moneytypes=sub_args.moneytypes
end
if sub_args.blackImg~=nil then
blackImg=false
end
end
end

self:activeBlack(blackImg)
self:changeBG(bgname)
self:changeMoney(moneytypes)



self.showParams.select_act_id=self.select_act_id
self.showParams.sub_act_type=self.sub_act_type
self.showParams.sub_act_id=self.sub_act_id
end


function UI_activityMerge_main_Win:changeParam(args)
args.act_id=self.select_act_id





args.sub_act_type=self.sub_act_type
args.sub_act_id=self.sub_act_id
args.parentWin='UI_activityMerge_main_Win'
args.extraParams=self.extraParams
end

function UI_activityMerge_main_Win:hideSubWin()
local subwinLookup=self.subwinLookup
if subwinLookup then
for winName,sub_args in pairs(subwinLookup)do
self:hideWindow(winName)
end
self.subwinLookup=nil
end
end

function UI_activityMerge_main_Win:clearSubWin()
if self.showWinLookup then
for winName,flag in pairs(self.showWinLookup)do
if flag then
self:closeWindow(winName)
end
end
self.showWinLookup={}
end
self.subwinLookup=nil
end

function UI_activityMerge_main_Win:onClickClose()

AudioManager.playBtnClick()
if self.isFull then
UIFullCommonControl:closeUI(nil,true)
else
self:closeSelf()
end
end

function UI_activityMerge_main_Win:onClickBlock()
if not self.clickAnyClose then
return
end
self:onClickClose()
end

function UI_activityMerge_main_Win:activeRoot(flag)
self.root:setActive(flag)
end

function UI_activityMerge_main_Win:fadeRoot(alpha,duration)
self.root:setChildCanvasGroupDOFade(alpha,duration,nil)
end

function UI_activityMerge_main_Win:activeBlack(flag)
self.blackImg:setActive(flag)
end

function UI_activityMerge_main_Win:setLockClick(flag)
self.lockClick=flag
end

function UI_activityMerge_main_Win.listenChangTag(actid,subtype,subid)
local data=_this.sublist
local idx
for k,v in ipairs(data)do
local act_id_=v.act_id
local sub_act_type_=v.sub_act_type
local sub_act_id_=v.sub_act_id
if act_id_==actid and sub_act_type_==subtype and sub_act_id_==subid then
idx=k
end
end
if idx then
if _this.isHideMenu then
return
end
local item=_this.dayScrollView:getChildScrollViewItemWidget(idx-1)
_this:refreshMenuItemFlag(item,idx,actid,subtype,subid)
end
end

function UI_activityMerge_main_Win:refreshMenuItemFlag(item,idx,act_id_,sub_act_type_,sub_act_id_)
if _this.isHideMenu then
return
end
if item==nil then
item=_this.dayScrollView:getChildScrollViewItemWidget(idx-1)
end
local actData=ActIconShowConfig[sub_act_type_]
if actData then
local abname=actData.abname
local iconName=actData.iconname
local callback=actData.callback
if abname and iconName and callback then
local flag=callback(act_id_,sub_act_type_,sub_act_id_)
if flag then
item:SetChildActive(6,true)
item:SetChildCSImageSprite(6,abname,iconName)
else
item:SetChildActive(6,false)
end
end
end
end
