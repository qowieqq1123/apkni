







def_class("UI_activity_main_Win_onlyBg",UIWindowBase)









function UI_activity_main_Win_onlyBg:bindComponents()

self.maskBlock=UIObject.get(self,0)
self.bgImg=UIImage.get(self,1)
self.root=UIObject.get(self,2)
self.btnClose=UIButton.get(self,3)

self.btnClose:setButtonClick(function()self:onBtnClose()end)



end


function UI_activity_main_Win_onlyBg:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.maskBlock);self.maskBlock=nil;
_UIObject_release(self.bgImg);self.bgImg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
end
















local _this


function UI_activity_main_Win_onlyBg:onLoaded(...)
_this=self
self:bindComponents()
end


function UI_activity_main_Win_onlyBg:__delete()
_this=nil
self:unbindComponents()

activitiesController:resetBgmByCloseActivitiesMainWin()
self:clearSubWin()
if self.showMoney then
self:hideWindow('UITopMoneyWin')
end
end


function UI_activity_main_Win_onlyBg:onHide()

end




function UI_activity_main_Win_onlyBg:onShow(argtable,afterOnloaded)
self.extraParams=argtable.extraParams
local isFull=argtable.isFull
self.isFull=isFull
self.clickAnyClose=argtable.clickAnyClose

local lastActId=self.act_id
self.act_id=argtable.act_id

self.select_act_id=self.act_id
if afterOnloaded or(lastActId and lastActId~=self.act_id)then
activitiesController:checkBgmByOpenActivitiesMainWin(self.act_id)
end
self.sub_act_type=argtable.sub_act_type
self.sub_act_id=argtable.sub_act_id

self:initSubList()

self.maskBlock:setActive(not isFull)
self:changeBG(argtable.bgname)

self.btnClose:setActive(true)
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.25,nil)

self:refreshSubWin()

local showMoney=false
if not isFull then
local moneytypes=argtable.moneytypes
if moneytypes then
showMoney=true
self:showWindow('UITopMoneyWin',moneytypes)
end
end
self.showMoney=showMoney

self.extraParams=nil
end

function UI_activity_main_Win_onlyBg:onShowArgRecv(argtable)
self:onShow(argtable)
end

function UI_activity_main_Win_onlyBg:changeBG(bgname)
local showBG=bgname~=nil
self.bgImg:setActive(showBG)
if showBG then
local abname=activitiesModel.getActBgABName(bgname)
self.bgImg:setSprite(abname,bgname)
end
end

function UI_activity_main_Win_onlyBg:initSubList()
self.sublist=activitiesModel:getActSubList_open_doing(self.act_id)
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
end

function UI_activity_main_Win_onlyBg:refreshSubWin()
self:clearSubWin()
if self.sub_act_type==nil then return end

local subwinLookup=activitiesModel:getSubPanelLookup(self.select_act_id,self.sub_act_type,self.sub_act_id)
self.subwinLookup=subwinLookup
if subwinLookup then
for winName,v in pairs(subwinLookup)do
local sub_args=table.deepCopy(v)
self:changeParam(sub_args)
self:showWindow(winName,sub_args)
end
end
end


function UI_activity_main_Win_onlyBg:changeParam(args)
args.act_id=self.select_act_id
args.sub_act_type=self.sub_act_type
args.sub_act_id=self.sub_act_id
args.parentWin='UI_activity_main_Win_onlyBg'
args.extraParams=self.extraParams
end

function UI_activity_main_Win_onlyBg:clearSubWin()
local subwinLookup=self.subwinLookup
if subwinLookup then
for winName,sub_args in pairs(subwinLookup)do
self:closeWindow(winName)
end
self.subwinLookup=nil
end
end

function UI_activity_main_Win_onlyBg:onBtnClose()
if self.isFull then
UIFullCommonControl:closeUI()
else
self:closeSelf()
end
end

function UI_activity_main_Win_onlyBg:onClickBlock()
if not self.clickAnyClose then
return
end
self:onClickClose()
end

function UI_activity_main_Win_onlyBg:hideClose()
self.btnClose:setActive(false)
end