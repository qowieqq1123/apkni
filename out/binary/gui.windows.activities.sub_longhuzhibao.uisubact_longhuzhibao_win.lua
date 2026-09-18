







def_class("UISubAct_longhuzhibao_Win",UIWindowBase)









function UISubAct_longhuzhibao_Win:bindComponents()

self.gbListPanel=UIObject.get(self,0)
self.bgModel=UIObject.get(self,1)
self.rewardBtn=UIButton.get(self,2)
self.baoXiangReddot=UIImage.get(self,3)
self.yetreward=UIObject.get(self,4)
self.timetext=UIText.get(self,5)
self.bgspine=UIObject.get(self,6)
self.peopleModel=UIObject.get(self,7)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)



end


function UISubAct_longhuzhibao_Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.gbListPanel);self.gbListPanel=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.baoXiangReddot);self.baoXiangReddot=nil;
_UIObject_release(self.yetreward);self.yetreward=nil;
_UIObject_release(self.timetext);self.timetext=nil;
_UIObject_release(self.bgspine);self.bgspine=nil;
_UIObject_release(self.peopleModel);self.peopleModel=nil;
end



















function UISubAct_longhuzhibao_Win:onLoaded(...)

self:bindComponents()
self.btlistp={}
end


function UISubAct_longhuzhibao_Win:__delete()
if self.btlistp and next(self.btlistp)then
for k,v in pairs(self.btlistp)do
uiAIManager:removeUIInstance(v)
end
end

self:unbindComponents()
end




function UISubAct_longhuzhibao_Win:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eLongHuZhiBao
self.subid=argtable.sub_act_id
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)

self:refreshShowGBPanel()
self:refreshDailyReward()
self:CreatAllpeopletree()
end


function UISubAct_longhuzhibao_Win:onHide()
if self.btlistp and next(self.btlistp)then
for k,v in pairs(self.btlistp)do
uiAIManager:removeUIInstance(v)
end
end
end
local itemcmp=
{
exchangeBtn=2,
itemclick=4,
model=6,
name=8,
}


local randbeginpostb=
{
[1]={-500,-299},
[2]={-400,-299},
[3]={-300,-299},
[4]={-200,-299},
[5]={100,-299},
[6]={200,-299},
[7]={300,-299},
[8]={400,-299},
}
local randposYtb=
{
[1]=-299,
[2]=-320,
[3]=-340,
[4]=-365

}
local randpostb=
{
[1]={-492,-299},
[2]={421,-299},
[3]={400,-299},
[4]={300,-299},
[5]={100,-299},
[6]={-200,-299},
[7]={-300,-299},
[8]={-400,-299},
}

local randman=
{
5314,
5315,
5316,
}
local randfatman=
{
5317,
5318,
5319,
}
local randwoman=
{
5321,
5322,
5323,
}
local randfatwoman=
{
5324,
5325,
5326,
}

local peoplecmp=
{
randman,
randfatman,
randwoman,
randfatwoman,
}

local speed=
{

25,
30,
35,
40,
45,
50,
55,
}

function UISubAct_longhuzhibao_Win:CreatAllpeopletree()
self.btlistp={}
randbeginpostb=
{
[1]={-500,-299},
[2]={-400,-299},
[3]={-300,-299},
[4]={-200,-299},
[5]={100,-299},
[6]={200,-299},
[7]={300,-299},
[8]={400,-299},
}
speed=
{

25,
30,
35,
40,
45,
50,
55,
}

