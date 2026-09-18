







def_class("UILianQiMGExcharge",UIWindowBase)









function UILianQiMGExcharge:bindComponents()

self.cancelBtn=UIButton.get(self,0)
self.desc1Txt=UIText.get(self,1)
self.desc2Txt=UIText.get(self,2)
self.frameSp=UIObject.get(self,3)
self.gotoBtn=UIButton.get(self,4)
self.modelMao=UIObject.get(self,5)
self.root=UIObject.get(self,6)
self.scrollView=UIObject.get(self,7)
self.showToggle=UIToggleButton.get(self,8)
self.speakObj=UIObject.get(self,9)
self.speakText=UIText.get(self,10)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)



end


function UILianQiMGExcharge:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.desc1Txt);self.desc1Txt=nil;
_UIObject_release(self.desc2Txt);self.desc2Txt=nil;
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.modelMao);self.modelMao=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.showToggle);self.showToggle=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
end
















local _this




function UILianQiMGExcharge:onLoaded(...)
self:bindComponents()

_this=self

self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)

self.root:setChildCanvasGroupAlpha(0)
self.frameSp:setChildUIModelShowTarget(4701,1,{},2040,false,false,0,function()
if _this==nil then return end
_this:delayDo(0.35,function()
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end)
self.modelMao:setChildUIModelShowTarget(4016,0.3,{},eAnimationID.stand,false,false,0,nil)
self.modelMao:setChildUIModelShowFlipX(true)
end


function UILianQiMGExcharge:__delete()
local flag=self.showToggle:getToggle()

self:unbindComponents()

_this=nil

if flag then
local key=FMT.fmt("act_lianqidahui_open_{0}_{1}",self.actId,self.subId)
onlineDataSetting:setData(key,true)
end
end




function UILianQiMGExcharge:onShow(argtable,afterOnloaded)
self.actId=argtable.act_id
self.subType=argtable.sub_act_type
self.subId=argtable.sub_act_id

self.config=cfgHelper.get1(cfg_artifactrefineconfig_get,self.subId)
local dhName=moneyModel.getMoneyName(self.config.auto[1][3])
local color1=FONT_COLOR_VAL[FONT_COLOR.ePurpleColor]
local color2=FONT_COLOR_VAL[FONT_COLOR.eGreenColor]
local color3=FONT_COLOR_VAL[FONT_COLOR.eBlueColor]
local descText=FMT.fmt('<color={1}>【{0}】</color>将于<color={2}>',self.config.sub_name,color1,color2)..'{0}'
..FMT.fmt('</color>后结算，结算后1小时以下活动资源将自动兑换为<color={1}>{0}</color>，请及时使用，避免浪费',dhName,color3)
self:setDescCountDown(descText)

if self.needClose then
self.needClose=nil
self:onCancelBtn()
return
end

local exList=argtable.exList
self:setExchargeList(exList)

self.talklist=self.config.speak_list
if self.talklist and#self.talklist>0 then
self:playSpeak(2)
end
end


function UILianQiMGExcharge:onHide()

end

function UILianQiMGExcharge:setDescCountDown(dtext)
if not self.nTimer then
local info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
local etime=info.end_time-self.config.earlyEndTime
local tick=function()
local dt=etime-gameUtilityModel.getServerShortTime()
self.desc1Txt:setText(FMT.fmt(dtext,timeHelper.format_time_stamp11(dt,true)))
if dt<0 then
self:stopTimerByID(self.nTimer)
self.nTimer=nil
self.needClose=true
end
end
self.nTimer=self:setTimer(1,0,tick)
tick()
end
end

function UILianQiMGExcharge:setExchargeList(ehlist)
local len=#ehlist
self.scrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.scrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=ehlist[i]
local exc=itemsModel.getCount(data[1])
local rate=math.floor(exc/data[2])
widgetHelper.setNormalRewardItem(item,0,{data[1],exc})
item:SetChildText(1,itemsConfig.getItemName(data[1]))
widgetHelper.setNormalRewardItem(item,2,{data[3],data[4]*rate})
item:SetChildText(3,itemsConfig.getItemName(data[3]))
end
end


function UILianQiMGExcharge:playSpeak(delay)
self:clearTalk()
if delay~=nil and delay>0 then
self.nextTalkTimer=self:delayDo(delay,function()
self.nextTalkTimer=nil
self:doSpeaking()
end)
else
self:doSpeaking()
end
end

function UILianQiMGExcharge:doSpeaking()
local talkarr=self.talklist
local speakStr=table.randomIndex(talkarr)
self.speakObj:setChildCanvasGroupAlpha(1)
local speed=30
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
self:doTalkAnim()
self.talkLifeTimer=self:delayDo(5,function()
self.talkLifeTimer=nil
self:finishSpeak()
end)
end

function UILianQiMGExcharge:doTalkAnim()
self.speakObj:setScale(Vector3.zero)
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween=self.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween=nil
_this.talkTween=_this.speakObj:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween=nil
end)
end)
end

function UILianQiMGExcharge:finishSpeak()
self.speakObj:setChildCanvasGroupAlpha(0)

self:playSpeak(5)
end

function UILianQiMGExcharge:clearTalk()
if self.nextTalkTimer~=nil then
self:stopTimerByID(self.nextTalkTimer)
self.nextTalkTimer=nil
end
if self.talkLifeTimer~=nil then
self:stopTimerByID(self.talkLifeTimer)
self.talkLifeTimer=nil
end
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
self.speakObj:setChildCanvasGroupAlpha(0)
end




function UILianQiMGExcharge:onCancelBtn()
self:closeSelf()
end

function UILianQiMGExcharge:onGotoBtn()
jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=self.subType,subid=self.subId}})
end

