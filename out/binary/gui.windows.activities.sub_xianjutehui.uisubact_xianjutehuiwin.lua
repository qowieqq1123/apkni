







def_class("UISubAct_XianJuTeHuiWin",UIWindowBase)









function UISubAct_XianJuTeHuiWin:bindComponents()

self.spinebg=UIObject.get(self,0)
self.boxImg=UIImage.get(self,1)
self.boxClick=UIButton.get(self,1)
self.rechargebtnClick=UIButton.get(self,2)
self.rechargenumtxt=UIText.get(self,3)
self.functioninforoot=UIObject.get(self,4)
self.functioninfo=UIText.get(self,5)
self.buildspine=UIObject.get(self,6)
self.buildnameroot=UIObject.get(self,7)
self.buildname=UIText.get(self,8)
self.builddescroot=UIObject.get(self,9)
self.desc1=UIText.get(self,10)
self.desc2=UIText.get(self,11)
self.buildsizeinfo=UIObject.get(self,12)
self.sizeinfo=UIText.get(self,13)
self.sizemodel=UIScrollView.get(self,14)
self.reddot=UIObject.get(self,15)
self.shouqing=UIObject.get(self,16)
self.countdownroot=UIObject.get(self,17)
self.countdowntxt=UIText.get(self,18)
self.desc1root=UIObject.get(self,19)
self.desc2root=UIObject.get(self,20)

self.rechargebtnClick:setButtonClick(function()
self:onRechargebtnClick()
end)

self.boxClick:setButtonClick(function()
self:onBoxbtnClick()
end)



end


function UISubAct_XianJuTeHuiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.spinebg);self.spinebg=nil;
_UIObject_release(self.boxImg);self.boxImg=nil;
_UIObject_release(self.boxClick);self.boxClick=nil;
_UIObject_release(self.rechargebtnClick);self.rechargebtnClick=nil;
_UIObject_release(self.rechargenumtxt);self.rechargenumtxt=nil;
_UIObject_release(self.functioninforoot);self.functioninforoot=nil;
_UIObject_release(self.functioninfo);self.functioninfo=nil;
_UIObject_release(self.buildspine);self.buildspine=nil;
_UIObject_release(self.buildnameroot);self.buildnameroot=nil;
_UIObject_release(self.buildname);self.buildname=nil;
_UIObject_release(self.builddescroot);self.builddescroot=nil;
_UIObject_release(self.desc1);self.desc1=nil;
_UIObject_release(self.desc2);self.desc2=nil;
_UIObject_release(self.buildsizeinfo);self.buildsizeinfo=nil;
_UIObject_release(self.sizeinfo);self.sizeinfo=nil;
_UIObject_release(self.sizemodel);self.sizemodel=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.shouqing);self.shouqing=nil;
_UIObject_release(self.countdownroot);self.countdownroot=nil;
_UIObject_release(self.countdowntxt);self.countdowntxt=nil;
_UIObject_release(self.desc1root);self.desc1root=nil;
_UIObject_release(self.desc2root);self.desc2root=nil;
end
















local _this=nil
local reddotState={
display=0,
hide=1
}




function UISubAct_XianJuTeHuiWin:onLoaded(...)
_this=self
self.ab='ui/windows/activities/sub_xianjutehui/xianjutehui_atlas_pak.ab'
self:bindComponents()
end


function UISubAct_XianJuTeHuiWin:__delete()
self:unbindComponents()
self:stopSelfTimer()
end




function UISubAct_XianJuTeHuiWin:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eXianJuTeHui
self.subid=argtable.sub_act_id
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)

self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
self.startday=self.info.start_day_idx
self.start_time=self.info.start_time
self.end_time=self.info.end_time

self:initView()
end


function UISubAct_XianJuTeHuiWin:onHide()

end


function UISubAct_XianJuTeHuiWin:initView()
self.buildsuitconfig=cfgHelper.get1(cfg_buildsuitconfig_get,self.config.build_suit_id)
self.buildconfig=cfgHelper.get1(cfg_monijybuildconfig_get,self.buildsuitconfig.map)
self.buildspine:setChildUIModelShowTarget(self.buildconfig.model[1],self.config.build_model_scale,{},0,false,false,0,nil)
self.buildspine:setChildUIModelShowTargetOffset(self.config.build_offset[1],self.config.build_offset[2])

self.sizeinfo:setText(FMT.fmt("尺寸{0}x{1}格",self.buildconfig.buid_size[1],self.buildconfig.buid_size[2]))


self.buildname:setText(self.config.build_name)
local descarr=string.split(self.config.build_descs[1],"\n")
local desclen=#descarr
self.desc1:setText(self.config.build_descs[1])
self.desc2:setText(self.config.build_descs[2])
self.desc1root:setChildSizeDelta(30,desclen*31)
self.desc2root:setChildSizeDelta(30,desclen*31)

