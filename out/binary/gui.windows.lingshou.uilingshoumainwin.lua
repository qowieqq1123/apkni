







def_class("UILingShouMainWin",UIWindowBase)









function UILingShouMainWin:bindComponents()

self.copyBtn=UIButton.get(self,0)
self.copyBtn2=UIButton.get(self,1)
self.copyBtn3=UIButton.get(self,2)
self.copyBtn4=UIButton.get(self,3)
self.lingshouListPanel=UIScrollView.get(self,4)
self.root=UIObject.get(self,5)

self.copyBtn:setButtonClick(function()self:onCopyBtn()end)

self.copyBtn2:setButtonClick(function()self:onCopyBtn2()end)

self.copyBtn3:setButtonClick(function()self:onCopyBtn3()end)

self.copyBtn4:setButtonClick(function()self:onCopyBtn4()end)



end


function UILingShouMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.copyBtn);self.copyBtn=nil;
_UIObject_release(self.copyBtn2);self.copyBtn2=nil;
_UIObject_release(self.copyBtn3);self.copyBtn3=nil;
_UIObject_release(self.copyBtn4);self.copyBtn4=nil;
_UIObject_release(self.lingshouListPanel);self.lingshouListPanel=nil;
_UIObject_release(self.root);self.root=nil;
end
















local WriteInCopyBuffer=CS.UIHelper.WriteInCopyBuffer

local PageSlotConfig=
{
[1]={

wins={'UILingShouModelWin','UILingShouInfoWin'},
},
[2]={

wins={'UILingShouModelWin','UILingShouJingJieWin'},
},




[3]={

wins={'UILingShouXueMaiWin'}
}
}
local maxScrollNum=5
local _this=nil


function UILingShouMainWin:onLoaded(...)
_this=self
self:bindComponents()
self.onRoleItemClick_=function(...)
if _this==nil then return end
_this:onRoleItemClick(...)
end
self.lingshouListPanel:setClickAction(self.onRoleItemClick_)
notifySystem:listenNotify(notifyConfig.onLingShouAwake,self.onLingShouAwake)
notifySystem:listenNotify(notifyConfig.onTestModelChange,self.onTestModelChange)

local _recv_19_9=function(guid)
if _this==nil then return end

_this:removeLS(guid)
end
self:addProNotify(19,9,_recv_19_9)

local _reddotFunc=function()
if _this==nil then return end
local item=_this.lingshouListPanel:getGridObjectByindex(_this.curSelectIndex-1)
_this:refreshRoleItem(item,_this.curSelectIndex)
end
self:addReddotNotify(REDDIT_SUB_TYPE.sLingShouBase,_reddotFunc)

self:showCopyBtn()
end

function UILingShouMainWin:removeLS(guid)
table.removeValueEx(self.lslist,{guid=guid},function(data)return tostring(data.guid)end)

self:refreshRoleGrid()
end


function UILingShouMainWin:__delete()
_this=nil
if self.lslist~=nil and#self.lslist>0 and self.curSelectIndex~=nil then
local data=self.lslist[self.curSelectIndex]
if data then
local lsGuid=data.guid
lingshouModel:clearLingShouNewSignByLsGuid(lsGuid)
end
end
self:unbindComponents()
self:closeAllWin()
notifySystem:removelistener(notifyConfig.onLingShouAwake,self.onLingShouAwake)
notifySystem:removelistener(notifyConfig.onTestModelChange,self.onTestModelChange)
end

function UILingShouMainWin.onLingShouAwake(guid)
if _this==nil then return end
if not mathHelper.compareInt64(guid,_this.ls_guid)then return end

if _this.activeWin~=nil then
for k,v in pairs(_this.activeWin)do
local win=UIManager:findActiveWindow(k)
if win then
if win.rec_awake then
win:rec_awake(guid)
else



end
end
end
end
end

function UILingShouMainWin.onTestModelChange(flag)
if _this==nil then return end

_this:showCopyBtn()
end

function UILingShouMainWin:showCopyBtn()
local show=false



show=show and playerController.testModel
self.copyBtn:setActive(show)
self.copyBtn2:setActive(show)
self.copyBtn3:setActive(show)
self.copyBtn4:setActive(show)
end




function UILingShouMainWin:onShow(argtable,afterOnloaded)
self.ls_guid=argtable.ls_guid
local defaultPage=argtable.showPage or 1
self.selectPage=defaultPage
self.lslist=argtable.lslist
self.showShareBtn=argtable.showShareBtn

if self.lslist==nil then
local sortType=lingshouModel:getSaveSortType()
local sortCondition=lingshouModel:getSaveSortCondition()
local sortOrder=eSortOrder.eDown
local list=lingshouLookup:getSortList(sortType,sortCondition,sortOrder)
self.lslist=list
end

for i,v in ipairs(self.lslist)do
if mathHelper.compareInt64(v.guid,self.ls_guid)then
self.curSelectIndex=i
break
end
end

