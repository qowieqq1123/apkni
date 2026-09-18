







def_class("UIWanLingTa_TianMingRewardWin",UIWindowBase)









function UIWanLingTa_TianMingRewardWin:bindComponents()

self.ScrollView=UILoopListView.new(self,0)

self.ScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIWanLingTa_TianMingRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
self.ScrollView:deleteSelf();self.ScrollView=nil;
end









local this

function UIWanLingTa_TianMingRewardWin:onLoaded(...)
self:bindComponents()
this=self
self.type=eWanLingTaShowcaseType.eXYHL
self:addNotify(notifyConfig.onWanLingTaTuJianChange,self.onWanLingTaTuJianChange)
self.receiveIdx=0
end


function UIWanLingTa_TianMingRewardWin:__delete()
self:unbindComponents()
this=nil
end

function UIWanLingTa_TianMingRewardWin:onShow(argtable,afterOnloaded)
self.tjId=argtable.tjId
self.config=cfg_xumitaxyhlconfig_get(self.tjId)
self.tj_conf=wanLingTaModel:getTuJianConfig(self.tjId)
local tj_data=wanLingTaModel:getTuJianData(self.tjId)
self.tj_lv=tj_data.level
local dzid=self.tj_conf.needItem
local dzData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(dzid)
if not dzData then
dzData=UIDiscipleModel:getDiscipleDataByDiziId(dzid)
end
self.dzData=dzData
self:refreshTianMingRewardView()
end

function UIWanLingTa_TianMingRewardWin.onWanLingTaTuJianChange(tjId,tjLevel)
if this.tjId==tjId then
this.tj_lv=tjLevel
this:refreshTianMingRewardView()
end
end

function UIWanLingTa_TianMingRewardWin:refreshTianMingRewardView()
local createCount=#self.config.rewards
local createList={}
for i=1,createCount do createList[#createList+1]=i end
self.ScrollView:initData('gubaoRewardItem',createList)
end

function UIWanLingTa_TianMingRewardWin:onFreshAction(i,grid)

local goodlist=self.config.rewards[i]
if grid then
local goodgrid=grid:GetChildCommonLayoutGroupWidgetList(1)
for i=1,4 do
local godddata=goodlist[i]
local gooditem=goodgrid[i-1]
local show=godddata~=nil
gooditem:SetChildActive(1,show)
if show then
local itemID=godddata[1]
local itemnum=godddata[2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemID,itemcount=itemcount,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
gooditem:SetChildPropData(0,prop)
gooditem:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(...)end)
end
end

self:refreshItem(grid,i)
end
end

function UIWanLingTa_TianMingRewardWin:onStartAction()

end
function UIWanLingTa_TianMingRewardWin:refreshItem(item,idx)
local needTmLv=self.config.activeUp[idx]
local dzNowTmLv=self.dzData.tmlv or-1
local canReceive=dzNowTmLv>=needTmLv
local isfinish=self.tj_lv>=idx

local dzName=self.dzData.disciplename
local title_str=needTmLv>0 and string.format("%s天命等级达到",dzName)or string.format("获得仙缘弟子%s",dzName)
item:SetChildText(0,title_str)

local showBtn=not isfinish and canReceive
if showBtn then
self.receiveIdx=math.max(self.receiveIdx,idx)
end
item:SetChildActive(2,showBtn)
item:SetChildButtonClick(2,function()
self:onReward()
end)

local showFinishSign=isfinish
item:SetChildActive(3,showFinishSign)

local showLockSing=false
item:SetChildActive(4,showLockSing)

local tmIconCmpIdx={5,6,7}
local chong=UIDiscipleModel.getTianMingLevelChong(needTmLv)
local floor=UIDiscipleModel.getTianMingLevelFloor(needTmLv)
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
for i,cmp in ipairs(tmIconCmpIdx)do
if chong>=i then
item:SetChildActive(cmp,true)
item:SetChildCSImageSprite(cmp,abName,iconName)
else
item:SetChildActive(cmp,false)
end
end
end

function UIWanLingTa_TianMingRewardWin:onGoodItemClick(itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
end
end

function UIWanLingTa_TianMingRewardWin:onReward(idx)
if self.receiveIdx>0 then
wanLingTaController.send_43_4(self.tjId,1,{{self.dzData.discipleguid,0}},self.receiveIdx)
end
end

function UIWanLingTa_TianMingRewardWin:rec_reward()
self:refreshTianMingRewardView()
end