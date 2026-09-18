







def_class("UISubAct_ZQDMtitleWin",UIWindowBase)









function UISubAct_ZQDMtitleWin:bindComponents()

self.blackBG=UIObject.get(self,0)
self.clickMask=UIButton.get(self,1)
self.infoPanel=UIObject.get(self,2)
self.btnClose=UIButton.get(self,3)
self.titleTxt=UIText.get(self,4)
self.tmtxt=UIText.get(self,5)
self.itempanel=UIObject.get(self,6)
self.rgpanel=UIObject.get(self,7)
self.tjbtn=UIButton.get(self,8)
self.gnitema=UIObject.get(self,9)
self.gnitemb=UIObject.get(self,10)
self.gnitemc=UIObject.get(self,11)
self.gnitemd=UIObject.get(self,12)
self.leftpanel=UIObject.get(self,13)
self.tjdjsbtn=UIButton.get(self,14)
self.djsbtntxt=UIText.get(self,15)
self.answertxt=UIText.get(self,16)
self.aeffect=UIObject.get(self,17)
self.bgModel=UIObject.get(self,18)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.tjbtn:setButtonClick(function()self:onTjbtn()end)

self.tjdjsbtn:setButtonClick(function()self:onTjdjsbtn()end)



end


function UISubAct_ZQDMtitleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackBG);self.blackBG=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.tmtxt);self.tmtxt=nil;
_UIObject_release(self.itempanel);self.itempanel=nil;
_UIObject_release(self.rgpanel);self.rgpanel=nil;
_UIObject_release(self.tjbtn);self.tjbtn=nil;
_UIObject_release(self.gnitema);self.gnitema=nil;
_UIObject_release(self.gnitemb);self.gnitemb=nil;
_UIObject_release(self.gnitemc);self.gnitemc=nil;
_UIObject_release(self.gnitemd);self.gnitemd=nil;
_UIObject_release(self.leftpanel);self.leftpanel=nil;
_UIObject_release(self.tjdjsbtn);self.tjdjsbtn=nil;
_UIObject_release(self.djsbtntxt);self.djsbtntxt=nil;
_UIObject_release(self.answertxt);self.answertxt=nil;
_UIObject_release(self.aeffect);self.aeffect=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end
















local _this
local itempos=
{
{-160,70},{-50,70},{60,70},{170,70},
{-160,-30},{-50,-30},{60,-30},{170,-30},
{-160,-130},{-50,-130},{60,-130},{170,-130},
{-160,-230},{-50,-230},{60,-230},{170,-230},
}
local maxWenzi=16
local maxxuanze=4
local itemidx=
{
wzitem=0,
imgbg=1,
img=2,
txt=3,
btn=4,
}
local rightidx=
{
rgitem=0,
imgbg=1,
img=2,
txt=3,
lock=4,
btn=5,
}
local skillidx=
{
selfitem=0,
headitem=1,
txt=2,
btn=3,
speakobj=4,
speaktxt=5,
}
local skill_delet_two=2
local skill_delet_eight=8




function UISubAct_ZQDMtitleWin:onLoaded(...)
self:bindComponents()
_this=self
self.gnitemalist={self.gnitema,self.gnitemb,self.gnitemc,self.gnitemd}
self.itemwidget=self.itempanel:getChildWidgetBase()
self.rgwidget=self.rgpanel:getChildWidgetBase()
end


function UISubAct_ZQDMtitleWin:__delete()
if self.isdoanimat then
self.sub_actInfo:setnowdaydata(nil,nil,false)
else
if self.sub_actInfo then
self.sub_actInfo:setnowdaydata(self.chooseidx,self.deletlist,self.islucking)
end
end
if self.sub_actInfo then
self.sub_actInfo:setAnawerData()
end
self:unbindComponents()
_this=nil
end




function UISubAct_ZQDMtitleWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.parentwin=argtable.parentwin
self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
if not self.sub_actInfo then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.startday=self.sub_actInfo.start_day_idx
self.start_time=self.sub_actInfo.start_time
self.end_time=self.sub_actInfo.end_time
self.subcfg=cfg_lanternriddlesconfig_get(self.subid)
self.chooseidx={[1]=0,[2]=0,[3]=0,[4]=0,}
self.deletlist={}
self.islucking=false

local _chooseidx,_deletlist,_islucking=self.sub_actInfo:getnowdaydata()

if _chooseidx and _deletlist then
self.chooseidx=_chooseidx
self.deletlist=_deletlist
end
self.islucking=_islucking
self.isdoanimat=false
self.isgnbtn=false

self.infoPanel:setChildCanvasGroupAlpha(0)

self:freshinfo()
self.bgModel:setChildUIModelShowTarget(5583,1,{},eAnimationID.stand,false,false,0)
self.infoPanel:setChildCanvasGroupDOFade(1,0.5,function()
if _this==nil then return end

end)
end


function UISubAct_ZQDMtitleWin:onHide()

end

function UISubAct_ZQDMtitleWin:onCloseClick()
self:closeSelf()
end
function UISubAct_ZQDMtitleWin:onBtnClose()
self:onCloseClick()
end
function UISubAct_ZQDMtitleWin:onClickMask()
self:onCloseClick()
end

