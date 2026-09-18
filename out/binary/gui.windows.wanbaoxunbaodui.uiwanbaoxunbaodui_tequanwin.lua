







def_class("UIWanBaoXunBaoDui_TeQuanWin",UIWindowBase)









function UIWanBaoXunBaoDui_TeQuanWin:bindComponents()

self.root=UIObject.get(self,0)
self.infoList=UIObject.get(self,1)
self.modelInfo=UIObject.get(self,2)
self.buyBtn=UIButton.get(self,3)
self.model=UIObject.get(self,4)
self.info=UIObject.get(self,5)
self.name=UIText.get(self,6)
self.buyNum=UIText.get(self,7)
self.infomationBtn=UIButton.get(self,8)
self.btnspine=UIObject.get(self,9)
self.receiveState=UIObject.get(self,10)
self.graybtn=UIButton.get(self,11)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)

self.infomationBtn:setButtonClick(function()self:onInfomationBtn()end)

self.graybtn:setButtonClick(function()self:onGraybtn()end)



end


function UIWanBaoXunBaoDui_TeQuanWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.infoList);self.infoList=nil;
_UIObject_release(self.modelInfo);self.modelInfo=nil;
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.info);self.info=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.buyNum);self.buyNum=nil;
_UIObject_release(self.infomationBtn);self.infomationBtn=nil;
_UIObject_release(self.btnspine);self.btnspine=nil;
_UIObject_release(self.receiveState);self.receiveState=nil;
_UIObject_release(self.graybtn);self.graybtn=nil;
end



















function UIWanBaoXunBaoDui_TeQuanWin:onLoaded(...)
self:bindComponents()
self:addNotify(notifyConfig.onWanBaoXunBaoDuiUnlockChannel,function(...)self:onWanBaoXunBaoDuiUnlockChannel(...)end)

end


function UIWanBaoXunBaoDui_TeQuanWin:__delete()
self:unbindComponents()
end




function UIWanBaoXunBaoDui_TeQuanWin:onShow(argtable,afterOnloaded)
self:initUI()
end


function UIWanBaoXunBaoDui_TeQuanWin:onHide()

end

function UIWanBaoXunBaoDui_TeQuanWin:initUI()
self.tqCfg=cfgHelper.get1(cfg_cattequanconfig_get,1)












local catCfg=cfgHelper.get1(cfg_catconfig_get,self.tqCfg.catid)
local modelcfg=cfgHelper.get1(cfg_catshowconfig_get,catCfg.show[1][1])
local name=cfgHelper.get1(cfg_catnameconfig_get,modelcfg.nameList[1]).name
self.model:setChildUIModelShowTarget(modelcfg.model,2,nil,eAnimationID.stand,false,false,0,nil)
self.name:setText(wanbaoXunBaoDuiHelper.transLineStr(name))

local rechargeCfg=cfgHelper.get1(cfg_rechargeconfig_get,self.tqCfg.rechargeid)
local str=pfwindowslController:showDesc_ByMoneyType(rechargeCfg)
self.buyNum:setText(FMT.fmt("{0}开启",str))

local tqchannelid=wanbaoXunBaoDuiHelper.getTQChannel()
local channelDatas=wanBaoXunBaoDuiModel:getChannelDatas()
local state=channelDatas[tqchannelid].open_state
self.buyBtn:setActive(not state)
self.receiveState:setActive(state)
self.btnspine:setActive(not state)
self.graybtn:setActive(state)
end

function UIWanBaoXunBaoDui_TeQuanWin:onWanBaoXunBaoDuiUnlockChannel(channel_id)
if channel_id==self.tqCfg.channelid then
self:initUI()
end
end





function UIWanBaoXunBaoDui_TeQuanWin:onInfomationBtn()
local catCfg=cfgHelper.get1(cfg_catconfig_get,self.tqCfg.catid)
local modelcfg=cfgHelper.get1(cfg_catshowconfig_get,catCfg.show[1][1])

local composeCatData={}
composeCatData.guid=Int64_0
composeCatData.lv=1
composeCatData.exp=0
composeCatData.name_id=modelcfg.nameList[1]
composeCatData.tili=0
composeCatData.wx_id=catCfg.show[1][1]
composeCatData.color=catCfg.speInfo[1]
composeCatData.state=0
composeCatData.prop_num=#catCfg.speInfo[2]
composeCatData.propList=catCfg.speInfo[2]
composeCatData.texing_num=#catCfg.speInfo[3]
composeCatData.txList=catCfg.speInfo[3]
composeCatData.equip_num=0

local temp=table.deepCopy(composeCatData)
wanBaoXunBaoDuiModel:updateEmployee(temp)

UIFullWanBaoXunBaoDuiController:showWindow("UIWanBaoXunBaoDui_RecruitmentWin",{catdata={temp},type=WBXBD_ReCruitment_TYPE.info})
end



function UIWanBaoXunBaoDui_TeQuanWin:onBuyBtn()
local callback=function()
local rechargeId=self.tqCfg.rechargeid
payControl.reqPay(rechargeId,1,self.tqCfg.id)
end
local rechargeCfg=cfgHelper.get1(cfg_rechargeconfig_get,self.tqCfg.rechargeid)
local str=pfwindowslController:showDesc_ByMoneyType(rechargeCfg)

local content=FMT.fmt("是否使用{0}解锁特权航道",str)
local show_data={
type='UIDialouge',
title='提示',
oktext='确定',
content=content,
canceltext='取消',
showclosebtn=true,
okcallback=function()
callback()
end,
cancelcallback=nil,
closecallback=nil,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

AudioManager.playOpenUI()
end





