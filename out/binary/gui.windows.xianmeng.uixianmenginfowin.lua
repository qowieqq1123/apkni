







def_class("UIXianMengInfoWin",UIWindowBase)









function UIXianMengInfoWin:bindComponents()

self.signIcon=UIImage.get(self,0)
self.signKuangIcon=UIImage.get(self,1)
self.signBGIcon=UIImage.get(self,2)
self.xmNameText=UIText.get(self,3)
self.leaderNameText=UIText.get(self,4)
self.leaderServerText=UIText.get(self,5)
self.xmLevelText=UIText.get(self,6)
self.manNumText=UIText.get(self,7)
self.fightText=UIText.get(self,8)
self.descText=UIText.get(self,9)
self.condText=UIText.get(self,10)
self.commitBtn=UIButton.get(self,11)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)



end


function UIXianMengInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.signIcon);self.signIcon=nil;
_UIObject_release(self.signKuangIcon);self.signKuangIcon=nil;
_UIObject_release(self.signBGIcon);self.signBGIcon=nil;
_UIObject_release(self.xmNameText);self.xmNameText=nil;
_UIObject_release(self.leaderNameText);self.leaderNameText=nil;
_UIObject_release(self.leaderServerText);self.leaderServerText=nil;
_UIObject_release(self.xmLevelText);self.xmLevelText=nil;
_UIObject_release(self.manNumText);self.manNumText=nil;
_UIObject_release(self.fightText);self.fightText=nil;
_UIObject_release(self.descText);self.descText=nil;
_UIObject_release(self.condText);self.condText=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
end

















function UIXianMengInfoWin:onLoaded(...)
self:bindComponents()
end


function UIXianMengInfoWin:__delete()
self:unbindComponents()
end


function UIXianMengInfoWin:onHide()

end




function UIXianMengInfoWin:onShow(argtable,afterOnloaded)
self.guildid=argtable.guildid
self.canvasIdx=argtable.canvasIdx
if self.canvasIdx then
self:setCanvasIndex(-1,self.canvasIdx)
end


local data=xianmengModel:getSearchXMDetailData(self.guildid)
if data~=nil then
self.detailData=data
self:refreshView()
end
end

function UIXianMengInfoWin:refreshView()
local data=self.detailData
local image=xianmengModel.splitGuildIcon(data.guildicon)
local abname=globalABLookup.xianmengicons

self.signIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

self.signBGIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

self.signKuangIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))


self.xmNameText:setText(data.guildname)

local leadernamestr=FMT.fmt('盟主：<color=#171311>{0}</color>',data.leadername)
self.leaderNameText:setText(leadernamestr)

local name_str
if xianmengController:checkKuafuMemberOpen()then
local serverName=loginModel:getServerName(data.leaderserverid)
if serverName~=''then
name_str=FMT.fmt('服务器：<color=#171311>{0}</color>',serverName)
else
name_str=''
end
else
name_str=''
end
self.leaderServerText:setText(name_str)

local levelstr=FMT.fmt('等级：<color=#171311>{0}</color>',data.guildlevel)
self.xmLevelText:setText(levelstr)

local maxNum=xianmengModel.getXMMaxMemberNum(data.guildlevel)
local curNum=data.membernum
local mannumstr=FMT.fmt('成员：<color=#171311>{0}/{1}</color>',curNum,maxNum)
self.manNumText:setText(mannumstr)

local fightnum=tonumber(tostring(data.memberfight))
local fightstr=FMT.fmt('总实力：<color=#171311>{0}</color>',mathHelper.formatNumber3(fightnum))
self.fightText:setText(fightstr)

local notice_str=xianmengModel:getXMNoticeEx(data.guildexnotice,cfgHelper.get2(cfg_guildbaseconfig_get,1,'defaultexnotice'))
notice_str=FMT.fmt('<color=#7D3B17>仙盟公告：</color>{0}',notice_str)
self.descText:setText(notice_str)

local isfullnum=curNum>=maxNum
local cond_str=''
local check_cond=not isfullnum
local joinlimit=data.joinlimit
if mathHelper.getBitValue(joinlimit,1)then
check_cond=false
cond_str='<color=#c82c2c>不再招人</color>'
else
local levellimit=data.levellimit
local zmlv=zongmenModel:getLevel()
if zmlv<levellimit then
check_cond=false
cond_str=FMT.fmt('宗门<color=#c82c2c>{0}级</color>',levellimit)
else
if mathHelper.getBitValue(joinlimit,0)then
cond_str='无限制'
else
cond_str=FMT.fmt('宗门{0}级',levellimit)
end
end
end
self.condText:setText(FMT.fmt('加入限制：<color=#171311>{0}</color>',cond_str))

if check_cond then
check_cond=not xianmengModel:hasXM()and not xianmengModel:checkApplyJoinState(data.guildid)
end
self.commitBtn:setGray(not check_cond)
self.check_cond=check_cond
end

function UIXianMengInfoWin:onCommitBtn()
if xianmengModel:hasXM()then
UIManager.error('已有仙盟')
return
end





local data=self.detailData
if not data:checkfunc(true)then
return
end

local guildid=data.guildid
if xianmengModel:checkApplyJoinState(guildid)then
UIManager.error('不能重复申请同一仙盟')
return
end




local func=function()
if self and not self.isClose then
xianmengController:reqApllyJoinXM({guildid})
self:closeSelf()
end
end
xianmengController:checkFreeCDTimes(func)
end

function UIXianMengInfoWin:onMemberBtn()
xianmengController:openXMMemberListWin(self.guildid,self.canvasIdx)
end

function UIXianMengInfoWin:rec_detail(guildid)
if mathHelper.compareInt64(guildid,self.guildid)then
self.detailData=xianmengModel:getSearchXMDetailData(guildid)
self:refreshView()
end
end