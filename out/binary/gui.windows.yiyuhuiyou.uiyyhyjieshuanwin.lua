







def_class("UIYYHYJieShuanWin",UIWindowBase)









function UIYYHYJieShuanWin:bindComponents()

self.reddotL=UIObject.get(self,0)
self.reddotR=UIObject.get(self,1)
self.model=UIObject.get(self,2)
self.leftBtn=UIButton.get(self,3)
self.rightBtn=UIButton.get(self,4)
self.count=UIText.get(self,5)
self.title=UIText.get(self,6)
self.rwScrollView=UIObject.get(self,7)
self.receiveBtn=UIButton.get(self,8)
self.receiveIcon=UIObject.get(self,9)
self.targetScrollView=UIObject.get(self,10)
self.countDown=UIText.get(self,11)
self.countDesc=UIText.get(self,12)
self.helpBtn=UIToggleButton.get(self,13)
self.helpPanelPos=UIObject.get(self,14)
self.rwScrollView2=UIObject.get(self,15)
self.titleyuhuo3=UIText.get(self,16)
self.closebtn1=UIButton.get(self,17)
self.chushouBtn=UIButton.get(self,18)
self.speakObjai=UIObject.get(self,19)
self.speakTextai=UIText.get(self,20)
self.jiacheng=UIImage.get(self,21)
self.titleyuhuotwo=UIText.get(self,22)
self.jifenimg=UIImage.get(self,23)
self.jiachengtext=UIText.get(self,24)
self.jiachengnd=UIText.get(self,25)
self.spinebg=UIObject.get(self,26)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.receiveBtn:setButtonClick(function()self:onReceiveBtn()end)

self.closebtn1:setButtonClick(function()self:onClosebtn1()end)

self.chushouBtn:setButtonClick(function()self:onChushouBtn()end)



end


function UIYYHYJieShuanWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.reddotL);self.reddotL=nil;
_UIObject_release(self.reddotR);self.reddotR=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.count);self.count=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.receiveBtn);self.receiveBtn=nil;
_UIObject_release(self.receiveIcon);self.receiveIcon=nil;
_UIObject_release(self.targetScrollView);self.targetScrollView=nil;
_UIObject_release(self.countDown);self.countDown=nil;
_UIObject_release(self.countDesc);self.countDesc=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.helpPanelPos);self.helpPanelPos=nil;
_UIObject_release(self.rwScrollView2);self.rwScrollView2=nil;
_UIObject_release(self.titleyuhuo3);self.titleyuhuo3=nil;
_UIObject_release(self.closebtn1);self.closebtn1=nil;
_UIObject_release(self.chushouBtn);self.chushouBtn=nil;
_UIObject_release(self.speakObjai);self.speakObjai=nil;
_UIObject_release(self.speakTextai);self.speakTextai=nil;
_UIObject_release(self.jiacheng);self.jiacheng=nil;
_UIObject_release(self.titleyuhuotwo);self.titleyuhuotwo=nil;
_UIObject_release(self.jifenimg);self.jifenimg=nil;
_UIObject_release(self.jiachengtext);self.jiachengtext=nil;
_UIObject_release(self.jiachengnd);self.jiachengnd=nil;
_UIObject_release(self.spinebg);self.spinebg=nil;
end

















local _task_item={
targetDes=0,
count=1,
gotoBtn=2,
receiveBtn=3,
receiveIcon=4,
rewards={5,6,7}
}

local _yuhuo_item={
icon=0,
textnum=3,
}

local _modelList={
2059,
2058,
2057,
2056,
2055,
}

local textyyhy=
{
[1]='【简单】',
[2]='【普通】',
[3]='【困难】',
[4]='【极难】',
[5]='【极难】',
}

local _this
local abname_yyhy='ui/windows/yiyuhuiyou/yyhyimage_atlas_pak.ab'



function UIYYHYJieShuanWin:onLoaded(...)
_this=self
self:bindComponents()

self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)
self.targetScrollView:setChildScrollViewInit(0.5,true,nil,nil)

self.helpBtn:setToggleChange(function(name,isOn,data)
if isOn then
self:onHelpBtn()
end
end)

self.helpPos=self.helpPanelPos:getChildAnchoredPosition()
end


function UIYYHYJieShuanWin:__delete()
_this=nil
self:unbindComponents()
end




