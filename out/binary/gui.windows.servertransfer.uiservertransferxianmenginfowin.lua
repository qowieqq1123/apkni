







def_class("UIServerTransferXianMengInfoWin",UIWindowBase)









function UIServerTransferXianMengInfoWin:bindComponents()

self.descText=UIText.get(self,0)
self.fightText=UIText.get(self,1)
self.leaderNameText=UIText.get(self,2)
self.leaderServerText=UIText.get(self,3)
self.manNumText=UIText.get(self,4)
self.signBGIcon=UIImage.get(self,5)
self.signIcon=UIImage.get(self,6)
self.signKuangIcon=UIImage.get(self,7)
self.xmLevelText=UIText.get(self,8)
self.xmNameText=UIText.get(self,9)



end


function UIServerTransferXianMengInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.descText);self.descText=nil;
_UIObject_release(self.fightText);self.fightText=nil;
_UIObject_release(self.leaderNameText);self.leaderNameText=nil;
_UIObject_release(self.leaderServerText);self.leaderServerText=nil;
_UIObject_release(self.manNumText);self.manNumText=nil;
_UIObject_release(self.signBGIcon);self.signBGIcon=nil;
_UIObject_release(self.signIcon);self.signIcon=nil;
_UIObject_release(self.signKuangIcon);self.signKuangIcon=nil;
_UIObject_release(self.xmLevelText);self.xmLevelText=nil;
_UIObject_release(self.xmNameText);self.xmNameText=nil;
end



















function UIServerTransferXianMengInfoWin:onLoaded(...)
self:bindComponents()
end


function UIServerTransferXianMengInfoWin:__delete()
self:unbindComponents()
end




function UIServerTransferXianMengInfoWin:onShow(argtable,afterOnloaded)
self.cross_id=argtable.cross_id
self.guildid=argtable.guildid
self.canvasIdx=argtable.canvasIdx
if self.canvasIdx then
self:setCanvasIndex(-1,self.canvasIdx)
end


local data=ServerTransferModel:getXianYuGuildDatas(self.guildid)
if data~=nil then
self.detailData=data
self:refreshView()
end
end

function UIServerTransferXianMengInfoWin:refreshView()
local data=self.detailData
local image=xianmengModel.splitGuildIcon(data.guild_icon)
local abname=globalABLookup.xianmengicons

self.signIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

self.signBGIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

self.signKuangIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))


self.xmNameText:setText(data.guild_name)

local leadernamestr=FMT.fmt('盟主：<color=#171311>{0}</color>',data.leader_name or"")
self.leaderNameText:setText(leadernamestr)

local name_str=''










self.leaderServerText:setText(name_str)

local levelstr=FMT.fmt('等级：<color=#171311>{0}</color>',data.guild_level)
self.xmLevelText:setText(levelstr)

local maxNum=xianmengModel.getXMMaxMemberNum(data.guild_level)
local curNum=data.member_cnt
local mannumstr=FMT.fmt('成员：<color=#171311>{0}/{1}</color>',curNum,maxNum)
self.manNumText:setText(mannumstr)

local fightnum=tonumber(tostring(data.guild_fight))
local fightstr=FMT.fmt('总实力：<color=#171311>{0}</color>',mathHelper.formatNumber3(fightnum))
self.fightText:setText(fightstr)

local notice_str=xianmengModel:getXMNoticeEx(data.guild_notice,cfgHelper.get2(cfg_guildbaseconfig_get,1,'defaultexnotice'))
notice_str=FMT.fmt('<color=#7D3B17>仙盟公告：</color>{0}',notice_str)
self.descText:setText(notice_str)
end

function UIServerTransferXianMengInfoWin:onMemberBtn()
if ServerTransferModel:getXianYuGuildMemberDatas(self.guildid)then
self:showWindow("UIServerTransferXianMengMemberWin",{cross_id=self.cross_id,guildid=self.guildid})
else
ServerTransferController:send_35_164(self.cross_id,self.guildid)
end
end