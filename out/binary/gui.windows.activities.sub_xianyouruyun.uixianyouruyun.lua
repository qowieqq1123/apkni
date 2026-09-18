







def_class("UiXianYouRuYun",UIWindowBase)









function UiXianYouRuYun:bindComponents()

self.bgModel=UIObject.get(self,0)
self.Content=UIObject.get(self,1)
self.packScrollerView=UILoopListView.new(self,2)
self.timeText=UIText.get(self,3)
self.titleImg=UIImage.get(self,4)

self.packScrollerView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UiXianYouRuYun:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.Content);self.Content=nil;
self.packScrollerView:deleteSelf();self.packScrollerView=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.titleImg);self.titleImg=nil;
end


















local imgType=
{
[4]='image_xyryui_8',
[5]='image_xyryui_4',
}

local abname='ui/windows/activities/sub_xianyouruyun/xianyouruyun_atlas_pak.ab'


function UiXianYouRuYun:onLoaded(...)
self:bindComponents()
end


function UiXianYouRuYun:__delete()
self:unbindComponents()
end




function UiXianYouRuYun:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
end

if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bgModel:getID(),true,true,true)
end
self.bgModel:setChildUIModelShowTarget(6126,1,{},eAnimationID.stand,false,false,0)

self:initSort()
self.taskLen=not self.config and 0 or#self.config

if self.taskLen>0 then
local _slotName='item'
self.packScrollerView:initData(_slotName,self.config)


end
end

function UiXianYouRuYun:onStartAction()

end


function UiXianYouRuYun:onHide()

end

function UiXianYouRuYun:refreshWin()
self:initSort()
self.taskLen=not self.config and 0 or#self.config

if self.taskLen>0 then
local _slotName='item'
self.packScrollerView:initData(_slotName,self.config)
end
end

function UiXianYouRuYun:initSort()
self.config={}
local data=table.deepCopy(xianYouRuYunModel:getTaskData())

for k,v in ipairs(data)do
local isRecv=xianYouRuYunModel:getTaskIsRecv(v.id)
local progress=xianYouRuYunModel:getTaskProgress(v.id)
if progress>=v.num and not isRecv then
v.sort=v.sort+1000
elseif isRecv then
v.sort=v.sort-1000
end
end

table.sort(data,function(a,b)
return a.sort>b.sort
end)
self.config=data
end



function UiXianYouRuYun:onFreshAction(i,grids)



local item=grids
local config=self.config[i]

local curNum=0
local aimNum=config.num
local taskId=config.id
local desc=config.taskdesc
local jumpParam=config.useJump


if config.params then
curNum=self:refreshHeadByTaskType(item,config.tasktype,config.params,aimNum)
end

local isFinish=curNum>=aimNum
if curNum>aimNum then curNum=aimNum end
desc=string.format('%s (<color=green>%s</color>/%s)',desc,curNum,aimNum)
local isRecv=xianYouRuYunModel:getTaskIsRecv(taskId)

item:SetChildText(0,desc)
item:SetChildActive(1,not isFinish)
item:SetChildActive(2,isFinish and not isRecv)
item:SetChildActive(3,isRecv)
item:SetChildActive(6,isFinish and not isRecv)
item:SetChildButtonClick(1,function()self:jumpToOtherWin(jumpParam,config.params)end)
item:SetChildButtonClick(2,function()xianYouRuYunController:reqReceive()end)


local gameVer=pfwindowslController:getGameVersion()
local pfid=loginModel:getPfid()or-1
local rewardCfg=config.rewards[gameVer]
local rewardList
if rewardCfg[pfid]then rewardList=rewardCfg[pfid]else rewardList=rewardCfg[-1]end

if rewardList then
local len=#rewardList
item:SetChildScrollViewCreateGrids(4,len,len)
local reward_grids=item:GetChildScrollViewItemWidgets(4)
for j=1,len do
local reward=rewardList[j]
local itemid=reward[1]
local count=reward[2]
local widget=reward_grids[j-1]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)


local isGot=false
local isGrayMask=isGot
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isGrayMask
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
end

end

function UiXianYouRuYun:refreshHeadByTaskType(item,type,params,aimnum)
if type==2 then
local color=params[1]
local taskNum=aimnum
item:SetChildScrollViewCreateGrids(5,taskNum,taskNum)
local grids=item:GetChildScrollViewItemWidgets(5)
local num,list=UIDiscipleModel:getDiscipleColorCountAndList(color)
local imgName=imgType[color]or'image_xyryui_8'

