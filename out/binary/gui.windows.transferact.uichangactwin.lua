







def_class("UIChangActWin",UIWindowBase)









function UIChangActWin:bindComponents()

self.root=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.bgmodel=UIObject.get(self,2)
self.back=UIButton.get(self,3)
self.dayitem1=UIObject.get(self,4)
self.dayitem2=UIObject.get(self,5)
self.dayitem3=UIObject.get(self,6)
self.titleimg=UIObject.get(self,7)
self.rwItem1=UIObject.get(self,8)
self.rwItem2=UIObject.get(self,9)
self.rwItem3=UIObject.get(self,10)
self.djstxt=UIText.get(self,11)
self.getbtn=UIButton.get(self,12)
self.ylqimg=UIObject.get(self,13)
self.getbtnred=UIObject.get(self,14)
self.testtxt=UIText.get(self,15)
self.speakObj=UIObject.get(self,16)
self.speakText=UIText.get(self,17)
self.copyBtn=UIButton.get(self,18)
self.bgmodel2=UIObject.get(self,19)
self.bgmodel3=UIObject.get(self,20)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.back:setButtonClick(function()self:onBack()end)

self.getbtn:setButtonClick(function()self:onGetbtn()end)

self.copyBtn:setButtonClick(function()self:onCopyBtn()end)



end


function UIChangActWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.bgmodel);self.bgmodel=nil;
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.dayitem1);self.dayitem1=nil;
_UIObject_release(self.dayitem2);self.dayitem2=nil;
_UIObject_release(self.dayitem3);self.dayitem3=nil;
_UIObject_release(self.titleimg);self.titleimg=nil;
_UIObject_release(self.rwItem1);self.rwItem1=nil;
_UIObject_release(self.rwItem2);self.rwItem2=nil;
_UIObject_release(self.rwItem3);self.rwItem3=nil;
_UIObject_release(self.djstxt);self.djstxt=nil;
_UIObject_release(self.getbtn);self.getbtn=nil;
_UIObject_release(self.ylqimg);self.ylqimg=nil;
_UIObject_release(self.getbtnred);self.getbtnred=nil;
_UIObject_release(self.testtxt);self.testtxt=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.copyBtn);self.copyBtn=nil;
_UIObject_release(self.bgmodel2);self.bgmodel2=nil;
_UIObject_release(self.bgmodel3);self.bgmodel3=nil;
end
















local dayitem=
{
selitem=0,
btn=1,
txt=2,
chooseimg=3,
reddot=4,
}
local _this
local abname2="ui/windows/firstrecharge/firstrecharge_atlas_pak.ab"





function UIChangActWin:onLoaded(...)
self:bindComponents()
_this=self
self.selectid=1
self.libaoid=0
self.dayitems={self.dayitem1,self.dayitem2,self.dayitem3}
self.rwlist={self.rwItem1,self.rwItem2,self.rwItem3}
end


function UIChangActWin:__delete()
self:unbindComponents()
self:clearTimer()
self:cleartxttimer()
self:cleartalktimer()
_this=nil
end




function UIChangActWin:onShow(argtable,afterOnloaded)


self.bgmodel:setChildUIModelShowTarget(6040,1,nil,eAnimationID.stand)
self.bgmodel2:setChildUIModelShowTarget(2113002,1,nil,eAnimationID.stand)
self.bgmodel2:setChildUIModelShowFlipX(true)
self.bgmodel3:setChildUIModelShowTarget(6039,1,nil,eAnimationID.stand)

self.is_converted_package=ChangeActController:getis_converted_package()
self.show_text=ChangeActController:getshow_text()
self.show_text_blink=ChangeActController:getshow_text_blink()
self.show_text_color=ChangeActController:getshow_text_color()

local txtarry=string.split(self.show_text_color,',')

if txtarry and#txtarry>0 then
self.wztopidx=tonumber(txtarry[1])
self.wzlastidx=tonumber(txtarry[2])
self.wzcolor=txtarry[3]
end

self.ispeaking=false
self:freshinfo()
ChangeActController:freshReddot()
end


function UIChangActWin:onHide()

end

function UIChangActWin:onCloseBtn()
end
function UIChangActWin:onBack()
end

function UIChangActWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end
function UIChangActWin:cleartxttimer()
if self.txttimer then
self:stopTimerByID(self.txttimer)
self.txttimer=nil
end
end
function UIChangActWin:cleartalktimer()
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
end

function UIChangActWin:onChooseBtn(index,libid)
if self.selectid==index then
return
end
local oldselect=self.selectid
self.selectid=index
self.libaoid=libid

local olditem=self.dayitems[oldselect]
if olditem then
local widget=olditem:getWidgetBase()

widget:SetChildCSImageSprite(dayitem.btn,abname2,"button_schlday_1")
end

local newitem=self.dayitems[self.selectid]
if newitem then
local widget=newitem:getWidgetBase()

widget:SetChildCSImageSprite(dayitem.btn,abname2,"button_schlday_2")
end

