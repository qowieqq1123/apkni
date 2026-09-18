







def_class("UIWanBaoXunBaoDui_MiJinTipsWin",UIWindowBase)









function UIWanBaoXunBaoDui_MiJinTipsWin:bindComponents()

self.mask=UIButton.get(self,0)
self.bgModel=UIObject.get(self,1)
self.Root=UIObject.get(self,2)
self.iconbg=UIImage.get(self,3)
self.iconmj=UIImage.get(self,4)
self.titletxt=UIText.get(self,5)
self.skillList=UIObject.get(self,6)
self.rewardlist=UIScrollView.get(self,7)
self.rewardContent=UIObject.get(self,8)
self.rwScrollView=UIObject.get(self,9)
self.enterbtn=UIButton.get(self,10)
self.discipleFightTxt=UIText.get(self,11)
self.gotobtn=UIButton.get(self,12)
self.closebtn=UIButton.get(self,13)
self.rolepanel=UIObject.get(self,14)
self.firstrole=UIObject.get(self,15)
self.firstrole2=UIObject.get(self,16)
self.firstrole3=UIObject.get(self,17)
self.titleimg=UIImage.get(self,18)

self.mask:setButtonClick(function()self:onMask()end)

self.enterbtn:setButtonClick(function()self:onEnterbtn()end)

self.gotobtn:setButtonClick(function()self:onGotobtn()end)

self.closebtn:setButtonClick(function()self:onClosebtn()end)



end


function UIWanBaoXunBaoDui_MiJinTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.iconbg);self.iconbg=nil;
_UIObject_release(self.iconmj);self.iconmj=nil;
_UIObject_release(self.titletxt);self.titletxt=nil;
_UIObject_release(self.skillList);self.skillList=nil;
_UIObject_release(self.rewardlist);self.rewardlist=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.enterbtn);self.enterbtn=nil;
_UIObject_release(self.discipleFightTxt);self.discipleFightTxt=nil;
_UIObject_release(self.gotobtn);self.gotobtn=nil;
_UIObject_release(self.closebtn);self.closebtn=nil;
_UIObject_release(self.rolepanel);self.rolepanel=nil;
_UIObject_release(self.firstrole);self.firstrole=nil;
_UIObject_release(self.firstrole2);self.firstrole2=nil;
_UIObject_release(self.firstrole3);self.firstrole3=nil;
_UIObject_release(self.titleimg);self.titleimg=nil;
end

















local _this
local abname="ui/windows/wanbaoxunbaodui/wanbaoxunbaodui_atlas_pak.ab"
local maxOpenNum=3


function UIWanBaoXunBaoDui_MiJinTipsWin:onLoaded(...)
_this=self
self:bindComponents()
self.rolewalks={self.firstrole,self.firstrole2,self.firstrole3}
MysteryController.send_4_81()
end


function UIWanBaoXunBaoDui_MiJinTipsWin:__delete()
self:unbindComponents()
if _this.refreshTimeIdshop then
_this:stopTimerByID(_this.refreshTimeIdshop)
_this.refreshTimeIdshop=nil
end
if _this.refreshTimeIdshop2 then
_this:stopTimerByID(_this.refreshTimeIdshop2)
_this.refreshTimeIdshop2=nil
end
_this=nil
end




function UIWanBaoXunBaoDui_MiJinTipsWin:onShow(argtable,afterOnloaded)

self.bgModel:setChildUIModelShowTarget(5051,1,{},eAnimationID.enter,false,false,0,nil)
self.rolepanel:setChildCanvasGroupAlpha(0)
self:delayDo(0.8,function()
self.rolepanel:setChildCanvasGroupDOFade(1,0.5,nil)
end)
if argtable then
self:refreshdata(argtable[1])
_this._mj_Id=argtable[1]
local guid=MysteryModel:getWanBaoXunBaoDuiCatModel()
if guid then
local catdata=wanBaoXunBaoDuiModel:getCatData(guid)
if catdata then
local modelid,componets=wanbaoXunBaoDuiHelper:getCatModelParam(catdata,1)

_this.roles={}
for i=1,2 do
local widget=_this.rolewalks[i]:getWidgetBase()
_this.roles[#_this.roles+1]=widget
end

_this.roles[1]:SetChildUIModelShowTarget(1,modelid,1,componets,eAnimationID.stand,false,false,0.1)



local info2=UIDiscipleModel:getDiscipleDataByDiziId(2001).imageInfo
local modelParams2=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info2)
_this.roles[2]:SetChildUIModelShowTarget(1,modelParams2.body,1,modelParams2.componets,eAnimationID.stand,false,false,0.1)



if _this.refreshTimeIdshop then
_this:stopTimerByID(_this.refreshTimeIdshop)
_this.refreshTimeIdshop=nil
end
_this.refreshTimeFunshop=function()
_this:doSpeaking_playerone(argtable[1])
end
_this.refreshTimeFunshop()
_this.refreshTimeIdshop=_this:setTimer(10,0,_this.refreshTimeFunshop)


