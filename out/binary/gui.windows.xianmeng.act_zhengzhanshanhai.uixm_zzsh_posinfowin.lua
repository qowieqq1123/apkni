







def_class("UIXM_ZZSH_posInfoWin",UIWindowBase)









function UIXM_ZZSH_posInfoWin:bindComponents()

self.root=UIObject.get(self,0)
self.signBtnTxt=UIText.get(self,1)
self.desc1Txt=UIText.get(self,2)
self.desc2Txt=UIText.get(self,3)
self.desc3Txt=UIText.get(self,4)
self.desc4Txt=UIText.get(self,5)
self.iconImg=UIImage.get(self,6)
self.nameTxt=UIText.get(self,7)
self.gotoBtn=UIButton.get(self,8)
self.icon2Img=UIButton.get(self,9)
self.shareBtn=UIButton.get(self,10)
self.signBtn=UIButton.get(self,11)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)

self.icon2Img:setButtonClick(function()self:onIcon2Img()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.signBtn:setButtonClick(function()self:onSignBtn()end)



end


function UIXM_ZZSH_posInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.signBtnTxt);self.signBtnTxt=nil;
_UIObject_release(self.desc1Txt);self.desc1Txt=nil;
_UIObject_release(self.desc2Txt);self.desc2Txt=nil;
_UIObject_release(self.desc3Txt);self.desc3Txt=nil;
_UIObject_release(self.desc4Txt);self.desc4Txt=nil;
_UIObject_release(self.iconImg);self.iconImg=nil;
_UIObject_release(self.nameTxt);self.nameTxt=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.icon2Img);self.icon2Img=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.signBtn);self.signBtn=nil;
end

















function UIXM_ZZSH_posInfoWin:onLoaded(...)
self:bindComponents()
end


function UIXM_ZZSH_posInfoWin:__delete()
self:unbindComponents()
if UIManager:isActive('UIXM_ZZSH_createSignWin')then
UIManager:closeWindow('UIXM_ZZSH_createSignWin')
end
if UIManager:isActive('UICommonShareTwoWin')then
UIManager:closeWindow('UICommonShareTwoWin')
end
end


function UIXM_ZZSH_posInfoWin:onHide()

end




function UIXM_ZZSH_posInfoWin:onShow(argtable,afterOnloaded)
self.mData=argtable
self.hasTarget=self:refreshView()
end

function UIXM_ZZSH_posInfoWin:refreshView()
local data=self.mData

local pos_str='坐标：<color=#f7f7f7>({0}，{1})</color>'
pos_str=FMT.fmt(pos_str,data.x,data.y)
self.desc1Txt:setText(pos_str)
if data.entityType==eZZSHEntityType.eLingDi then
local ldData=zhengzhanshanhaiModel:getLDData(data.cfgID)
local cfg=zhengzhanshanhaiModel:getLingDiCfg(data.cfgID)

data.name=cfg.name
data.shareName=data.name
data.msgName=data.name
if cfg.type==1 then
data.shareType=3
data.icon1='icon_sjdtfdbiaoshi_2'
else
data.shareType=4
data.icon1='icon_sjdtfdbiaoshi_1'
end
if data.icon1==nil then
if cfg.type==1 then
data.icon1='icon_sjdtfdbiaoshi_2'
else
data.icon1='icon_sjdtfdbiaoshi_1'
end
end
local name_str=FMT.fmt('<color=#1ce78>{0}</color>',cfg.name)
self.nameTxt:setText(name_str)

self.desc2Txt:setActive(false)
self.desc3Txt:setActive(false)

self.desc4Txt:setActive(true)
local widget=self.desc4Txt:getWidgetBase()
local xmData
if ldData then
xmData=ldData:getXM()
end
local hasXM=xmData~=nil
widget:SetChildActive(0,hasXM)
local xmName_str
if hasXM then
xmName_str=xmData.guildname
local abname=globalABLookup.xianmengicons
local image=xianmengModel.splitGuildIcon(xmData.guildicon)

