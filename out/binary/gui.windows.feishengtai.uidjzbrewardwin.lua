







def_class("UIDJZBRewardWin",UIWindowBase)









function UIDJZBRewardWin:bindComponents()

self.btnClose=UIButton.get(self,0)
self.bgmodel=UIObject.get(self,1)
self.desc1=UIText.get(self,2)
self.desc2=UIText.get(self,3)
self.desc3=UIText.get(self,4)
self.desc4=UIText.get(self,5)
self.layout1=UIObject.get(self,6)
self.layout2=UIObject.get(self,7)
self.leftArrow=UIButton.get(self,8)
self.leftArrowImg=UIObject.get(self,9)
self.rightArrow=UIButton.get(self,10)
self.rightArrowImg=UIObject.get(self,11)
self.bgmodelb=UIObject.get(self,12)
self.root=UIObject.get(self,13)
self.npcModel=UIObject.get(self,14)
self.speakObj=UIObject.get(self,15)
self.speakText=UIText.get(self,16)
self.npcClicker=UIButton.get(self,17)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.leftArrow:setButtonClick(function()self:onLeftArrow()end)

self.rightArrow:setButtonClick(function()self:onRightArrow()end)

self.npcClicker:setButtonClick(function()self:onNpcClicker()end)



end


function UIDJZBRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.bgmodel);self.bgmodel=nil;
_UIObject_release(self.desc1);self.desc1=nil;
_UIObject_release(self.desc2);self.desc2=nil;
_UIObject_release(self.desc3);self.desc3=nil;
_UIObject_release(self.desc4);self.desc4=nil;
_UIObject_release(self.layout1);self.layout1=nil;
_UIObject_release(self.layout2);self.layout2=nil;
_UIObject_release(self.leftArrow);self.leftArrow=nil;
_UIObject_release(self.leftArrowImg);self.leftArrowImg=nil;
_UIObject_release(self.rightArrow);self.rightArrow=nil;
_UIObject_release(self.rightArrowImg);self.rightArrowImg=nil;
_UIObject_release(self.bgmodelb);self.bgmodelb=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.npcClicker);self.npcClicker=nil;
end
















local _this
local buildelement=
{
[84]=2,
[85]=4,
[86]=5,
[82]=1,
[83]=3,
}
local buildstate=
{
weidoing=0,
doing=1,
finish=2
}
local _titems=
{
baseitem=1,
selfitem=2,
gotflag=3,
hasflag=4,
}
local alldjjz={82,83,84,85,86}



function UIDJZBRewardWin:onLoaded(...)
self:bindComponents()
_this=self
self.root:setChildCanvasGroupAlpha(0)
self.bgmodel:setChildUIModelShowTarget(5498,1,nil,eAnimationID.enter)
self.bgmodelb:setChildUIModelShowTarget(5499,1,nil,eAnimationID.enter)
end


function UIDJZBRewardWin:__delete()
self:unbindComponents()
end




function UIDJZBRewardWin:onShow(argtable,afterOnloaded)
self.sfId=zongmenModel:getMountainId()
self.buildid=argtable.buildid
self.nowelement=1

_this:delayDo(0.2,function()
if _this==nil then return end
_this.winlua:SetChildCanvasGroupDOFade(_this.root:getID(),1,0.4)
end)


self:refreshjzData()
self:refreshRewardPanel()
self:checkAndShowArrowBtn()

local cfg_npcmodelid=2113025
_this.npcModel:setChildUIModelShowTarget(cfg_npcmodelid,0.6,{},eAnimationID.stand,false,true)

self:doSpeaking_player()
end

function UIDJZBRewardWin:onHide()

end

function UIDJZBRewardWin:refreshjzData()
local templist={}
for k,v in ipairs(alldjjz)do
local temp=
{
stage=0,
jzid=v,
jzdata=nil,
model=1,
isfinish=false
}
templist[v]=temp
end

for k,SLG_type in ipairs(alldjjz)do
local bdDatas=zongmenModel:getBuildingDataByBdType(self.sfId,SLG_type)
if bdDatas and bdDatas[1]then
local v=bdDatas[1]
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
if v.flag>10 then
local temp=
{
stage=1,
jzid=cfg.build_type,
jzdata=v,
model=2,
isfinish=false
}
templist[cfg.build_type]=temp
else
local temp=
{
stage=2,
jzid=cfg.build_type,
jzdata=v,
model=2,
isfinish=true
}
templist[cfg.build_type]=temp
end
end
end


for k,v in pairs(templist)do
local _stage=v.stage
local _jzid=v.jzid
if _stage==buildstate.weidoing then
local _data=isometricMapSystem:getRepairDataByID(self.sfId,_jzid)
local temp=
{
stage=0,
jzid=_jzid,
jzdata=_data,
model=1,
isfinish=false
}
templist[k]=temp
end
end
self.allZhenWudata=templist

end

function UIDJZBRewardWin:refreshRewardPanel()
local djcfg=cfg_dujietreasuresconfig_get(self.buildid)
local cfg_stage_reward=djcfg.stage_reward
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,self.buildid)
local name=cfg.name
local str1=FMT.fmt("完成【{0}】",name)
local str2="修筑阶段<color=#f1ce78>至宝粗胚</color>可领取"
local str3="修筑阶段<color=#f1ce78>至宝精炼</color>可领取"
self.desc1:setText(str1)
self.desc2:setText(str2)
self.desc3:setText(str1)
self.desc4:setText(str3)


local oneflag=1
local twoflag=1
local builddata=self.allZhenWudata[self.buildid]
local severdatas=DuJieZhiBaoModel:getDJZBData()
local severdata=severdatas[self.buildid]

