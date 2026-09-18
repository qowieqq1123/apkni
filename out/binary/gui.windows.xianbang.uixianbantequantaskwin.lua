







def_class("UIXianBanTeQuanTaskWin",UIWindowBase)









function UIXianBanTeQuanTaskWin:bindComponents()

self.bgmodel=UIObject.get(self,0)
self.ClickTequan=UIButton.get(self,1)
self.closebtn=UIButton.get(self,2)
self.fmodel=UIObject.get(self,3)
self.NPCmodel=UIObject.get(self,4)
self.reddot=UIObject.get(self,5)
self.root=UIObject.get(self,6)
self.select=UIToggleButton.get(self,7)
self.taskback=UIButton.get(self,8)
self.tasklist=UIObject.get(self,9)
self.xianbangtaskItem1=UIObject.get(self,10)
self.xianbangtaskItem2=UIObject.get(self,11)

self.ClickTequan:setButtonClick(function()self:onClickTequan()end)

self.closebtn:setButtonClick(function()self:onClosebtn()end)

self.taskback:setButtonClick(function()self:onTaskback()end)


self.sprite_image_dygou=0
self.sprite_image_dycha=1

end


function UIXianBanTeQuanTaskWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgmodel);self.bgmodel=nil;
_UIObject_release(self.ClickTequan);self.ClickTequan=nil;
_UIObject_release(self.closebtn);self.closebtn=nil;
_UIObject_release(self.fmodel);self.fmodel=nil;
_UIObject_release(self.NPCmodel);self.NPCmodel=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.select);self.select=nil;
_UIObject_release(self.taskback);self.taskback=nil;
_UIObject_release(self.tasklist);self.tasklist=nil;
_UIObject_release(self.xianbangtaskItem1);self.xianbangtaskItem1=nil;
_UIObject_release(self.xianbangtaskItem2);self.xianbangtaskItem2=nil;
end


















local _this=nil

function UIXianBanTeQuanTaskWin:onLoaded(...)
_this=self
self:addNotify(notifyConfig.onTeQuanInfoChange,self.onTeQuanInfoChange)
self:bindComponents()
end

function UIXianBanTeQuanTaskWin.onTeQuanInfoChange(tqData)
if _this==nil then return end
local tqid=tqData.tqid
if tqid==_this.tqId then



if tqData.list then
_this:refreshwin(tqData)
xianjiexianbangModel:refreshYJYHUD()
else
_this:recordselect()
UIManager:invokeUIMethod('UIXianBangWin','refreshBtn')
_this:RefreshReddot()
end


end

end

function UIXianBanTeQuanTaskWin:__delete()
self:unbindComponents()
end

local cmp=
{
monsterfight=0,
monsterfighttext=1,
monsterkuang=2,
rwScrollview=3,
rwScrollview2=4,
yetselect=5,
rwlist=6,
rwlist2=7,
bgmodel=8,
root=9,
gotobtn=10,
taskname=12,
massspine=13,
monstericon=14,
effect=15,
tstitle=16,
}

local rwidex=
{
type1=1,
type2=2
}



function UIXianBanTeQuanTaskWin:onShow(argtable,afterOnloaded)
self.jobflag=argtable.jobflag
self.xgid=argtable.xgid
self.tqId=10
_this.selectindex=nil
self.reddot:setActive(false)
self.NPCmodel:setChildUIModelShowTarget(1113030,1,{},eAnimationID.idle)
self.bgmodel:setChildUIModelShowTarget(6109,1,{},eAnimationID.enter)
self.fmodel:setChildUIModelShowTarget(6110,1,{},eAnimationID.enter)
local key=xianguanConfig.getTeQuanFindKey(self.xgid,self.tqId)

self.data=xianguanModel:getTeQuanDataByKey(key)
if self.data and self.data.list then
self:refreshwin(self.data)
else
self.tasklist:setActive(false)
self.taskback:setActive(false)
end
self:RefreshReddot()
end


function UIXianBanTeQuanTaskWin:onHide()

end

