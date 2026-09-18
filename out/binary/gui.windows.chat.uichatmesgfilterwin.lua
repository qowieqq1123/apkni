







def_class("UIChatMesgFilterWin",UIWindowBase)









function UIChatMesgFilterWin:bindComponents()

self.pageCreater=UIObject.get(self,0)



end


function UIChatMesgFilterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.pageCreater);self.pageCreater=nil;
end















local _colomn=5

local CmpSettingItemIndex={
toggle=0,
name=1,
xianGuan=2,
xgSpriteAnimation=3,
xgName=4,
manualCheckMaskBtn=5,
manualCheckMask=6
}

local _idx=0

local getIdx=function()
_idx=_idx+1
return _idx
end

local pageType={
eSystemMsg=getIdx(),
eChatXianGuanSign=getIdx(),
}

local pageCfgList={
[pageType.eSystemMsg]={
id=pageType.eSystemMsg,
title="系统公告设置",

checkOpen=function()
return true
end,
preFreshItem=function(self,item)
item:SetChildActive(CmpSettingItemIndex.name,true)
item:SetChildActive(CmpSettingItemIndex.xianGuan,false)
item:SetChildActive(CmpSettingItemIndex.toggle,true)
item:SetChildActive(CmpSettingItemIndex.manualCheckMaskBtn,false)
end,
freshItem=function(self,index,item,cfg,pageCfg,parent)
local name=cfg.name
local typo=cfg.id
local isToggle=chatMesgFilterControl.getValueByType(typo)
item:SetChildToggle(CmpSettingItemIndex.toggle,isToggle)
item:SetChildToggleChange(CmpSettingItemIndex.toggle,function(name,isOn)
chatMesgFilterControl.setValueByType(typo,isOn)
end)
item:SetChildText(CmpSettingItemIndex.name,name)
end,
getCfg=function()
local allcfgs=cfg_msgtypeconfig()
local cfgs={}
for i,cfg in ipairs(allcfgs)do
if cfg.filter then
cfgs[#cfgs+1]=cfg
end
end
return cfgs
end,
},
[pageType.eChatXianGuanSign]={
id=pageType.eChatXianGuanSign,
title="聊天仙官头衔设置",

checkOpen=function()
local jobList=xianguanController.getSelfJobInfoList()
return#jobList>0
end,
preFreshItem=function(self,item)
item:SetChildActive(CmpSettingItemIndex.name,false)
item:SetChildActive(CmpSettingItemIndex.xianGuan,true)
item:SetChildActive(CmpSettingItemIndex.toggle,false)
item:SetChildActive(CmpSettingItemIndex.manualCheckMaskBtn,true)
end,
freshItem=function(self,index,item,cfg,pageCfg,parent)
local name=cfg.name
local typo=cfg.id


local lid=chatModel:getSignXgCurSign()
local isToggle=lid==typo
self.xgChatSignSelectIndex=isToggle and index
item:SetChildActive(CmpSettingItemIndex.manualCheckMask,isToggle)
item:SetChildButtonClick(CmpSettingItemIndex.manualCheckMaskBtn,function()
if self.xgChatSignOpreationLock then
UIManager.info("祖师慢点")
return
end

local curSignId=chatModel:getSignXgCurSign()
if typo==curSignId then

chatControl.reqChangeXgCurFlag(0)
self.xgChatSignOpreationLock=true
elseif curSignId==0 then

chatControl.reqChangeXgCurFlag(typo)
self.xgChatSignOpreationLock=true
elseif typo~=curSignId then

chatControl.reqChangeXgCurFlag(typo)
self.xgChatSignOpreationLock=true
end
end,true)


item:SetChildText(CmpSettingItemIndex.xgName,name)

local signCfg=cfgHelper.get1(cfg_chatflagconfig_get,typo)

local isShowIcon=signCfg.icon~=nil
if isShowIcon then
local signBgIcon=chatModel:getSignIcon(signCfg.icon)
item:SetChildIcon(CmpSettingItemIndex.xianGuan,signBgIcon,true)
end

local spriteAnimation=signCfg.spriteAnimation
local isShowSpriteAnimation=spriteAnimation~=nil
item:SetChildActive(CmpSettingItemIndex.xgSpriteAnimation,isShowSpriteAnimation)
if isShowSpriteAnimation then
item:SetChildAnimationStringID(CmpSettingItemIndex.xgSpriteAnimation,spriteAnimation)
end
end,
getCfg=function()
local jobList=xianguanController.getSelfJobInfoList()

local cfgs={}

for index,jobInfo in ipairs(jobList)do
local jobCfg=xianguanConfig.getJobConfig(jobInfo.groupId,jobInfo.jobId)
cfgs[#cfgs+1]={
id=jobCfg.chatFlagId,
name=jobCfg.name
}
end

return cfgs
end,
},
}



function UIChatMesgFilterWin:onLoaded(...)
self:bindComponents()
self:freshItems()
end

function UIChatMesgFilterWin:__delete()
self:unbindComponents()
chatMesgFilterControl.flush()
end

function UIChatMesgFilterWin:onShow(argtable,afterOnloaded)

end

function UIChatMesgFilterWin:onHide()

end



function UIChatMesgFilterWin:getOpenPageCfgList()
local openPageCfgList={}

for index,pageCfg in ipairs(pageCfgList)do
if pageCfg.checkOpen()then
openPageCfgList[#openPageCfgList+1]=pageCfg
end
end
return openPageCfgList
end

function UIChatMesgFilterWin:freshItems()

local openPageCfgList=self:getOpenPageCfgList()

local len=#openPageCfgList
self.pageCreater:setChildLayoutGroupCreateItems(len)
local grids=self.pageCreater:getChildLayoutGroupGridList()
for i=1,len do
local item=grids[i-1]
self:freshSingleItem(i,item,openPageCfgList[i])
end
end

function UIChatMesgFilterWin:freshSingleItem(pageidx,item,pageCfg)
item:SetChildText(1,pageCfg.title)
local cfgs=pageCfg.getCfg()
local len=#cfgs
item:SetChildLayoutGroupCreateItems(0,len)
local childGrids=item:GetChildLayoutGroupGridList(0)
for i=1,len do
local childItem=childGrids[i-1]


pageCfg.preFreshItem(self,childItem)
pageCfg.freshItem(self,i,childItem,cfgs[i],pageCfg,item)
end
end

function UIChatMesgFilterWin:onSelectXianGuanSign(oldSign,signId)
self.xgChatSignOpreationLock=false

local openPageCfgList=self:getOpenPageCfgList()
local xianguanPageCfg
local sIndex

for index,cfg in ipairs(openPageCfgList)do
if cfg.id==pageType.eChatXianGuanSign then
xianguanPageCfg=cfg
sIndex=index
break
end
end

if xianguanPageCfg==nil then return end

if signId==0 then
local pageItem=self.pageCreater:getChildLayoutGroupGridItem(sIndex-1)
local sItem=pageItem:GetChildLayoutGroupGridItem(0,self.xgChatSignSelectIndex-1)
sItem:SetChildActive(CmpSettingItemIndex.manualCheckMask,false)
self.xgChatSignSelectIndex=nil
else
local oldSignIndex
local cfgs=xianguanPageCfg.getCfg()
for index,cfg in ipairs(cfgs)do
if cfg.id==signId then
self.xgChatSignSelectIndex=index
end
if cfg.id==oldSign then
oldSignIndex=index
end
end
local pageItem=self.pageCreater:getChildLayoutGroupGridItem(sIndex-1)
local sItem=pageItem:GetChildLayoutGroupGridItem(0,self.xgChatSignSelectIndex-1)
sItem:SetChildActive(CmpSettingItemIndex.manualCheckMask,true)
if oldSignIndex then
local oItem=pageItem:GetChildLayoutGroupGridItem(0,oldSignIndex-1)
oItem:SetChildActive(CmpSettingItemIndex.manualCheckMask,false)
end
end
end










