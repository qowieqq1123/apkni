







def_class("UIMoJieForceTaskWin",UIWindowBase)









function UIMoJieForceTaskWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.bgModel=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.root=UIObject.get(self,3)
self.titlebg=UIImage.get(self,4)
self.titlebg2=UIImage.get(self,5)
self.tipsbtn=UIButton.get(self,6)
self.taskScroller=UIObject.get(self,7)
self.titlebg3=UIObject.get(self,8)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.tipsbtn:setButtonClick(function()self:onTipsbtn()end)



end


function UIMoJieForceTaskWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.titlebg);self.titlebg=nil;
_UIObject_release(self.titlebg2);self.titlebg2=nil;
_UIObject_release(self.tipsbtn);self.tipsbtn=nil;
_UIObject_release(self.taskScroller);self.taskScroller=nil;
_UIObject_release(self.titlebg3);self.titlebg3=nil;
end
















local _this
local abname='ui/windows/mojieforce/mojieforce_atlas_pak.ab'
local taskitemidx=
{
selfitem=0,
desc=1,
flag=2,
gobtn=3,
rewardbtn=4,
gotflag=5,
rewscrollview=6,
resettxt=7,
}
local jieduantype=
{
[1]='image_shilirenwu_9',
[2]='image_shilirenwu_10',
[3]='image_shilirenwu_11',
[4]='image_shilirenwu_12',
[5]='image_shilirenwu_13',
[6]='image_shilirenwu_14',
[7]='image_shilirenwu_14',
}
local typeflag=
{
[1]='image_shilirenwu_6',
[2]='image_shilirenwu_15',
[3]='image_shilirenwu_4',
}
local resetdesc=
{
[MJTaskResetType.NewDay]='每日0点重置',
[MJTaskResetType.NewDay5am]='每日5点重置',
[MJTaskResetType.NewWeek]='每周0点重置',
[MJTaskResetType.NewWeek5am]='每周5点重置',
}




function UIMoJieForceTaskWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIMoJieForceTaskWin:__delete()
self:unbindComponents()
_this=nil
end



function UIMoJieForceTaskWin:onTipsbtn()
local d={}
d.title='规则'
d.mode=3
d.name='ui_UIMoJieForceTaskWin_rule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

function UIMoJieForceTaskWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then return end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eCenter})
end

function UIMoJieForceTaskWin:onClickGotoBtn(jumpParam)
jumpManager:jump(jumpParam)
end

function UIMoJieForceTaskWin:reqGetGoalReward()
local len=#self.canRewards
if len>0 then
xianjieController:send_35_226(len,self.canRewards)
end
end





function UIMoJieForceTaskWin:onShow(argtable,afterOnloaded)
self.root:setChildCanvasGroupAlpha(0)
self.bgModel:setChildUIModelShowTarget(6260,1,nil,eAnimationID.enter)
self.root:setChildCanvasGroupDOFade(1,0.6,nil)
self.saijiid=xianjieController:getMoJieSaiJiID()
self.chapteridx=xianjieController:getMoJieSaiJiChapteridx()or 1
self.forceid=xianjieController:getForce()
self.Skillidx,self.Taskidx=xianjieController:getForceCfg()
if self.forceid==nil then
self.forceid=1
self.taskScroller:setActive(false)
end
if self.Skillidx==nil then
self.Skillidx=1
self.taskScroller:setActive(false)
logErr(FMT.fmt('获取势力配置为nil,查看魔界赛季配置表的force字段,赛季id={0}',self.saijiid))
end

self:freshtitle()
self:freshpanel()
end


function UIMoJieForceTaskWin:onHide()

end
function UIMoJieForceTaskWin:onClickMask()
self:onCloseClick()
end
function UIMoJieForceTaskWin:onCloseBtn()
self:onCloseClick()
end

function UIMoJieForceTaskWin:onCloseClick(atOnce)

self:closeSelf()
end


function UIMoJieForceTaskWin:severfresh()
_this:freshpanel()
end


function UIMoJieForceTaskWin:freshtitle()

