







def_class("UI_activity_main_Win_define",UIWindowBase)









function UI_activity_main_Win_define:bindComponents()

self.blackImg=UIObject.get(self,0)
self.maskBlock=UIObject.get(self,1)
self.bgImg=UIImage.get(self,2)
self.root=UIObject.get(self,3)
self.menuScrollView=UIObject.get(self,4)
self.menuGrid=UIObject.get(self,5)



end


function UI_activity_main_Win_define:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.maskBlock);self.maskBlock=nil;
_UIObject_release(self.bgImg);self.bgImg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.menuScrollView);self.menuScrollView=nil;
_UIObject_release(self.menuGrid);self.menuGrid=nil;
end
















local _this


function UI_activity_main_Win_define:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onActivityStateChange,self.onActivityStateChange)
self:addNotify(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)
self:addNotify(notifyConfig.onSubActivityReddotChange,self.onSubActivityReddotChange)
self:addNotify(notifyConfig.onActTabReddotChange,self.onActTabReddotChange)
self:addNotify(notifyConfig.onActivityTabChange,self.onActivityTabChange)
self:addNotify(notifyConfig.onSubActivityOpen,self.onSubActivityOpen)
self:addNotify(notifyConfig.onSubActUnlock,self.onSubActUnlock)
self:addNotify(notifyConfig.onActTabFlagChange,self.onActTabFlagChange)
self:addNotify(notifyConfig.onSubActivityFlagChange,self.listenChangTag)
end


function UI_activity_main_Win_define:__delete()
_this=nil
self:unbindComponents()

activitiesController:resetBgmByCloseActivitiesMainWin()
self:clearSubWin()
if self.showMoney then
self:hideWindow('UITopMoneyWin')
end
end


function UI_activity_main_Win_define:onHide()

end

function UI_activity_main_Win_define.onActivityStateChange(actID,state)
if _this==nil then return end
if _this.act_id==actID then
if state==activitiesModel.activityFinishState then

_this:onClickClose()
end
end
end

function UI_activity_main_Win_define.onSubActivityOpen(actID,subType,subid,flag,args)
if _this==nil then return end

if flag then
local check=activitiesModel:findSubActInAct(_this.act_id,actID,subType,subid)
if args and args.hideRefreshSubList then
check=false
end
if check then
_this:initSubList()
_this:refreshMenu()
end
end
end

function UI_activity_main_Win_define.onSubActivityStateChange(actID,subType,subid,state)
if _this==nil then return end

local flag=activitiesModel:findSubActInAct(_this.act_id,actID,subType,subid)
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


function UI_activity_main_Win_define.onSubActivityReddotChange(actID,subType,subid)
if _this==nil then return end

for idx,v in ipairs(_this.tablist)do

if v.id==nil then
if actID==v.actID and subType==v.subType and subid==v.subid then
_this:refreshMenuItemState(nil,idx)
break
end
end
end
end


function UI_activity_main_Win_define.onActTabReddotChange(tab_id)
if _this==nil then return end

for idx,v in ipairs(_this.tablist)do

if v.id~=nil and v.id==tab_id then
_this:refreshMenuItemState(nil,idx)
break
end
end
end

function UI_activity_main_Win_define.onSubActUnlock(actID,subType,subID)
if _this==nil then return end

for idx,v in ipairs(_this.tablist)do

if v.id~=nil and v.id==tab_id then
_this:refreshMenuItemState(nil,idx)
break
end
end
end

function UI_activity_main_Win_define.onActTabFlagChange(tab_id)
if _this==nil then return end

for idx,v in ipairs(_this.tablist)do

if v.id~=nil and v.id==tab_id then
_this:refreshMenuItemFlag(nil,idx)
break
end
end
end

function UI_activity_main_Win_define.onActivityTabChange(actID,subType,subid)
if _this==nil then return end

local flag=activitiesModel:findSubActInAct(_this.act_id,actID,subType,subid)
if flag then
local old_select_key=_this.select_key
_this:initSubList()
_this:refreshMenu()
if _this.select_key==nil then
_this:onClickClose()
else
_this:clearSubWin()
_this:refreshSubWin()
end
end
end




function UI_activity_main_Win_define:onShow(argtable,afterOnloaded)
self:clearSubWin()
self.showParams=argtable
self.extraParams=argtable.extraParams
local isFull=argtable.isFull
self.isFull=isFull
self.clickAnyClose=argtable.clickAnyClose

local lastActId=self.act_id
self.act_id=argtable.act_id
if afterOnloaded or(lastActId and lastActId~=self.act_id)then
activitiesController:checkBgmByOpenActivitiesMainWin(self.act_id)
end
local old_act_id=argtable.old_act_id
if old_act_id==nil then
self.select_actID=self.act_id
else
self.select_actID=old_act_id
end
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.select_tab_idx=self.select_tab_idx or 1
if self.extraParams and self.extraParams.tab_idx then
self.select_tab_idx=self.extraParams.tab_idx
end
self.select_key=FMT.fmt('{0}_{1}_{2}',self.select_actID,self.subType,self.subid)

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