self:freshrewards(self.libaoid)
self:freshTimes(self.libaoid)
self:freshSinglereddot(self.selectid,self.libaoid)

if index>1 and self.is_converted_package==0 then
if not self.ispeaking then
self.ispeaking=true
self:delayDo(0.3,function()
self:doSpeaking()
end)
end
end
end

function UIChangActWin:onGetbtn()
local iscanget=FreeGiftController.GetFreeGift(self.libaoid)
local isgettime=self:checkCanGet(self.selectid)
if not iscanget then
UIManager.info("该礼包已领取")
return
end
if not isgettime then
UIManager.info(self.djsstr)
return
end
if self.selectid>1 and self.is_converted_package==0 then


self:doSpeaking()

return
end



FreeGiftController.SendFreeGift(self.libaoid,nil,function()
if _this==nil then return end
self:freshTimes(_this.libaoid)
self:freshSinglereddot(_this.selectid,_this.libaoid)
ChangeActController:freshReddot()
reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
ChangeActController:freshEntry()
end)
end

function UIChangActWin:onCopyBtn()

local accountStr=self.show_text
if accountStr==nil or accountStr==''or accountStr=='nil'then
accountStr='未知'
end

if deviceHelper.isRunIOS()then
if api_Available_SetSystemCopyBuffer()then
CS.GameInterface.SetSystemCopyBuffer(accountStr)
end
else
local result=platformHelper.copyTextToClipboard(accountStr)
if result then
UIManager.info("复制成功")
else
UIManager.error("复制失败")
end
end
end


function UIChangActWin:freshinfo()
local hdcfg=cfg_huanduanconfig_get(1)
local titleimg=hdcfg.titleimg
local freelsit=hdcfg.freelsit
self.getbtnred:setActive(false)

for k,v in ipairs(self.dayitems)do
local widget=v:getWidgetBase()
if freelsit and freelsit[k]then
widget:SetChildActive(dayitem.selitem,true)
local str=FMT.fmt("第{0}天",k)
widget:SetChildText(dayitem.txt,str or"")

local libid=freelsit[k]
if self.selectid==k then

widget:SetChildCSImageSprite(dayitem.btn,abname2,"button_schlday_2")
self.libaoid=libid
self:freshrewards(libid)
self:freshTimes(libid)
else

widget:SetChildCSImageSprite(dayitem.btn,abname2,"button_schlday_1")
end


self.getbtn:setGray(false)
local iscanget=FreeGiftController.GetFreeGift(libid)
if iscanget then
local isgettime=self:checkCanGet(k)
if isgettime then
widget:SetChildActive(dayitem.reddot,true)
if self.selectid==k then
self.getbtnred:setActive(true)
self.getbtn:setGray(false)
end
else
widget:SetChildActive(dayitem.reddot,false)
if self.selectid==k then
self.getbtn:setGray(true)
end
end
else
widget:SetChildActive(dayitem.reddot,false)
if self.selectid==k then
self.getbtn:setGray(true)
end
end


widget:SetChildButtonClick(dayitem.btn,function()
if _this==nil then return end
self:onChooseBtn(k,libid)
end)
else
widget:SetChildActive(dayitem.selitem,false)
end
end
end

function UIChangActWin:freshrewards(libid)
local freeCfg=cfg_freegiftconfig_get(libid)
local rewards=freeCfg.rewards or{}
local len=#self.rwlist
for i=1,len do
local item=self.rwlist[i]:getWidgetBase()
local data=rewards[i]
if data then
item:SetChildActive(0,true)
local itemId=data[1]
local itemCount=data[2]
local showEffFlag=false
local countStr=itemCount>1 and mathHelper.formatNumber2(itemCount)or''
local showCountBG=itemCount>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=showEffFlag}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(1,prop)
item:SetBaseItemClickEvent(1,function(...)
if _this==nil then return end
self:onClickItemitem(itemId)
end)
else
item:SetChildActive(0,false)
end
end
end
function UIChangActWin.getPassDay(startStamp)
local curStamp=timeHelper.getServerLongTime()
local stamp=startStamp
local left=curStamp-stamp

left=left>0 and left or 0
local onydaysec=86400
local firstPass=timeHelper.getServerLongStampPass(stamp)
local firstLeft=onydaysec-firstPass
if left>0 then
if left<firstLeft then
return 1
elseif left>=firstLeft then
local dayLeft=left-firstLeft
return math.ceil(dayLeft/onydaysec)+1
end
end
return 0
end

function UIChangActWin:freshTimes(libid)
local begin_time=ChangeActController:getbegin_time()


local passDay=UIChangActWin.getPassDay(begin_time)
local nowdayidx=self.selectid

if passDay>=nowdayidx then
self:clearTimer()
self.djstxt:setText("可领取")
else

self:clearTimer()
local tick=function()
local passDay2=UIChangActWin.getPassDay(begin_time)
if passDay2>=nowdayidx then
self:clearTimer()
self.djstxt:setText("可领取")
self:freshSinglereddot(nowdayidx,libid)
else
local todayLeft=timeHelper.getServerTodayLeft()
local nextday=(nowdayidx-2)*86400
local needtime=todayLeft+nextday