self:refreshWin()
if afterOnloaded then
self:refreshRoleGrid()
end
end

function UILingShouMainWin:getShowPage()
return self.selectPage
end

function UILingShouMainWin:onShowArgRecv(argtable)
self.selectPage=argtable.showPage
self:refreshWin()
end

function UILingShouMainWin:refreshWin()
local show_wins={}
local close_wins={}
local cur=PageSlotConfig[self.selectPage]
local cur_wins=cur.wins
if cur_wins and#cur_wins>0 then
for i,v in ipairs(cur_wins)do
show_wins[v]=true
end
end
if self.activeWin~=nil then
for k,v in pairs(self.activeWin)do
if v==true and show_wins[k]==nil then
close_wins[k]=true
end
end

for k,v in pairs(close_wins)do
UIManager:hideWindow(k)
self.activeWin[k]=false
end
end

if self.activeWin==nil then
self.activeWin={}
end
if cur_wins and#cur_wins>0 then
for i,v in ipairs(cur_wins)do
local args={ls_guid=self.ls_guid,page=self.selectPage,showShareBtn=self.showShareBtn}
if self.activeWin[v]then
local win=UIManager:findActiveWindow(v)
if win then
win:onShow(args)
else
UIManager:showWindowImp(v,args)
end
else
UIManager:showWindowImp(v,args)
self.activeWin[v]=true
end
end
end
end

function UILingShouMainWin:closeAllWin()
if self.activeWin~=nil then
for k,v in pairs(self.activeWin)do
UIManager:closeWindow(k)
end
self.activeWin=nil
end
end

function UILingShouMainWin:refreshRoleGrid()
local tNum=#self.lslist
self.lingshouListPanel:freshGridsNum(tNum,tNum,1,true)
for i=1,tNum do
local item=self.lingshouListPanel:getGridObjectByindex(i-1)
self:refreshRoleItem(item,i)
end
self.lingshouListPanel:jumpToLockX(self.curSelectIndex)
end

function UILingShouMainWin:refreshRoleItem(item,idx)
local lsData=self.lslist[idx]
local guid=lsData.guid
local lsID=lsData.id



comHelper.setChildModelHeadIconBGByColor(item,0,lingshouModel.getColorEx(lsData))

comHelper.setChildModelRawImage_lingshou(item,lsID,1,0,eHeadCenterType.eHead,1)

local isSelect=mathHelper.compareInt64(self.ls_guid,guid)
self:changItemBG(item,isSelect)

local isbianyi=lsData.cfg.bianyi==1
item:SetChildActive(5,isbianyi)


local reddot=lingshouModel:checkLingShouReddotAndDiscipleEquip(guid)
item:SetChildActive(4,reddot)


local isnew=lsData.isnew==true
item:SetChildActive(2,isnew)
end

function UILingShouMainWin:changItemBG(item,isSelect,needClearNewFlag)
item:SetChildActive(3,isSelect)
if needClearNewFlag then

item:SetChildActive(2,false)
end
end

function UILingShouMainWin:onRoleItemClick(id,idx,guid,attach)
if self.curSelectIndex==idx then return end

local old=self.curSelectIndex
self.curSelectIndex=idx
if old then
local data=self.lslist[old]
local needClearNewFlag=false
if data.isnew then

lingshouModel:clearLingShouNewSignByLsGuid(data.guid)
needClearNewFlag=true
end

local olditem=self.lingshouListPanel:getGridObjectByindex(old-1)
if olditem then
self:changItemBG(olditem,false,needClearNewFlag)
end
end
local item=self.lingshouListPanel:getGridObjectByindex(self.curSelectIndex-1)
self:changItemBG(item,true)

local data=self.lslist[idx]
self.ls_guid=data.guid
if self.activeWin~=nil then
for k,v in pairs(self.activeWin)do
if v==true then
local win=UIManager:findActiveWindow(k)
if win and win.onChangeLingShou then
win:onChangeLingShou(data.guid)
end
end
end
end

UIFullLingShouMainControl:changeAttachValue('ls_guid',self.ls_guid)

reddotControl.on_change_catch_type(CATCH_TYPE.eLingShouChangeTab)
end

function UILingShouMainWin:onCopyBtn()
local data=self.lslist[self.curSelectIndex]
WriteInCopyBuffer(tostring(data.guid))
end

function UILingShouMainWin:onCopyBtn2()
local data=self.lslist[self.curSelectIndex]
WriteInCopyBuffer(tostring(data.id))
end

function UILingShouMainWin:onCopyBtn3()
self:showWindow('UILingShouAttrLookWin',{sindex=self.curSelectIndex,list=self.lslist})
end

function UILingShouMainWin:onCopyBtn4()
local data=self.lslist[self.curSelectIndex]
local xuemai_cost_ls=data.cfg.xuemai_cost_ls
local id=next(xuemai_cost_ls[data.xuemai_val])
WriteInCopyBuffer(id)
end

function UILingShouMainWin:getLingShouList()
return self.lslist
end
