







def_class("UIWanBaoXunBaoDui_MiJinWin",UIWindowBase)









function UIWanBaoXunBaoDui_MiJinWin:bindComponents()

self.rewardContent=UIObject.get(self,0)
self.rewardlist=UIScrollView.get(self,1)
self.conditionContent=UIObject.get(self,2)
self.rewardroot=UIObject.get(self,3)
self.receivebtn=UIButton.get(self,4)
self.notip=UIText.get(self,5)
self.countdown=UIText.get(self,6)
self.advContent=UIObject.get(self,7)
self.leftroot=UIObject.get(self,8)
self.rightroot=UIObject.get(self,9)
self.Root=UIObject.get(self,10)
self.closebtn=UIButton.get(self,11)
self.frightxt=UIText.get(self,12)
self.progressbar=UIProgress.get(self,13)
self.skillList=UIObject.get(self,14)
self.tipspanel=UIObject.get(self,15)
self.mijintitle=UIText.get(self,16)
self.baotubtn=UIButton.get(self,17)
self.rijibtn=UIButton.get(self,18)
self.rijireddot=UIObject.get(self,19)
self.mask=UIButton.get(self,20)
self.bgspine=UIObject.get(self,21)

self.receivebtn:setButtonClick(function()self:onReceivebtn()end)

self.closebtn:setButtonClick(function()self:onClosebtn()end)

self.baotubtn:setButtonClick(function()self:onBaotubtn()end)

self.rijibtn:setButtonClick(function()self:onRijibtn()end)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIWanBaoXunBaoDui_MiJinWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardlist);self.rewardlist=nil;
_UIObject_release(self.conditionContent);self.conditionContent=nil;
_UIObject_release(self.rewardroot);self.rewardroot=nil;
_UIObject_release(self.receivebtn);self.receivebtn=nil;
_UIObject_release(self.notip);self.notip=nil;
_UIObject_release(self.countdown);self.countdown=nil;
_UIObject_release(self.advContent);self.advContent=nil;
_UIObject_release(self.leftroot);self.leftroot=nil;
_UIObject_release(self.rightroot);self.rightroot=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.closebtn);self.closebtn=nil;
_UIObject_release(self.frightxt);self.frightxt=nil;
_UIObject_release(self.progressbar);self.progressbar=nil;
_UIObject_release(self.skillList);self.skillList=nil;
_UIObject_release(self.tipspanel);self.tipspanel=nil;
_UIObject_release(self.mijintitle);self.mijintitle=nil;
_UIObject_release(self.baotubtn);self.baotubtn=nil;
_UIObject_release(self.rijibtn);self.rijibtn=nil;
_UIObject_release(self.rijireddot);self.rijireddot=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.bgspine);self.bgspine=nil;
end

















local _this
local abname="ui/windows/wanbaoxunbaodui/wanbaoxunbaodui_atlas_pak.ab"
local maxOpenNum=3


function UIWanBaoXunBaoDui_MiJinWin:onLoaded(...)
_this=self
self:bindComponents()
self.mjSelectidx=1
self.rewardlist:setClickAction(itemsComponentHelper.onItemClick)
self.advpoints={}
end


function UIWanBaoXunBaoDui_MiJinWin:__delete()
self:unbindComponents()
_this=nil
end




function UIWanBaoXunBaoDui_MiJinWin:onShow(argtable,afterOnloaded)
if argtable then
_this.getmijiid=argtable[1]
end
self.Root:setChildCanvasGroupAlpha(0)
self:freshLeftPart()
self:freshRightPart()
self.bgspine:setChildSpineAnimation(eAnimationID.enter,1,nil)
self:delayDo(0.3,function()
self.Root:setChildCanvasGroupDOFade(1,0.2,nil)
end)
self:refreshrijireddot()
end


function UIWanBaoXunBaoDui_MiJinWin:onHide()

end


function UIWanBaoXunBaoDui_MiJinWin:refreshrijireddot()
local reddot=wanBaoXunBaoDuiController:checkCatMijinReddot()
self.rijireddot:setActive(reddot)
end


function UIWanBaoXunBaoDui_MiJinWin:getAdvPoints()
local severdata=MysteryModel:getWanBaoXunBaoDuiData()