local refine_rate
if severdata and severdata.refine_rate then
refine_rate=severdata.refine_rate
end
local reward_flag
local bitflag_one=false
local bitflag_two=false
if severdata and severdata.reward_flag then
reward_flag=severdata.reward_flag
bitflag_one=bitHelper.check_pos(reward_flag,0)
bitflag_two=bitHelper.check_pos(reward_flag,1)
end

local _stage=builddata.stage
if _stage==buildstate.weidoing then
oneflag=1
twoflag=1
else
local flag=builddata.jzdata.flag
if flag>10 then
if flag>11 and flag<=21 then
if bitflag_one then
oneflag=3
else
oneflag=2
end
elseif flag>21 then
if bitflag_one then
oneflag=3
else
oneflag=2
end
if bitflag_two then
twoflag=3
else
twoflag=2
end
end
else

if refine_rate then
if bitflag_one then
oneflag=3
else
oneflag=2
end
if bitflag_two then
twoflag=3
else
twoflag=2
end
end
end
end




local grids=self.layout1:getChildCommonLayoutGroupWidgetList()
local oneReward=cfg_stage_reward[1]
for i=1,grids.Count do
local widget=grids[i-1]
local reward=oneReward[i]
if reward then
widget:SetChildActive(1,true)
local itemid=reward[1]
local count=reward[2]

widget:SetChildActive(2,false)
widget:SetChildActive(3,false)
if oneflag==2 then
widget:SetChildActive(3,true)
elseif oneflag==3 then
widget:SetChildActive(2,true)
end
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
if _this==nil then return end
_this:onClickItemitem(itemid,1,oneflag)
end)
else
widget:SetChildActive(1,false)
end
end


local grids2=self.layout2:getChildCommonLayoutGroupWidgetList()
local oneReward2=cfg_stage_reward[2]
for i=1,grids2.Count do
local widget2=grids2[i-1]
local reward2=oneReward2[i]
if reward2 then
widget2:SetChildActive(1,true)
local itemid=reward2[1]
local count=reward2[2]

widget2:SetChildActive(2,false)
widget2:SetChildActive(3,false)
if twoflag==2 then
widget2:SetChildActive(3,true)
elseif twoflag==3 then
widget2:SetChildActive(2,true)
end
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget2:SetChildActive(-1,true)
widget2:SetChildPropData(0,prop)
widget2:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItemitem(itemid,2,twoflag)
end)
else
widget2:SetChildActive(1,false)
end
end
end

function UIDJZBRewardWin:onClickItemitem(itemId,reward_idx,flag)

if flag==2 then
DuJieZhiBaoController:send_34_34(_this.buildid,reward_idx)
else
if itemId then
tipsManager.showTips({itemid=itemId,itemguid=nil,showModel=true})
end
end
end

function UIDJZBRewardWin:checkAndShowArrowBtn()
self.leftArrow:setActive(false)
self.rightArrow:setActive(false)



















end

function UIDJZBRewardWin:refreshGetReward(buildid)
if _this.buildid==buildid then
UIManager.info("领取成功")
_this:refreshRewardPanel()
end
end



function UIDJZBRewardWin:onBtnClose()
self:closeSelf()
end
function UIDJZBRewardWin:onLeftArrow()

if self.allZhenWudata then
local thisbuild=self.buildid
local lastidx
local lastbuid
local maxlength=#alldjjz
for k,v in ipairs(alldjjz)do
if v==thisbuild then
lastidx=k-1
end
end
if lastidx then
if lastidx<1 then
lastidx=maxlength
end
lastbuid=alldjjz[lastidx]
end
if lastbuid then
self.buildid=lastbuid
self.nowelement=buildelement[lastbuid]or 1
self:refreshRewardPanel()
self:doSpeaking_player()
end
end
end
function UIDJZBRewardWin:onRightArrow()
if self.allZhenWudata then
local thisbuild=self.buildid
local nexidx
local nexbuid
local maxlength=#alldjjz
for k,v in ipairs(alldjjz)do
if v==thisbuild then
nexidx=k+1
end
end

if nexidx then
if nexidx>maxlength then
nexidx=nexidx-maxlength
end
nexbuid=alldjjz[nexidx]
end
if nexbuid then
self.buildid=nexbuid
self.nowelement=buildelement[nexbuid]or 1
self:refreshRewardPanel()
self:doSpeaking_player()
end
end
end


function UIDJZBRewardWin:doSpeaking_player()
local buildid=_this.buildid
local cfg=cfg_dujietreasuresconfig_get(buildid).speaks
local speakList=cfg
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]

local speed=30
_this.speakObj:setChildCanvasGroupAlpha(1)
_this.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
_this:doTalkAnim_player()
end

function UIDJZBRewardWin:doTalkAnim_player()
if _this.talkTween2~=nil then
_this.talkTween2:Kill()
_this.talkTween2=nil
end
_this.speakObj:setScale(Vector3.zero)
_this:delayDo(0.2,function()
_this.speakObj:setChildCanvasGroupAlpha(1)
_this.talkTween2=_this.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween2=nil
_this.talkTween2=_this.speakObj:setChildDOScale(0.9,0.1,function()
if _this==nil then return end
_this.talkTween2=nil
return _this:talkEnd()
end)
end)
end)
end
function UIDJZBRewardWin:talkEnd()
if _this.speakShowTimer then
_this:stopTimerByID(_this.speakShowTimer)
_this.speakShowTimer=nil
end
_this.speakShowTimer=_this:delayDo(8,function()

if _this==nil then return end
_this.speakObj:setScale(Vector3.zero)
_this.speakObj:setChildCanvasGroupAlpha(0)
if _this.speakShowTimer then
_this:stopTimerByID(_this.speakShowTimer)
_this.speakShowTimer=nil
end
end)
end
