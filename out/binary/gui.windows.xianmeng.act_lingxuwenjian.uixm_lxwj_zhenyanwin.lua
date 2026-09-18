







def_class("UIXM_LXWJ_zhenyanWin",UIWindowBase)









function UIXM_LXWJ_zhenyanWin:bindComponents()

self.root=UIObject.get(self,0)
self.lineGridPanel=UIObject.get(self,1)
self.zyGridPanel=UIObject.get(self,2)
self.leftPanel=UIObject.get(self,3)
self.bottomPanel=UIObject.get(self,4)
self.infoPanel=UIObject.get(self,5)
self.closeBtn=UIButton.get(self,6)
self.scoreRanktBtn=UIButton.get(self,7)
self.notestBtn=UIButton.get(self,8)
self.defBtn=UIButton.get(self,9)
self.attackNumObj=UIObject.get(self,10)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.scoreRanktBtn:setButtonClick(function()self:onScoreRanktBtn()end)

self.notestBtn:setButtonClick(function()self:onNotestBtn()end)

self.defBtn:setButtonClick(function()self:onDefBtn()end)



end


function UIXM_LXWJ_zhenyanWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.lineGridPanel);self.lineGridPanel=nil;
_UIObject_release(self.zyGridPanel);self.zyGridPanel=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.bottomPanel);self.bottomPanel=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.scoreRanktBtn);self.scoreRanktBtn=nil;
_UIObject_release(self.notestBtn);self.notestBtn=nil;
_UIObject_release(self.defBtn);self.defBtn=nil;
_UIObject_release(self.attackNumObj);self.attackNumObj=nil;
end
















local _this=nil
local lineEffectLookup={
[1]=10353,
[2]=10354,
[3]=10355,
[4]=10354,
[5]=10353,
[6]=10354,
[7]=10355,
[8]=10354,
}
local ZhenYanGuide={
[1]=3577,
[2]=3578,
[3]=3579,
[4]=3580,
[5]=3581,
[6]=3582,
[7]=3583,
[8]=3584,
}


function UIXM_LXWJ_zhenyanWin:onLoaded(...)
_this=self
self:bindComponents()
self.zhenyanSpines={}
self.zhenyanProgressTweeners={}
self.m_cav=self:getChildCanvas(-1)
end


function UIXM_LXWJ_zhenyanWin:__delete()
_this=nil
self:clearLineEffect()
self:unbindComponents()
UIManager:closeWindow('UIXM_LXWJ_posInfoWin')
UIManager:invokeUIMethod('UIXM_LXWJ_memberTwoWin','onClickClose')

end


function UIXM_LXWJ_zhenyanWin:onHide()

end




function UIXM_LXWJ_zhenyanWin:onShow(argtable,afterOnloaded)





self.posData=argtable.posData
if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
self:refreshTime()
end)
end
self:refreshTime()
self:refreshInfo()
self:initFaZhen()


local checkJump=false
local checkShowGuide=true
if self.posData[3]~=nil then
local extraParams={openReplay=self.posData.openReplay}
local flag=self:onZhenYanClick(self.posData[3],extraParams)
if flag then
checkJump=true
end
self.posData[3]=nil
self.posData.openReplay=nil
checkShowGuide=false
end
if not checkJump then
lingxuwenjianController:doCloseCloud()
end
if checkShowGuide then
local zyData_my=lingxuwenjianModel:getMyPosData2(playerModel:getActorID())
local raceState=lingxuwenjianModel:getLunState()
if not zyData_my and raceState==eLXWJ_State.eStandby then
local id=lingxuwenjianModel:fingEmptyZhenYanID(self.posData[2])
if id then
local weakguideid=ZhenYanGuide[id]
if weakguideid then
weakGuideController:beginGuide(weakguideid)
end
end
end
end
end

function UIXM_LXWJ_zhenyanWin:refreshTime()
local raceState,left=lingxuwenjianModel:getLunState()
local raceState_old=self.raceState
self.raceState=raceState
if self.raceState~=raceState_old then
self:refreshAttackNum()
self:refreshDefBtn()

if raceState_old~=nil then
if self.raceState==eLXWJ_State.eFight then
self:refreshAllZhenYan()
end
end
end
end

function UIXM_LXWJ_zhenyanWin:refreshAttackNum()
local isshow=self.raceState==eLXWJ_State.eFight and lingxuwenjianModel:hasEnemy()
self.attackNumObj:setActive(isshow)
if isshow then
local widget=self.attackNumObj:getWidgetBase()
local max=lingxuwenjianModel:getMaxAttackTimes()
local cur=lingxuwenjianModel:getAttackTimes()or 0
local lerp=max-cur
widget:SetChildLayoutGroupCreateItems(0,max,function(i)
if _this==nil then return end
local item=widget:GetChildLayoutGroupGridItem(0,i-1)
local has=i<=lerp
local icon=has==true and'icon_xmgjian_1'or'icon_xmgjian_2'
item:SetChildCSImageSprite(-1,globalABLookup.lingxuwenjianicons,icon)
end)
end
end

