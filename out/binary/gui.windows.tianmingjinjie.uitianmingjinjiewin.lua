







def_class("UITianMingJinJieWin",UIWindowBase)









function UITianMingJinJieWin:bindComponents()

self.bg=UIObject.get(self,0)
self.contect=UIObject.get(self,1)
self.fg=UIObject.get(self,2)
self.gotoBtn=UIButton.get(self,3)
self.receiveBtn=UIButton.get(self,4)
self.receiveFlag=UIObject.get(self,5)
self.rewards=UIObject.get(self,6)
self.root=UIObject.get(self,7)
self.scrollView=UIObject.get(self,8)
self.targetText=UIText.get(self,9)
self.time=UIText.get(self,10)
self.title=UIImage.get(self,11)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)

self.receiveBtn:setButtonClick(function()self:onReceiveBtn()end)



end


function UITianMingJinJieWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.contect);self.contect=nil;
_UIObject_release(self.fg);self.fg=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.receiveBtn);self.receiveBtn=nil;
_UIObject_release(self.receiveFlag);self.receiveFlag=nil;
_UIObject_release(self.rewards);self.rewards=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.targetText);self.targetText=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.title);self.title=nil;
end



















function UITianMingJinJieWin:onLoaded(...)
self:bindComponents()

self.abName='ui/windows/tianmingjinjie/tianmingjinjie_atlas_pak.ab'
self.bgImgName={
{
'image_tianmingjinjie_07',
'image_tianmingjinjie_08'
},
{
'image_tianmingjinjie_09',
'image_tianmingjinjie_10'
}
}

self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)

self.bg:setChildUIModelShowTarget(6224,1,nil,eAnimationID.stand)
end


function UITianMingJinJieWin:__delete()
self:unbindComponents()
end




function UITianMingJinJieWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.actId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
end

self:setEndTimeTips()

self:refresh()
end


function UITianMingJinJieWin:onHide()

end

function UITianMingJinJieWin:setEndTimeTips()
if not self.nTimer then
local info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
local etime=info.end_time
local tick=function()
local dt=etime-gameUtilityModel.getServerShortTime()
self.time:setText(FMT.fmt('{0}后结束',timeHelper.format_time_stamp11(dt,true)))
if dt<0 then
self.time:setText('活动已结束')
self:stopTimerByID(self.nTimer)
self.nTimer=nil
end
end
self.nTimer=self:setTimer(1,0,tick)
tick()
end
end