self.functioninfo:setText(self:getBuffDesc())


self.reddot:setActive(self.info.ex==reddotState.display)
self.shouqing:setActive(self.info.recharge_id~=0)
self.rechargebtnClick:setActive(self.info.recharge_id==0)
self.boxImg:setSprite(self.ab,self.info.ex==reddotState.display and"image_baoxiang_01"or"image_baoxiang_02")

local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,self.config.rechargeid)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
self.rechargenumtxt:setText(str)

self:startCountDown()

self:playFadeIn()
end

function UISubAct_XianJuTeHuiWin:playFadeIn()
self.functioninfo:setChildCanvasGroupAlpha(0)
self.functioninfo:setChildCanvasGroupDOFade(1,1,nil)

self.buildspine:setChildCanvasGroupAlpha(0)
self.buildspine:setChildCanvasGroupDOFade(1,2,nil)

self.buildnameroot:setChildCanvasGroupAlpha(0)
self.buildnameroot:setChildCanvasGroupDOFade(1,2.5,nil)

self.builddescroot:setChildCanvasGroupAlpha(0)
self.builddescroot:setChildCanvasGroupDOFade(1,2.7,nil)

self.buildsizeinfo:setChildCanvasGroupAlpha(0)
self.buildsizeinfo:setChildCanvasGroupDOFade(1,3,nil)
end

function UISubAct_XianJuTeHuiWin:getBuffDesc()
local desc=""
for k,v in pairs(self.buildsuitconfig.guild_buffs)do
local effects=cfgHelper.get2(cfg_guildstateconfig_get,v,'effects')
for kk,vv in pairs(effects)do
local str=cfgHelper.get2(cfg_guildstateeffectconfig_get,vv,'desc')

desc=FMT.fmt("{0}{1}",desc,str)
if kk<#effects then
desc=FMT.fmt("{0}{1}",desc,'\n')
end
end
if k<#self.buildsuitconfig.guild_buffs then
desc=FMT.fmt("{0}{1}",desc,'\n')
end
end
return desc
end





function UISubAct_XianJuTeHuiWin:onRechargebtnClick()
local callback=function()
local rechargeId=_this.config.rechargeid
local params=payControl.getActivityPayParams(_this.actid,_this.subType,_this.subid)
payControl.reqPay(rechargeId,1,params)
end
local itemlist={}
local rewardlist=cfgHelper.get2(cfg_xianjutehuiactconfig_get,_this.subid,'recharge_reward')

if rewardlist[_this.config.rechargeid]then
for k,v in pairs(rewardlist[_this.config.rechargeid])do
local itemid=v[1]
local itemcount=v[2]
table.insert(itemlist,{itemid=itemid,itemcount=itemcount})
end
end


local show_data={
type='UIDialougeBuyWithReward',
title='限购礼包',
oktext='确定',
canceltext='取消',
itemlist=itemlist,
tip="限购： 0/1",
showclosebtn=true,
okcallback=function()
if _this==nil then return end
callback()
end,
cancelcallback=nil,
closecallback=nil,
canvasindex=5,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

AudioManager.playOpenUI()
end

function UISubAct_XianJuTeHuiWin:onBoxbtnClick()
if self.info.ex==reddotState.display then
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actid,self.subType,self.subid,"")
end
end



function UISubAct_XianJuTeHuiWin:recv_recharged(actID,subType,subID)
self.info=activitiesModel:getSubActInfo(actID,subType,subID)
self.shouqing:setActive(self.info.recharge_id~=0)
self.rechargebtnClick:setActive(self.info.recharge_id==0)
end


function UISubAct_XianJuTeHuiWin:recv_reward(actID,subType,subID)
self.info=activitiesModel:getSubActInfo(actID,subType,subID)
self.reddot:setActive(self.info.ex==reddotState.display)
self.boxImg:setSprite(self.ab,self.info.ex==reddotState.display and"image_baoxiang_01"or"image_baoxiang_02")
end




function UISubAct_XianJuTeHuiWin:startCountDown()
local time=activitiesModel:getSubActEndLeftTime(self.actid,self.subType,self.subid)
self.stamp=os.time()+time


self:stopSelfTimer()

local func=function()
if self==nil then return end
local left=self.stamp-os.time()
if left<0 then left=0 end
self.countdowntxt:setText(timeHelper.format_time_stamp3(left))
end
self.timer=self:setTimer(1,0,func)
func()
end

function UISubAct_XianJuTeHuiWin:stopSelfTimer()
if self.timer then
self:stopTimerByID(self.timer)
end
self.timer=nil
end