function UIXM_LXWJ_zhenyanWin:refreshDefBtn()
local isshow=self.raceState~=eLXWJ_State.eFight
self.defBtn:setActive(isshow)
end

function UIXM_LXWJ_zhenyanWin:refreshInfo()
local pos=self.posData
local widget=self.infoPanel:getWidgetBase()

local cfg=cfgHelper.get1(cfg_lingxuwenjianfazhenconfig_get,pos[2])
widget:SetChildText(0,cfg.name)

local desc_str=pos[1]==0 and cfg.desc1 or cfg.desc2
widget:SetChildText(1,desc_str)

local rate,lv
if pos[1]==0 then
local curman,maxman=lingxuwenjianModel:getMyFaZhenManNum(pos[2])
if self.raceState==eLXWJ_State.eStandby then
if curman>0 then
rate=10000
else
rate=0
end
lv=curman
else
rate,lv=lingxuwenjianModel:getMyFaZhenBlood(pos[2])
end
else
rate,lv=lingxuwenjianModel:getEnemyFaZhenBlood(pos[2])
end
rate=mathHelper.decimal(rate/100,1)
local blood_str=FMT.fmt('法阵总血量：{0}%',rate)
widget:SetChildText(2,blood_str)

local buff
if lv>0 then
buff=cfg.faze[1][lv]
end
local buff_desc
local buffIcon
if pos[2]==1 then
buffIcon='icon_xmzbeizhan_3'
elseif pos[2]==2 then
buffIcon='icon_xmzbeizhan_4'
else
buffIcon='icon_xmzbeizhan_5'
end
if buff then
buff_desc=mysteryEnvironmentEffectModel.getRuleDesc(buff[1],buff[2])
else
buff_desc='无效果加成'
end
widget:SetChildText(3,buff_desc)
widget:SetChildCSImageSprite(4,globalABLookup.lingxuwenjianicons,buffIcon)
end

function UIXM_LXWJ_zhenyanWin:initFaZhen()
local pos=self.posData
local fzGridWidget=self.zyGridPanel:getWidgetBase()

local fzWidget=fzGridWidget:GetChildWidgetBase(0)
fzWidget:SetChildButtonClick(1,function()
if _this==nil then return end
_this:onFaZhenClick()
end)

local name=cfgHelper.get2(cfg_lingxuwenjianfazhenconfig_get,pos[2],'name')
fzWidget:SetChildText(2,name)
fzWidget:SetChildCanvas(3,self.m_cav[1],self.m_cav[2]+3)

for i=0,8 do
local widget=fzGridWidget:GetChildWidgetBase(i)
if i>0 then
self:initZhenYan(widget,i)
end
self:refreshZhenYan(widget,i)
end
end

function UIXM_LXWJ_zhenyanWin:initZhenYan(widget,idx)
widget:SetChildButtonClick(1,function()
if _this==nil then return end
_this:onZhenYanClick(idx)
end)
widget:SetChildCanvas(8,self.m_cav[1],self.m_cav[2]+3)
end

function UIXM_LXWJ_zhenyanWin:refreshAllZhenYan()
local fzGridWidget=self.zyGridPanel:getWidgetBase()
for i=1,8 do
local widget=fzGridWidget:GetChildWidgetBase(i)
self:refreshZhenYan(widget,i)
end
end

function UIXM_LXWJ_zhenyanWin:refreshZhenYan(widget,idx,anim)
if widget==nil then
local fzWidget=self.zyGridPanel:getWidgetBase()
widget=fzWidget:GetChildWidgetBase(idx)
end

local pos=self.posData
if idx==0 then

local curman
if pos[1]==0 then
curman=lingxuwenjianModel:getMyFaZhenManNum(pos[2])
else
curman=lingxuwenjianModel:getEnemyFaZhenManNum(pos[2])
end
local rate=lingxuwenjianModel:getFaZhenBloodRate(pos[1],pos[2],curman,self.raceState)

