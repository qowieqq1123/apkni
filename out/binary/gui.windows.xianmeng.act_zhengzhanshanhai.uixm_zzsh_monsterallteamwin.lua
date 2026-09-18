







def_class("UIXM_ZZSH_monsterAllTeamWin",UIWindowBase)









function UIXM_ZZSH_monsterAllTeamWin:bindComponents()

self.cliskMask=UIButton.get(self,0)
self.infoItem=UIObject.get(self,1)
self.itemScrollView=UIObject.get(self,2)
self.noSign=UIObject.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.itemPanel=UIObject.get(self,5)

self.cliskMask:setButtonClick(function()self:onCliskMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXM_ZZSH_monsterAllTeamWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cliskMask);self.cliskMask=nil;
_UIObject_release(self.infoItem);self.infoItem=nil;
_UIObject_release(self.itemScrollView);self.itemScrollView=nil;
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
end
















local _this


function UIXM_ZZSH_monsterAllTeamWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_ZZSH_monsterAllTeamWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_ZZSH_monsterAllTeamWin:onHide()

end




function UIXM_ZZSH_monsterAllTeamWin:onShow(argtable,afterOnloaded)
self.qbGuid=argtable.qbGuid
self:refreshInfo()

if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
self:refreshAllItem()
end)
end
end

function UIXM_ZZSH_monsterAllTeamWin:refreshView(guid)
if guid~=self.qbGuid then return end
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData==nil then
return
end
self:refreshInfo()
end

function UIXM_ZZSH_monsterAllTeamWin:refreshInfo()
local qbData=zhengzhanshanhaiModel:getQingBaoData(self.qbGuid)
local detail=qbData:getDetail()

local widget=self.infoItem:getWidgetBase()
local cfg=qbData:getCfg()
self.isBoss=cfg.stage>=5

local bgIcon=FMT.fmt('image_gwtouxiangpjk_{0}',cfg.stage)
widget:SetChildCSImageSprite(0,globalABLookup.global,bgIcon)

local groupid=cfg.monster[1]
comHelper.setChildModelRawImage_monsterGroup(widget,groupid,1,0,eHeadCenterType.eHead)

local stageBGIcon=FMT.fmt('image_gwtouxiangdjk_{0}',cfg.stage)
widget:SetChildCSImageSprite(2,globalABLookup.global,stageBGIcon)
widget:SetChildText(3,tostring(cfg.stage))

local jjlv=zhengzhanshanhaiModel:getMonsterLv(cfg)
local jingjie_str=FMT.fmt('[{0}]',UIDiscipleModel.getJJNameCommon(jjlv,3))
widget:SetChildText(4,jingjie_str)

local nameStr=qbData:getName()
widget:SetChildText(5,nameStr)

local xmData=qbData:getXM()
local hasXM=xmData~=nil
widget:SetChildActive(6,hasXM)
local xmName_str
if hasXM then
xmName_str=xmData.guildname
local abname=globalABLookup.xianmengicons
local image=xianmengModel.splitGuildIcon(xmData.guildicon)

widget:SetChildCSImageSprite(7,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(6,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(8,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
else
xmName_str='无'
end
widget:SetChildText(9,xmName_str)

local percent
if detail then
percent=detail.percent
else
percent=10000
end
local rate_str=FMT.fmt('{0}%',percent/100)
if self.isBoss and percent<=1 then
percent=0
rate_str="垂死"
end
widget:SetChildIconFillAmount(10,percent/10000)
widget:SetChildText(11,rate_str)


local num=qbData:getAllTeamNum()
local isshow=num>0
self.itemScrollView:setActive(isshow)
self.noSign:setActive(not isshow)
if isshow then
local list={}
for k,v in pairs(detail.allTeam)do
table.insert(list,v)
end
if num>1 then
table.sort(list,function(a,b)
return a.fight_num>b.fight_num
end)
end
self.teamsList=list
self.itemPanel:setChildLayoutGroupCreateItems(num,function(idx)
if _this==nil then return end
local item=self.itemPanel:getChildLayoutGroupGridItem(idx-1)
local team=self.teamsList[idx]

item:SetChildText(0,tostring(idx))

local ismy=team.ismy
item:SetChildActive(4,ismy)
self:refreshItem(item,idx)
end)
end
end

function UIXM_ZZSH_monsterAllTeamWin:refreshItem(item,idx)
if item==nil then
item=self.itemPanel:getChildLayoutGroupGridItem(idx-1)
end
if item==nil then return end
local team=self.teamsList[idx]
local state,time=zhengzhanshanhaiModel:getPvETeamState(zhengzhanshanhaiModel.qbType.eMonster,team.sec,true)

local desc1=FMT.fmt('<color=#7D3B17>[{0}]{1}</color>率总战力<color=#ca631d>{2}</color>的<color=#ca631d>{3}</color>支队伍 {4}',
team.guildname,team.actorname,mathHelper.formatNumber8(team.fight_num,nil,2),team.massnum,state)





local time_str
if time>=0 then
time_str=timeHelper.format_time_stamp3(time)
end
local showTime=time_str~=nil
item:SetChildActive(2,showTime)
item:SetChildActive(3,showTime)
if showTime then
item:SetChildText(3,time_str)
end
item:SetChildText(1,desc1)
end

function UIXM_ZZSH_monsterAllTeamWin:refreshAllItem()
if self.teamsList then
local num=#self.teamsList
if num>0 then
for idx,v in ipairs(self.teamsList)do
self:refreshItem(nil,idx)
end
end
end
end

function UIXM_ZZSH_monsterAllTeamWin:onCliskMask()
self:onCloseBtn()
end

function UIXM_ZZSH_monsterAllTeamWin:onCloseBtn()
self:closeSelf()
end