if needtime>=0 then
local str=FMT.fmt('{0}后可领取',timeHelper.format_time_stamp3(needtime,true))
self.djstxt:setText(str)
self.djsstr=str
else
self:clearTimer()
self.djstxt:setText("可领取")
self:freshSinglereddot(nowdayidx,libid)
end
end
end
self.timer=self:setTimer(1,0,tick)
tick()
end


local iscanget=FreeGiftController.GetFreeGift(libid)
if iscanget then
self.getbtn:setActive(true)
self.ylqimg:setActive(false)
else
self.getbtn:setActive(false)
self.ylqimg:setActive(true)
self.djstxt:setText("")
end
end

function UIChangActWin:freshSinglereddot(selectid,libaoid)
self.getbtnred:setActive(false)
local newitem=self.dayitems[selectid]
if newitem then
local widget=newitem:getWidgetBase()
local iscanget=FreeGiftController.GetFreeGift(libaoid)
if iscanget then
local isgettime=self:checkCanGet(selectid)
if isgettime then
widget:SetChildActive(dayitem.reddot,true)
if self.selectid==selectid then
self.getbtnred:setActive(true)
self.getbtn:setGray(false)
end
else
widget:SetChildActive(dayitem.reddot,false)
if self.selectid==selectid then
self.getbtn:setGray(true)
end
end
else
widget:SetChildActive(dayitem.reddot,false)
if self.selectid==selectid then
self.getbtn:setGray(true)
end
end
end
end


function UIChangActWin:onClickItemitem(itemId)
if itemId then
tipsManager.showTips({itemid=itemId,itemguid=nil,showModel=true,move=TIPS_MOVE_POS.eCenter})
end
end

function UIChangActWin:checkCanGet(selectid)
local isget=false
local begin_time=ChangeActController:getbegin_time()
local passDay=timeHelper.getPassDay(begin_time)
local nowdayidx=selectid
if passDay>=nowdayidx then
isget=true
else
local todayLeft=timeHelper.getServerTodayLeft()
local nextday=(nowdayidx-2)*86400
local needtime=todayLeft+nextday
if needtime<=0 then
isget=true
end
end
return isget
end

function UIChangActWin:freshAllreddot()
local hdcfg=cfg_huanduanconfig_get(1)
local freelsit=hdcfg.freelsit
self.getbtnred:setActive(false)
for k,v in ipairs(self.dayitems)do
local widget=v:getWidgetBase()
if freelsit and freelsit[k]then
local libid=freelsit[k]
local iscanget=FreeGiftController.GetFreeGift(libid)
if iscanget then
local isgettime=self:checkCanGet(k)
if isgettime then
widget:SetChildActive(dayitem.reddot,true)
if self.selectid==k then
self.getbtnred:setActive(true)
end
else
widget:SetChildActive(dayitem.reddot,false)
end
else
widget:SetChildActive(dayitem.reddot,false)
end
end
end
end



function UIChangActWin:doSpeaking()
self:cleartalktimer()
local text=self.show_text
self.speakObj:setChildCanvasGroupAlpha(1)
if self.show_text_blink and self.show_text_blink==1 then
self:duihuaAnima(text)
else
self.speakText:setText(text or"")
end
self:doTalkAnim()
end

function UIChangActWin:doTalkAnim()
self:cleartalktimer()
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

function UIChangActWin:talkEnd()
self:clearSpeakTimer()
self.speakShowTimer=self:delayDo(self.npcTalkShowTime,function()

self.speakObj:setScale(Vector3.zero)

self.speakTimer=self:delayDo(self.npcTalkTime,function()
return self:doSpeaking()
end)
end)
end

function UIChangActWin:duihuaAnima(text)
self:cleartxttimer()

local result=string.toTable(text)

local topidx=1
local lastidx=#result


























local strarry={}
for k=1,#result do
local aa=''
local bb=''
local cc=''
for i=1,#result do
if k==i then
bb=result[i]
elseif k>i then
aa=FMT.fmt("{0}{1}",aa,result[i])
elseif k<i then
cc=FMT.fmt("{0}{1}",cc,result[i])
end
end
local str=FMT.fmt("<color=#00000000>{0}</color>{1}<color=#00000000>{2}</color>",aa,bb,cc)
if self.wztopidx then
if k>=self.wztopidx and k<=self.wzlastidx then
str=FMT.fmt("<color=#00000000>{0}</color><color={3}>{1}</color><color=#00000000>{2}</color>",aa,bb,cc,self.wzcolor or"#c82c2c")
end
end
strarry[k]=str
end
local tick=function()
if topidx<=lastidx then
self.testtxt:setChildCanvasGroupAlpha(0)
self.testtxt:setChildCanvasGroupDOFade(1,0.12,nil)
self.speakText:setText(strarry[topidx]or"")
topidx=topidx+1
else
topidx=1
end
end
self.txttimer=self:setTimer(0.3,0,tick)
tick()
end



function UIChangActWin:testwenzi()
_this:duihuaAnima()
end