function UIXianBanTeQuanTaskWin:RefreshReddot()
self.reddot:setActive(false)
local jobflag,id=xianguanController:checkSelfHasJobByType(self.tqId)
if not jobflag then
return
end

local key=xianguanConfig.getTeQuanFindKey(self.xgid,self.tqId)
self.data=xianguanModel:getTeQuanDataByKey(key)
self:refreshSkipBtn()
if self.data and self.data.list then
self.reddot:setActive(true)
return
end
local state=xianguanHelper.checkTeQuanUseCondition(self.xgid,_this.tqId,false)
if state then
self.reddot:setActive(true)
return
end
end




function UIXianBanTeQuanTaskWin:getrewardlsit(cfg_task)
local list={}
local rewards=cfg_task.rewards
local type=rewards[1]
local redata=rewards[2]
if type==rwidex.type1 then
list=redata
elseif type==rwidex.type2 then
local exrewards=cfg_task.exrewards or{}
list=exrewards
end
return type,list
end


function UIXianBanTeQuanTaskWin:refreshwin(data)

if self.PlayAnimation then
self.tasklist:setActive(false)
self.taskback:setActive(false)
return
end
if not data or not data.list then
self.tasklist:setActive(false)
self.taskback:setActive(false)
return
end


self.tasklist:setActive(true)
self.taskback:setActive(true)
local taskid1=data.list[1]
local cfg_task1=cfg_xianbangtaskconfig_get(taskid1)
local item1=self.xianbangtaskItem1:getWidgetBase()
item1:SetChildText(cmp.taskname,cfg_task1.name)
local type,rewards=self:getrewardlsit(cfg_task1)
item1:SetChildActive(cmp.rwScrollview,true)
item1:SetChildCanvasGroupDOFade(cmp.root,0,0)
item1:SetChildCanvasGroupDOFade(cmp.root,1,0.5)
if cfg_task1.spinecolor then
item1:SetChildUIModelShowTarget(cmp.bgmodel,cfg_task1.spinecolor,1,{},eAnimationID.enter)
else
item1:SetChildUIModelShowTarget(cmp.bgmodel,6099,1,{},eAnimationID.enter)
end
item1:SetChildShowEffect(cmp.effect,cfg_task1.effectcolor,true)