if _this.refreshTimeIdshop2 then
_this:stopTimerByID(_this.refreshTimeIdshop2)
_this.refreshTimeIdshop2=nil
end
_this.refreshTimeFunshop2=function()
_this:doSpeaking_playertwo(argtable[1])
end
_this.refreshTimeFunshop2()
_this.refreshTimeIdshop2=_this:setTimer(11,0,_this.refreshTimeFunshop2)

end
end
end

end


function UIWanBaoXunBaoDui_MiJinTipsWin:onHide()

end

function UIWanBaoXunBaoDui_MiJinTipsWin:getAdvPoints()
local severdata=MysteryModel:getWanBaoXunBaoDuiData()

local severlist={}
if severdata and#severdata>0 then
for k,v in ipairs(severdata)do
severlist[v.ssId]=v
end
end
local cfg_mj=cfg_catcatmijingbaseconfig_get(1).ptMiJing
local list={}
local tempnum=0
for k,v in ipairs(cfg_mj)do
local mj_idx=v
local cfg_mj=cfg_catcatmijingconfig_get(mj_idx)
local mj_id=cfg_mj.id
local mj_sever_data=severlist[mj_id]
if mj_sever_data then

local sever_jindu=0
if mj_sever_data then
sever_jindu=mj_sever_data.percent
end
if sever_jindu<100 then
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


local num
local newlist={}
if num>0 then
if num<maxOpenNum then
for i=1,num do
if list[i]then
newlist[i]=list[i]
end
end
else
for i=1,maxOpenNum do
if list[i]then
newlist[i]=list[i]
end
end
end
end

return newlist
end


function UIWanBaoXunBaoDui_MiJinTipsWin:openlist()



local list=UIWanBaoXunBaoDui_MiJinTipsWin:getAdvPoints()
local mijindata=userActorSetting.get('UIWanBaoXunBaoDui_MiJinTipsWin_openMiJin',{})
local new_mijindata=mijindata
if#list>0 then
if new_mijindata[#new_mijindata]==list[#list]then
else
new_mijindata[#new_mijindata+1]=list[#list]
userActorSetting.set('UIWanBaoXunBaoDui_MiJinTipsWin_openMiJin',new_mijindata)

end
end

end





function UIWanBaoXunBaoDui_MiJinTipsWin:onMask()
self:closeSelf()
end

function UIWanBaoXunBaoDui_MiJinTipsWin:onClosebtn()
self:closeSelf()
end

function UIWanBaoXunBaoDui_MiJinTipsWin:onEnterbtn()
end


function UIWanBaoXunBaoDui_MiJinTipsWin:refreshdata(mj_Id)

local cfg_mj=cfg_catcatmijingconfig_get(mj_Id)
local mjId=mj_Id
local cfg_mj_ditu=cfg_secretscenefubenconfig_get(mjId)





local mjicon=cfg_mj.titleimg
self.winlua:SetChildCSImageSprite(self.titleimg:getID(),abname,mjicon)


local mjicon=cfg_mj.iconimg
self.winlua:SetChildCSImageSprite(self.iconmj:getID(),abname,mjicon)


local teamFight=cfg_mj_ditu.teamFight or 100000
teamFight=mathHelper.formatNumber(teamFight)

self.discipleFightTxt:setText(teamFight)


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

end


function UIWanBaoXunBaoDui_MiJinTipsWin:onClickSkill(index,skillData)
local x=-145+78*(index-(_this.skillCnt/2+0.5))
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
anchoredPosition=Vector2.New(x,85),
}
}
UIWanBaoXunBaoDui_MiJinTipsWin:showWindow('UISimpleTeXingTipsWin',args)
end


function UIWanBaoXunBaoDui_MiJinTipsWin:onGotobtn()
local cat_sysid=SYSTEM_DEFINE.eCatCatMiJing
if systemModel.isOpen(cat_sysid)then

local _mjid=_this._mj_Id
UIManager:showWindow("UIWanBaoXunBaoDui_MiJinWin",{_mjid})
self:closeSelf()
end
end




function UIWanBaoXunBaoDui_MiJinTipsWin:doSpeaking_playerone(mj_Id)
local cfg_speaks=cfg_catcatmijingconfig_get(mj_Id).speaks
local speakList=cfg_speaks[1]or{"这位仙友，你也是来钓鱼的吗？","吾纵横渔界多年，未逢一败，无敌真寂寞啊。"}
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
_this.roles[1]:SetChildCanvasGroupAlpha(2,1)
_this.roles[1]:SetChildTrendsTextPlay(3,speakStr,speed,nil)
_this:doTalkAnim_playerone()
end
function UIWanBaoXunBaoDui_MiJinTipsWin:doTalkAnim_playerone()
if _this.talkTween11~=nil then
_this.talkTween11:Kill()
_this.talkTween11=nil
end