local severlist={}
if severdata and#severdata>0 then
for k,v in ipairs(severdata)do
severlist[v.ssId]=v
end
end
local cfg_mj=cfg_catcatmijingbaseconfig_get(1).ptMiJing
local list={}
local num=MysteryModel:getWanBaoXunBaoDuiTXNum()
local tempnum=0
for k,v in ipairs(cfg_mj)do
local mj_idx=v
local cfg_mj=cfg_catcatmijingconfig_get(mj_idx)
local mj_id=cfg_mj.id
local mj_sever_data=severlist[mj_id]
if mj_sever_data then

local sever_jindu=0
local sever_ismj=0
if mj_sever_data then
sever_jindu=mj_sever_data.percent
sever_ismj=mj_sever_data.closeFlag
end
if sever_jindu<100 or sever_ismj==0 then
table.insert(list,v)
tempnum=tempnum+1
end
else

local isopen=true
local openLimit=cfg_mj.openLimit

if openLimit[1]then
local day_=timeHelper.getServerOpenDay()
if day_<openLimit[1]then
isopen=false
end
end

if openLimit[2]then
local level=zongmenModel:getLevel()
if level<openLimit[2]then
isopen=false
end
end

if openLimit[3]then
local oldVal=playerModel:getActorFightValue()
if oldVal<openLimit[3]then
isopen=false
end
end
if isopen then
table.insert(list,v)
tempnum=tempnum+1
end
end
if tempnum>=maxOpenNum then
break
end
end


local newlist={}