if taskNum<=5 then
item:SetChildScrollRectEnable(5,false)
end

for i=1,taskNum do
local data=list[i]
local widget=grids[i-1]

if i<=num then
widget:SetChildActive(2,true)
widget:SetChildActive(3,true)
widget:SetChildActive(9,false)
widget:SetChildActive(11,false)
widget:SetChildActive(12,false)



comHelper.setChildModelRawImage(widget,data.discipleguid,1,0,eHeadCenterType.eHalf)
else
widget:SetChildActive(2,false)
widget:SetChildActive(3,false)
widget:SetChildActive(9,false)
widget:SetChildActive(11,true)
widget:SetChildActive(12,true)
widget:SetChildCSImageSprite(11,abname,imgName)
end
end
return num
elseif type==3 then
local len=aimnum
local level=params[1]
local imgName='image_xyryui_8'
local num,list=UIDiscipleModel:getDiscipleJJCountList(level)

item:SetChildScrollViewCreateGrids(5,len,len)
local grids=item:GetChildScrollViewItemWidgets(5)

if len<=5 then item:SetChildScrollRectEnable(5,false)end

for i=1,len do
local data=list[i]
local widget=grids[i-1]

if i<=num then
widget:SetChildActive(1,true)
widget:SetChildActive(2,true)
widget:SetChildActive(3,true)
widget:SetChildActive(9,false)
widget:SetChildActive(11,false)
widget:SetChildActive(12,false)


comHelper.setChildModelRawImage(widget,data.discipleguid,1,0,eHeadCenterType.eHalf)
else
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
widget:SetChildActive(3,false)
widget:SetChildActive(9,false)
widget:SetChildActive(11,true)
widget:SetChildActive(12,true)
widget:SetChildCSImageSprite(11,abname,imgName)
end
end
return num
elseif type==4 then
local len=aimnum
local level=params[1]
local imgName='image_xyryui_8'
local num,list=UIDiscipleModel:getDiscipleLTCountList(level)

item:SetChildScrollViewCreateGrids(5,len,len)
local grids=item:GetChildScrollViewItemWidgets(5)

if len<=5 then
item:SetChildScrollRectEnable(5,false)
end

for i=1,len do
local data=list[i]
local widget=grids[i-1]

if i<=num then
widget:SetChildActive(1,true)
widget:SetChildActive(2,true)
widget:SetChildActive(3,true)
widget:SetChildActive(9,false)
widget:SetChildActive(11,false)
widget:SetChildActive(12,false)


comHelper.setChildModelRawImage(widget,data.discipleguid,1,0,eHeadCenterType.eHalf)
else
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
widget:SetChildActive(3,false)
widget:SetChildActive(9,false)
widget:SetChildActive(11,true)
widget:SetChildActive(12,true)
widget:SetChildCSImageSprite(11,abname,imgName)
end
end

return num
elseif type==306 then
local num=0
local len=#params
item:SetChildScrollViewCreateGrids(5,len,len)
local grids=item:GetChildScrollViewItemWidgets(5)

if len<=5 then
item:SetChildScrollRectEnable(5,false)
end

for i=1,len do
local modelParams={}
local diziId=params[i]
local widget=grids[i-1]
local datas=UIDiscipleModel:getDiscipleDataByDiziId(diziId)
local cfg=cfgHelper.get2(cfg_discipleconfig_get,diziId,'imagelib')
local bodyid=cfgHelper.get2(cfg_disciplebodyimageconfig_get,cfg[3],'skeletonID')
modelParams.body=bodyid
local count=UIDiscipleModel:getSameIdDiscipleCount(diziId)
local isGray=true and count<1 or false

if not isGray then num=num+1 end

widget:SetChildActive(1,true)
widget:SetChildActive(2,not isGray)
widget:SetChildActive(3,not isGray)
widget:SetChildActive(9,false)
widget:SetChildActive(11,false)
widget:SetChildActive(12,isGray)



comHelper.setChildModelRawImageEx(1,widget,modelParams,eHeadCenterType.eHalf)
end

return num
elseif type==307 then
local num=0
local len=#params
item:SetChildScrollViewCreateGrids(5,len,len)
local grids=item:GetChildScrollViewItemWidgets(5)

if len<=5 then
item:SetChildScrollRectEnable(5,false)
end

for i=1,len do
local modelParams={}
local param=params[i]
local widget=grids[i-1]
local d=string.split(param,'_')
local diziId=tonumber(d[1])
local tmLv=tonumber(d[2])

