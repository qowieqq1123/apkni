







def_class("UIServerTransferXianYuDetailWin",UIWindowBase)









function UIServerTransferXianYuDetailWin:bindComponents()

self.cancelBtn=UIButton.get(self,0)
self.costIcon=UIObject.get(self,1)
self.costNum=UIText.get(self,2)
self.discipleModel=UIObject.get(self,3)
self.guildFight=UIText.get(self,4)
self.guildName=UIText.get(self,5)
self.joinBtn=UIButton.get(self,6)
self.limitInfoBtn=UIButton.get(self,7)
self.limitStr=UIText.get(self,8)
self.noticeBtn=UIButton.get(self,9)
self.playerFight=UIText.get(self,10)
self.playerName=UIText.get(self,11)
self.realmName=UIText.get(self,12)
self.realmNotice=UIText.get(self,13)
self.root=UIObject.get(self,14)
self.signBGIcon=UIImage.get(self,15)
self.signButton=UIButton.get(self,16)
self.signIcon=UIImage.get(self,17)
self.signKuangIcon=UIImage.get(self,18)
self.xyGradeFlag=UIImage.get(self,19)
self.zmGradeNum_1=UIText.get(self,20)
self.zmGradeNum_2=UIText.get(self,21)
self.zmGradeNum_3=UIText.get(self,22)
self.zmGradeNum_4=UIText.get(self,23)
self.zmGradeNum_5=UIText.get(self,24)
self.zmGradeOther=UIText.get(self,25)
self.limitLayout=UIObject.get(self,26)
self.costPreviewNum=UIText.get(self,27)
self.costPreviewIcon=UIImage.get(self,28)
self.costPreview=UIObject.get(self,29)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.joinBtn:setButtonClick(function()self:onJoinBtn()end)

self.limitInfoBtn:setButtonClick(function()self:onLimitInfoBtn()end)

self.noticeBtn:setButtonClick(function()self:onNoticeBtn()end)

self.signButton:setButtonClick(function()self:onSignButton()end)
self.zmGradeNum={
self.zmGradeNum_1,
self.zmGradeNum_2,
self.zmGradeNum_3,
self.zmGradeNum_4,
self.zmGradeNum_5,
}



end


function UIServerTransferXianYuDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costNum);self.costNum=nil;
_UIObject_release(self.discipleModel);self.discipleModel=nil;
_UIObject_release(self.guildFight);self.guildFight=nil;
_UIObject_release(self.guildName);self.guildName=nil;
_UIObject_release(self.joinBtn);self.joinBtn=nil;
_UIObject_release(self.limitInfoBtn);self.limitInfoBtn=nil;
_UIObject_release(self.limitStr);self.limitStr=nil;
_UIObject_release(self.noticeBtn);self.noticeBtn=nil;
_UIObject_release(self.playerFight);self.playerFight=nil;
_UIObject_release(self.playerName);self.playerName=nil;
_UIObject_release(self.realmName);self.realmName=nil;
_UIObject_release(self.realmNotice);self.realmNotice=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.signBGIcon);self.signBGIcon=nil;
_UIObject_release(self.signButton);self.signButton=nil;
_UIObject_release(self.signIcon);self.signIcon=nil;
_UIObject_release(self.signKuangIcon);self.signKuangIcon=nil;
_UIObject_release(self.xyGradeFlag);self.xyGradeFlag=nil;
_UIObject_release(self.zmGradeNum_1);self.zmGradeNum_1=nil;
_UIObject_release(self.zmGradeNum_2);self.zmGradeNum_2=nil;
_UIObject_release(self.zmGradeNum_3);self.zmGradeNum_3=nil;
_UIObject_release(self.zmGradeNum_4);self.zmGradeNum_4=nil;
_UIObject_release(self.zmGradeNum_5);self.zmGradeNum_5=nil;
_UIObject_release(self.zmGradeOther);self.zmGradeOther=nil;
_UIObject_release(self.limitLayout);self.limitLayout=nil;
_UIObject_release(self.costPreviewNum);self.costPreviewNum=nil;
_UIObject_release(self.costPreviewIcon);self.costPreviewIcon=nil;
_UIObject_release(self.costPreview);self.costPreview=nil;
self.zmGradeNum=nil;
end


















local showZongMenGrade={
zongMenGradeEnum.eZhiZun,
zongMenGradeEnum.eDianFeng,
zongMenGradeEnum.eBaCui,
zongMenGradeEnum.eZhongJian,
zongMenGradeEnum.eXiaoYao,
}
local _abName="ui/windows/servertransfer/servertransferspriteatlas_pak.ab"

function UIServerTransferXianYuDetailWin:onLoaded(...)
self:bindComponents()
local cost=cfgHelper.get2(cfg_switchserverguildlevelcconfig_get,1,"cost")
local costItem=unpack(cost[1])
self:showWindow("UITopMoneyWin2",{{costItem}})
end


function UIServerTransferXianYuDetailWin:__delete()
self:unbindComponents()
end




function UIServerTransferXianYuDetailWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6)
end
self.cross_id=argtable
self.detailsDatas=ServerTransferModel:getXianYuDetailsDatas(self.cross_id)
self.realmName:setText(loginModel:getCrossZoneName(self.cross_id))
local playerImage=self.detailsDatas.yz_iconInfo.piList
playerImageController.setPlayerModel(self.winlua,self.discipleModel:getID(),playerImage,0.6,eAnimationID.idle,0,0,playerController:supportDynamic())
self.playerName:setText(self.detailsDatas.yz_name)
local playerFightStr=mathHelper.formatNumber3((mathHelper.int64_to_number(self.detailsDatas.yz_fight)))
self.playerFight:setText(string.format("战力:%s",playerFightStr))
local image=self.detailsDatas.guild_icon>0 and xianmengModel.splitGuildIcon(self.detailsDatas.guild_icon)or xianmengModel.getDefualtGuildIamge()
local abname=globalABLookup.xianmengicons

self.signIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

self.signBGIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

self.signKuangIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

local guildName=(not self.detailsDatas.guild_name or self.detailsDatas.guild_name=="")and"暂无仙盟"or self.detailsDatas.guild_name
self.guildName:setText(guildName)

local guildFightStr=mathHelper.formatNumber3(mathHelper.int64_to_number(self.detailsDatas.guild_fight))
self.guildFight:setText(string.format("实力:%s",guildFightStr))

self.xyGradeFlag:setSprite(_abName,string.format("image_pojieyueqian_wz%d",self.detailsDatas.xianyu_pj_level))

local color=ServerTransferModel:getZongMenGradeColor(self.detailsDatas.curr_xianyu_level)
local zmGradeStr=ServerTransferModel:getZongMenGradeName(self.detailsDatas.curr_xianyu_level)
self.zmGradeOther:setText(string.format("您在此仙域的宗门评级：<color=%s>%s宗门</color>",color,zmGradeStr))
self:refreshNotice()

local showNotice=ServerTransferModel:checkXianYuReviewPermission(self.cross_id)
self.noticeBtn:setActive(showNotice)

local zmCntList=self.detailsDatas.zmCntList or defaultT
local zmCntLookup={}
for i,v in ipairs(zmCntList)do
local level=v.param_1
local cnt=v.param_2
zmCntLookup[level]=cnt
end

local zhizun_dianfeng_cnt=cfgHelper.get2(cfg_switchserverlevelbasicconfig_get,1,"zhizun_dianfeng_cnt")
local cnt=(zmCntLookup[zongMenGradeEnum.eZhiZun]or 0)+(zmCntLookup[zongMenGradeEnum.eDianFeng]or 0)
self.zhizun_dianfeng_full=cnt>=zhizun_dianfeng_cnt
for i,v in ipairs(self.zmGradeNum)do
local level=showZongMenGrade[i]
local cnt=zmCntLookup[level]or 0
local color=ServerTransferModel:getZongMenGradeColor(level)
v:setText(string.format("<color=%s>%s宗门    %d</color>",color,ServerTransferModel:getZongMenGradeName(level),cnt))
end
self:refreshTransferState()
end


function UIServerTransferXianYuDetailWin:refreshNotice(notice)
notice=notice or self.detailsDatas.xianyu_notice
if not notice or notice==""then
notice=cfgHelper.get2(cfg_switchserverlevelbasicconfig_get,1,"def_notice")
end
self.realmNotice:setText(notice)
end


function UIServerTransferXianYuDetailWin:refreshTransferState()
self.joinBtn:setActive(false)
self.limitStr:setText("")
self.limitInfoBtn:setActive(false)
self.costPreview:setActive(false)
self.limitLayout:setActive(false)
local isShowLimitLayout=false
self.cancelBtn:setActive(false)
local actOpen=ServerTransferController:checkServerTransferTimeOpen()
if not actOpen then
return
end