function UIYYHYJieShuanWin:onShow(argtable,afterOnloaded)
if argtable then
self.iswin=argtable[1]
if argtable[1]==0 then
self.title:setText(FMT.fmt('胜利'))
_this.spinebg:setChildUIModelShowTarget(4501,1,nil,eAnimationID.stand)
elseif argtable[1]==1 then
self.title:setText(FMT.fmt('失败'))
_this.spinebg:setChildUIModelShowTarget(4503,1,nil,eAnimationID.stand)
elseif argtable[1]==2 then
self.title:setText(FMT.fmt('平局'))
_this.spinebg:setChildUIModelShowTarget(4502,1,nil,eAnimationID.stand)
else
self.title:setText(FMT.fmt(''))
_this.spinebg:setChildUIModelShowTarget(4502,1,nil,eAnimationID.stand)
end
if argtable[2]then
self.now_score=argtable[2]
else
self.now_score=0
end
end

self.npc_id=YiYuHuiYouModel:getNPCId()
local npccfg=cfg_yiyuhuiyounpcconfig_get(_this.npc_id)
local nandu_index=npccfg.nanduImg
local difficulty_per=npccfg.difficulty_per

_this.winlua:SetChildCSImageSprite(_this.jiacheng:getID(),abname_yyhy,FMT.fmt('image_cyhyjiesuanui_{0}',nandu_index))
_this.jiachengnd:setText(textyyhy[nandu_index])
_this.jiachengtext:setText(FMT.fmt('渔获+{0}%',difficulty_per))

UIYYHYJieShuanWin:updataInfo()
_this:delayDo(0.8,function()
UIYYHYJieShuanWin:doSpeaking()
end)
end


function UIYYHYJieShuanWin:initSortGroups()
local cfg=cfgHelper.get1(cfg_targetactivity1config_get,self.subId)
local groups={}
local grouprewards=cfg.grouprewards

for id,v in pairs(grouprewards)do
groups[#groups+1]=id
end


table.sort(groups,function(a,b)
return a<b
end)

return groups
end

function UIYYHYJieShuanWin:getStartGroupIndex()
for i,v in ipairs(self.groups)do
local isReceive=self:callActivityInfoFunc('isGroupRewardReceive',v)
if not isReceive then
return i
end

local isComplete=self:callActivityInfoFunc('isGroupComplete',self.subId,v)
if not isComplete then
return i
end
end
return 1
end

function UIYYHYJieShuanWin:refresh()
self:showCurrentGroup()
end

function UIYYHYJieShuanWin:callActivityFunc(fname,...)
return call_activitiesHandle_func('activitiesHandle_targetActivity',fname,self.actId,self.subId,...)
end

function UIYYHYJieShuanWin:callActivityInfoFunc(fname,...)
local info=activitiesModel:getSubActInfo(self.actId,SUB_ACTIVITY_TYPE.eMuBiaoHuoDong,self.subId)
return info[fname](info,...)
end


function UIYYHYJieShuanWin:onHide()

end

function UIYYHYJieShuanWin:startCountDown()
local time=self:callActivityInfoFunc('getEndLeftTime')
local endTime=os.time()+time
local tick=function()
local dt=endTime-os.time()
self.countDown:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp11(dt,true)))
if dt<=0 then
self:clearTimer()
end
end
self:clearTimer()
self.timer=self:setTimer(1,time+5,tick)
tick()
end

function UIYYHYJieShuanWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIYYHYJieShuanWin:showCurrentGroup()
self.countDesc:setText(self.countDes)
self.count:setText(self:callActivityInfoFunc('getTargetProgress'))
self.title:setText(FMT.fmt('第{0}轮',mathHelper.numberToChinese(self.groupId)))

self:setTargetTasks()

if self.helpDes then

self.helpBtn:setActive(true)
else

self.helpBtn:setActive(false)
end

local gstate=self:callActivityInfoFunc('getGroupState',self.groupId)
local receive=false
if gstate then
receive=gstate==3
end
self.receiveBtn:setActive(not receive)
self.receiveIcon:setActive(receive)
if not receive then
local isComplete=self:callActivityInfoFunc('isGroupComplete',self.subId,self.groupId)
self.receiveBtn:setButtonEnable(isComplete,not isComplete)
end


