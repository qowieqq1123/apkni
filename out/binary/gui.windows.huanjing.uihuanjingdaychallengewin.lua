







def_class("UIHuanJingDayChallengeWin",UIWindowBase)









function UIHuanJingDayChallengeWin:bindComponents()

self.root=UIObject.get(self,0)
self.faZeList=UIObject.get(self,1)
self.level1=UIButton.get(self,2)
self.level2=UIButton.get(self,3)
self.rewardScrollView1=UIObject.get(self,4)
self.rewardScrollView2=UIObject.get(self,5)
self.rewardBox1=UIImage.get(self,6)
self.rewardBox2=UIImage.get(self,7)
self.rewardBoxReddot1=UIObject.get(self,8)
self.rewardBoxReddot2=UIObject.get(self,9)

self.level1:setButtonClick(function()self:onLevel1()end)

self.level2:setButtonClick(function()self:onLevel2()end)



end


function UIHuanJingDayChallengeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.faZeList);self.faZeList=nil;
_UIObject_release(self.level1);self.level1=nil;
_UIObject_release(self.level2);self.level2=nil;
_UIObject_release(self.rewardScrollView1);self.rewardScrollView1=nil;
_UIObject_release(self.rewardScrollView2);self.rewardScrollView2=nil;
_UIObject_release(self.rewardBox1);self.rewardBox1=nil;
_UIObject_release(self.rewardBox2);self.rewardBox2=nil;
_UIObject_release(self.rewardBoxReddot1);self.rewardBoxReddot1=nil;
_UIObject_release(self.rewardBoxReddot2);self.rewardBoxReddot2=nil;
end
















local _level_index={
root=0,
head_bg=1,
head_icon=2,
level_bg=3,
level=4,
model=5,
effect=6,
flag=7,
battle=8,
model_bg=9,
model_bg2=10,
}
local ab='ui/windows/huanjing/huanjing_atlas_pak.ab'
local _this




function UIHuanJingDayChallengeWin:onLoaded(...)
self:bindComponents()

_this=self

self.levels={
self.level1,
self.level2
}
self.rewardScrollView={
self.rewardScrollView1,
self.rewardScrollView2
}
self.rewardBox={
self.rewardBox1,
self.rewardBox2
}
self.rewardBoxReddot={
self.rewardBoxReddot1,
self.rewardBoxReddot2
}

self.faZeList:setChildScrollViewInit(0.5,true,nil,nil)
self.rewardScrollView1:setChildScrollViewInit(0.5,true,nil,nil)
self.rewardScrollView2:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIHuanJingDayChallengeWin:__delete()
self:unbindComponents()

_this=nil
end

function UIHuanJingDayChallengeWin:getLevels(levels)
local list={}
for i,v in ipairs(levels)do
local mtype=cfgHelper.get2(cfg_guanqianewconfig_get,v.param_1,'mtype')or 1
table.insert(list,{data=v,mtype=mtype})
end
table.sort(list,function(a,b)
return a.mtype<b.mtype
end)
return list
end




function UIHuanJingDayChallengeWin:onShow(argtable,afterOnloaded)
self:refresh()
end

function UIHuanJingDayChallengeWin:refresh()
local data=UIHuanJingControl:getDayChallengeData()
self.faZeData={data.fzId}
self:showFaZeList()
self.data=data
local ldatas=self:getLevels(data.levels)
for i,v in ipairs(self.levels)do
self:setLevel(v,ldatas[i].data)
end
self:refreshRewards()
end

function UIHuanJingDayChallengeWin:refreshRewards()
local data=UIHuanJingControl:getDayChallengeData()
local ldatas=self:getLevels(data.levels)
for i,v in ipairs(self.levels)do
self:setReward(ldatas[i].data,self.rewardScrollView[i],self.rewardBox[i],self.rewardBoxReddot[i])
end
end


function UIHuanJingDayChallengeWin:onHide()

end

function UIHuanJingDayChallengeWin:setLevel(levelIcon,data)
local id=data.param_1
local flag=data.param_2
local cfg=cfgHelper.get1(cfg_guanqianewconfig_get,id)
local mtype=cfg.mtype or 1
local model=cfg.model and cfg.model[1]
local widget=levelIcon:getChildWidgetBase()
local showModel=mtype>1
widget:SetChildActive(_level_index.root,true)
widget:SetChildActive(_level_index.level_bg,false)
widget:SetChildActive(_level_index.head_bg,mtype==1)
widget:SetChildActive(_level_index.model_bg,mtype==2)
widget:SetChildActive(_level_index.model_bg2,mtype==3)
widget:SetChildActive(_level_index.model,showModel)
local showBattle=showModel and flag~=1
widget:SetChildActive(_level_index.battle,showBattle)
if showBattle then
widget:SetChildUIModelShowTarget(_level_index.battle,4045,1,nil,eAnimationID.stand)
end
widget:SetChildActive(_level_index.flag,flag==1)
if showModel then
local scale=isometricMapSystem:getModelScale(model,true)
local mcfg=cfgHelper.get1(cfg_dbbodyconfig_get,model)
local scaleData=mcfg and mcfg.scales2 and mcfg.scales2[5]
if scaleData then
scale=scale*scaleData[1]
widget:SetChildLocalPos(_level_index.model,scaleData[2],scaleData[3],0)
end
local cmps=cfg.model[2]
widget:SetChildUIModelShowTarget(_level_index.model,model,scale,cmps,eAnimationID.stand)
else