local canCntList=self.detailsDatas.canCntList or defaultT
local curr_xianyu_level=self.detailsDatas.curr_xianyu_level
local hasPlace=false
if self.zhizun_dianfeng_full and(curr_xianyu_level==zongMenGradeEnum.eZhiZun or curr_xianyu_level==zongMenGradeEnum.eDianFeng)then
hasPlace=false
else
for i,v in ipairs(canCntList)do
local level=v.param_1
local cnt=v.param_2
if level<=curr_xianyu_level and cnt>0 then
hasPlace=true
break
end
end
end
local transferCrossServerId=ServerTransferModel:getTransferCrossServerId()
if self.cross_id==loginModel:getCrossServerId()then
self.limitStr:setText("已处于该仙域")
isShowLimitLayout=true
elseif transferCrossServerId==self.cross_id then
local changeserverresult=ServerTransferModel:getTransferResult()
self.cancelBtn:setActive(changeserverresult==-1)
local switch_time_conf=cfgHelper.get2(cfg_switchserverbasicconfig_get,1,"switch_time_conf")
local deal_time=ServerTransferModel:getTransferDealTime()or 0
local longTime=timeHelper.convertLongStamp(deal_time)
local deal_hour=tonumber(os.date("%H",timeHelper.convertTimeStamp(longTime)))
local isAfterTomorrow=deal_hour>=switch_time_conf[1]
local deal_zero_time=math.floor(deal_time/86400)*86400
local now_zero_time=math.floor(timeHelper.getServerShortTime()/(86400))*86400
local startHour=switch_time_conf[2]
local dayStr="次日"
local transfer_zero_time=deal_zero_time+(isAfterTomorrow and 2 or 1)*86400
local diff_day=math.floor((transfer_zero_time-now_zero_time)/86400)
if diff_day>=2 then
dayStr="后天"
elseif diff_day>=1 then
dayStr="次日"
else
dayStr=""
end
local tipStr=diff_day<=0 and"，请尽快下线"or""
local timeStr=string.format("%s%d点",startHour>12 and"下午"or"上午",startHour>12 and startHour-12 or startHour)
self.limitStr:setText(changeserverresult==1 and string.format("已同意转服，%s%s开始转服%s",dayStr,timeStr,tipStr)or"")
isShowLimitLayout=true
elseif transferCrossServerId and transferCrossServerId>0 then
self.limitStr:setText("已向其他仙域发起申请，无法再次发起申请")
isShowLimitLayout=true
elseif not hasPlace then
self.limitStr:setText("此界仙域本源已满！\n无法接纳更多强大的宗门")
isShowLimitLayout=true
else
local hasLimit=ServerTransferController:checkServerTransferLimit()
isShowLimitLayout=hasLimit
self.limitStr:setText(hasLimit and"未满足跃迁条件！无法申请"or"")
self.limitInfoBtn:setActive(hasLimit)
self.joinBtn:setActive(not hasLimit)
self.costPreview:setActive(hasLimit)

local cost=cfgHelper.get2(cfg_switchserverguildlevelcconfig_get,curr_xianyu_level,"cost")
local costItem,costNum=unpack(cost[1])
local xianyu_pj_level=self.detailsDatas.xianyu_pj_level
local ex_cost=cfgHelper.get2(cfg_switchserverlevelcconfig_get,xianyu_pj_level,"ex_cost")
local ex_num=(ex_cost and ex_cost[1])and ex_cost[1][2]or 0
costNum=costNum+ex_num
local cost_multiple=ServerTransferModel:getTransferCostMultiple()or 1
local cost_multiple_cfg=cfgHelper.get2(cfg_switchserverbasicconfig_get,1,"cost_multiple")
local cost_multiple_list=cost_multiple_cfg[cost_multiple]
if not cost_multiple_list then
cost_multiple_list=cost_multiple_cfg[#cost_multiple_cfg]
end
costNum=costNum+((cost_multiple_list and cost_multiple_list[1])and cost_multiple_list[1][2]or 0)
self.costItem=costItem
self.costItemNum=costNum
local costIcon=iconHelper.getIconName(costItem)
local has=itemsModel.getCount(costItem)
local costNumStr=string.format("<color=%s>%d</color>",has<costNum and"#C82C2C"or"#171311",costNum)

if not hasLimit then
self.costIcon:setChildIcon(costIcon,true)
self.costNum:setText(costNumStr)
else
self.costPreviewIcon:setChildIcon(costIcon,false)
self.costPreviewNum:setText(FMT.fmt("转服消耗：{0}",costNumStr))
end
end

self.limitLayout:setActive(isShowLimitLayout)
end


function UIServerTransferXianYuDetailWin:onJoinBtn()
local has=itemsModel.getCount(self.costItem)
if has<self.costItemNum then
gainControl:showGainWin(self.costItem)
return
end
local xyName=loginModel:getCrossZoneName(self.cross_id)
local showdata={
type='UIDialouge',
title='提示',
content=string.format("是否申请跃迁至<color=#CA631D>%s</color>？同时仅能申请一个仙域",xyName),
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function()
ServerTransferController:send_254_97(self.cross_id)
end,
showclosebtn=true,
}
local dialog=UIDialogManager.newDialog(showdata)
dialog:show()
end

function UIServerTransferXianYuDetailWin:onCancelBtn()
ServerTransferController:send_254_134(self.cross_id)
end

function UIServerTransferXianYuDetailWin:onNoticeBtn()
self:showWindow("UIServerTransferXianYuNoticeWin",self.cross_id)
end

function UIServerTransferXianYuDetailWin:onLimitInfoBtn()
self:showWindow("UIServerTransferConditionWin")
end

function UIServerTransferXianYuDetailWin:onSignButton()
if self.detailsDatas.guild_icon<=0 then
return
end
local guild_id=self.detailsDatas.guild_id
if ServerTransferModel:getXianYuGuildDatas(guild_id)then
self:showWindow("UIServerTransferXianMengInfoWin",{cross_id=self.cross_id,guildid=guild_id})
else
ServerTransferController:send_35_163(self.cross_id,guild_id)
end
end