local spineID=lingxuwenjianModel:getFaZhenSpine(pos[1],pos[2])
local animState=lingxuwenjianModel:checkFaZhenAnim(rate,self.raceState)
if self.zhenyanSpines[idx]==nil then
self.zhenyanSpines[idx]={spineID,animState}
local anim_=lingxuwenjianModel:getFaZhenAnimChange(nil,animState)
widget:SetChildUIModelShowTarget(0,spineID,1,{},anim_,false,false,0,nil)
else
local old_animState=self.zhenyanSpines[idx][2]
if animState~=old_animState then
self.zhenyanSpines[idx][2]=animState
local anim_=lingxuwenjianModel:getFaZhenAnimChange(old_animState,animState)
widget:SetChildModelAnimationState(0,anim_)
end
end
else

local zyData
if pos[1]==0 then
zyData=lingxuwenjianModel:getMyPosData(pos[2],idx)
else
zyData=lingxuwenjianModel:getEnemyPosData(pos[2],idx)
end
local hasman=zyData~=nil
local blood=nil
if hasman then
blood=zyData.blood
end

local spineID=lingxuwenjianModel:getZhenYanSpine(pos[1],pos[2])
local animState=lingxuwenjianModel:checkZhenYanAnim(hasman,blood,self.raceState)
if self.zhenyanSpines[idx]==nil then
self.zhenyanSpines[idx]={spineID,animState}
local anim_=lingxuwenjianModel:getZhenYanAnimChange(nil,animState)

local old_animState=lingxuwenjianModel:getChangeAnimationData(idx,pos[2],pos[1])
if animState==3 and old_animState~=3 and hasman then
anim_=2154
lingxuwenjianModel:setChangeAnimationData(idx,animState,pos[2],pos[1])
widget:SetChildShowEffect(11,10502,true)
elseif animState==4 and old_animState~=4 and hasman then
anim_=2155
lingxuwenjianModel:setChangeAnimationData(idx,animState,pos[2],pos[1])
widget:SetChildShowEffect(11,10502,true)
end
widget:SetChildUIModelShowTarget(0,spineID,1,{},anim_,false,false,0,nil)
else
if _this==nil then return end
local old_animState=self.zhenyanSpines[idx][2]
if animState~=old_animState then
self.zhenyanSpines[idx][2]=animState
local anim_=lingxuwenjianModel:getZhenYanAnimChange(old_animState,animState)

local old_animState=lingxuwenjianModel:getChangeAnimationData(idx,pos[2],pos[1])

if animState==3 and old_animState~=3 then
anim_=2154
lingxuwenjianModel:setChangeAnimationData(idx,animState,pos[2],pos[1])
widget:SetChildShowEffect(11,10502,true)
elseif animState==4 and old_animState~=4 then
anim_=2155
lingxuwenjianModel:setChangeAnimationData(idx,animState,pos[2],pos[1])
widget:SetChildShowEffect(11,10502,true)
end
widget:SetChildModelAnimationState(0,anim_)
end
end

local showAdd=not hasman
widget:SetChildActive(2,showAdd)
if showAdd then

local showAddIcon=pos[1]==0 and self.raceState==eLXWJ_State.eStandby
widget:SetChildActive(10,showAddIcon)
end

local showMan=hasman
widget:SetChildActive(3,showMan)
if showMan then

local headParams={iconInfo=zyData.iconInfo,scale=0.5}
playerController:setHeadIcon(widget,4,headParams)

widget:SetChildText(5,mathHelper.formatNumber3(zyData.fightvalue_num))
widget:SetChildActive(12,zyData.actorid==playerModel:getActorID())
end

local showEffect=showMan
widget:SetChildShowEffect(9,10356,showEffect)

local rate=0
if self.raceState==eLXWJ_State.eStandby then
if hasman then
rate=1
else
rate=0
end
else
if lingxuwenjianModel:hasEnemy()and blood~=nil then
if hasman then
rate=blood/10000
else
rate=0
end
else
if hasman then
rate=1
else
rate=0
end
end
end
if self.zhenyanProgressTweeners[idx]~=nil then
if not self.zhenyanProgressTweeners[idx]:IsComplete()then
self.zhenyanProgressTweeners[idx]:OnComplete(nil)
self.zhenyanProgressTweeners[idx]:Complete()
end
self.zhenyanProgressTweeners[idx]=nil
end
local progressIndex=pos[1]==0 and 6 or 7
widget:SetChildActive(6,pos[1]==0)
widget:SetChildActive(7,pos[1]~=0)
if anim then
local speed=1
local old_rate=widget:GetChildIconFillAmount(progressIndex)
self.zhenyanProgressTweeners[idx]=widget:SetChildImageDOFillAmount(progressIndex,rate,math.abs(rate-old_rate)*speed,function()
if _this==nil then return end
_this.zhenyanProgressTweeners[idx]=nil
end)
else
widget:SetChildIconFillAmount(progressIndex,rate)
end