_this.roles[1]:SetChildScale(2,Vector3.zero)
_this:delayDo(0.2,function()
_this.roles[1]:SetChildCanvasGroupAlpha(2,1)
_this.talkTween11=_this.roles[1]:SetChildDOScaleY(2,1.2,0.2,function()
if _this==nil then return end
_this.talkTween11=nil
_this.talkTween11=_this.roles[1]:SetChildDOScale(2,0.8,0.1,function()
if _this==nil then return end
_this.talkTween11=nil
return _this:talkEndone()
end)
end)
end)
end
function UIWanBaoXunBaoDui_MiJinTipsWin:talkEndone()
if _this.speakShowTimerone then
_this:stopTimerByID(_this.speakShowTimerone)
_this.speakShowTimerone=nil
end
_this.speakShowTimerone=_this:delayDo(3,function()

if _this==nil then return end
_this.roles[1]:SetChildScale(2,Vector3.zero)
_this.roles[1]:SetChildCanvasGroupAlpha(2,0)

if _this.speakShowTimerone then
_this:stopTimerByID(_this.speakShowTimerone)
_this.speakShowTimerone=nil
end
end)
end


function UIWanBaoXunBaoDui_MiJinTipsWin:doSpeaking_playertwo(mj_Id)
local cfg_speaks=cfg_catcatmijingconfig_get(mj_Id).speaks
local speakList=cfg_speaks[2]or{"这位仙友，你也是来钓鱼的吗？","吾纵横渔界多年，未逢一败，无敌真寂寞啊。"}
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
_this.roles[2]:SetChildCanvasGroupAlpha(2,1)
_this.roles[2]:SetChildTrendsTextPlay(3,speakStr,speed,nil)
_this:doTalkAnim_playertwo()
end
function UIWanBaoXunBaoDui_MiJinTipsWin:doTalkAnim_playertwo()
if _this.talkTween12~=nil then
_this.talkTween12:Kill()
_this.talkTween12=nil
end

_this.roles[2]:SetChildScale(2,Vector3.zero)
_this:delayDo(0.2,function()
_this.roles[2]:SetChildCanvasGroupAlpha(2,1)
_this.talkTween12=_this.roles[2]:SetChildDOScaleY(2,1.2,0.2,function()
if _this==nil then return end
_this.talkTween12=nil
_this.talkTween12=_this.roles[2]:SetChildDOScale(2,0.8,0.1,function()
if _this==nil then return end
_this.talkTween12=nil
return _this:talkEndtwo()
end)
end)
end)
end
function UIWanBaoXunBaoDui_MiJinTipsWin:talkEndtwo()
if _this.speakShowTimerone2 then
_this:stopTimerByID(_this.speakShowTimerone2)
_this.speakShowTimerone2=nil
end
_this.speakShowTimerone2=_this:delayDo(2.8,function()

if _this==nil then return end
_this.roles[2]:SetChildScale(2,Vector3.zero)
_this.roles[2]:SetChildCanvasGroupAlpha(2,0)

if _this.speakShowTimerone2 then
_this:stopTimerByID(_this.speakShowTimerone2)
_this.speakShowTimerone2=nil
end
end)
end


function UIWanBaoXunBaoDui_MiJinTipsWin:doSpeaking_playerthree(speakType)
local cfg_speaks={1}
local speakList=cfg_speaks[3][2]or{{"这位仙友，你也是来钓鱼的吗？"},{"吾纵横渔界多年，未逢一败，无敌真寂寞啊。"}}
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
_this.roles[3]:SetChildCanvasGroupAlpha(2,1)
_this.roles[3]:SetChildTrendsTextPlay(3,speakStr,speed,nil)
_this:doTalkAnim_playerthree()
end
function UIWanBaoXunBaoDui_MiJinTipsWin:doTalkAnim_playerthree()
if _this.talkTween13~=nil then
_this.talkTween13:Kill()
_this.talkTween13=nil
end

_this.roles[3]:SetChildScale(2,Vector3.zero)
_this:delayDo(0.2,function()
_this.roles[3]:SetChildCanvasGroupAlpha(2,1)
_this.talkTween13=_this.roles[3]:SetChildDOScaleY(2,1.2,0.2,function()
if _this==nil then return end
_this.talkTween13=nil
_this.talkTween13=_this.roles[3]:SetChildDOScale(2,0.8,0.1,function()
if _this==nil then return end
_this.talkTween13=nil
return _this:talkEndthree()
end)
end)
end)
end
function UIWanBaoXunBaoDui_MiJinTipsWin:talkEndthree()
if _this.speakShowTimerone3 then
_this:stopTimerByID(_this.speakShowTimerone3)
_this.speakShowTimerone3=nil
end
_this.speakShowTimerone3=_this:delayDo(3,function()

if _this==nil then return end
_this.roles[3]:SetChildScale(2,Vector3.zero)
_this.roles[3]:SetChildCanvasGroupAlpha(2,0)

if _this.speakShowTimerone3 then
_this:stopTimerByID(_this.speakShowTimerone3)
_this.speakShowTimerone3=nil
end
end)
end
