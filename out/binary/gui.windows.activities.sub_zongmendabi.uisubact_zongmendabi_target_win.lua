







def_class("UISubAct_zongmendabi_target_win",UIWindowBase)









function UISubAct_zongmendabi_target_win:bindComponents()

self.root=UIObject.get(self,0)
self.ruleBtn=UIButton.get(self,1)
self.targetGrid=UIObject.get(self,2)
self.ruleSelect=UIObject.get(self,3)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)



end


function UISubAct_zongmendabi_target_win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.targetGrid);self.targetGrid=nil;
_UIObject_release(self.ruleSelect);self.ruleSelect=nil;
end
















local _this


function UISubAct_zongmendabi_target_win:onLoaded(...)
_this=self
self:bindComponents()
end


function UISubAct_zongmendabi_target_win:__delete()
_this=nil
self:unbindComponents()
end


function UISubAct_zongmendabi_target_win:onHide()

end




function UISubAct_zongmendabi_target_win:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.parentWin=argtable.parentWin
self.tab_idx=argtable.tab_idx

self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)

self:refreshTargetsGrid()
end

function UISubAct_zongmendabi_target_win:findTaskIndex(task_id)
for i,task in ipairs(self.tasklist)do
if task.task_id==task_id then
return i
end
end
return nil
end

function UISubAct_zongmendabi_target_win:refreshTargetsGrid()
local tasklist={}
for i,v in pairsBySortKey(self.myData.sectTaskLookup)do
table.insert(tasklist,v)
end
self.tasklist=tasklist

local c=#self.tasklist
self.targetGrid:setChildLayoutGroupCreateItems(c)
local grids=self.targetGrid:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
self:refreshTaskItem(item,i)

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onTaskItemClick(i)
end)
end
end

function UISubAct_zongmendabi_target_win:refreshTaskItem(item,idx)
if item==nil then
item=self.targetGrid:getChildLayoutGroupGridItem(idx-1)
end

local task=self.tasklist[idx]
local task_id=task.task_id
local info=self.sub_actcfg.taskinfo[task_id]
local maxnum=info[2]
local curnum=task.task_progress

local task_state=task.task_state


local name_str=info[4]or'待定'
item:SetChildText(1,name_str)

local rewards=table.weakCopy(info[3])
if info[6]and info[6]>0 then
table.insert(rewards,{eMoneyType.mtSectScore,info[6]})
end
item:SetChildLayoutGroupCreateItems(2,#rewards)
local grids=item:GetChildLayoutGroupGridList(2)
for i=1,#rewards do
local rewardItem=grids[i-1]
local reward=rewards[i]
local itemid=reward[1]
local itemNum=reward[2]
local itemcount,showCountBG
if itemNum>1 then
itemcount=tostring(itemNum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(idx,itemid)
end)
end

local desc_str=info[5]
if desc_str~=nil then
desc_str=FMT.fmt(desc_str,maxnum)
else
desc_str='待定'
end
local showPorgressTitle=info[8]~=nil
if not showPorgressTitle then
desc_str=FMT.fmt('{0} ({1}/{2})',desc_str,curnum,maxnum)
end



item:SetChildText(3,desc_str)

item:SetChildActive(7,showPorgressTitle)
if showPorgressTitle then
item:SetChildText(8,info[8])
local rate=curnum/maxnum
item:SetChildIconFillAmount(9,rate)
item:SetChildText(10,FMT.fmt('{0}/{1}',curnum,maxnum))
end

item:SetChildActive(4,task_state==3)
item:SetChildActive(5,task_state==3)
if task_state==2 then
item:SetChildShowEffect(6,10209,true)
else
item:SetChildShowEffect(6,0,false)
end
end

function UISubAct_zongmendabi_target_win:onClickItem(idx,itemid)
local task=self.tasklist[idx]
if task==nil then return end
local task_state=task.task_state
if task_state==2 then
self:onTaskItemClick(idx)
return
end
tipsManager.showTips({itemid=itemid,itemguid=nil,move=TIPS_MOVE_POS.eRight})
end

function UISubAct_zongmendabi_target_win:onTaskItemClick(idx)
local task=self.tasklist[idx]
local task_state=task.task_state
if task_state~=2 then return end
local task_id=task.task_id

local json_str=jsonHelper.encode({8,task_id})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actID,self.subType,self.subid,json_str)
end

function UISubAct_zongmendabi_target_win:onRuleBtn()
local d={}
d.title='活动规则'
d.mode=3
d.name='act_zongmendabi_target_rule_%d'
d.closeCB=function()
if _this==nil then return end
_this:refreshRuleSelect(false)
end
UIManager:showWindow('UIRuleWin',d)
self:refreshRuleSelect(true)
end

function UISubAct_zongmendabi_target_win:refreshRuleSelect(flag)
self.ruleSelect:setActive(flag)
end

function UISubAct_zongmendabi_target_win:recv_getReward(task_id)
local idx=self:findTaskIndex(task_id)
if idx then
self:refreshTaskItem(nil,idx)
end
end

function UISubAct_zongmendabi_target_win:recv_refresh()
self:refreshTargetsGrid()
end