function UISubAct_ZQDMtitleWin:onTjbtn()
if _this.isgetbtn then
UIManager.error('祖师点击太频繁，请稍后')
return
end
if not _this.isgetbtn then
local none=false
if not self.chooseidx then return end
for k,v in ipairs(self.chooseidx)do
if v~=0 then
none=true
end
end
if not none then
UIManager.error('答案不能为空')
else
local answerlist=self.cfg_tiku.answer
local ispass=0
local isneed=0
for k,v in ipairs(self.chooseidx)do
if answerlist[k]==v then
ispass=ispass+1
end
if v>0 then
isneed=isneed+1
end
end
if ispass==#answerlist and isneed==#answerlist then
self.sub_actInfo:setAnserdata()
local finishIdex=self:getNowNum()
local maxNum,tikulist,rewardlist=self:getMaxTitledata()

self.aeffect:setChildShowEffect(10232,true)
if finishIdex>=maxNum then
local json_str=jsonHelper.encode({1})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actID,self.subType,self.subid,json_str)
self.severget=true
self:playskillspeak()
else
UIManager:invokeUIMethod('UISubAct_ZQDMmainWin','freshdatijindu')

self.severget=false
self:playskillspeak()
self:freshfinishbtn()
end
else

self.aeffect:setChildShowEffect(10233,true)
self:delayDo(0.2,function()
if _this==nil then return end
if self.chooseidx and#self.chooseidx>0 then
local tmep=table.weakCopy(self.chooseidx)
for k,v in ipairs(self.chooseidx)do
local leftidx=v
local _rightidx=k
if leftidx~=0 then
local rightwidget=self.rgwidget:GetChildWidgetBase(_rightidx-1)
rightwidget:SetChildCanvasGroupDOFade(itemidx.img,0,0.2,nil)
local leftwidget=self.itemwidget:GetChildWidgetBase(leftidx-1)
leftwidget:SetChildCanvasGroupDOFade(rightidx.img,1,0.2,nil)
tmep[k]=0
end
end
self.chooseidx=tmep
end
end)
end
end
_this.isgetbtn=true
end

if not _this.isgetbtnTimer and _this.isgetbtn==true then
_this.isgetbtnTimer=_this:delayDo(1,function()
if _this==nil then return end
_this.isgetbtnTimer=nil
_this.isgetbtn=false
end)
end
end

function UISubAct_ZQDMtitleWin:refreshallfinishbtn()
_this.chooseidx=nil
_this.deletlist=nil
_this.islucking=false
_this:freshallfinishbtn()
end

function UISubAct_ZQDMtitleWin:freshallfinishbtn()
self.tjdjsbtn:setActive(true)
self.tjbtn:setActive(false)
if self.reTimeId2 then
self:stopTimerByID(self.reTimeId2)
self.reTimeId2=nil
end
self.isdoanimat=true
local maxTime=gameUtilityModel.getServerShortTime()+5
self.reTimeFunc2=function()
if _this==nil then return end
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=maxTime-nowTime
if lerp>0 then
local str=FMT.fmt('结算 ({0}秒)',maxTime-nowTime)
self.djsbtntxt:setText(str)
else
if self.reTimeId2 then
self:stopTimerByID(self.reTimeId2)
self.reTimeId2=nil
end
self.tjdjsbtn:setActive(false)
self.tjbtn:setActive(true)
self:closethiswin()
self.isdoanimat=false
end
end
self.reTimeFunc2()
self.reTimeId2=self:setTimer(1,0,self.reTimeFunc2)
end

function UISubAct_ZQDMtitleWin:freshfinishbtn()
self.tjdjsbtn:setActive(true)
self.tjbtn:setActive(false)
if self.reTimeId then
self:stopTimerByID(self.reTimeId)
self.reTimeId=nil
end
self.isdoanimat=true
local maxTime=gameUtilityModel.getServerShortTime()+5
self.reTimeFunc=function()
if _this==nil then return end
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=maxTime-nowTime
if lerp>0 then
local str=FMT.fmt('下一题 ({0}秒)',maxTime-nowTime)
self.djsbtntxt:setText(str)
else
if self.reTimeId then
self:stopTimerByID(self.reTimeId)
self.reTimeId=nil
end
self.tjdjsbtn:setActive(false)
self.tjbtn:setActive(true)

self:freshallPanel()
self.isdoanimat=false
end
end
self.reTimeFunc()
self.reTimeId=self:setTimer(1,0,self.reTimeFunc)
end

function UISubAct_ZQDMtitleWin:onTjdjsbtn()
self.tjdjsbtn:setActive(false)

if self.severget==true then
if self.reTimeId2 then
self:stopTimerByID(self.reTimeId2)
self.reTimeId2=nil
end
self:closethiswin()
else
if self.reTimeId then
self:stopTimerByID(self.reTimeId)
self.reTimeId=nil
end
UIManager:invokeUIMethod('UISubAct_ZQDMmainWin','freshdatijindu')
self:freshallPanel()
end
self.isdoanimat=false
self.tjbtn:setActive(true)
end