local mijindata=userActorSetting.get('UIWanBaoXunBaoDui_MiJinTipsWin_openMiJin',{})
for k,v in ipairs(mijindata)do
for i,j in ipairs(list)do
if v==j then
newlist[#newlist+1]=j
end
end
end

return newlist
end


function UIWanBaoXunBaoDui_MiJinWin:freshLeftPart()
_this.advpoints=self:getAdvPoints()
if#_this.advpoints>0 then
for k,v in ipairs(_this.advpoints)do
local mjidx=_this.advpoints[k]
if _this.getmijiid then
if _this.getmijiid==mjidx then
_this.mjSelectidx=k
end
end
end
self.advContent:setChildLayoutGroupCreateItems(#_this.advpoints,function(index)
local item=self.advContent:getChildLayoutGroupGridItem(index-1)
local mjidx=_this.advpoints[index]
local cfg_mj=cfg_catcatmijingconfig_get(mjidx)


local iconimg=cfg_mj.iconimg
item:SetChildCSImageSprite(3,abname,iconimg)

item:SetChildActive(2,false)

local pos=cfg_mj.pos
item:SetChildLocalPosition(-1,Vector3(pos[1],pos[2],0))
item:SetChildActive(-1,true)

item:SetChildActive(1,_this.mjSelectidx==index)
if _this.mjSelectidx==index then
item:SetChildDOTweenAnimation_DOPause(3)
end

item:SetBaseItemClickEvent(-1,function()
_this:refreshchoose(index)
_this:freshRightPart()
end)
end)
end
end


function UIWanBaoXunBaoDui_MiJinWin:refreshchoose(index)
if index and _this.mjSelectidx==index then
return
end
local old=_this.mjSelectidx
_this.mjSelectidx=index
if old and old>0 then
local oldItem=self.advContent:getChildLayoutGroupGridItem(old-1)
oldItem:SetChildActive(1,false)
oldItem:SetChildScale(3,Vector3.New(0.5,0.5,1))
oldItem:SetChildDOTweenAnimation_DOPlay(3)
end
local newItem=self.advContent:getChildLayoutGroupGridItem(_this.mjSelectidx-1)
newItem:SetChildActive(1,true)
newItem:SetChildDOTweenAnimation_DOPause(3)
end


function UIWanBaoXunBaoDui_MiJinWin:freshRightPart()
if#_this.advpoints>0 then
self.rightroot:setActive(true)
self.tipspanel:setActive(false)
local mjidx=_this.advpoints[_this.mjSelectidx]
local cfg_mj=cfg_catcatmijingconfig_get(mjidx)
local mjId=cfg_mj.id
local cfg_mj_ditu=cfg_secretscenefubenconfig_get(mjId)

local data=MysteryModel:getFBInfoData(mjId)
if data and data[1]~=nil then
else

MysteryController.send_4_3(mjId)
end

local name=cfg_mj_ditu.name
local namestr=FMT.fmt("<color=#7d3b17>秘境宝地：</color>{0}",name)
self.mijintitle:setText(namestr)

local teamFight=cfg_mj_ditu.teamFight or 100000
teamFight=mathHelper.formatNumber(teamFight)
local teamFighttr=FMT.fmt("<color=#7d3b17>战力：</color>{0}",teamFight)
self.frightxt:setText(teamFighttr)


local severdata=MysteryModel:getWanBaoXunBaoDuiData()
local severlist={}
if severdata and#severdata>0 then
for k,v in ipairs(severdata)do
severlist[v.ssId]=v
end
end
local mj_sever_data=severlist[mjId]
local sever_jindu=0
local sever_ismj=0
if mj_sever_data then
sever_jindu=mj_sever_data.percent
sever_ismj=mj_sever_data.closeFlag
end
local cur=sever_jindu
local need=100
if cur>need then
cur=need
end
_this.winlua:SetChildProgressValue(_this.progressbar:getID(),cur,need)
_this.winlua:SetChildProgressText(_this.progressbar:getID(),FMT.fmt('{0}%',cur))


local fixedenveffect=cfg_mj_ditu.fixedenveffect
local skillList=fixedenveffect or{{10004,1}}
_this.skillCnt=#skillList
_this.skillList:setChildLayoutGroupCreateItems(_this.skillCnt,function(index)
local item=_this.skillList:getChildLayoutGroupGridItem(index-1)
local skillData=skillList[index]
local iconName=""
local skillParam=skillData[1]
if skillParam then

local fazeCfg=cfgHelper.getSSlawRule(skillParam)
iconName=fazeCfg.image
else
loggerUtil.logWarnFMT("当前秘境无法则:{0},",mjId)
end
item:SetChildCSImageIcon(-1,iconName,false)
item:SetChildButtonClick(-1,function()
_this:onClickSkill(index,skillData)
end)
end)


local jinjie=cfg_mj_ditu.fixedJingJie or 30
if not jinjie then
loggerUtil.logErrFMT("副本表的固定秘境境界fixedJindJie为空")
end
local rewards,detail=MysteryModel:getShowAwards(mjId,jinjie)
self.rewardContent:setChildLayoutGroupCreateItems(#rewards,function(index)
local itemReward=self.rewardContent:getChildLayoutGroupGridItem(index-1)
local _data=rewards[index]
local showCountBG=_data[2]>1
local countStr=showCountBG and _data[2]or""
local conf={itemid=_data[1],itemcount=countStr,showCountBG=showCountBG,}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemReward:SetChildPropData(0,prop)
itemReward:SetChildActive(1,false)
itemReward:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end)
else
self.rightroot:setActive(false)
self.tipspanel:setActive(true)
end
end


function UIWanBaoXunBaoDui_MiJinWin:onReceivebtn()
local mjidx=_this.advpoints[_this.mjSelectidx]
local cfg_mj=cfg_catcatmijingconfig_get(mjidx)
local mjId=cfg_mj.id
wanBaoXunBaoDuiController:setCatMiJinState(mjId)
MysteryController:enterMysteryFbEx(mjId,MysteryModel:have_mystery_task(mjId))
self:closeSelf()
end


function UIWanBaoXunBaoDui_MiJinWin:onRijibtn()
UIManager:showWindow('UIWanBaoXunBaoDui_MiJinRiJinWin')
end


function UIWanBaoXunBaoDui_MiJinWin:onClickSkill(index,skillData)
local x=382+78*(index-(_this.skillCnt/2+0.5))














local txParam=skillData
local fazeID=txParam[1]
local fazeLv=txParam[2]
local fazeCfg=cfgHelper.getSSlawRule(fazeID)
local descparm=fazeCfg.descparm
local name=fazeCfg.name
local icon=fazeCfg.image
local desc=descparm and string.format(fazeCfg.desc,unpack(descparm[fazeLv]))or fazeCfg.desc
local halfVector=Vector2.right*0.5
local args={
name=name,
icon=icon,
desc=desc,
bottomLeft=nil,
rootPoint={
anchorsMin=halfVector,
anchorsMax=halfVector,
pivot=halfVector,
anchoredPosition=Vector2.New(x,146),
}
}
UIWanBaoXunBaoDui_MiJinWin:showWindow('UISimpleTeXingTipsWin',args)
end

function UIWanBaoXunBaoDui_MiJinWin:onClosebtn()
self:closeSelf()
end
function UIWanBaoXunBaoDui_MiJinWin:onMask()
self:closeSelf()
end