widget:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(0,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
else
xmName_str='无'
end
widget:SetChildText(3,xmName_str)
elseif data.entityType==eZZSHEntityType.eMonster then
local qbData=zhengzhanshanhaiModel:getQingBaoData(data.guid)
if qbData==nil then return false end
local needRefresh=zhengzhanshanhaiModel:checkQingBaoRefresh(qbData)

local cfg=qbData:getCfg()
local name_str=qbData:getColorName()
data.name=qbData:getName()
data.shareName=data.name
data.msgName=data.name
data.shareType=1
data.stage=cfg.stage
if data.icon1==nil then
data.icon1=FMT.fmt('icon_sjysbiaoshi_{0}',cfg.stage)
data.abname=globalABLookup.zzshicons
end
self.nameTxt:setText(name_str)
if not needRefresh then
self:refreshMonsterInfo(qbData)
else
self.desc2Txt:setActive(false)
self.desc3Txt:setActive(false)
zhengzhanshanhaiModel:reqQingBaoDetail(qbData)
end

self.desc4Txt:setActive(false)
elseif data.entityType==eZZSHEntityType.eResource then
local qbData=zhengzhanshanhaiModel:getQingBaoData(data.guid)
if qbData==nil then return false end
local needRefresh=zhengzhanshanhaiModel:checkQingBaoRefresh(qbData)

local name_str=qbData:getColorName()
local cfg=qbData:getCfg()
data.name=qbData:getName()
data.shareName=data.name
data.msgName=data.name
data.shareType=2
data.stage=cfg.stage
if data.icon1==nil then
data.icon1=FMT.fmt('icon_sjwpbiaoshi_{0}',cfg.stage)
data.icon2=moneyModel.getIconNameEx(cfg.moneytype)
data.abname=globalABLookup.zzshicons
end
self.nameTxt:setText(name_str)
if not needRefresh then
self:refreshResourceInfo(qbData)
else
self.desc2Txt:setActive(false)
self.desc3Txt:setActive(false)
zhengzhanshanhaiModel:reqQingBaoDetail(qbData)
end

self.desc4Txt:setActive(false)
elseif data.entityType==eZZSHEntityType.ePvEXianMeng then
local xmData=zhengzhanshanhaiModel:getXMData(data.guid)
if xmData==nil then return false end

local name=xmData.guildname
data.name=name
data.shareName=data.name
data.msgName=data.name
data.shareType=5
if data.icon1==nil then
data.icon1='icon_sjbiaoshia_3'
end
local name_str=FMT.fmt('<color=#efb150>{0}</color>',name)
self.nameTxt:setText(name_str)

self.desc2Txt:setActive(false)
self.desc3Txt:setActive(false)
self.desc4Txt:setActive(false)
elseif data.entityType==nil then

local name_str='空地'
data.name=name_str
data.shareName=''
data.msgName=data.name
data.shareType=6
if data.icon1==nil then
data.icon1='icon_sjgdbiaoshi_1'
end
self.nameTxt:setText(name_str)

self.desc2Txt:setActive(false)
self.desc3Txt:setActive(false)
self.desc4Txt:setActive(false)
elseif data.entityType==eZZSHEntityType.eLingShan then
local cfg=UILSZDControl:getLingShanConfig(data.mountId)
data.msgName=cfg.mount_name
data.shareName=cfg.mount_name
data.shareType=7
local name_str=FMT.fmt('<color=#1ce78>{0}</color>',cfg.mount_name)
self.nameTxt:setText(name_str)
self.desc2Txt:setActive(true)
local num=UILSZDControl:getMountTeamNum(data.mountId)
local max=UILSZDControl:getMountMaxTeamNum(data.mountId)
self.desc2Txt:setText(FMT.fmt('队伍：<color=#f7f7f7>{0}/{1}</color>',num,max))
end


if data.abname then
self.iconImg:setSprite(data.abname,data.icon1)
else
self.iconImg:setImageIcon(data.icon1,true)
end

local showIcon2=data.icon2~=nil
self.icon2Img:setActive(showIcon2)
if showIcon2 then
self.icon2Img:setImageIcon(data.icon2,true)
end


self:refreshSignRecord()

local showGoBtn=UIManager:isActive('UIXM_ZZSH_worldWin')
self.gotoBtn:setActive(showGoBtn)

return true
end

function UIXM_ZZSH_posInfoWin:refreshSignRecord()
local data=self.mData

local checkSign=zhengzhanshanhaiModel:checkSignRecord(data.x,data.y)
local str=checkSign==true and'取消标记'or'标记'
self.signBtnTxt:setText(str)
end

function UIXM_ZZSH_posInfoWin:refreshMonsterInfo(qbData)
local detail=qbData.detail

self.desc2Txt:setActive(true)
local life_str=FMT.fmt('生命：<color=#aae252>{0}%</color>',detail.percent/100)
self.desc2Txt:setText(life_str)

local teamInfo=qbData:getTeamInfo()
local hasTeam=teamInfo~=nil
self.desc3Txt:setActive(hasTeam)
if hasTeam then
local maxNum,fixNum=zhengzhanshanhaiModel:getMaxMonsterTeamNum()
local cur=teamInfo.massnum
local max=teamInfo.setoutnum>0 and teamInfo.setoutnum or maxNum
local num_str=FMT.fmt('队伍：<color=#f7f7f7>{0}/{1}</color>',cur,max)
self.desc3Txt:setText(num_str)
local widget=self.desc3Txt:getWidgetBase()
widget:SetChildActive(0,false)
end
end

function UIXM_ZZSH_posInfoWin:refreshResourceInfo(qbData)
local detail=qbData.detail

self.desc2Txt:setActive(true)
local cur=detail:getLerpRes()
local cfg=qbData:getCfg()
local max=cfg.moneynum
local str=FMT.fmt('储量：<color=#aae252>{0}%</color>',mathHelper.decimal(cur/max*100,2))
self.desc2Txt:setText(str)

local checkFlag=detail:checkXM()
self.desc3Txt:setActive(true)
local max_atkNum=cfg.max
local collectNum=detail.collectNum or 0

local teamNum_str
if checkFlag==2 then
teamNum_str=FMT.fmt('队伍：<color=#f36666>{0}/{1}</color>',collectNum,max_atkNum)
else
teamNum_str=FMT.fmt('队伍：<color=#f7f7f7>{0}/{1}</color>',collectNum,max_atkNum)
end
self.desc3Txt:setText(teamNum_str)
local showTeamSign=checkFlag~=0
local widget=self.desc3Txt:getWidgetBase()
widget:SetChildActive(0,showTeamSign)
if showTeamSign then
local teamSignIcon=checkFlag==1 and'image_ben_1'or'image_di_1'
widget:SetChildCSImageSprite(0,globalABLookup.global,teamSignIcon)
end
end

function UIXM_ZZSH_posInfoWin:onSignBtn()
if not self.hasTarget then
UIManager.error('目标已消失')
return
end
local data=self.mData
local checkSign,idx=zhengzhanshanhaiModel:checkSignRecord(data.x,data.y)
if checkSign then
if zhengzhanshanhaiModel:removeSignRecordEx(idx)then
UIManager.info('标记移除成功')
UIManager:invokeUIMethod('UIXM_ZZSH_signWin','handleSignRefresh')
UIManager:invokeUIMethod('UIXM_ZZSH_worldWin','handleSignRefresh')
self:refreshSignRecord()
end
else
local cur=zhengzhanshanhaiModel:getSignRecordNum()
local max=zhengzhanshanhaiController:getZZSHCfg('maxSignNum')
if cur>=max then
UIManager.error('收藏地点数已达到最大限制')
return
end
local d={x=data.x,y=data.y,name=data.name}
UIManager:showWindow('UIXM_ZZSH_createSignWin',d)
end
end

function UIXM_ZZSH_posInfoWin:onGotoBtn()
if not self.hasTarget then
UIManager.error('目标已消失')
return
end
local data=self.mData
if UIManager:isActive('UIXM_ZZSH_worldWin')then
UIManager:invokeUIMethod('UIXM_ZZSH_worldWin','jumpSignPos',data.x,data.y)
else

UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','quitMiniMapModel',data.x,data.y)
end
self:closeSelf()
end

function UIXM_ZZSH_posInfoWin:onShareBtn()
if not self.hasTarget then
UIManager.error('目标已消失')
return
end
local data=self.mData
local str=zhengzhanshanhaiModel:getShareStr(data)
str=chatLinkHelper.clearLink(str)
local jsonStr=jsonHelper.encode({data.shareType,data.shareName,data.x,data.y,data.stage or 0})
local args={
channels={CHAT_CHANNNEL.eWorld,CHAT_CHANNNEL.eKuafu,CHAT_CHANNNEL.eXianmeng},
counterType=gameCounterType.eZhengZhanShanHaiDailyShareNum,
regexType=CHAT_REGEX_TYPE.eZZSHPosShare,
descStr=str,
jsonStr=jsonStr,
title='坐标分享',
shareName=data.msgName,
sharePosStr=FMT.fmt('X <color=#171311>{0},</color> Y <color=#171311>{1}</color>',data.x,data.y)
}
UIManager:showWindow("UICommonShareTwoWin",args)
end

function UIXM_ZZSH_posInfoWin:rcv_qbDetail(guid)
local data=self.mData
if data.entityType==eZZSHEntityType.eMonster then
if data.guid==guid then
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData then
self:refreshMonsterInfo(qbData)
end
end
elseif data.entityType==eZZSHEntityType.eResource then
if data.guid==guid then
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData then
self:refreshResourceInfo(qbData)
end
end
end
end