function UISubAct_ZQDMtitleWin:getSkillNumbyID(skillid)
local skillnum=self.sub_actInfo:getSkilldata(skillid)
return skillnum
end

function UISubAct_ZQDMtitleWin:getNowNum()
local finishIdex=self.sub_actInfo:getAnserdata()
return finishIdex
end

function UISubAct_ZQDMtitleWin:getMaxTitledata()
local idx=self.sub_actInfo:getOpenDayIndex()
local cfg_questions=self.subcfg.questions
if idx then
local questionslist=cfg_questions[idx]
if not questionslist then
logErr(FMT.fmt('中秋灯谜活动缺少活动天数{0} 对应配置',idx))
return 0,{},{}
end
local tklist=questionslist[1]or{}
local rewardlist=questionslist[2]or{}
return#tklist,tklist,rewardlist
end
return 0,{},{}
end

function UISubAct_ZQDMtitleWin:freshinfo()
self.tjdjsbtn:setActive(false)
self.tjbtn:setActive(true)
local finishIdex=self:getNowNum()
local nowNum=finishIdex+1
local maxNum,tikulist,rewardlist=self:getMaxTitledata()

local str=FMT.fmt('题目{0}（{1}/{2}）',mathHelper.numberToChinese(nowNum),nowNum,maxNum)
self.titleTxt:setText(str)