local modelId=2059
if not modelId then
modelId=_modelList[#_modelList]
end
self.model:setChildUIModelShowTarget(modelId,1.5,{},eAnimationID.stand,false,false,0.5)
self.model:setChildUIModelShowFlipX(true)
end



function UIYYHYJieShuanWin:updataInfo()

UIYYHYJieShuanWin:setTargetYuHuo()
UIYYHYJieShuanWin:setTargetRewards()


local dizi_guid=YiYuHuiYouModel:getDiZiId()
if dizi_guid then
local info=UIDiscipleModel:getDiscipleImageInfo(dizi_guid)
if info then
_this.model:setChildUIModelRemoveTarget()
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info)
_this.model:setChildUIModelShowTarget(modelParams.body,0.9,modelParams.componets,eAnimationID.stand,false,false,0.5)
_this.model:setChildUIModelShowFlipX(true)
end
end


local yuhuonum=_this.now_score
_this.titleyuhuotwo:setText(FMT.fmt('{0}',yuhuonum))
_this.winlua:SetChildCSImageSprite(23,abname_yyhy,'yyhy_jifen')

end



function UIYYHYJieShuanWin:setTargetRewards()
local rewards={}
local rewardlist=YiYuHuiYouModel:getRewardData()
local npc_id=YiYuHuiYouModel:getNPCId()
local cfg=cfg_yiyuhuiyounpcconfig_get(npc_id).rewards

if _this.iswin==0 then
rewards=cfg[1]
elseif _this.iswin==1 then
rewards=cfg[2]
elseif _this.iswin==2 then
rewards=cfg[3]
end



local hbnum=YiYuHuiYouModel:gethebingCnt()
if rewards and#rewards>0 and hbnum>0 then
for k,v in ipairs(rewards)do
v[2]=v[2]*hbnum
end
end


