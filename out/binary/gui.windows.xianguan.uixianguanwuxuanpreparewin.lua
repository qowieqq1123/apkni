







def_class("UIXianGuanWuXuanPrepareWin",UIWindowBase)









function UIXianGuanWuXuanPrepareWin:bindComponents()

self.empty=UIText.get(self,0)
self.quickCancelSignBtn=UIButton.get(self,1)
self.quickSignUpBtn=UIButton.get(self,2)
self.scrollView=UILoopListView.new(self,3)
self.timeTx=UIText.get(self,4)

self.quickCancelSignBtn:setButtonClick(function()self:onQuickCancelSignBtn()end)

self.quickSignUpBtn:setButtonClick(function()self:onQuickSignUpBtn()end)

self.scrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIXianGuanWuXuanPrepareWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.empty);self.empty=nil;
_UIObject_release(self.quickCancelSignBtn);self.quickCancelSignBtn=nil;
_UIObject_release(self.quickSignUpBtn);self.quickSignUpBtn=nil;
self.scrollView:deleteSelf();self.scrollView=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
end















local _this=nil
local _itemCmp={
playerBG=0,
playerHead=1,
playerHeadIcon=2,
level=3,
serverName=4,
name=5,
xmName=6,
fightValue=7,
timeTx=8,
declarationTx=9,
declarationBtn=10,
declarationTx2=11,
}
local _itemPrefabName='playerItem'



function UIXianGuanWuXuanPrepareWin:onLoaded(...)
self:bindComponents()
_this=self

self:addProNotify(40,30,self.on_40_30)

self.scrollViewList=self.winlua:GetChildUILoopListView(self.scrollView:getID())
self.scrollViewListCmp=self.winlua:GetChildLoopListView2(self.scrollView:getID())

self:addProNotify(40,23,function()
if _this==nil then return end

_this:refreshQuickbtns()
end)
end


function UIXianGuanWuXuanPrepareWin:__delete()
self:unbindComponents()
self.scrollViewList=nil
self.scrollViewListCmp=nil
_this=nil
end




function UIXianGuanWuXuanPrepareWin:onShow(argtable,afterOnloaded)
self.job=argtable.job
local activity=xianguanModel:getWuXuanActivityData()
self.endTime=activity and activity.registerETime or nil
self.isBW=xianguanController:IsInBWMatchStage_Campaign_Compatible(XianGuanCampaignType.eWuXuan)
self:updateData()
self:refreshCDTick()
self:refreshList()
self:refreshQuickbtns()
end


function UIXianGuanWuXuanPrepareWin:onHide()

end



function UIXianGuanWuXuanPrepareWin:refreshCDTick()
if self.endTime then
if self:updateCDTick()then
self:startCDTick()
end
else
self.timeTx:setText("")
self:stopCDTick()
end
end

function UIXianGuanWuXuanPrepareWin:startCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UIXianGuanWuXuanPrepareWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UIXianGuanWuXuanPrepareWin:updateCDTick()
local nowTime=timeHelper.getServerShortTime()
local least=math.max(self.endTime-nowTime,0)
self.timeTx:setText(FMT.fmt("报名倒计时：{0}",timeHelper.format_time_stamp3(least)))
if least>0 then
self:stopCDTick()
return false
end
return true
end

function UIXianGuanWuXuanPrepareWin:updateData()
self.datas=xianguanModel:getWuXuanRegisterJobData(self.job)
self.sortList={}
for i,v in ipairs(self.datas)do
table.insert(self.sortList,{i,mathHelper.int64_to_number(v.fight)})
end
table.sort(self.sortList,function(a,b)
return a[2]>b[2]
end)
end

function UIXianGuanWuXuanPrepareWin:refreshList()
local count=#self.datas
self.empty:setActive(count<=0)
self.scrollView:setActive(count>0)
if count>0 then
local itemidlist={}
for i=1,count do
table.insert(itemidlist,i)
end
self.scrollView:initData("playerItem",itemidlist)
self.scrollView:jumpItem(0)
end

end