local titleidx=tikulist[nowNum]or 1
local cfg_tiku=cfg_lanternriddlesquizconfig_get(titleidx)
self.cfg_tiku=cfg_tiku
local tstr=FMT.fmt('<color=#7d3b17>题目：</color>{0}',cfg_tiku.title)
self.tmtxt:setText(tstr)
local tipstr=FMT.fmt('谜底文字数量：{0}',#self.cfg_tiku.answer or"")
self.answertxt:setText(tipstr)
local recordlist={}
for k,v in ipairs(self.chooseidx)do
if v~=0 then
recordlist[v]=true
end
end

local option=cfg_tiku.option
for i=1,maxWenzi do
local widget=self.itemwidget:GetChildWidgetBase(i-1)
if option[i]then
widget:SetChildActive(itemidx.wzitem,true)
widget:SetChildText(itemidx.txt,option[i])
if recordlist[i]or self.deletlist[i]then
widget:SetChildCanvasGroupAlpha(itemidx.img,0)
else
widget:SetChildCanvasGroupAlpha(itemidx.img,1)
end
widget:SetChildButtonClick(itemidx.img,function(...)
if _this==nil then return end
self:onLeftClickItem(i,option[i])
end)
else
widget:SetChildActive(itemidx.wzitem,false)
end
end


for i=1,maxxuanze do
local widget=self.rgwidget:GetChildWidgetBase(i-1)
local leftidx=self.chooseidx[i]
if leftidx~=0 then
widget:SetChildText(rightidx.txt,option[leftidx]or"")
widget:SetChildCanvasGroupAlpha(rightidx.img,1)
else
widget:SetChildText(rightidx.txt,"")
end
if not self.chooseidx[i]then
widget:SetChildActive(rightidx.lock,true)
else
widget:SetChildActive(rightidx.lock,false)

end
widget:SetChildButtonClick(rightidx.btn,function(...)
if _this==nil then return end
self:onRightClickItem(i)
end)
end


local skills=self.subcfg.skills
for k,v in ipairs(self.gnitemalist)do
local widget=v:getChildWidgetBase()
if skills[k]then
widget:SetChildActive(skillidx.selfitem,true)
local skillid=skills[k][1]
local diziid=skills[k][2]
local maxnum=skills[k][3]
local skillcfg=cfg_lanternriddlesshelfconfig_get(skillid)
local desc=skillcfg.desc
local useNum=self:getSkillNumbyID(skillid)
local _str=""
if useNum>=maxnum then
_str=FMT.fmt('{0}（剩: <color=#c82c2c>{1}次</color>）',desc,maxnum-useNum)
else
_str=FMT.fmt('{0}（剩: {1}次）',desc,maxnum-useNum)
end
widget:SetChildText(skillidx.txt,_str)

local dzitem=widget:GetChildWidgetBase(skillidx.headitem)
local dizidata=UIDiscipleModel:getDiscipleDataByDiziId(diziid)
local imageInfo=dizidata.imageInfo
comHelper.setChildModelHeadIconBGByColor(dzitem,1,imageInfo.color)
comHelper.setChildModelRawImageByDiziId(dzitem,diziid,2,0,eHeadCenterType.eHead,nil,false)
widget:SetChildButtonClick(skillidx.btn,function(...)
if _this==nil then return end
self:onSkillClickItem(k,skillid,maxnum,widget)
end)
else
widget:SetChildActive(skillidx.selfitem,false)
end
end
end


function UISubAct_ZQDMtitleWin:getChooselen()
local len=0
for k,v in ipairs(self.chooseidx)do
if v~=0 then
len=len+1
end
end
return len
end

function UISubAct_ZQDMtitleWin:checkChooseidx(idx)
for k,v in ipairs(self.chooseidx)do
if v==idx then
return true
end
end
return false
end

function UISubAct_ZQDMtitleWin:setChooseidx(idx)
for k,v in ipairs(self.chooseidx)do
if v==0 then
self.chooseidx[k]=idx
return k
end
end
end

function UISubAct_ZQDMtitleWin:checkChooseRightidx(_rightidx)
if self.chooseidx[_rightidx]and self.chooseidx[_rightidx]~=0 then
return true
end
return false
end

function UISubAct_ZQDMtitleWin:deletChooseidx(_rightidx)
local idx=self.chooseidx[_rightidx]
self.chooseidx[_rightidx]=0
return idx
end


function UISubAct_ZQDMtitleWin:onLeftClickItem(idx,wenzi)





if self.isdoanimat==true then
return
end

if self:checkChooseidx(idx)or self.deletlist[idx]then
return
end
local len=self:getChooselen()
if len>=#self.chooseidx then
UIManager.info("可填字符已满")
return
end


local _rightidx=self:setChooseidx(idx)
local leftwidget=self.itemwidget:GetChildWidgetBase(idx-1)
leftwidget:SetChildCanvasGroupDOFade(itemidx.img,0,0.2,nil)

if _rightidx then
local rightwidget=self.rgwidget:GetChildWidgetBase(_rightidx-1)
rightwidget:SetChildText(rightidx.txt,wenzi or"")
rightwidget:SetChildCanvasGroupDOFade(rightidx.img,1,0.2,nil)
end
end

function UISubAct_ZQDMtitleWin:onRightClickItem(_rightidx)
if self.isdoanimat==true then
return
end

if not self:checkChooseRightidx(_rightidx)then
return
end
local leftidx=self:deletChooseidx(_rightidx)
local rightwidget=self.rgwidget:GetChildWidgetBase(_rightidx-1)
rightwidget:SetChildCanvasGroupDOFade(itemidx.img,0,0.2,nil)

if leftidx and leftidx>0 then
local leftwidget=self.itemwidget:GetChildWidgetBase(leftidx-1)
leftwidget:SetChildCanvasGroupDOFade(rightidx.img,1,0.2,nil)
end
end

function UISubAct_ZQDMtitleWin:onSkillClickItem(i,skillid,maxnum,widget)
if self.isdoanimat==true then
return
end

local useNum=self:getSkillNumbyID(skillid)
if useNum<maxnum then
if self.isgnbtn then
UIManager.error('祖师点击太频繁，请稍后')
return
end
if not self.isgnbtn then
self:handelSkill(i,skillid,widget)
self.isgnbtn=true
end

if not self.isgnbtnTimer and self.isgnbtn==true then
self.isgnbtnTimer=self:delayDo(0.8,function()
if _this==nil then return end
self.isgnbtnTimer=nil
self.isgnbtn=false
end)
end
else
UIManager.info("剩余次数不足")
end
end

function UISubAct_ZQDMtitleWin:handelSkill(i,skillid,widget)

if skillid==1 then

self.doanima=true
local answerlist=self.cfg_tiku.answer
local ispass=0
local isneed=0
for k,v in ipairs(self.chooseidx)do
if answerlist[k]==v then
ispass=ispass+1
end
if v>0 then
isneed=isneed+1
end
end
if ispass==#answerlist and isneed==#answerlist then
UIManager.info("所填入的文字为正确答案")
return
end
local tmep=table.weakCopy(self.chooseidx)
for k,v in ipairs(self.chooseidx)do
local leftidx=v
local _rightidx=k
if leftidx~=0 then
local rightwidget=self.rgwidget:GetChildWidgetBase(_rightidx-1)
rightwidget:SetChildCanvasGroupDOFade(itemidx.img,0,0.2,nil)
local leftwidget=self.itemwidget:GetChildWidgetBase(leftidx-1)
leftwidget:SetChildCanvasGroupDOFade(rightidx.img,1,0.2,nil)
tmep[k]=0
end
end
self.chooseidx=tmep
self:delayDo(0.5,function()
if not _this then return end
local option=self.cfg_tiku.option
for k,v in ipairs(answerlist)do
local leftidx=v
local _rightidx=k
local leftwidget=self.itemwidget:GetChildWidgetBase(leftidx-1)
leftwidget:SetChildCanvasGroupDOFade(itemidx.img,0,0.2,nil)
local rightwidget=self.rgwidget:GetChildWidgetBase(_rightidx-1)
rightwidget:SetChildText(rightidx.txt,option[leftidx]or"")
rightwidget:SetChildCanvasGroupDOFade(rightidx.img,1,0.2,nil)
self.chooseidx[_rightidx]=leftidx
end
end)

self:doSpeaking_playera(widget,1,skillid)
self.sub_actInfo:setSkilldata(skillid,1)
self:freshSkillPanel()

elseif skillid==2 then

local answerlist=self.cfg_tiku.answer
local answerlist2={}
local option=self.cfg_tiku.option
local tmep=table.weakCopy(self.chooseidx)
local temp2={}
for k,v in ipairs(tmep)do
if v~=0 then
temp2[v]=true
end
end
for k,v in ipairs(answerlist)do
answerlist2[v]=true
end
local list={}
for k,v in ipairs(option)do
if not answerlist2[k]and not temp2[k]and not self.deletlist[k]then
table.insert(list,k)
end
end
if#list<=0 then
UIManager.info("无可排除的文字")
return
end
local deletlist={}
local num=#list
local loop=num>skill_delet_two and skill_delet_two or num
for i=1,loop do
local r=math.random(1,num-i+1)
local a=list[r]
table.insert(deletlist,a)
local templist={}
for k,v in ipairs(list)do
if v==list[r]then
else
templist[#templist+1]=v
end
end
list=templist
end
for k,v in ipairs(deletlist)do
local leftidx=v
self.deletlist[leftidx]=true
local leftwidget=self.itemwidget:GetChildWidgetBase(leftidx-1)
leftwidget:SetChildCanvasGroupDOFade(itemidx.img,0,0.2,nil)
end
self:doSpeaking_playerb(widget,1,skillid)
self.sub_actInfo:setSkilldata(skillid,1)
self:freshSkillPanel()

elseif skillid==3 then

local len=self:getChooselen()
if len>=#self.chooseidx then
UIManager.info("可填入的字符个数已满")
return
end
local answerlist=self.cfg_tiku.answer
local option=self.cfg_tiku.option
local needPut={0,0}
local deneedPut={0,0}
for i=1,#answerlist do
local chooseid=answerlist[i]
local ridx=self.chooseidx[i]
if ridx~=chooseid then
needPut[1]=chooseid
needPut[2]=i
break
end
end
if needPut[1]>0 then
for k,v in ipairs(self.chooseidx)do
local leftid=needPut[1]
if v==leftid then
deneedPut[1]=v
deneedPut[2]=k
break
end
end
end

if needPut[1]==0 and needPut[2]==0 then
UIManager.info("所填入的答案已包含正确的文字")
return
end
if needPut[2]>0 and self.chooseidx[needPut[2]]and self.chooseidx[needPut[2]]>0 then
local leftidx=self.chooseidx[needPut[2]]
self.chooseidx[needPut[2]]=0
local rightwidget=self.rgwidget:GetChildWidgetBase(needPut[2]-1)
rightwidget:SetChildCanvasGroupDOFade(rightidx.img,0,0.2,nil)
local leftwidget=self.itemwidget:GetChildWidgetBase(leftidx-1)
leftwidget:SetChildCanvasGroupDOFade(rightidx.img,1,0.2,nil)
end
if deneedPut[2]>0 and self.chooseidx[deneedPut[2]]and self.chooseidx[deneedPut[2]]>0 then
local leftidx=self.chooseidx[deneedPut[2]]
self.chooseidx[deneedPut[2]]=0
local rightwidget=self.rgwidget:GetChildWidgetBase(deneedPut[2]-1)
rightwidget:SetChildCanvasGroupDOFade(rightidx.img,0,0.2,nil)
local leftwidget=self.itemwidget:GetChildWidgetBase(leftidx-1)
leftwidget:SetChildCanvasGroupDOFade(rightidx.img,1,0.2,nil)
end
if needPut[1]>0 then
self.chooseidx[needPut[2]]=needPut[1]
local leftwidget=self.itemwidget:GetChildWidgetBase(needPut[1]-1)
leftwidget:SetChildCanvasGroupDOFade(itemidx.img,0,0.2,nil)
local rightwidget=self.rgwidget:GetChildWidgetBase(needPut[2]-1)
rightwidget:SetChildText(rightidx.txt,option[needPut[1]]or"")
rightwidget:SetChildCanvasGroupDOFade(rightidx.img,1,0.2,nil)
end
self:doSpeaking_playerc(widget,1,skillid)
self.sub_actInfo:setSkilldata(skillid,1)
self:freshSkillPanel()

elseif skillid==4 then








































local answerlist=self.cfg_tiku.answer
local answerlist2={}
local option=self.cfg_tiku.option
local tmep=table.weakCopy(self.chooseidx)
local temp2={}
for k,v in ipairs(tmep)do
if v~=0 then
temp2[v]=true
end
end
for k,v in ipairs(answerlist)do
answerlist2[v]=true
end
local list={}
for k,v in ipairs(option)do
if not answerlist2[k]and not temp2[k]and not self.deletlist[k]then
table.insert(list,k)
end
end
if#list<=0 then
UIManager.info("无可排除的文字")
return
end
local deletlist={}
local num=#list
local loop=num>skill_delet_eight and skill_delet_eight or num
for i=1,loop do
local r=math.random(1,num-i+1)
local a=list[r]
table.insert(deletlist,a)
local templist={}
for k,v in ipairs(list)do
if v==list[r]then
else
templist[#templist+1]=v
end
end
list=templist
end
for k,v in ipairs(deletlist)do
local leftidx=v
self.deletlist[leftidx]=true
local leftwidget=self.itemwidget:GetChildWidgetBase(leftidx-1)
leftwidget:SetChildCanvasGroupDOFade(itemidx.img,0,0.2,nil)
end
self:doSpeaking_playerd(widget,1,skillid)
self.sub_actInfo:setSkilldata(skillid,1)
self:freshSkillPanel()
end
end

function UISubAct_ZQDMtitleWin:freshSkillPanel()
local skills=self.subcfg.skills
for k,v in ipairs(self.gnitemalist)do
local widget=v:getChildWidgetBase()
if skills[k]then
local skillid=skills[k][1]
local maxnum=skills[k][3]
local skillcfg=cfg_lanternriddlesshelfconfig_get(skillid)
local desc=skillcfg.desc
local useNum=self:getSkillNumbyID(skillid)
local _str=""
if useNum>=maxnum then
_str=FMT.fmt('{0}（剩: <color=#c82c2c>{1}次</color>）',desc,maxnum-useNum)
else
_str=FMT.fmt('{0}（剩: {1}次）',desc,maxnum-useNum)
end
widget:SetChildText(skillidx.txt,_str)
end
end
end

function UISubAct_ZQDMtitleWin:freshallPanel()
self.chooseidx={[1]=0,[2]=0,[3]=0,[4]=0,}
self.deletlist={}
self.islucking=false
self.isgnbtn=false
self.isdoanimat=false
self.tjdjsbtn:setActive(false)
self.tjbtn:setActive(true)
local finishIdex=self:getNowNum()
local nowNum=finishIdex+1
local maxNum,tikulist,rewardlist=self:getMaxTitledata()

local str=FMT.fmt('题目{0}（{1}/{2}）',mathHelper.numberToChinese(nowNum),nowNum,maxNum)
self.titleTxt:setText(str)

local titleidx=tikulist[nowNum]or 1
local cfg_tiku=cfg_lanternriddlesquizconfig_get(titleidx)
self.cfg_tiku=cfg_tiku
local tstr=FMT.fmt('<color=#7d3b17>题目：</color>{0}',cfg_tiku.title)
self.tmtxt:setText(tstr)
local tipstr=FMT.fmt('谜底文字数量：{0}',#self.cfg_tiku.answer or"")
self.answertxt:setText(tipstr)

self.leftpanel:setChildCanvasGroupAlpha(0)
self.leftpanel:setChildCanvasGroupDOFade(1,0.8,nil)
for i=1,maxWenzi do
local widget=self.itemwidget:GetChildWidgetBase(i-1)
local option=cfg_tiku.option
if option[i]then
widget:SetChildActive(itemidx.wzitem,true)
widget:SetChildCanvasGroupAlpha(itemidx.img,1)
widget:SetChildText(itemidx.txt,option[i])
widget:SetChildButtonClick(itemidx.img,function(...)
if _this==nil then return end
self:onLeftClickItem(i,option[i])
end)
else
widget:SetChildActive(itemidx.wzitem,false)
end
end


for i=1,maxxuanze do
local widget=self.rgwidget:GetChildWidgetBase(i-1)
widget:SetChildText(rightidx.txt,"")
if not self.chooseidx[i]then
widget:SetChildActive(rightidx.lock,true)
else
widget:SetChildActive(rightidx.lock,false)
end
end


local skills=self.subcfg.skills
for k,v in ipairs(self.gnitemalist)do
local widget=v:getChildWidgetBase()
if skills[k]then
widget:SetChildActive(skillidx.selfitem,true)
local skillid=skills[k][1]
local maxnum=skills[k][3]
local skillcfg=cfg_lanternriddlesshelfconfig_get(skillid)
local desc=skillcfg.desc
local useNum=self:getSkillNumbyID(skillid)
local _str=""
if useNum>=maxnum then
_str=FMT.fmt('{0}（剩: <color=#c82c2c>{1}次</color>）',desc,maxnum-useNum)
else
_str=FMT.fmt('{0}（剩: {1}次）',desc,maxnum-useNum)
end
widget:SetChildText(skillidx.txt,_str)
else
widget:SetChildActive(skillidx.selfitem,false)
end
end
end

function UISubAct_ZQDMtitleWin:closethiswin()
_this.infoPanel:setChildCanvasGroupDOFade(0,0.5,function()
if _this==nil then return end
_this.infoPanel:setActive(false)
local temp=
{
act_id=_this.actID,
sub_act_type=_this.subType,
sub_act_id=_this.subid,
}
_this:showWindow("UISubAct_ZQDMrewardWin",temp)
end)
end


function UISubAct_ZQDMtitleWin:playskillspeak()
local rand=math.random(1,4)
self.rand=rand
if self.gnitemalist[rand]then
local widget=self.gnitemalist[rand]:getChildWidgetBase()
if rand==1 then
self:doSpeaking_playera(widget,2,nil)
elseif rand==2 then
self:doSpeaking_playerb(widget,2,nil)
elseif rand==3 then
self:doSpeaking_playerc(widget,2,nil)
elseif rand==4 then
self:doSpeaking_playerd(widget,2,nil)
end
end
end

function UISubAct_ZQDMtitleWin:clearplayskillspeak()
if self.rand and self.gnitemalist[self.rand]then
local widget=self.gnitemalist[self.rand]:getChildWidgetBase()
if self.rand==1 then
if self.talkTween1~=nil then
self.talkTween1:Kill()
self.talkTween1=nil
end
if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
elseif self.rand==2 then
if self.talkTween2~=nil then
self.talkTween2:Kill()
self.talkTween2=nil
end
if self.speakShowTimer2 then
self:stopTimerByID(self.speakShowTimer2)
self.speakShowTimer2=nil
end
elseif self.rand==3 then
if self.talkTween3~=nil then
self.talkTween3:Kill()
self.talkTween3=nil
end
if self.speakShowTimer3 then
self:stopTimerByID(self.speakShowTimer3)
self.speakShowTimer3=nil
end
elseif self.rand==4 then
if self.talkTween4~=nil then
self.talkTween4:Kill()
self.talkTween4=nil
end
if self.speakShowTimer4 then
self:stopTimerByID(self.speakShowTimer4)
self.speakShowTimer4=nil
end
end
widget:SetChildScale(skillidx.speakobj,Vector3.zero)
widget:SetChildCanvasGroupAlpha(skillidx.speakobj,0)
self.rand=false
end
end


function UISubAct_ZQDMtitleWin:doSpeaking_playera(widget,type,skillid)
local cfg
if type==1 then
local skillcfg=cfg_lanternriddlesshelfconfig_get(skillid)
cfg=skillcfg.speakskill
widget:SetChildLocalPosX(skillidx.speakobj,-150)
else
cfg=self.subcfg.speakend
widget:SetChildLocalPosX(skillidx.speakobj,-195)
end
if cfg then
local speakList=cfg
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
widget:SetChildCanvasGroupAlpha(skillidx.speakobj,1)
widget:SetChildTrendsTextPlay(skillidx.speaktxt,speakStr,speed,nil)
self:doTalkAnim_playera(widget)
end
end
function UISubAct_ZQDMtitleWin:doTalkAnim_playera(widget)
if self.talkTween1~=nil then
self.talkTween1:Kill()
self.talkTween1=nil
end
widget:SetChildScale(skillidx.speakobj,Vector3.zero)
self:delayDo(0.2,function()
widget:SetChildCanvasGroupAlpha(skillidx.speakobj,1)
self.talkTween1=widget:SetChildDOScale(skillidx.speakobj,1.2,0.2,function()
if self==nil then return end
self.talkTween1=nil
self.talkTween1=widget:SetChildDOScale(skillidx.speakobj,0.9,0.1,function()
if self==nil then return end
self.talkTween1=nil
return self:talkEnda(widget)
end)
end)
end)
end
function UISubAct_ZQDMtitleWin:talkEnda(widget)
if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
self.speakShowTimer=self:delayDo(3.5,function()
if self==nil then return end
widget:SetChildScale(skillidx.speakobj,Vector3.zero)
widget:SetChildCanvasGroupAlpha(skillidx.speakobj,0)
if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end)
end
function UISubAct_ZQDMtitleWin:doSpeaking_playerb(widget,type,skillid)
local cfg
if type==1 then
local skillcfg=cfg_lanternriddlesshelfconfig_get(skillid)
cfg=skillcfg.speakskill
widget:SetChildLocalPosX(skillidx.speakobj,-150)
else
cfg=self.subcfg.speakend
widget:SetChildLocalPosX(skillidx.speakobj,-195)
end
if cfg then
local speakList=cfg
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
widget:SetChildCanvasGroupAlpha(skillidx.speakobj,1)
widget:SetChildTrendsTextPlay(skillidx.speaktxt,speakStr,speed,nil)
self:doTalkAnim_playerb(widget)
end
end
function UISubAct_ZQDMtitleWin:doTalkAnim_playerb(widget)
if self.talkTween2~=nil then
self.talkTween2:Kill()
self.talkTween2=nil
end
widget:SetChildScale(skillidx.speakobj,Vector3.zero)
self:delayDo(0.2,function()
widget:SetChildCanvasGroupAlpha(skillidx.speakobj,1)
self.talkTween2=widget:SetChildDOScale(skillidx.speakobj,1.2,0.2,function()
if self==nil then return end
self.talkTween2=nil
self.talkTween2=widget:SetChildDOScale(skillidx.speakobj,0.9,0.1,function()
if self==nil then return end
self.talkTween2=nil
return self:talkEndb(widget)
end)
end)
end)
end
function UISubAct_ZQDMtitleWin:talkEndb(widget)
if self.speakShowTimer2 then
self:stopTimerByID(self.speakShowTimer2)
self.speakShowTimer2=nil
end
self.speakShowTimer2=self:delayDo(3.5,function()
if self==nil then return end
widget:SetChildScale(skillidx.speakobj,Vector3.zero)
widget:SetChildCanvasGroupAlpha(skillidx.speakobj,0)
if self.speakShowTimer2 then
self:stopTimerByID(self.speakShowTimer2)
self.speakShowTimer2=nil
end
end)
end
function UISubAct_ZQDMtitleWin:doSpeaking_playerc(widget,type,skillid)
local cfg
if type==1 then
local skillcfg=cfg_lanternriddlesshelfconfig_get(skillid)
cfg=skillcfg.speakskill
widget:SetChildLocalPosX(skillidx.speakobj,-150)
else
cfg=self.subcfg.speakend
widget:SetChildLocalPosX(skillidx.speakobj,-195)
end
if cfg then
local speakList=cfg
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
widget:SetChildCanvasGroupAlpha(skillidx.speakobj,1)
widget:SetChildTrendsTextPlay(skillidx.speaktxt,speakStr,speed,nil)
self:doTalkAnim_playerc(widget)
end
end
function UISubAct_ZQDMtitleWin:doTalkAnim_playerc(widget)
if self.talkTween3~=nil then
self.talkTween3:Kill()
self.talkTween3=nil
end
widget:SetChildScale(skillidx.speakobj,Vector3.zero)
self:delayDo(0.2,function()
widget:SetChildCanvasGroupAlpha(skillidx.speakobj,1)
self.talkTween3=widget:SetChildDOScale(skillidx.speakobj,1.2,0.2,function()
if self==nil then return end
self.talkTween3=nil
self.talkTween3=widget:SetChildDOScale(skillidx.speakobj,0.9,0.1,function()
if self==nil then return end
self.talkTween3=nil
return self:talkEndc(widget)
end)
end)
end)
end
function UISubAct_ZQDMtitleWin:talkEndc(widget)
if self.speakShowTimer3 then
self:stopTimerByID(self.speakShowTimer3)
self.speakShowTimer3=nil
end
self.speakShowTimer3=self:delayDo(3.5,function()
if self==nil then return end
widget:SetChildScale(skillidx.speakobj,Vector3.zero)
widget:SetChildCanvasGroupAlpha(skillidx.speakobj,0)
if self.speakShowTimer3 then
self:stopTimerByID(self.speakShowTimer3)
self.speakShowTimer3=nil
end
end)
end
function UISubAct_ZQDMtitleWin:doSpeaking_playerd(widget,type,skillid)
local cfg
if type==1 then
local skillcfg=cfg_lanternriddlesshelfconfig_get(skillid)
cfg=skillcfg.speakskill
widget:SetChildLocalPosX(skillidx.speakobj,-150)
else
cfg=self.subcfg.speakend
widget:SetChildLocalPosX(skillidx.speakobj,-195)
end
if cfg then
local speakList=cfg
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
widget:SetChildCanvasGroupAlpha(skillidx.speakobj,1)
widget:SetChildTrendsTextPlay(skillidx.speaktxt,speakStr,speed,nil)
self:doTalkAnim_playerd(widget)
end
end
function UISubAct_ZQDMtitleWin:doTalkAnim_playerd(widget)
if self.talkTween4~=nil then
self.talkTween4:Kill()
self.talkTween4=nil
end
widget:SetChildScale(skillidx.speakobj,Vector3.zero)
self:delayDo(0.2,function()
widget:SetChildCanvasGroupAlpha(skillidx.speakobj,1)
self.talkTween4=widget:SetChildDOScale(skillidx.speakobj,1.2,0.2,function()
if self==nil then return end
self.talkTween4=nil
self.talkTween4=widget:SetChildDOScale(skillidx.speakobj,0.9,0.1,function()
if self==nil then return end
self.talkTween4=nil
return self:talkEndd(widget)
end)
end)
end)
end
function UISubAct_ZQDMtitleWin:talkEndd(widget)
if self.speakShowTimer4 then
self:stopTimerByID(self.speakShowTimer4)
self.speakShowTimer4=nil
end
self.speakShowTimer4=self:delayDo(3.5,function()
if self==nil then return end
widget:SetChildScale(skillidx.speakobj,Vector3.zero)
widget:SetChildCanvasGroupAlpha(skillidx.speakobj,0)
if self.speakShowTimer4 then
self:stopTimerByID(self.speakShowTimer4)
self.speakShowTimer4=nil
end
end)
end


function UISubAct_ZQDMtitleWin:clearAnserdata(actid,subtype,suid)
local key_AnserIdx=FMT.fmt('ActivityZQDM_act{0}_sub{1}_subid{2}_AnserIdx',actid,subtype,suid)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eZhongQiuDengMi,key_AnserIdx,0)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZhongQiuDengMi)
end

function UISubAct_ZQDMtitleWin:clearSkilldata(actid,subtype,suid)
local key_skillnum=FMT.fmt('ActivityZQDM_act{0}_sub{1}_subid{2}_skillnum',actid,subtype,suid)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eZhongQiuDengMi,key_skillnum,{})
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZhongQiuDengMi)
end


function UISubAct_ZQDMtitleWin:printtiltletest()
local answerlist=_this.cfg_tiku.answer
local option=_this.cfg_tiku.option
local str=""
for k,v in ipairs(answerlist)do
local char=option[v]
if char then
str=FMT.fmt('{0}{1}',str,char)
end
end
UIManager.error(str)
end