function UITianMingJinJieWin:getDZCheckList(dzlist)
local list={}
for i,v in ipairs(dzlist)do
local flist=UIDiscipleModel:findDisciplesByID(v)
list[#list+1]=#flist>0
end
return list
end

function UITianMingJinJieWin:getDZList(dzlist,check_list,target,progress)
local list={}
for i,v in ipairs(dzlist)do
local d={}
d.id=i
d.dzId=v
d.check=check_list[i]
d.finish=progress[i]>=target[i]
list[#list+1]=d
end
table.sort(list,function(a,b)
if not a.finish and b.finish then
return true
elseif a.finish==b.finish then
if a.check and not b.check then
return true
elseif a.check==b.check then
return a.id<b.id
else
return false
end
else
return false
end
end)
return list
end

function UITianMingJinJieWin:refresh()
local cfg=cfgHelper.get1(cfg_specdsptianmingconfig_get,self.subId)
self.title:setSprite(self.abName,cfg.title_image)
local data=activitiesModel:getSubActInfoData(self.actId,self.subType,self.subId)
local showIndex=data.rewardIndex+1
showIndex=math.min(showIndex,#cfg.reward)
local tskdata=cfg.reward[showIndex]
self.taskData=tskdata
local target=tskdata[1]
local dzlist=cfg.dsp_list
local check_list=self:getDZCheckList(dzlist)
dzlist=self:getDZList(dzlist,check_list,target,data.progress)
self.dzlist=dzlist
local len=#target
local passCount=0
self.contect:setChildPivot(Vector2(0,1))
self.scrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.scrollView:getChildScrollViewItemWidgets()
self.contect:setChildPivot(Vector2(0.5,1))
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local sdata=dzlist[i]
local dzId=sdata.dzId
local dzData=UIDiscipleModel:getDiscipleDataByDiziId(dzId)
item:SetChildText(0,dzData.disciplename)

local id=sdata.id
local bgt=check_list[id]and 1 or 2
item:SetChildCSImageSprite(7,self.abName,self.bgImgName[bgt][1])
item:SetChildCSImageSprite(8,self.abName,self.bgImgName[bgt][2])

local active=bgt==1
item:SetChildActive(9,active)
item:SetChildActive(10,not active)

local info=dzData.imageInfo
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(info)
modelParams.scale=0.019


comHelper.setChildModelRawImageEx(1,item,modelParams,eHeadCenterType.eNone,1,false)

local tmLevelT=target[id]
local tmLevelC=data.progress[id]
local tmName=UIDiscipleModel.getTianMingLevelDesc(tmLevelT,1)
if tmLevelT>0 then
item:SetChildText(2,FMT.fmt(cfg.desc[2],tmName))
else
item:SetChildText(2,cfg.desc[3])
end
if tmLevelC>=tmLevelT then
item:SetChildText(3,'')
item:SetChildActive(6,true)
elseif tmLevelT>0 then
local color=self:getColor(tmLevelC,tmLevelT)
item:SetChildText(3,FMT.fmt('<color={0}>({1}/{2})</color>',color,math.max(0,tmLevelC),tmLevelT))
item:SetChildActive(6,false)
else
item:SetChildText(3,'')
item:SetChildActive(6,false)
end

local jobicon=UIDiscipleModel:getJobIconName(info.job)
item:SetChildCSImageSprite(4,globalABLookup.global,jobicon)

if active then
self:setTMLevelIcon(item,5,tmLevelT)
end

if tmLevelC>=tmLevelT then
passCount=passCount+1
end
end

local desc=FMT.fmt(cfg.desc[1],len)
local color=self:getColor(passCount,len)
self.targetText:setText(FMT.fmt('{0}<color={1}>（{2}/{3}）</color>',desc,color,passCount,len))

local canReceive=passCount>=len
local isReceived=showIndex==data.rewardIndex
self.gotoBtn:setActive(not canReceive)
self.receiveBtn:setActive(canReceive and not isReceived)


local animId=eAnimationID.stand
if isReceived then
animId=eAnimationID.stand_tmjj_lqwc
elseif canReceive then
animId=eAnimationID.stand_tmjj_lq
end
self.fg:setChildUIModelShowTarget(6225,1,nil,animId)

self:setRewards(tskdata[2],isReceived)
end

function UITianMingJinJieWin:getColor(curr,max)
if curr>=max then
return'#aae252'
else
return'#f36666'
end
end

function UITianMingJinJieWin:setTMLevelIcon(widget,index,tmlv)
local chong=UIDiscipleModel.getTianMingLevelChong(tmlv)
local showchong=chong>0
widget:SetChildActive(index,showchong)
if showchong then
local floor=UIDiscipleModel.getTianMingLevelFloor(tmlv)
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
local grids=widget:GetChildCommonLayoutGroupWidgetList(index)
for i=1,3 do
local item=grids[i-1]
local isActive=i<=chong
local scale=1




item:SetChildActive(-1,isActive)
if isActive then
item:SetChildCSImageSprite(0,abName,iconName)
item:SetChildScale(0,Vector3.New(scale,scale,scale))
end
end
end
end

function UITianMingJinJieWin:setRewards(rwdatas,flag)
local grids=self.rewards:getChildCommonLayoutGroupWidgetList()
for i=1,5 do
local item=grids[i-1]
local rwd=rwdatas[i]
if rwd then
item:SetChildActive(-1,true)
widgetHelper.setNormalRewardItem(item,0,rwd)
item:SetChildActive(1,flag)
else
item:SetChildActive(-1,false)
end
end
end

function UITianMingJinJieWin:callActivityFunc(fname,...)
return call_activitiesHandle_func('activitiesHandle_tainmingjinjie',fname,self.actId,self.subId,...)
end




function UITianMingJinJieWin:onGotoBtn()
local data=activitiesModel:getSubActInfoData(self.actId,self.subType,self.subId)
local target=self.taskData[1]
local dzguid
local len=#target
for i=1,len do
local dzdata=self.dzlist[i]
local id=dzdata.id
if data.progress[id]<target[id]then
local list=UIDiscipleModel:findDisciplesByID(dzdata.dzId)
if#list>0 then
dzguid=list[1].discipleguid
break
end
end
end
if dzguid then
local subType=self.subType
local subId=self.subId
local jumpBackFunc=function()
jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=subType,subid=subId}},function()
jumpManager:clearJump()
end)
end
local tabType=FULL_TAB_TYPE.eDiscipleTianMing
UIFullCommonControl:jumpDiscipleMain(dzguid,tabType,jumpBackFunc)
else
local cfg=cfgHelper.get1(cfg_specdsptianmingconfig_get,self.subId)
if cfg.jump then
jumpManager:jump(cfg.jump)
end
end
end

function UITianMingJinJieWin:onReceiveBtn()
self:callActivityFunc('reqReceive')
end
