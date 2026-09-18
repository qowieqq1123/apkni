







def_class("UIXM_LXWJ_zhizunbang_win",UIWindowBase)









function UIXM_LXWJ_zhizunbang_win:bindComponents()

self.frameSp=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.rankGridPanel=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.raceTxt=UIText.get(self,4)
self.likeNumTxt=UIText.get(self,5)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXM_LXWJ_zhizunbang_win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.rankGridPanel);self.rankGridPanel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.raceTxt);self.raceTxt=nil;
_UIObject_release(self.likeNumTxt);self.likeNumTxt=nil;
end
















local _this=nil


function UIXM_LXWJ_zhizunbang_win:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
end


function UIXM_LXWJ_zhizunbang_win:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_LXWJ_zhizunbang_win:onHide()

end

function UIXM_LXWJ_zhizunbang_win.onLimitActStateChange(actID,state,isNew)
if _this==nil then return end
if actID~=LIMIT_ACT_TYPE.eLingXuWenJian then return end
if state==limitActivitiesModel.actFinishState then
_this:onCloseBtn()
end
end




function UIXM_LXWJ_zhizunbang_win:onShow(argtable,afterOnloaded)
self:refreshView()
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.frameSp:setChildUIModelShowTarget(4796,1,{},2040,false,false,0,function()
if _this==nil then return end
_this:delayDo(0.45,function()
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end)
end
lingxuwenjianModel:checkRefreshLike()
end

function UIXM_LXWJ_zhizunbang_win:refreshLikeTimes()
local cur=lingxuwenjianModel:getLikeTimes()
local max=lingxuwenjianModel:getMamLikeTimes()
local lerp=max-cur
if lerp<0 then lerp=0 end
self.curLerpNum=lerp
local times_str
if lerp>0 then
times_str=FMT.fmt('<color=#171311>{0}</color>',lerp)
else
times_str=FMT.fmt('<color=#C82C2C>{0}</color>',lerp)
end
times_str=FMT.fmt('点赞剩余次数：{0}',times_str)
self.likeNumTxt:setText(times_str)
end

function UIXM_LXWJ_zhizunbang_win:refreshView()

local raceIndex=lingxuwenjianModel:getRaceIndex()
local race_str=tostring(raceIndex)
self.raceTxt:setText(race_str)

self:refreshLikeTimes()

self.topList=lingxuwenjianModel:getLikeTopThree()or{}
local grids=self.rankGridPanel:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local data=self.topList[i]
local item=grids[i-1]
local isshow=data~=nil

item:SetChildActive(0,isshow)
item:SetChildActive(12,not isshow)
if isshow then
local image=xianmengModel.splitGuildIcon(data.guildicon)
local abname=globalABLookup.xianmengicons

item:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

item:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

item:SetChildCSImageSprite(3,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

item:SetChildText(4,data.guildname)

local sname=loginModel:getServerName(data.serverid)
item:SetChildText(5,sname or'')

local abname,icon,name=lingxuwenjianModel:getScoreCfg(data.score)
item:SetChildCSImageSprite(7,abname,icon)
local name_str=FMT.fmt('{0}({1})',name,data.score)
item:SetChildText(6,name_str)

item:SetChildButtonClick(8,function()
if _this==nil then return end
_this:onLikeClick(i)
end)
self:refreshItemLike(item,i)





end
end
end

function UIXM_LXWJ_zhizunbang_win:refreshItemLike(item,idx)
if item==nil then
item=self.rankGridPanel:getChildCommonLayoutGroupWidgetItem(idx-1)
end
local data=self.topList[idx]
local num_str=tostring(data.likestimes)
item:SetChildText(9,num_str)
local isReddot=self.curLerpNum>0
item:SetChildActive(10,isReddot)
end

function UIXM_LXWJ_zhizunbang_win:onHeadClick(idx)

end

function UIXM_LXWJ_zhizunbang_win:onLikeClick(idx)
if self.curLerpNum<=0 then
UIManager.error('今日点赞次数已用完')
return
end
lingxuwenjianController:reqLike(idx)
end

function UIXM_LXWJ_zhizunbang_win:onCloseBtn()
self:closeSelf()
end

function UIXM_LXWJ_zhizunbang_win:rec_like(rank)
self:refreshLikeTimes()
local grids=self.rankGridPanel:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local data=self.topList[i]
if data~=nil then
local item=grids[i-1]
self:refreshItemLike(item,i)
end
end
end