function UI_activity_main_Win_define:onShowArgRecv(argtable)
self:onShow(argtable)
end

function UI_activity_main_Win_define:changeBG(bgname)
bgname=bgname or self.default_bgname
local showBG=bgname~=nil
self.bgImg:setActive(showBG)
if showBG and self.bgname~=bgname then
self.bgname=bgname
local abname=activitiesModel.getActBgABName(bgname)
self.bgImg:setSprite(abname,bgname)
end
end

function UI_activity_main_Win_define:changeMoney(moneytypes)
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

function UI_activity_main_Win_define:initSubList()
self.sublist=activitiesModel:getActSubList_open_doing(self.act_id)
local tablist={}
for i,v in ipairs(self.sublist)do
local defineTabs=activitiesModel:getSubActDefineTabList(v.act_id,v.sub_act_type,v.sub_act_id)
if defineTabs then
for i2,v2 in ipairs(defineTabs)do
table.insert(tablist,v2)
end
else

local sub_actcfg=activitiesModel:getSubActivityConfig(v.sub_act_type,v.sub_act_id)
local d={}
d.name=sub_actcfg.sub_name or'活动名称'
d.tabIcons=cfgHelper.get2(cfg_subactivitytypeconfig_get,v.sub_act_type,'tabIcons')
d.subwinLookup=activitiesModel:getSubPanelLookup(v.act_id,v.sub_act_type,v.sub_act_id)or{}
d.reddot=nil
d.tab_idx=1
d.actID=v.act_id
d.subType=v.sub_act_type
d.subid=v.sub_act_id
table.insert(tablist,d)
end
end
self.tablist=tablist
if self.subType~=nil then
local f=nil
for i,v in ipairs(self.tablist)do
if self.select_actID==v.actID and self.subType==v.subType and self.subid==v.subid then
if self.select_tab_idx==v.tab_idx then
f=i
break
end
end
end
if f then
self.curSelectIndex=f
else
self.select_actID=nil
self.subType=nil
self.subid=nil
self.select_tab_idx=nil
self.curSelectIndex=nil
self.select_key=nil
end
end
if self.subType==nil then

if#self.tablist>0 then
local f
for i,v in ipairs(self.tablist)do
if activitiesModel:checkSubActUnlock(v.actID,v.subType,v.subid)then
f=i
break
end
end
if f then
self.curSelectIndex=f
local data=self.tablist[self.curSelectIndex]
self.select_actID=data.actID
self.subType=data.subType
self.subid=data.subid
self.select_tab_idx=data.tab_idx
self.select_key=FMT.fmt('{0}_{1}_{2}',self.select_actID,self.subType,self.subid)
end
end
end
end

function UI_activity_main_Win_define:refreshMenu()
local c=#self.tablist
self.menuGrid:setChildLayoutGroupCreateItems(c)
if c>0 then
local grids=self.menuGrid:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
self:refreshMenuItem(item,i)
end
end
end

function UI_activity_main_Win_define:getMenuItemIndexs(actID,subType,subid)
local list={}
for i,v in ipairs(self.tablist)do
if actID==v.actID and subType==v.subType and subid==v.subid then
table.insert(list,i)
end
end
return list
end

function UI_activity_main_Win_define:refreshMenuItem(item,idx)
if item==nil then
item=self.menuGrid:getChildLayoutGroupGridItem(idx-1)
end

self:refreshMenuItemFlag(item,idx)

self:refreshMenuItemSelect(item,idx,self.curSelectIndex==idx)

self:refreshMenuItemState(item,idx)

item:SetChildButtonClick(4,function()
self:onItemClick(idx)
end)
end

function UI_activity_main_Win_define:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuGrid:getChildLayoutGroupGridItem(idx-1)
end

local data=self.tablist[idx]
local actID_=data.actID
local subType_=data.subType
local subid_=data.subid
local sub_actcfg=activitiesModel:getSubActivityConfig(subType_,subid_)

item:SetChildActive(2,not flag)
item:SetChildActive(3,flag)

local name_str=data.name
if flag then
name_str=toColorString(FONT_COLOR.eGrayWhiteTxtColor,name_str)
else
name_str=FMT.fmt('<color=#d0b496>{0}</color>',name_str)
end





item:SetChildText(0,name_str)

local tabIcons=data.tabIcons
local showIcon=tabIcons~=nil
item:SetChildActive(5,showIcon)
if showIcon then
local iconname=flag==true and tabIcons[1]or tabIcons[2]
item:SetChildCSImageSprite(5,globalABLookup.activieSprites,iconname)
end
end

function UI_activity_main_Win_define:refreshMenuItemState(item,idx)
if item==nil then
item=self.menuGrid:getChildLayoutGroupGridItem(idx-1)
end
local data=self.tablist[idx]
local flag
if data.reddot then
flag=data.reddot(data.actID,data.subType,data.subid)
else
flag=activitiesModel:checkSubActReddot(data.actID,data.subType,data.subid)
end
local isUnlock=activitiesModel:checkSubActUnlock(data.actID,data.subType,data.subid)
item:SetChildActive(1,flag)
item:SetChildActive(7,isUnlock)
item:SetChildActive(8,not isUnlock)
end