function UIXianGuanWuXuanPrepareWin:refreshItem(index,widget)
local sortData=self.sortList[index]
local data=self.datas[sortData[1]]
local isSelf=playerModel:checkActorId(data.actor_id)
widget:SetChildButtonClick(_itemCmp.playerBG,function()
self:onClickPlayer(sortData[1])
end)
widget:SetChildButtonClick(_itemCmp.declarationBtn,function()
self:onClickDeclaration(index)
end)
playerController:setHeadIcon(widget,_itemCmp.playerHead,{iconInfo=data.iconInfo,scale=0.6})
widget:SetChildText(_itemCmp.level,data.level)
local serverStr=FMT.fmt("[{0}]",loginModel:getServerName(data.server_id))
widget:SetChildText(_itemCmp.serverName,isSelf and FMT.cfmt2("#10ab00",serverStr)or serverStr)
local nameStr=data.name
widget:SetChildText(_itemCmp.name,isSelf and FMT.cfmt2("#10ab00",nameStr)or nameStr)
widget:SetChildText(_itemCmp.xmName,data.guild_name~=""and FMT.fmt("[{0}]",data.guild_name)or"暂无仙盟")
widget:SetChildText(_itemCmp.fightValue,FMT.fmt("战：{0}",mathHelper.int64_to_number(data.fight)))



widget:SetChildActive(_itemCmp.declarationBtn,isSelf)

local declarationStr=cfgHelper.get2(cfg_officerelectiondeclaration2config_get,data.declaration_idx,"desc")

declarationStr=chatEmotHelper.decodeEmot(declarationStr)





widget:SetChildText(_itemCmp.declarationTx,declarationStr)
end

function UIXianGuanWuXuanPrepareWin:onClickPlayer(index)
UIFullXJForceControl:showWuXuanTeamWin(self.job,index)
end

function UIXianGuanWuXuanPrepareWin:onClickDeclaration(index)
local sortData=self.sortList[index]
local data=self.datas[sortData[1]]
if playerModel:checkActorId(data.actor_id)then
UIManager:showWindow("UIXianGuanCampaignDescWin",{officerId=self.job,descIdx=data.declaration_idx})
end
end

function UIXianGuanWuXuanPrepareWin.on_40_30(job)
if _this.job==job then
_this.datas=xianguanModel:getWuXuanRegisterJobData(_this.job)
_this:updateData()
_this:refreshList()
end
end

function UIXianGuanWuXuanPrepareWin:onStartAction()

end

function UIXianGuanWuXuanPrepareWin:onFreshAction(index,widget)
self:refreshItem(index,widget)
end


function UIXianGuanWuXuanPrepareWin:refreshQuickbtns()
local officer_id=xianguanController:getJingXuanPlayerJob(XianGuanCampaignType.eWuXuan)or xianguanController:getJingXuanPlayerJob(XianGuanCampaignType.eWenXuan)
local group=xianguanConfig.getJobGroupId(self.job)
local canCX=xianguanConfig.checkCanJob(group,self.job)

local isHasJob=false
if self.isBW then
isHasJob=xianguanController:checkSelfHasJob()
end


self.quickSignUpBtn:setActive(officer_id==nil and canCX and(not isHasJob))
self.quickCancelSignBtn:setActive(officer_id~=nil and officer_id==self.job and(not isHasJob))
end

function UIXianGuanWuXuanPrepareWin:onQuickCancelSignBtn()
local officer_id=xianguanController:getJingXuanPlayerJob(XianGuanCampaignType.eWuXuan)

if officer_id~=nil and officer_id==self.job then
xianguanController:send_40_23_cancel()
end
end

function UIXianGuanWuXuanPrepareWin:onQuickSignUpBtn()
local officer_id=xianguanController:getJingXuanPlayerJob(XianGuanCampaignType.eWuXuan)
local group=xianguanConfig.getJobGroupId(self.job)
local canCX=xianguanConfig.checkCanJob(group,self.job)

if officer_id==nil and canCX then
UIFullXJForceControl:showWuXuanAttendWin(self.job)
end
end