local lineGridWidget=self.lineGridPanel:getWidgetBase()
local effectid=lineEffectLookup[idx]
local showLine=false
if hasman then
if blood==nil or blood>0 then
showLine=true
end
end
lineGridWidget:SetChildShowEffect(idx-1,effectid,showLine)
end
end

function UIXM_LXWJ_zhenyanWin:clearLineEffect()
local lineGridWidget=self.lineGridPanel:getWidgetBase()
for i=1,8 do
local effectid=lineEffectLookup[i]
lineGridWidget:SetChildShowEffect(i-1,effectid,false)
end
end

function UIXM_LXWJ_zhenyanWin:onFaZhenClick()

end

function UIXM_LXWJ_zhenyanWin:onZhenYanClick(idx,extraParams)
local showExtra=false
local pos=self.posData
local zyData=nil
if pos[1]==0 then

zyData=lingxuwenjianModel:getMyPosData(pos[2],idx)
if zyData~=nil then

local params={}
params.server_id=playerModel:getActorServerID()
params.actorid=zyData.actorid
params.lxwjteamtype=1
params.posData={pos[1],pos[2],idx}
params.extraParams=extraParams
lingxuwenjianController:openBattleWin(params)
showExtra=extraParams~=nil
else

if self.raceState==eLXWJ_State.eStandby then
if lingxuwenjianModel:isLeader()then
lingxuwenjianController:openMemberList(2,{fzid=pos[2],zyid=idx})
else
local actorid_my=playerModel:getActorID()
local zyData_my=lingxuwenjianModel:getMyPosData2(actorid_my)
local content
local cb
if zyData_my~=nil then

content='您已有防守阵眼，是否将其更换到当前阵眼进行防守？'
cb=function()
local zyData_=lingxuwenjianModel:getMyPosData(pos[2],idx)
if zyData_~=nil then
UIManager.error('祖师来晚了，该阵眼已有防守成员')
return
end
local list={}
list[1]={zyData_my.lxwjtype,zyData_my.lxwjkey,int64.new('0')}
list[2]={pos[2],idx,actorid_my}
lingxuwenjianController:reqSetup(list)
end
else

content='是否进驻此阵眼防守？'
cb=function()
local zyData_=lingxuwenjianModel:getMyPosData(pos[2],idx)
if zyData_~=nil then
UIManager.error('祖师来晚了，该阵眼已有防守成员')
return
end
local list={}
list[1]={pos[2],idx,actorid_my}
lingxuwenjianController:reqSetup(list)
end
end
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=cb,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end
else
UIManager.error('该阵眼无人镇守')
end
end
else

zyData=lingxuwenjianModel:getEnemyPosData(pos[2],idx)
if zyData~=nil then
local enemyData=lingxuwenjianModel:getEnemyData()
local params={}
params.server_id=enemyData.enemyserverid
params.actorid=zyData.actorid
params.lxwjteamtype=1
params.posData={pos[1],pos[2],idx}
params.extraParams=extraParams
lingxuwenjianController:openBattleWin(params)
showExtra=extraParams~=nil
else
UIManager.error('该阵眼无人镇守')
end
end
return showExtra
end

function UIXM_LXWJ_zhenyanWin:onCloseBtn()
self:closeSelf()
end

function UIXM_LXWJ_zhenyanWin:onScoreRanktBtn()
lingxuwenjianController:openScoreWin()
end

function UIXM_LXWJ_zhenyanWin:onNotestBtn()
UIManager:showWindow('UIXM_LXWJ_notesWin')
end

function UIXM_LXWJ_zhenyanWin:onDefBtn()
if self.raceState==eLXWJ_State.eFight then
UIManager.error('决战阶段不能设置防守阵容')
return
end

local pos=self.posData
lingxuwenjianController.setupDefTeams(1,nil,{openPos={pos[1],pos[2]}})
end

function UIXM_LXWJ_zhenyanWin:rec_enemy()
self:refreshAttackNum()
end

function UIXM_LXWJ_zhenyanWin:rec_fazhen(src,idx)
local pos=self.posData
if pos[1]==src and pos[2]==idx then
self:refreshZhenYan(nil,0,true)
self:refreshInfo()
end
end

function UIXM_LXWJ_zhenyanWin:rec_zhenyan(src,idx,zy_idx)
local pos=self.posData
if pos[1]==src and pos[2]==idx then
self:refreshZhenYan(nil,zy_idx,true)
end
end

function UIXM_LXWJ_zhenyanWin:rec_over()
UIManager:closeWindow('UIXM_LXWJ_posInfoWin')
UIManager:invokeUIMethod('UIXM_LXWJ_memberTwoWin','onClickClose')
end