self.randY={}
local peoplerand=math.random(1,#peoplecmp)
for i=1,4 do
local rand1=math.random(1,#peoplecmp[i])
local rand2=math.random(1,#speed)
local stateId=0
if peoplerand==i then
stateId=1
end

self.randY[i]=randposYtb[i]
self:peopletree(peoplecmp[i][rand1],speed[rand2],i,stateId,self.randY[i])
table.remove(speed,rand2)
end

end


function UISubAct_longhuzhibao_Win:peopletree(modelId,speed,id,stateId,randY)
local tran=self.peopleModel:getCommonComponent('Transform')

local randomIndex=math.random(1,#randbeginpostb)
local randomIndex2=math.random(-492,421)
local randomIndex3=math.random(-492,421)

local randomtalk=math.random(1,#self.config.people_txt)
local vpos=Vector2.New(randbeginpostb[randomIndex][1],randY)
table.remove(randbeginpostb,randomIndex)
local myid=id
local initData={
winName="UISubAct_longhuzhibao_Win",


pos_1={randomIndex2,randY},
pos_2={randomIndex3,randY},
myid=myid,
runSpeed=speed,
talktxt=#self.config.people_txt[randomtalk],
offset={0,130},
stateId=stateId,




isWait=false,
RandPos="RandPos",
}
local func=function(bt)
self.btlistp[myid]=bt
end
self.peopleModel:setChildCanvasGroupAlpha(1)
uiAIManager:createUIObject('UISubAct_longhuzhibao_Win','bt_ui_walk_people',INSTANCE_TYPE.eUIDModel,modelId,tran,vpos,initData,nil,func)

end

function UISubAct_longhuzhibao_Win:refreshShowGBPanel()
self.bgspine:setChildUIModelShowTarget(5337,1,{},eAnimationID.stand,false,false,0,nil)
local grids=self.gbListPanel:getChildCommonLayoutGroupWidgetList()

local gubao_itemid=self.config.gubao_itemid[1]
local jumpall=self.config.jump

for i=1,grids.Count do
local widget=grids[i-1]
local gubaoItemId=gubao_itemid[i]
local gbId=gubaoLookup:good2GuBao(gubaoItemId)
local itemCfg=itemsConfig.getConfig(gbId,ITEM_CONFIG_TYPE.eGuBao)
local pram=itemCfg.relevantPram.pram
local name=itemCfg.name
local effectId=self.config.gubao_effectid[1][i]
local scale_=Vector3(self.config.gubao_scale[i][1],self.config.gubao_scale[i][2],self.config.gubao_scale[i][3])
local position_=Vector3(self.config.gubao_position[i][1],self.config.gubao_position[i][2],self.config.gubao_position[i][3])
if effectId then
widget:SetChildShowEffect(itemcmp.model,effectId,true)
widget:SetChildScale(itemcmp.model,scale_)
widget:SetChildLocalPosition(itemcmp.model,position_)
widget:SetChildButtonClick(itemcmp.itemclick,function()
itemsComponentHelper.onItemClick(gubaoItemId)
end)

else
widget:SetChildShowEffect(itemcmp.model,0,false)
end

widget:SetChildButtonClick(itemcmp.exchangeBtn,function()
if jumpall then
local jump=jumpall[i]









jumpManager:jump(jump)



end

end)
widget:SetChildText(itemcmp.name,name)
end
self:setRemainingTimeTimer()
end


function UISubAct_longhuzhibao_Win:refreshDailyReward()
if not self.info then
return
end

local isGot=self.info:reqlonghuzhibao_checkDailyRewardsIsGot()


if not isGot then




self.rewardBtn:setChildUIModelShowTarget(5336,1,{},eAnimationID.stand2,false,false,0,nil)

self.baoXiangReddot:setActive(false)
self:doPunchRotation(false)
else


self.rewardBtn:setChildUIModelShowTarget(5336,1,{},eAnimationID.stand,false,false,0,nil)

self.baoXiangReddot:setActive(true)
self:doPunchRotation(true)
end
end



function UISubAct_longhuzhibao_Win:doPunchRotation(reddot)
if reddot then
if self.reddotTweener==nil then
self.baoXiangReddot:setRotation(0,0,0)
local tweener=self.baoXiangReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self.baoXiangReddot:setRotation(0,0,0)
end
end
end


function UISubAct_longhuzhibao_Win:onRewardBtn()
if not self.info then
return
end

local isGot=self.info:reqlonghuzhibao_checkDailyRewardsIsGot()
if not isGot then

return
end

self.info:reqlonghuzhibao_getDailyRewards()
end


function UISubAct_longhuzhibao_Win:setRemainingTimeTimer()

local func
func=function()
local nowTime=timeHelper.getServerShortTime()
local lerp=self.info:getEndLeftTime()and self.info:getEndLeftTime()or 0
if lerp>0 then

self.timetext:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp11(lerp,true)))


else
self.timetext:setText("活动已结束")
UIManager.error("活动已结束")
self.timer=nil
end
end

self.timer=self:setTimer(1,0,func)

func()
end


function UISubAct_longhuzhibao_Win:RandPos(id)
local randomIndex1=math.random(-492,421)
local randomIndex2=math.random(-492,421)
self.btlistp[id]:setSharedVar("pos_1",{randomIndex1,self.randY[id]})
self.btlistp[id]:setSharedVar("pos_2",{randomIndex2,self.randY[id]})
local randomIndex3=math.random(1,#self.config.people_txt)

self.btlistp[id]:setSharedVar("talktxt",self.config.people_txt[randomIndex3])
end