item1:SetChildLayoutGroupCreateItems(cmp.rwlist,#rewards,function(index)
local item=item1:GetChildLayoutGroupGridItem(cmp.rwlist,index-1)
local data=rewards[index]
local itemId=data[1]
local itemCount=data[2]
local showEffFlag=false
local countStr=itemCount>1 and mathHelper.formatNumber2(itemCount)or''
local showCountBG=itemCount>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=showEffFlag}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
self:onClickItemitem(itemId)
end)
item:SetChildActive(1,type~=rwidex.type1)
end)
item1:SetChildScrollRectEnable(cmp.rwScrollview,#rewards>=5)
item1:SetChildButtonClick(cmp.gotobtn,function()

local func=function()

xianguanController.sendUsePrivilege(self.xgid,self.tqId,"[8,1]")
_this.selectindex=1
end
self:showDiolouge(func)
end)
self:showModel(cfg_task1,item1)
item1:SetChildActive(cmp.yetselect,false)

local taskid2=data.list[2]
local cfg_task2=cfg_xianbangtaskconfig_get(taskid2)
local item2=self.xianbangtaskItem2:getWidgetBase()
item2:SetChildText(cmp.taskname,cfg_task2.name)
local type,rewards=self:getrewardlsit(cfg_task2)
item2:SetChildActive(cmp.rwScrollview,true)
if cfg_task2.spinecolor then
item2:SetChildUIModelShowTarget(cmp.bgmodel,cfg_task1.spinecolor,1,{},eAnimationID.enter)
else
item2:SetChildUIModelShowTarget(cmp.bgmodel,6099,1,{},eAnimationID.enter)
end
item2:SetChildShowEffect(cmp.effect,cfg_task2.effectcolor,true)
item2:SetChildCanvasGroupDOFade(cmp.root,0,0)
item2:SetChildCanvasGroupDOFade(cmp.root,1,0.5)
item2:SetChildLayoutGroupCreateItems(cmp.rwlist,#rewards,function(index)
local item=item2:GetChildLayoutGroupGridItem(cmp.rwlist,index-1)
local data=rewards[index]
local itemId=data[1]
local itemCount=data[2]
local showEffFlag=false
local countStr=itemCount>1 and mathHelper.formatNumber2(itemCount)or''
local showCountBG=itemCount>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=showEffFlag}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
self:onClickItemitem(itemId)
end)
item:SetChildActive(1,type~=rwidex.type1)
end)
item2:SetChildScrollRectEnable(cmp.rwScrollview,#rewards>=5)
item2:SetChildButtonClick(cmp.gotobtn,function()
local func=function()

xianguanController.sendUsePrivilege(self.xgid,self.tqId,"[8,2]")
_this.selectindex=2
end
self:showDiolouge(func)
end)
self:showModel(cfg_task2,item2)
item2:SetChildActive(cmp.yetselect,false)
end

function UIXianBanTeQuanTaskWin:showDiolouge(func)

local show_data={
type='UIDialouge',
title='提示',
content='选择后不可更改，是否选择该任务发布？',
oktext='确定',
canceltext='取消',
okcallback=func,
}
local comfirmDialogEnter=UIDialogManager.newDialog(show_data)
comfirmDialogEnter:show()
end


function UIXianBanTeQuanTaskWin:recordselect()
if not _this.selectindex then
return
end
local item1=self.xianbangtaskItem1:getWidgetBase()
local item2=self.xianbangtaskItem2:getWidgetBase()
item1:SetChildActive(cmp.yetselect,_this.selectindex==1)
item2:SetChildActive(cmp.yetselect,_this.selectindex==2)
if _this.selectindex==1 then
item1:SetChildActive(cmp.gotobtn,false)
item2:SetChildButtonEnable(cmp.gotobtn,false,true)
elseif _this.selectindex==2 then
item2:SetChildActive(cmp.gotobtn,false)
item1:SetChildButtonEnable(cmp.gotobtn,false,true)
end

end

function UIXianBanTeQuanTaskWin:showModel(cfg_task,item)
local xjres=cfg_task.xjres
if not xjres then
return
end
local rewards={}
if xjres[1]==XJ_ResPoint_TYPE.eMonster then

local cfg=cfgHelper.get(cfg_fairylandmonsterresourceconfig_get,xjres[2])

local modelParams=comHelper.getMonsterGroupModelParams(cfg.monster_id)
local scaleParam=isometricMapSystem:getModelScales2Pram(modelParams.body,18)
local scales2=cfg.scales2
if scales2 then
scaleParam=scales2[1]
end
item:SetChildUIModelShowTarget(cmp.massspine,modelParams.body,scaleParam[1],modelParams.componets,eAnimationID.stand,false,false,1,nil)
item:SetChildUIModelShowTargetOffset(cmp.massspine,scaleParam[2],scaleParam[3])

local fightvalue=cfg_task.fightvalue or 0
item:SetChildActive(cmp.monsterfight,true)
item:SetChildText(cmp.monsterfighttext,mathHelper.formatNumber5(fightvalue,2))
local dropCfg=cfgHelper.get(cfg_awardconfig_get,cfg.drop_id)
rewards=dropCfg and dropCfg.showItems or{}
elseif xjres[1]==XJ_ResPoint_TYPE.eCollectible then


local cfg=cfgHelper.get(cfg_fairylanditemresourceconfig_get,xjres[2])
local body=cfg.modelSet.model
local scaleParam={0.5,0,0}
local scales2=cfg.scales2
if scales2 then
scaleParam=scales2[1]
end
item:SetChildUIModelShowTarget(cmp.massspine,body,scaleParam[1],{},eAnimationID.stand,false,false,1,nil)
item:SetChildUIModelShowTargetOffset(cmp.massspine,scaleParam[2],scaleParam[3])
rewards=cfgHelper.get(cfg_awardconfig_get,cfg.drop_id)
local dropCfg=cfgHelper.get(cfg_awardconfig_get,cfg.drop_id)
rewards=dropCfg and dropCfg.showItems or{}
elseif xjres[1]==XJ_ResPoint_TYPE.eCtCollectible then
local cfg=cfgHelper.get(cfg_fairylandexchangeitemresourceconfig_get,xjres[2])


item:SetChildActive(cmp.monsterkuang,true)
item:SetChildIcon(cmp.monstericon,cfg.headimage,false)
rewards=cfg.rewards
end
if#rewards<=0 then
return
end

item:SetChildActive(cmp.rwScrollview2,true)
item:SetChildLayoutGroupCreateItems(cmp.rwlist2,#rewards,function(index)
local itemchild=item:GetChildLayoutGroupGridItem(cmp.rwlist2,index-1)
local data=rewards[index]
local itemId=data[1]
local itemCount=data[2]
local showEffFlag=false
local countStr=itemCount>1 and mathHelper.formatNumber2(itemCount)or''
local showCountBG=itemCount>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=showEffFlag}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemchild:SetChildPropData(0,prop)
itemchild:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
self:onClickItemitem(itemId)
end)
itemchild:SetChildActive(1,data.range==nil and itemCount<0)

