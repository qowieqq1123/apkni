







def_class("UIJYZF_RecordWin",UIWindowBase)









function UIJYZF_RecordWin:bindComponents()

self.noItemTips=UIText.get(self,0)
self.root=UIObject.get(self,1)
self.Scroller=UILoopListView.new(self,2)

self.Scroller:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIJYZF_RecordWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.noItemTips);self.noItemTips=nil;
_UIObject_release(self.root);self.root=nil;
self.Scroller:deleteSelf();self.Scroller=nil;
end















local LOGTYPE={
eCommon=0,
eWDCQ=1,
eYWT_ZJB=2,
eYWT_ZSB=3,
eYWT_ZS=4,
eXY_ZDZ=5,
eXJYB=6,
eXJFM=7,
eXJXX=8,
}
local prefabNames={
[LOGTYPE.eCommon]="scrollerItem_common",
}

local refreshFuncName={
[LOGTYPE.eCommon]="refreshFunc_Common",
}





function UIJYZF_RecordWin:onLoaded(...)
self:bindComponents()
JiuYuZhengFengController.req_35_240()
end


function UIJYZF_RecordWin:__delete()
self:unbindComponents()
end




function UIJYZF_RecordWin:onShow(argtable,afterOnloaded)
local list=JiuYuZhengFengModel:getLogList()
if list and#list>0 then
self.noItemTips:setActive(false)
local prefabnameList={}
for i,xianyuLevelLogInfo in ipairs(list)do
local name=prefabNames[xianyuLevelLogInfo.log_type]or prefabNames[LOGTYPE.eCommon]
table.insert(prefabnameList,name)
end
self.Scroller:refreshAllItems()
self.Scroller:initDataEx(prefabnameList,list)
else
self.Scroller:initData(nil,nil,0)
self.noItemTips:setActive(true)
end
end


function UIJYZF_RecordWin:onHide()

end

function UIJYZF_RecordWin:onFreshAction(index,widget,xianyuLevelLogInfo)
local item=widget
local funcName=refreshFuncName[xianyuLevelLogInfo.log_type]or refreshFuncName[LOGTYPE.eCommon]
local itemCmpIndex,bgCmpIndex,contentCmpIndex
if funcName and self[funcName]then
itemCmpIndex,bgCmpIndex,contentCmpIndex=self[funcName](self,item,xianyuLevelLogInfo)
end
if bgCmpIndex and itemCmpIndex then
item:ForceLayoutVertical(contentCmpIndex)
local bgY=item:GetChildRectHeight(bgCmpIndex)
local itemHiget=bgY+10
item:SetChildSizeDelta(itemCmpIndex,1053,itemHiget)
item:FreshChildLayoutRectThree(contentCmpIndex)
else
logErr("UIJYZF_RecordWin bgCmpIndex or itemCmpIndex")
end
end


function UIJYZF_RecordWin:onStartAction()
end

















function UIJYZF_RecordWin:refreshFunc_Common(item,xianyuLevelLogInfo)
local log_type=xianyuLevelLogInfo.log_type
local name=xianyuLevelLogInfo.name
local iconInfo=xianyuLevelLogInfo.iconInfo
local log_time=xianyuLevelLogInfo.log_time
local scroe=xianyuLevelLogInfo.scroe
local rank_idx=xianyuLevelLogInfo.rank_idx
local param=xianyuLevelLogInfo.param
local guild_id=xianyuLevelLogInfo.guild_id

local logCfg=cfg_xianyulevelscorecconfig_get(log_type)
local group=self:getGroup(log_type,rank_idx,param)
local log_str=logCfg.log_str[group]
item:SetChildText(2,FMT.fmt(log_str,self:getFormat(log_type,scroe,rank_idx,param)))
item:SetChildText(3,name)
item:SetChildActive(4,false)
if guild_id and mathHelper.int64_to_number(guild_id)>0 then
item:SetChildActive(5,false)
item:SetChildActive(8,true)
local image=xianmengModel.splitGuildIcon(param)
local abname=globalABLookup.xianmengicons

item:SetChildCSImageSprite(9,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

item:SetChildCSImageSprite(8,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

item:SetChildCSImageSprite(10,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

else
item:SetChildActive(8,false)
item:SetChildActive(5,true)
playerController:setHeadIcon(item,5,{iconInfo=iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
end


local timeStr=timeHelper.getFormatByShortStamp(log_time)
local datePart,timePart=timeStr:match("^(.-) (.*)$")
item:SetChildText(6,datePart)
item:SetChildText(7,timePart)
return 0,1,2
end























function UIJYZF_RecordWin:getFormat(log_type,scroe,rank_idx,param)


if log_type==LOGTYPE.eWDCQ then







return scroe,mathHelper.numberToChinese(rank_idx),WDCQCGroupNmae[param]
elseif log_type==LOGTYPE.eYWT_ZJB then





return scroe,mathHelper.numberToChinese(rank_idx)
elseif log_type==LOGTYPE.eYWT_ZSB then





return scroe,mathHelper.numberToChinese(rank_idx)
elseif log_type==LOGTYPE.eYWT_ZS then
return scroe
elseif log_type==LOGTYPE.eXY_ZDZ then





return scroe,rank_idx==1 and"冠军"or"亚军"
elseif log_type==LOGTYPE.eXJYB then
return scroe
elseif log_type==LOGTYPE.eXJFM then





return scroe,mathHelper.numberToChinese(param)
elseif log_type==LOGTYPE.eXJXX then





return scroe,mathHelper.numberToChinese(rank_idx)
end
return scroe,rank_idx,param
end

function UIJYZF_RecordWin:getGroup(log_type,rank_idx,param)
if log_type==LOGTYPE.eWDCQ then
return param
elseif log_type==LOGTYPE.eXJFM then
if param==0 then
return 1
end
return rank_idx
end
return 1
end