comHelper.setChildModelRawImage_monsterGroup(widget,cfg.mon_ids[1][1],_level_index.head_icon,0,eHeadCenterType.eHead)
end

widget:SetChildButtonClickWithID(-1,self.on_level_click,id)
end

function UIHuanJingDayChallengeWin:setReward(data,rewardScrollView,rewardBox,rewardBoxReddot)
local id=data.param_1
local flag=data.param_2
local reward_flag=_this.data.levelDict[id].param_3
local cfg=cfgHelper.get1(cfg_guanqianewconfig_get,id)
local rwList=_this:getRewards(cfg.daily_reward)
local len=#rwList
local rewardReddot=flag==1 and reward_flag==0
local clickFunc
if rewardReddot then
clickFunc=function()
socketManager:send_25_13(1,{id})
end
end
rewardScrollView:setChildScrollViewCreateGrids(len,math.min(len,3))
local grids=rewardScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local reward=rwList[i]
local itemCfg=itemsConfig.getConfig(reward[1])
widgetHelper.setNormalRewardItem(item,0,{reward[1],reward[2],stage=itemCfg.stage,showGrayImage=reward_flag==1,clickFunc=clickFunc})
item:SetChildActive(1,reward_flag==1)
end
rewardBox:setSprite(ab,reward_flag==0 and'image_tiaozhanjiangli_1'or'image_tiaozhanjiangli_2')
_this.winlua:SetChildButtonClickWithID(rewardBox:getID(),self.on_reward_click,id,true,100)

rewardBoxReddot:setActive(rewardReddot)
if rewardReddot then
local tweener=self.winlua:SetChildDOPunchRotation(rewardBoxReddot:getID(),Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
end
end

function UIHuanJingDayChallengeWin:getRewards(drops)
local level=zongmenModel:getLevel()
local rewardList=itemsAwardConfig:getAwardInConfigByLevel(drops,level)
return rewardList.showItems
end

function UIHuanJingDayChallengeWin:getJingJie(level)
local n,p,pN=UIDiscipleModel:getJJNameX(level)
local jj_str
if p~=nil then
jj_str=FMT.fmt('境界：{0}{1}',n,pN)
else
jj_str=FMT.fmt('境界：{0}',n)
end
return jj_str
end

function UIHuanJingDayChallengeWin.on_reward_click(id)
local flag=_this.data.levelDict[id].param_2
local reward_flag=_this.data.levelDict[id].param_3
if flag~=1 then
UIManager.info('挑战成功可领取')
return
end
if reward_flag~=0 then
UIManager.info('奖励已领取')
return
end
socketManager:send_25_13(1,{id})
end

function UIHuanJingDayChallengeWin.on_level_click(id)
local falg=_this.data.levelDict[id].param_2
if falg==1 then
UIManager.info('已通关该挑战')
return
end
local isUnlock,tips=UIHuanJingControl:checkAndGetUnlockArgs(id)
if isUnlock then
return UIHuanJingControl:openFighting(id,1)
end

local cfg=cfgHelper.get1(cfg_guanqianewconfig_get,id)
local mId=cfg.mon_ids[1][1]
local mcfg=cfgHelper.get1(cfg_monstergroup_get,mId)
local skills=mcfg.showSkills
local rwList=_this:getRewards(cfg.daily_reward)
local title='每日挑战'

local args={
groupId=mId,
title=title,
title2='挑战奖励',
name=mcfg.name,
level='',
skills=skills,
rewards=rwList,
desc=mcfg.desc,
active_bg_click=true,
}

local fazelist={}
fazelist[1]=_this.faZeData[1]
for i,v in ipairs(cfg.fazelist)do
fazelist[#fazelist+1]=v
end
args.challenge_tips=tips

UIManager:showWindow('UIMonsterInfoWin',args)
end

function UIHuanJingDayChallengeWin:showFaZeList()
local len=self.faZeData and#self.faZeData or 0
self.faZeList:setChildScrollViewCreateGrids(len,0)
self.grids=self.faZeList:getChildScrollViewItemWidgets()
local count=self.grids.Count
for i=1,count do
local item=self.grids[i-1]
local id=self.faZeData[i]
local cfg=cfgHelper.getSSlawRule(id)
item:SetChildText(0,cfg.desc)
item:SetChildIcon(1,cfg.image,true)
end
end




function UIHuanJingDayChallengeWin:onCloseClick()
UIHuanJingControl:closeUI(true,true)
end