end)
item:SetChildScrollRectEnable(cmp.rwScrollview2,#rewards>=5)

if xjres[1]==XJ_ResPoint_TYPE.eMonster then
item:SetChildText(cmp.tstitle,'征讨奖励')
elseif xjres[1]==XJ_ResPoint_TYPE.eCollectible then
item:SetChildText(cmp.tstitle,'探索掉落')
elseif xjres[1]==XJ_ResPoint_TYPE.eCtCollectible then
item:SetChildText(cmp.tstitle,'缴纳奖励')
end
end



function UIXianBanTeQuanTaskWin:onClickItemitem(itemId)
if itemId then
tipsManager.showTips({itemid=itemId,itemguid=nil,showModel=true,move=TIPS_MOVE_POS.eCenter})
end
end

function UIXianBanTeQuanTaskWin:onClickTequan()
self.jobflag,self.xgid=xianguanController:checkSelfHasJobByType(10)
if not self.jobflag then
UIManager.info("您已失去仙务正使官职，操作失败")
return
end
local key=xianguanConfig.getTeQuanFindKey(self.xgid,self.tqId)
self.data=xianguanModel:getTeQuanDataByKey(key)
self:refreshSkipBtn()
if self.data and self.data.list then
self:refreshwin(self.data)
return
end
local state=xianguanHelper.checkTeQuanUseCondition(self.xgid,_this.tqId,true)
if not state then
return
end


xianguanController.sendUsePrivilege(self.xgid,self.tqId,"")
if not self.Skip then
self.bgmodel:setChildUIModelShowTarget(6109,1,{},eAnimationID.common_window_enter2)
self.fmodel:setChildUIModelShowTarget(6110,1,{},eAnimationID.common_window_enter2)

self.PlayAnimation=true
self:delayDo(2.5,function()
self.PlayAnimation=false
local key=xianguanConfig.getTeQuanFindKey(self.xgid,self.tqId)

self.data=xianguanModel:getTeQuanDataByKey(key)

if self.data and self.data.list then
self:refreshwin(self.data)
end
end)
end

end

function UIXianBanTeQuanTaskWin:onClosebtn()
self:closeSelf()
end
function UIXianBanTeQuanTaskWin:onTaskback()
self:onClosebtn()
end
function UIXianBanTeQuanTaskWin:refreshSkipBtn()
local typo=ACTOR_SETTING_TYPE.eXianShiYaoWu
local data=userActorArraySetting.getBase(typo,{})
local flag=data['1']==true
self.Skip=flag
data['1']=flag


self.select:setToggle(self.Skip)
self.select:setToggleChange(function(name,isOn)
self.Skip=isOn

self:onSkipBtn()
end)
end

function UIXianBanTeQuanTaskWin:onSkipBtn()
local typo=ACTOR_SETTING_TYPE.eXianShiYaoWu
local data={}
data['1']=self.Skip
userActorArraySetting.setBase(typo,data)
userActorArraySetting.flush(typo)
end

function UIXianBanTeQuanTaskWin:onCloseClick()

end