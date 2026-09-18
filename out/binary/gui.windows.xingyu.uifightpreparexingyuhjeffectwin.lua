







def_class("UIFightPrepareXingYuHJEffectWin",UIWindowBase)









function UIFightPrepareXingYuHJEffectWin:bindComponents()

self.skillList=UIObject.get(self,0)
self.tips=UIText.get(self,1)
self.jiyuanRoot=UIObject.get(self,2)
self.jiyuanTxt=UIText.get(self,3)
self.tipRoot=UIObject.get(self,4)
self.desc=UIText.get(self,5)
self.clicker=UIButton.get(self,6)
self.tipBtn=UIButton.get(self,7)
self.addTxt=UIText.get(self,8)
self.smasker=UIButton.get(self,9)
self.tipsroot=UIObject.get(self,10)
self.itemGreator=UIObject.get(self,11)
self.ScrollView=UILoopListView.new(self,12)
self.tipShowIcon=UIObject.get(self,13)
self.tipShowHide=UIObject.get(self,14)
self.jingjieTips=UIText.get(self,15)
self.jingjieBg=UIObject.get(self,16)
self.JJImage=UIImage.get(self,17)
self.tipsrootnew=UIObject.get(self,18)
self.tipsconten=UIText.get(self,19)
self.effect=UIObject.get(self,20)

self.clicker:setButtonClick(function()self:onClicker()end)

self.tipBtn:setButtonClick(function()self:onTipBtn()end)

self.smasker:setButtonClick(function()self:onSmasker()end)

self.ScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIFightPrepareXingYuHJEffectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.skillList);self.skillList=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.jiyuanRoot);self.jiyuanRoot=nil;
_UIObject_release(self.jiyuanTxt);self.jiyuanTxt=nil;
_UIObject_release(self.tipRoot);self.tipRoot=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.clicker);self.clicker=nil;
_UIObject_release(self.tipBtn);self.tipBtn=nil;
_UIObject_release(self.addTxt);self.addTxt=nil;
_UIObject_release(self.smasker);self.smasker=nil;
_UIObject_release(self.tipsroot);self.tipsroot=nil;
_UIObject_release(self.itemGreator);self.itemGreator=nil;
self.ScrollView:deleteSelf();self.ScrollView=nil;
_UIObject_release(self.tipShowIcon);self.tipShowIcon=nil;
_UIObject_release(self.tipShowHide);self.tipShowHide=nil;
_UIObject_release(self.jingjieTips);self.jingjieTips=nil;
_UIObject_release(self.jingjieBg);self.jingjieBg=nil;
_UIObject_release(self.JJImage);self.JJImage=nil;
_UIObject_release(self.tipsrootnew);self.tipsrootnew=nil;
_UIObject_release(self.tipsconten);self.tipsconten=nil;
_UIObject_release(self.effect);self.effect=nil;
end



















function UIFightPrepareXingYuHJEffectWin:onLoaded(...)
self:bindComponents()
self:addNotify(notifyConfig.onFightPrepareSelectChange,function(selectList)
self:refreshJY(selectList)
end)
self:addNotify(notifyConfig.onFightPrepareChangeTeam,function(flag)
self.hidePlayEffect=flag
end)
self.tipsroot:setActive(false)
self.tipsrootnew:setActive(false)
self.TRshowFlag=false
self.tipShowHide:setActive(not self.TRshowFlag)
self.tipShowIcon:setActive(self.TRshowFlag)
end


function UIFightPrepareXingYuHJEffectWin:__delete()
self:unbindComponents()
end




function UIFightPrepareXingYuHJEffectWin:onShow(argtable,afterOnloaded)
self.lastfight=0
self.curffight=0
local tipsStr=argtable.tips
self.tips:setText(tipsStr or"")
local xyId=argtable.xyId
self:refreshJY()
local hjList=XingYuController.getHuanjingList(xyId)
self.skillList:setChildLayoutGroupCreateItems(#hjList,function(index)
local skillItem=self.skillList:getChildLayoutGroupGridItem(index-1)
skillItem:SetChildActive(-1,true)
local cfg=hjList[index]
local id=cfg.id
local parms=cfg.parms
local type=cfg.type
if type==XYHJTYPE.eFaZe then
local ruleCfg=cfgHelper.getSSlawRule(id)
local image=ruleCfg.image
skillItem:SetChildCSImageIcon(0,image,false)
elseif type==XYHJTYPE.eLimit then
local baseCfg=XingYuModel:getXingYuBaseConfig()
local limitTypeCfg=baseCfg.limitTypeCfg
local fmtStr=limitTypeCfg[id].fmtStr
local image=limitTypeCfg[id].iconName
skillItem:SetChildCSImageIcon(0,image,false)
end

skillItem:SetChildButtonClick(1,function()













self.tipRoot:setActive(true)
self.clicker:setActive(true)
local desc=self:getDesc(cfg)
self.desc:setText(desc)
local sizeY=self.widget:GetChildPreferredSize(self.desc:getID(),1)
if sizeY>48 then
self.widget:SetChildTextAlignment(self.desc:getID(),3)
else
self.widget:SetChildTextAlignment(self.desc:getID(),4)
end
local pos=skillItem:GetChildAnchoredPosition(-1)
self.tipRoot:setChildAnchoredPos(pos.x,pos.y-43)
end)
end)
local xyCfg=XingYuModel:getXingYuConfig(xyId)