function UI_activity_main_Win_define:onItemClick(idx)
if self.lockClick==true then return end
if self.curSelectIndex==idx then
return
end

local data=self.tablist[idx]
if not activitiesModel:checkSubActUnlock(data.actID,data.subType,data.subid,true)then
return
end

if self.curSelectIndex then
self:refreshMenuItemSelect(nil,self.curSelectIndex,false)
end
self:refreshMenuItemSelect(nil,idx,true)
self.curSelectIndex=idx


self.select_actID=data.actID
self.subType=data.subType
self.subid=data.subid
self.select_tab_idx=data.tab_idx
self.select_key=FMT.fmt('{0}_{1}_{2}',self.select_actID,self.subType,self.subid)

self:refreshSubWin()
end

function UI_activity_main_Win_define:refreshSubWin()
self:hideSubWin()
if self.subType==nil then return end
if self.showWinLookup==nil then
self.showWinLookup={}
end

local data=self.tablist[self.curSelectIndex]
self.subwinLookup=data.subwinLookup
local bgname,moneytypes
if self.subwinLookup then
for winName,v in pairs(self.subwinLookup)do
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
end
end
self:changeBG(bgname)
self:changeMoney(moneytypes)


self.showParams.act_id=self.act_id

if self.select_actID~=self.act_id then
self.showParams.old_act_id=self.select_actID
else
self.showParams.old_act_id=nil
end
self.showParams.sub_act_type=self.subType
self.showParams.sub_act_id=self.subid
if self.showParams.extraParams==nil then
self.showParams.extraParams={}
end
self.showParams.extraParams.tab_idx=self.select_tab_idx
end


function UI_activity_main_Win_define:changeParam(args)
args.act_id=self.select_actID
if self.select_actID~=self.act_id then

args.merge_act_id=self.act_id
end
args.sub_act_type=self.subType
args.sub_act_id=self.subid
args.parentWin='UI_activity_main_Win_define'
args.tab_idx=self.select_tab_idx
args.extraParams=self.extraParams
end

function UI_activity_main_Win_define:hideSubWin()
local subwinLookup=self.subwinLookup
if subwinLookup then
for winName,sub_args in pairs(subwinLookup)do
self:hideWindow(winName)
end
self.subwinLookup=nil
end
end

function UI_activity_main_Win_define:clearSubWin()
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

function UI_activity_main_Win_define:onClickClose()

AudioManager.playCloseUI()
if self.isFull then
UIFullCommonControl:closeUI(nil,true)
else
self:closeSelf()
end
end

function UI_activity_main_Win_define:onClickBlock()
if not self.clickAnyClose then
return
end
self:onClickClose()
end

function UI_activity_main_Win_define:activeRoot(flag)
self.root:setActive(flag)
end

function UI_activity_main_Win_define:activeBlack(flag)
self.blackImg:setActive(flag)
end

function UI_activity_main_Win_define:setLockClick(flag)
self.lockClick=flag
end

function UI_activity_main_Win_define:getOpenParams()
local p={actID=self.select_actID,subType=self.subType,subid=self.subid,tab_idx=self.select_tab_idx}
return p
end

function UI_activity_main_Win_define:refreshMenuItemFlag(item,idx)
if item==nil then
item=_this.menuGrid:getChildLayoutGroupGridItem(idx-1)
end
local actData=self.tablist[idx]
if actData then
local abname=actData.exIconAB
local iconName=actData.exIconName
local callback=actData.exIconRefresh
if abname and iconName and callback then
local flag=callback(actData.actID,actData.subType,actData.subid)
if flag then
item:SetChildActive(6,true)
item:SetChildCSImageSprite(6,abname,iconName)
else
item:SetChildActive(6,false)
end
end
end


if actData then
local leftIconConfig=ActIconShowConfig[actData.subType]
if leftIconConfig and leftIconConfig.isInit then
local abname=leftIconConfig.abname
local iconName=leftIconConfig.iconname
local callback=leftIconConfig.callback

if abname and iconName and callback then
local flag=callback(actData.actID,actData.subType,actData.subid)
if flag then
item:SetChildActive(6,true)
item:SetChildCSImageSprite(6,abname,iconName)
else
item:SetChildActive(6,false)
end
end
else
item:SetChildActive(6,false)
end
end
end

function UI_activity_main_Win_define.listenChangTag(actid,subtype,subid)
local data=_this.tablist or{}
local idx
for k,v in ipairs(data)do
local act_id_=v.actID
local sub_act_type_=v.subType
local sub_act_id_=v.subid
if act_id_==actid and sub_act_type_==subtype and sub_act_id_==subid then
idx=k
end
end
if idx then
local item=_this.menuGrid:getChildLayoutGroupGridItem(idx-1)
_this:refreshMenuItemFlag2(item,idx,actid,subtype,subid)
end
end

function UI_activity_main_Win_define:refreshMenuItemFlag2(item,idx,act_id_,sub_act_type_,sub_act_id_)
if item==nil then
item=_this.menuGrid:getChildLayoutGroupGridItem(idx-1)
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