local forceid=self.forceid
local chapteridx=self.chapteridx
local cfg=cfg_devildomforceconfig_get(forceid)
local tasktitle=cfg.tasktitle
if tasktitle then
self.winlua:SetChildCSImageSprite(self.titlebg:getID(),abname,tasktitle)
self.winlua:SetChildCSImageSprite(self.titlebg3:getID(),abname,jieduantype[chapteridx])
end
end

function UIMoJieForceTaskWin:getTaskList()
self.canRewards={}
local list={}
local tasklist=xianjieController:getForceTasklistc()

local cfgList=cfg_devildomforcetaskconfig_get(self.Taskidx)
for i,cfg in ipairs(cfgList)do
local taskid=cfg.index
local taskdata=tasklist[taskid]
local sever_aim=0
local sever_gotflag=0
if xianjieController:checkMJSLTaskCondition(cfg,self.chapteridx)then
local aim=cfg.aim
local class=cfg.class
if taskdata then
sever_aim=taskdata.param_2 or 0
sever_gotflag=taskdata.param_3 or 0
end
local fix=sever_aim>=aim
local flag=sever_gotflag==1
if fix and not flag then
table.insert(self.canRewards,taskid)
end
local state=flag==true and 0 or 1
local weight=state*10000+(10000-class)
table.insert(list,{_taskdata=taskdata,_fix=fix,_isgot=flag,_weight=weight,_cfg=cfg,_sever_aim=sever_aim})

end
end
table.sort(list,function(a,b)
return a._weight>b._weight
end)

return list
end

function UIMoJieForceTaskWin:testttfreshpanel()
_this:freshpanel()
end

function UIMoJieForceTaskWin:freshpanel()
local list=self:getTaskList()
local dataNum=#list
self.taskScroller:setActive(true)
self.taskScroller:setChildScrollViewCreateGrids(dataNum,2)
local grids=self.taskScroller:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local data=list[i]

local isfix=data._fix
local isgot=data._isgot
local cfg=data._cfg
local task_aim=data._sever_aim
local aim=cfg.aim

local value=''
if aim then
if task_aim>=aim then
value=FMT.fmt("（<color=#ca631d>{0}/{1}</color>）",task_aim,aim)
else
value=FMT.fmt("（<color=#549327>{0}/{1}</color>）",task_aim,aim)
end
end
local desc=FMT.fmt(cfg.desc,value)
item:SetChildText(taskitemidx.desc,desc)


if cfg.class then
item:SetChildActive(taskitemidx.flag,true)
item:SetChildCSImageSprite(taskitemidx.flag,abname,typeflag[cfg.class])
else
item:SetChildActive(taskitemidx.flag,false)
end

local jumpParam=cfg.jumpParam
local hasJump=jumpParam~=nil
item:SetChildActive(taskitemidx.resettxt,false)
item:SetChildActive(taskitemidx.gobtn,false)
item:SetChildActive(taskitemidx.rewardbtn,false)
item:SetChildActive(taskitemidx.gotflag,false)


if isgot then
item:SetChildActive(taskitemidx.gotflag,true)

local reset=cfg.reset
if reset and reset>0 then
item:SetChildActive(taskitemidx.resettxt,true)
item:SetChildText(taskitemidx.resettxt,resetdesc[reset])
end
else
if isfix then

item:SetChildActive(taskitemidx.rewardbtn,true)
else
item:SetChildActive(taskitemidx.gobtn,hasJump)
end
end


item:SetChildButtonClick(taskitemidx.gobtn,function()
self:onClickGotoBtn(jumpParam)
end)

item:SetChildButtonClick(taskitemidx.rewardbtn,function()
self:reqGetGoalReward()
end)

self:setWidgetRewards(item,cfg)
end
end
end

function UIMoJieForceTaskWin:setWidgetRewards(grid,cfg)
local rewardList=cfg.rewards
if rewardList then
local len=#rewardList
grid:SetChildScrollViewCreateGrids(taskitemidx.rewscrollview,len,len)
local reward_grids=grid:GetChildScrollViewItemWidgets(taskitemidx.rewscrollview)
for j=1,len do
local reward=rewardList[j]
local itemid=reward[1]
local count=reward[2]
local widget=reward_grids[j-1]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
end
end
