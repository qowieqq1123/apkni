







def_class("UIXM_ZZSH_noteFightReportWin",UIWindowBase)









function UIXM_ZZSH_noteFightReportWin:bindComponents()

self.attackXM=UIText.get(self,0)
self.attackQSZ=UIText.get(self,1)
self.attackTeamNum=UIText.get(self,2)
self.defendXM=UIText.get(self,3)
self.defendQSZ=UIText.get(self,4)
self.defendTeamNum=UIText.get(self,5)
self.LogScrollView=UIObject.get(self,6)
self.winIconatk=UIImage.get(self,7)
self.winIcondef=UIImage.get(self,8)
self.attackInfo=UIObject.get(self,9)
self.defendInfo=UIObject.get(self,10)
self.logTips=UIText.get(self,11)
self.resultItem=UIObject.get(self,12)
self.logGridPanel=UIObject.get(self,13)



end


function UIXM_ZZSH_noteFightReportWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attackXM);self.attackXM=nil;
_UIObject_release(self.attackQSZ);self.attackQSZ=nil;
_UIObject_release(self.attackTeamNum);self.attackTeamNum=nil;
_UIObject_release(self.defendXM);self.defendXM=nil;
_UIObject_release(self.defendQSZ);self.defendQSZ=nil;
_UIObject_release(self.defendTeamNum);self.defendTeamNum=nil;
_UIObject_release(self.LogScrollView);self.LogScrollView=nil;
_UIObject_release(self.winIconatk);self.winIconatk=nil;
_UIObject_release(self.winIcondef);self.winIcondef=nil;
_UIObject_release(self.attackInfo);self.attackInfo=nil;
_UIObject_release(self.defendInfo);self.defendInfo=nil;
_UIObject_release(self.logTips);self.logTips=nil;
_UIObject_release(self.resultItem);self.resultItem=nil;
_UIObject_release(self.logGridPanel);self.logGridPanel=nil;
end

















function UIXM_ZZSH_noteFightReportWin:onLoaded(...)
self:bindComponents()
end


function UIXM_ZZSH_noteFightReportWin:__delete()
self:unbindComponents()
end




function UIXM_ZZSH_noteFightReportWin:onShow(argtable,afterOnloaded)

local recordguid=argtable[1]
local atkName=argtable[4]
local atkQSZ=argtable[5]
local atkTeamNum=argtable[6]
self.attackXM:setText(atkName==""and"已解散仙盟"or atkName)
self.attackQSZ:setText(FMT.fmt("气势值：{0}",atkQSZ))
self.attackTeamNum:setText(FMT.fmt("队伍数：{0}",atkTeamNum))

local defName=argtable[9]
local defQSZ=argtable[10]
local defTeamNum=argtable[11]
self.defendXM:setText(defName==""and"已解散仙盟"or defName)
self.defendQSZ:setText(FMT.fmt("气势值：{0}",defQSZ))
self.defendTeamNum:setText(FMT.fmt("队伍数：{0}",defTeamNum))

local fightDetailList=argtable[14]
self.logGridPanel:setChildLayoutGroupCreateItems(#fightDetailList)
local logGridGrids=self.logGridPanel:getChildLayoutGroupGridList()
for i=1,#fightDetailList do
local logWidget=logGridGrids[i-1]
local fightDetail=fightDetailList[i]
local is_win=fightDetail.res==1
logWidget:SetChildActive(0,is_win)
logWidget:SetChildActive(1,not is_win)
if is_win then
defTeamNum=defTeamNum-1
else
atkTeamNum=atkTeamNum-1
end


local attackWidget=logWidget:GetChildWidgetBase(2)


attackWidget:SetChildText(0,atkTeamNum)
attackWidget:SetChildText(1,tostring(fightDetail.attackteamfight))
attackWidget:SetChildText(2,fightDetail.attackname)
local rate1=fightDetail.attackteampower/zhengzhanshanhaiModel.maxLingLi
attackWidget:SetChildIconFillAmount(3,rate1)
attackWidget:SetChildText(4,FMT.fmt("灵力值：{0}%",fightDetail.attackteampower))


local defendWidget=logWidget:GetChildWidgetBase(3)


defendWidget:SetChildText(0,defTeamNum)
defendWidget:SetChildText(1,tostring(fightDetail.defendteamfight))
defendWidget:SetChildText(2,fightDetail.defendname)
local rate2=fightDetail.defendteampower/zhengzhanshanhaiModel.maxLingLi
defendWidget:SetChildIconFillAmount(3,rate2)
defendWidget:SetChildText(4,FMT.fmt("灵力值：{0}%",fightDetail.defendteampower))


if fightDetail.fightlogid and fightDetail.fightlogid~=""then
local reportId=fightDetail.fightlogid
logWidget:SetChildActive(4,true)
logWidget:SetChildButtonClick(4,function()
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
local isSeason=shSeasonId~=-1
local isBigCrossServer=isSeason
fightController:send_254_29(reportId,{nil,reportId,eRePlayerType.shanhailog,nil,2,nil,nil,is_win and 1 or 0},true,isBigCrossServer,nil,isSeason)
end)
else
logWidget:SetChildActive(4,false)
end
end



local abname=globalABLookup.xianmengicons
local atkWin=atkTeamNum>defTeamNum
local winIcon=atkWin and'image_pqjsshengbai_1'or'image_pqjsshengbai_2'
self.winIconatk:setSprite(globalABLookup.global,winIcon)
winIcon=not atkWin and'image_pqjsshengbai_1'or'image_pqjsshengbai_2'
self.winIcondef:setSprite(globalABLookup.global,winIcon)

local oriAtkTeamNum=argtable[6]
local oriDefTeamNum=argtable[11]

local result_atk=self.attackInfo:getWidgetBase()
local image=argtable[3]>0 and xianmengModel.splitGuildIcon(argtable[3])or xianmengModel.getDefualtGuildIamge()

result_atk:SetChildCSImageSprite(0,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

result_atk:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

result_atk:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

result_atk:SetChildActive(3,atkWin)
result_atk:SetChildActive(4,not atkWin)
result_atk:SetChildText(5,FMT.fmt("剩余队伍数：{0}/{1}",atkTeamNum,oriAtkTeamNum))
result_atk:SetChildText(6,atkName==""and"已解散仙盟"or atkName)
result_atk:SetChildText(7,argtable[5])
result_atk:SetChildActive(8,atkWin)
result_atk:SetChildActive(9,atkWin)
if atkWin then
result_atk:SetChildText(9,argtable[12]or'')
end
result_atk:SetChildText(10,(atkWin and argtable[12]==0)and'已掠夺过该盟'or'')


local result_def=self.defendInfo:getWidgetBase()
local image=argtable[8]>0 and xianmengModel.splitGuildIcon(argtable[8])or xianmengModel.getDefualtGuildIamge()

result_def:SetChildCSImageSprite(0,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

result_def:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

result_def:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

result_def:SetChildActive(3,not atkWin)
result_def:SetChildActive(4,atkWin)
result_def:SetChildText(5,FMT.fmt("剩余队伍数：{0}/{1}",defTeamNum,oriDefTeamNum))
result_def:SetChildText(6,defName==""and"已解散仙盟"or defName)
result_def:SetChildText(7,argtable[10])
result_def:SetChildActive(8,not atkWin)
result_def:SetChildActive(9,not atkWin)
if not atkWin then
result_def:SetChildText(9,argtable[12]or'')
end

local logTxt=zhengzhanshanhaiModel:Get_recordLogLookup(argtable[1])
self.logTips:setText(logTxt)
end

function UIXM_ZZSH_noteFightReportWin:onHide()

end