if#rewardlist>0 then
for k,v in ipairs(rewardlist)do
if v.param_1<60000 or v.param_1>69999 then
rewards[#rewards+1]={v.param_1,v.param_2}
end
end
end



local new_rewards_list={}
for k,v in ipairs(rewards)do
local isadd=true
for i,j in ipairs(new_rewards_list)do
if j[1]==v[1]then
j[2]=j[2]+v[2]
isadd=false
break
end
end
if isadd then
new_rewards_list[#new_rewards_list+1]=v
end
end


table.sort(new_rewards_list,function(a,b)
local cfga=itemsConfig.getConfig(a[1])
local colora=cfga.color
local cfgb=itemsConfig.getConfig(b[1])
local colorb=cfgb.color
return colora>colorb
end)

local yuhuolist=_this.rightyuhuolist
local new_yuhuolist={}
for k,v in ipairs(yuhuolist)do
new_yuhuolist[#new_yuhuolist+1]={v.itemid,v.num,v.itemguid}
end


local new_rewards={}
new_rewards=new_yuhuolist
for k,v in ipairs(new_rewards_list)do
new_rewards[#new_rewards+1]=v
end


local len=#new_rewards
_this.rwScrollView:setChildScrollViewCreateGrids(len,len)
local grids=_this.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=new_rewards[i]
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
_this:onClickItemitem(itemId,1,data[3])
end)
end
end



function UIYYHYJieShuanWin:setTargetYuHuo()
local js_data_all_new3=YiYuHuiYouModel:getRewardData()
local js_data_all=YiYuHuiYouModel:getlYYHYDiaoLuo()

local js_data={}
for k,v in ipairs(js_data_all)do
if v.itemid>=60000 and v.itemid<=69999 then
js_data[#js_data+1]=v
end
end



table.sort(js_data,function(a,b)
local itema=UIAquariumControl:getItemByGuid(a.itemguid)
local isshanga=UIAquariumControl:isOrnamentalFish(itema)==true and 1000 or 0
local itemb=UIAquariumControl:getItemByGuid(b.itemguid)
local isshangb=UIAquariumControl:isOrnamentalFish(itemb)==true and 1000 or 0
local color_a=itemsConfig.getConfig(a.itemid).color
local color_b=itemsConfig.getConfig(b.itemid).color
return(isshanga+color_a)>(isshangb+color_b)
end)


local new_list={}
for k,v in ipairs(js_data)do

local itema=UIAquariumControl:getItemByGuid(v.itemguid)
local isshanga=UIAquariumControl:isOrnamentalFish(itema)
if isshanga then
new_list[#new_list+1]=v
else


local isaddd=true
for i,j in ipairs(new_list)do
if v.itemid==j.itemid then
local itemb=UIAquariumControl:getItemByGuid(j.itemguid)
local isshangb=UIAquariumControl:isOrnamentalFish(itemb)
if not isshangb then
j.num=j.num+1
isaddd=false


break
end
end
end
if isaddd then
new_list[#new_list+1]=v
end
end
end
_this.rightyuhuolist=new_list


if#new_list>0 then
local len=#new_list
_this.rwScrollView2:setChildScrollViewCreateGrids(len,2)
local grids=_this.rwScrollView2:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]


local guid=new_list[i].itemguid
local itemid=new_list[i].itemid
local num=new_list[i].num
local cfg=itemsConfig.getConfig(itemid)
local color=cfg.color




item:SetChildIcon(0,iconHelper.getItemIconName(cfg.icon),false)
item:SetChildText(1,FMT.fmt('X{0}',num))
item:SetChildCSImageSprite(2,abname_yyhy,FMT.fmt('image_cyhyyupj_{0}',color))

local itema=UIAquariumControl:getItemByGuid(guid)
local isshanga=UIAquariumControl:isOrnamentalFish(itema)
item:SetChildActive(4,isshanga)



item:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onClickItem(itemid,1,guid)
end,true)
end
end
end


function UIYYHYJieShuanWin:onClosebtn1()


YiYuHuiYouModel:ClearYYHYData()
self:closeSelf()
local win=UIManager:findActiveWindow('UIYYHYWin')
if win then
UIFullYiYuHuiYouController:closeUI()

local npcdatas=YiYuHuiYouModel:getNPCIdlist()
if npcdatas and#npcdatas>0 then
local guid=npcdatas[1].guid
local npc_id=YiYuHuiYouModel:getNPCId()
for i,v in pairs(npcdatas)do
if v.npcid==npc_id then
guid=v.guid
end
end
YiYuHuiYouController.onClickEntity({eWorldUnitTpye.YIYUHUIYOU,guid})
end
end
end

function UIYYHYJieShuanWin:onChushouBtn()

UIManager:showWindow('UIAquariumBagWin')

end



function UIYYHYJieShuanWin:doSpeaking()
local ku_id=1
if _this.iswin==0 then
ku_id=20
elseif _this.iswin==1 then
ku_id=22
elseif _this.iswin==2 then
ku_id=21
end
local speakList=cfg_yiyuhuiyouspeckkuconfig_get(ku_id).text_list
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local randomnum=math.random(1,100)
if randomnum>speakStr[1]then
return
end
local speed=30
_this.speakObjai:setChildCanvasGroupAlpha(1)
_this.speakTextai:setChildTrendsTextPlay(speakStr[2],speed,nil)
_this:doTalkAnim()
end

function UIYYHYJieShuanWin:doTalkAnim()
if _this.talkTween~=nil then
_this.talkTween:Kill()
_this.talkTween=nil
end
_this.speakObjai:setScale(Vector3.zero)
_this:delayDo(0.2,function()
_this.speakObjai:setChildCanvasGroupAlpha(1)
_this.talkTween=_this.speakObjai:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween=nil
_this.talkTween=_this.speakObjai:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween=nil
return _this:talkEndai()
end)
end)
end)
end
function UIYYHYJieShuanWin:talkEndai()
if _this.speakShowTimerai then
_this:stopTimerByID(_this.speakShowTimerai)
_this.speakShowTimerai=nil
end
_this.speakShowTimerai=_this:delayDo(3.5,function()

_this.speakObjai:setScale(Vector3.zero)
_this.speakObjai:setChildCanvasGroupAlpha(0)

if _this.speakShowTimerai then
_this:stopTimerByID(_this.speakShowTimerai)
_this.speakShowTimerai=nil
end
end)
end



function UIYYHYJieShuanWin:setTargetTasks()
local datas=self:getTargetDatas()
local len=#datas
self.targetScrollView:setChildScrollViewCreateGrids(len,1)
local grids=self.targetScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=datas[i]
local taskId=data.taskId
local taskData=self:callActivityInfoFunc('getTaskData',taskId)
local cfg=cfgHelper.get1(cfg_targetactivity1config_get,self.subId)
local td=cfg.tasks[taskId]
item:SetChildText(_task_item.targetDes,FMT.fmt(self.taskDes,td.task[1]))
item:SetChildText(_task_item.count,FMT.fmt('{0}/{1}',taskData and taskData.taskprogress or 0,td.task[1]))
local jumpArgs=td.jump
local state=taskData and taskData.taskstate or 1
local check1=state==1 and jumpArgs~=nil
local check2=state==2
local check3=state==3
item:SetChildActive(_task_item.gotoBtn,check1)
item:SetChildActive(_task_item.receiveBtn,check2)
item:SetChildActive(_task_item.receiveIcon,check3)
item:SetChildActive(_task_item.count,not check3)
if check1 then
item:SetChildButtonClick(_task_item.gotoBtn,function()
jumpManager:jump(jumpArgs)
end)
end
if check2 then
item:SetChildButtonClick(_task_item.receiveBtn,function()
self:callActivityFunc('reqTaskReward',taskId)
end)
end
local rwArr=td.task_rewards
for i,v in ipairs(_task_item.rewards)do
local rw=rwArr[i]
if rw then
item:SetChildActive(v,true)
widgetHelper.setNormalRewardItem(item,v,rw)
else
item:SetChildActive(v,false)
end
end
end
end

function UIYYHYJieShuanWin:getTargetDatas()
local cfg=cfgHelper.get1(cfg_targetactivity1config_get,self.subId)
local list={}
local tasks=cfg.grouprewards[self.groupId].task_ids
for i,v in ipairs(tasks)do
local taskData=self:callActivityInfoFunc('getTaskData',v)
local state=taskData and taskData.taskstate or 3
table.insert(list,{taskId=v,taskState=state})
end
local svd={2,1,3}
table.sort(list,function(a,b)
if svd[a.taskState]==svd[b.taskState]then

return a.taskId<b.taskId
else
return svd[a.taskState]<svd[b.taskState]
end
end)
return list
end



function UIYYHYJieShuanWin:showPageBtn()
local showL=self.groupIndex>1
local showR=self.groupIndex<#self.groups
self.leftBtn:setActive(showL)
self.rightBtn:setActive(showR)
if showL then
self.reddotL:setActive(self:callActivityInfoFunc('checkGroupReddot',self.subId,self.groupIndex-1))
end
if showR then
self.reddotR:setActive(self:callActivityInfoFunc('checkGroupReddot',self.subId,self.groupIndex+1))
end
end

function UIYYHYJieShuanWin:onLeftBtn()
if self.groupIndex>1 then
self.groupIndex=self.groupIndex-1
self.groupId=self.groups[self.groupIndex]
self:showCurrentGroup()
self:showPageBtn()
end
end

function UIYYHYJieShuanWin:onRightBtn()
if self.groupIndex<#self.groups then
self.groupIndex=self.groupIndex+1
self.groupId=self.groups[self.groupIndex]
self:showCurrentGroup()
self:showPageBtn()
end
end

function UIYYHYJieShuanWin:onReceiveBtn()
local isComplete=self:callActivityInfoFunc('isGroupComplete',self.subId,self.groupId)
if isComplete then
self:callActivityFunc('reqGroupReward',self.groupId)
else
UIManager.error('完成本轮全部任务方可领取')
end
end

function UIYYHYJieShuanWin:onHelpBtn()
if not self.helpDes then
return
end

local contentStr=self.helpDes
local x=self.helpPos.x
local y=self.helpPos.y
self:showWindow('UICommonHelpTwo',
{content=contentStr,
doScaleType=2,
x=x,
y=y,
ptype=3,
closeCB=function()
self.helpBtn:setToggle(false)
end})
end

function UIYYHYJieShuanWin:onClickItemitem(itemId,index,guid,attach)

if itemId<60000 or itemId>69999 then
tipsManager.showTips({itemid=itemId,itemguid=nil})
elseif itemId>=60000 and itemId<=69999 then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eYuHuo,itemid=itemId,itemguid=guid,attach=attach})
end
end

function UIYYHYJieShuanWin:onClickItem(itemId,index,guid,attach)

tipsManager.showTips({formType=TIPS_FORM_TYPE.eYuHuo,itemid=itemId,itemguid=guid,attach=attach})
end