local datas=UIDiscipleModel:getDiscipleDataByDiziId(diziId)
local cfg=cfgHelper.get2(cfg_discipleconfig_get,diziId,'imagelib')
local bodyid=cfgHelper.get2(cfg_disciplebodyimageconfig_get,cfg[3],'skeletonID')
modelParams.body=bodyid
local count,list=UIDiscipleModel:getSameIdDiscipleCountAndList(diziId)
local isGray=true and count<1 or false

widget:SetChildActive(1,true)
widget:SetChildActive(2,not isGray)
widget:SetChildActive(3,not isGray)
widget:SetChildActive(11,false)
widget:SetChildActive(12,isGray)



comHelper.setChildModelRawImageEx(1,widget,modelParams,eHeadCenterType.eHalf)

if count>=1 then

local guidinfo=list[1]
local netData=UIDiscipleModel:getDiscipleDataByStr(guidinfo.discipleguidStr)
local dzInfo=netData.imageInfo
local dzNowTmLv=UIDiscipleModel:getTianMingLevelEx(netData)
if dzNowTmLv>=tmLv then num=num+1 end

if dzInfo then

local chong=UIDiscipleModel.getTianMingLevelChong(dzNowTmLv)
local floor=UIDiscipleModel.getTianMingLevelFloor(dzNowTmLv)
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
local createCount=chong
if createCount<1 then createCount=1 end

widget:SetChildActive(9,true)
widget:SetChildLayoutGroupCreateItems(9,createCount)

local tmGrids=widget:GetChildLayoutGroupGridList(9)

for i=1,createCount do
local fireItem=tmGrids[i-1]
fireItem:SetChildCSImageSprite(0,abName,iconName)
end
end
else
widget:SetChildActive(9,false)
widget:SetChildActive(10,false)
end
end
return num
elseif type==308 then
local len=aimnum
local param=params[1]
local d=string.split(param,'_')
local color=tonumber(d[1])
local jobid=tonumber(d[2])
local num,list=UIDiscipleModel:getDiscipleJobAndColorCount(jobid,color)
local imgName=imgType[color]or'image_xyryui_8'

item:SetChildScrollViewCreateGrids(5,len,len)
local grids=item:GetChildScrollViewItemWidgets(5)

if len<=5 then
item:SetChildScrollRectEnable(5,false)
end

for i=1,len do
local data=list[i]
local widget=grids[i-1]

if i<=num then
widget:SetChildActive(1,true)
widget:SetChildActive(2,true)
widget:SetChildActive(3,true)
widget:SetChildActive(9,false)
widget:SetChildActive(11,false)
widget:SetChildActive(12,false)



comHelper.setChildModelRawImage(widget,data.discipleguid,1,0,eHeadCenterType.eHalf)
else
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
widget:SetChildActive(3,false)
widget:SetChildActive(9,false)
widget:SetChildActive(11,true)
widget:SetChildActive(12,true)
widget:SetChildCSImageSprite(11,abname,imgName)
end
end
return num
end
end

function UiXianYouRuYun:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then return end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end

function UiXianYouRuYun:jumpToOtherWin(jumpParam,params)
local dzid
local type=jumpParam[1]

if type==1 then
activitiesController:jump(jumpParam[2],jumpParam[3],jumpParam[4])
elseif type==2 then
local id=jumpParam.id
local args=jumpParam.args
jumpManager:jump({id=id,args=args})
UIManager:closeWindow('UiXianYouRuYun')
elseif type==3 and params then

local dzData
local jumpBackFunc
local tabType=FULL_TAB_TYPE.eDiscipleTianMing

for k,param in ipairs(params)do
local d=string.split(param,'_')
local diziId=tonumber(d[1])
local tmLv=tonumber(d[2])
local count,list=UIDiscipleModel:getSameIdDiscipleCountAndList(diziId)

if count>=1 then
local guidinfo=list[1]
local dzData=UIDiscipleModel:getDiscipleDataByStr(guidinfo.discipleguidStr)
local dzNowTmLv=UIDiscipleModel:getTianMingLevelEx(dzData)
if dzNowTmLv<tmLv then
dzid=dzData.discipleguid
end
end
end

if self.activityId then
local subId=self.subId
local subType=self.subType

jumpBackFunc=function()
jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=subType,subid=subId}},function()
jumpManager:clearJump()
end)
end
end

if dzData then UIFullCommonControl:jumpDiscipleMain(dzid,tabType,jumpBackFunc)end
end
end