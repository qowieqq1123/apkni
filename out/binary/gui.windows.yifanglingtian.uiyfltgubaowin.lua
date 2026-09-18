







def_class("UIYFLTgubaoWin",UIWindowBase)









function UIYFLTgubaoWin:bindComponents()

self.addlyBtn=UIButton.get(self,0)
self.allLY=UIText.get(self,1)
self.btntext=UIText.get(self,2)
self.bulidEffect=UIText.get(self,3)
self.check=UIButton.get(self,4)
self.gubaoimage=UIImage.get(self,5)
self.haveintroduce=UIText.get(self,6)
self.icon=UIObject.get(self,7)
self.introduce=UIText.get(self,8)
self.lyicon=UIObject.get(self,9)
self.lyjindu=UIObject.get(self,10)
self.num=UIText.get(self,11)
self.rightPanel=UIObject.get(self,12)
self.ShowCuiShu=UIButton.get(self,13)
self.single=UIText.get(self,14)
self.title=UIText.get(self,15)

self.addlyBtn:setButtonClick(function()self:onAddlyBtn()end)

self.check:setButtonClick(function()self:onCheck()end)

self.ShowCuiShu:setButtonClick(function()self:onShowCuiShu()end)



end


function UIYFLTgubaoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addlyBtn);self.addlyBtn=nil;
_UIObject_release(self.allLY);self.allLY=nil;
_UIObject_release(self.btntext);self.btntext=nil;
_UIObject_release(self.bulidEffect);self.bulidEffect=nil;
_UIObject_release(self.check);self.check=nil;
_UIObject_release(self.gubaoimage);self.gubaoimage=nil;
_UIObject_release(self.haveintroduce);self.haveintroduce=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.introduce);self.introduce=nil;
_UIObject_release(self.lyicon);self.lyicon=nil;
_UIObject_release(self.lyjindu);self.lyjindu=nil;
_UIObject_release(self.num);self.num=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.ShowCuiShu);self.ShowCuiShu=nil;
_UIObject_release(self.single);self.single=nil;
_UIObject_release(self.title);self.title=nil;
end



















function UIYFLTgubaoWin:onLoaded(...)
self:bindComponents()
end


function UIYFLTgubaoWin:__delete()
self:unbindComponents()
end




function UIYFLTgubaoWin:onShow(argtable,afterOnloaded)


self:ShowGuBaoData()
self:SetLingYeData()
end


function UIYFLTgubaoWin:onHide()

end


function UIYFLTgubaoWin:SetNotGubaoData()
local num,maxnum=YiFangLingTianModel:GetLingYeNum()
self.num:setText(string.format("灵液数量：<color=#171311>%d/%d</color>",num,maxnum))
self.introduce:setActive(true)
self.introduce:setText(string.format("尚未获得%s无法恢复灵液",self.xbCfg.name))
self.haveintroduce:setActive(false)
self.gubaoimage:setGray(true)
self.single:setActive(false)
self.allLY:setActive(false)
self.lyicon:setChildUIProgressbar(num,maxnum,false)
self.btntext:setText("获取"..self.xbCfg.name)
end

function UIYFLTgubaoWin:SetLingYeData()
if YiFangLingTianModel:Getbegintimes()==0 then
self:SetNotGubaoData()
return
end
self.gubaoimage:setGray(false)
self.introduce:setActive(false)
self.haveintroduce:setActive(true)
self.single:setActive(true)

self.allLY:setActive(false)
self.btntext:setText("催熟灵植")
local basecfg=cfg_yifanglintianconfig().const_def

local gubaolv=xianbaoModel:getXbStart_liandon(cfg_yifanglintianconfig().const_def.unlock_lingye_gubao_id)
local lingye_redece_times=basecfg.lingye_redece_times
local lingye_redece_times=lingye_redece_times[gubaolv]
local lynum,maxnum=YiFangLingTianModel:GetLingYeNum()
local onelyyear=gameUtilityModel.calculateGameYearFloor(lingye_redece_times)
local text=""
if lynum==0 then
text=string.format("每滴灵液+%d年，总共<color=#c82c2c>+%d年</color>",onelyyear,lynum*onelyyear)
else
text=string.format("每滴灵液+%d年，总共+%d年",onelyyear,lynum*onelyyear)
end
self.haveintroduce:setText(string.format("每滴灵液+%d年，总共+%d年",onelyyear,lynum*onelyyear))
local func=function()
local time,alltime=YiFangLingTianModel:GetLingYeTime()
local timestr=timeHelper.format_time_stamp(time,false)
local alltimestr=timeHelper.format_time_stamp(alltime,false)

self.single:setText(string.format("恢复一滴灵液：<color=#549327>%s</color>",timestr))

local num,maxnum=YiFangLingTianModel:GetLingYeNum()
self.num:setText(string.format("灵液数量：<color=#171311>%d/%d</color>",num,maxnum))

self.lyicon:setChildUIProgressbar(num,maxnum,false)
if time==0 then
if self.lytime then
self:stopTimerByID(self.lytime)
self.lytime=nil
end
end
end
if not self.lytime then
self.lytime=self:setTimer(0,0,func)
end



local num,maxnum=YiFangLingTianModel:GetLingYeNum()
self.num:setText(string.format("灵液数量：<color=#171311>%d/%d</color>",num,maxnum))

self.lyicon:setChildUIProgressbar(num,maxnum,false)
end


function UIYFLTgubaoWin:ShowGuBaoData()

self.xbId=cfg_yifanglintianconfig().const_def.unlock_lingye_gubao_id
if not xianbaoModel:checkActive(self.xbId)then
local glid=liandonModel:CheckXB_Guanlian(self.xbId)
if glid then
if xianbaoModel:checkActive(glid)then
self.xbId=glid
else
local startStr=cfgHelper.get2(cfg_yifanglingtianbaseconfig_get,1,"showXB_time")
local startTime=timeHelper.dataToTimeStam(startStr)
local time=timeHelper.getServerLongTime()
if time>startTime then
self.xbId=glid
end
end
end
end
self.xbCfg=cfgHelper.get1(cfg_xianbaoconfig_get,self.xbId)
local xianbao_introduce=self.xbCfg.story

self.gubaoimage:setImageIcon(self.xbCfg.bigicon,false)
self.bulidEffect:setText(xianbao_introduce)
self.title:setText(self.xbCfg.name.."灵液")
end

function UIYFLTgubaoWin:onClickClose()
self:closeSelf()
end


function UIYFLTgubaoWin:onCheck()
local gbid=self.xbCfg.id
tipsManager.showTipsXB({formType=TIPS_FORM_TYPE.eNone,tipsType=TIPS_TYPE.eCommonXianBao,itemid=gbid,bg=false,funType=TIPS_FUNC_TYPE.eXianBao})
end


function UIYFLTgubaoWin:onShowCuiShu()

if YiFangLingTianModel:Getbegintimes()==0 then
local itemid=0
for k,v in pairs(self.xbCfg.active)do
itemid=k
break
end
local activeflag=xianbaoModel:checkCanActive(self.xbCfg.id)
if activeflag then
jumpManager:jump({id=JUMP_TYPE.eXBTujian})
else
gainControl:showGainWin(itemid)
end


else
UIManager:showWindow('UIYFLTcuishuWin')
self:onClickClose()
end
end

function UIYFLTgubaoWin:onAddlyBtn()
YiFangLingTianModel:openlyGainWin()
end