local jjLevelAssest=xyCfg.jjLevelAssest
self.JJImage:setSprite("ui/windows/xingyu/xingyu_atlas_pak.ab",jjLevelAssest)
self:delayDo(0.5,function()
self.jingjieBg:setChildCanvasGroupDOFade(1,0.5)
end)
end


function UIFightPrepareXingYuHJEffectWin:onHide()

end


function UIFightPrepareXingYuHJEffectWin:getDesc(cfg)
local id=cfg.id
local parms=cfg.parms
local type=cfg.type
if type==XYHJTYPE.eFaZe then
local ruleCfg=cfgHelper.getSSlawRule(id)
local desc=ruleCfg.desc
local descparm=ruleCfg.descparm
if descparm and descparm[parms]and next(descparm[parms])then
desc=string.format(desc,unpack(descparm[parms]))
end
return desc
elseif type==XYHJTYPE.eLimit then
local baseCfg=XingYuModel:getXingYuBaseConfig()
local limitTypeCfg=baseCfg.limitTypeCfg
local fmtStr=limitTypeCfg[id].fmtStr
local image=limitTypeCfg[id].iconName
local fmtparms
if id==1 then
fmtparms=cfgHelper.get(cfg_disciplevocationconfig_get,parms[1],"name")
elseif id==2 then
local spetype=parms[1]
local speId=parms[2]
local specialityConfig
if spetype==DISCIPLE_SPECIALITY_TYPE.eSpiritRoot then
specialityConfig=cfg_disciplespiritrootbookconfig_get(speId)
else
specialityConfig=UIDiscipleModel:getSpecialityConfig(spetype,speId)
end
fmtparms=specialityConfig.name
end
local desc=FMT.fmt(fmtStr,fmtparms)
return desc
end
end


function UIFightPrepareXingYuHJEffectWin:refreshJY(selectList)








local fight=0
for i,v in pairs(selectList or{})do
if v[1]==fightPreSelectModel.teamEntityType.dizi then
local netdata=UIDiscipleModel:getDiscipleDataX(v[2]).netData.net
local value=netdata.fightvalue
fight=fight+mathHelper.int64_to_number(value)
end
end
self.curffight=fight
local addValue,index=XingYuController.getAddValue(self.curffight)
local valueStr=addValue==0 and"无加成"or FMT.fmt("+{0}%",addValue*100)

self.addTxt:setText(valueStr)

local playEffect=not self.hidePlayEffect
if self.lastfight~=addValue then
if playEffect then
self.effect:setChildShowEffect(10668,true)
end
self.lastfight=addValue
end
end




function UIFightPrepareXingYuHJEffectWin:onClicker()
self.tipRoot:setActive(false)
self.clicker:setActive(false)
end

function UIFightPrepareXingYuHJEffectWin:onTipBtn()
self.TRshowFlag=not self.TRshowFlag
self.tipShowHide:setActive(not self.TRshowFlag)
self.tipShowIcon:setActive(self.TRshowFlag)

self.smasker:setActive(self.TRshowFlag)
self.tipsrootnew:setActive(self.TRshowFlag)
UIManager:invokeUIMethod("UIFightPrepareWin","registerEasyTouch",not self.TRshowFlag)
if not self.TRshowFlag then
return
end
local baseCfg=XingYuModel:getXingYuBaseConfig()
local tsrwPercent=baseCfg.tsrwPercent















local addValue,_index=XingYuController.getAddValue(self.curffight)
self.curIndex=_index



















local lowinfo=tsrwPercent[1]
local hightinfo=tsrwPercent[#tsrwPercent]
local str=FMT.fmt("队伍战力：<color=#F1CE78>{0}</color>\n队伍探索资源奖励额外<color=#F1CE78>+{1}%</color>(最高<color=#F1CE78>+{2}%</color>)\n<color=#cacaca>队伍战力需要达到<color=#F1CE78>{3}</color>才可获得加成，\n战力越高，奖励加成越多</color>",
mathHelper.formatNumber3(self.curffight),addValue*100,hightinfo[3]*100,mathHelper.formatNumber3(lowinfo[1]))
self.tipsconten:setText(str)
end


function UIFightPrepareXingYuHJEffectWin:onFreshAction(index,widget,data)
local item=widget
local info=data
local colorStr='#CACACA'
if self.curIndex and self.curIndex==index then
colorStr='#76d81e'
end
local descStr1=FMT.fmt('<color={0}>{1}</color>',colorStr,FMT.fmt("{0}以上",mathHelper.formatNumber3(info[1])))
local descStr2=FMT.fmt('<color={0}>{1}</color>',colorStr,FMT.fmt("{0}%",info[3]*100))
item:SetChildText(0,descStr1)
item:SetChildText(1,descStr2)
end

function UIFightPrepareXingYuHJEffectWin:onStartAction()
end

function UIFightPrepareXingYuHJEffectWin:onSmasker()
self.tipsrootnew:setActive(false)
self.smasker:setActive(false)

self.TRshowFlag=false
self.tipShowHide:setActive(not self.TRshowFlag)
self.tipShowIcon:setActive(self.TRshowFlag)
UIManager:invokeUIMethod("UIFightPrepareWin","registerEasyTouch",true)
end

