







def_class("UIXBTCTaskWin",UIWindowBase)









function UIXBTCTaskWin:bindComponents()

self.cjbtn=UIButton.get(self,0)
self.Content=UIObject.get(self,1)
self.itemScroller=UILoopListView.new(self,2)
self.maskBlock=UIButton.get(self,3)
self.root=UIObject.get(self,4)
self.uiPanel=UIObject.get(self,5)
self.noSign=UIObject.get(self,6)

self.cjbtn:setButtonClick(function()self:onCjbtn()end)

self.itemScroller:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.maskBlock:setButtonClick(function()self:onMaskBlock()end)



end


function UIXBTCTaskWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cjbtn);self.cjbtn=nil;
_UIObject_release(self.Content);self.Content=nil;
self.itemScroller:deleteSelf();self.itemScroller=nil;
_UIObject_release(self.maskBlock);self.maskBlock=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.uiPanel);self.uiPanel=nil;
_UIObject_release(self.noSign);self.noSign=nil;
end


















local taskcmp=
{
rewardlist=0,
taskname=1,
taskdesc=2,
gotobtn=3,
scrollview=4,
headroot=5,
monsterkuang=6,
monsterlvbg=7,
monsterlvtxt=8,
monstericon=9,
zydicon=10,
tszimg=11,
doimg=12,
gotobtn2=13,
}

local iconname=
{
[1]='image_xirenwu_1',
[2]='image_xizhandou_1',
[3]='image_xjtansuo_1',
}
local _this
local abname="ui/windows/xianbang/xianbang_atlas_pak.ab"
local rwidex=
{
type1=1,
type2=2
}

function UIXBTCTaskWin:onLoaded(...)
self:bindComponents()
_this=self
self.loopListView=self.winlua:GetChildUILoopListView(self.itemScroller:getID())
self.loopListViewCmp=self.winlua:GetChildLoopListView2(self.itemScroller:getID())
end


function UIXBTCTaskWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXBTCTaskWin:onShow(argtable,afterOnloaded)
self:refreshView()
if afterOnloaded and argtable.isInit then
self:playEnterAnim()
end
end


function UIXBTCTaskWin:playEnterAnim()
if not newbieControl.isInNewbie()then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
self.uiPanel:setChildAnchoredPosition(Vector2(-508,1))
self.uiPanel:setChildDOAnchorPosX(0,0.2,nil)
end
UIManager:invokeUIMethod('UIXianJieExplorationWin','playEnterAnim')
end

function UIXBTCTaskWin:playLeaveAnim()
self.uiPanel:setChildDOAnchorPosX(-508,0.2,nil)
self.closeLock=true
self:delayDo(0.2,function()
self.closeLock=nil
self:closeSelf()
end)
end

function UIXBTCTaskWin:onHide()

end
function UIXBTCTaskWin:onMaskBlock()
end
function UIXBTCTaskWin:onStartAction()
end
function UIXBTCTaskWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eCenter})
end

function UIXBTCTaskWin:getrewardlsit(cfg_task)
local list={}
local rewards=cfg_task.rewards
local type=rewards[1]
local redata=rewards[2]
if type==rwidex.type1 then
list=redata
elseif type==rwidex.type2 then
local exrewards=cfg_task.exrewards or{}
list=exrewards
end
return type,list
end

function UIXBTCTaskWin:onCjbtn()
xianjiexianbangController:XianBangJump()
end

function UIXBTCTaskWin:omjump(taskId,taskflag,_sceneidx)
if taskflag==0 then

return
end
if taskflag==1 then
if _sceneidx then
local mapid=xianjieModel:sceneIndex2SceneType(_sceneidx)

jumpManager:jump({id=JUMP_TYPE.eXianJie_ResPoint_4,args={mapid=mapid,taskid=taskId,autoclick=true}})
end

elseif taskflag==2 then
local sceneidx,gridX,gridZ=xianjiexianbangController:jumpxjzm()
if sceneidx then
xianjieController:jumpGrid(sceneidx,gridX,gridZ,nil,true)
end
end
end


function UIXBTCTaskWin:refreshView()
self.datalist=xianjiexianbangModel:getXBTaskDataOfTC()
if self.datalist and#self.datalist>0 then
self.noSign:setActive(false)
local createCount=#self.datalist
local createList={}
for i=1,createCount do
createList[#createList+1]=i
end
self.itemScroller:initData('XBtaskItem',createList)
else
self.noSign:setActive(true)
end
end

function UIXBTCTaskWin:onFreshAction(i,widget,data)

local taskdata=self.datalist[i]
local taskId=taskdata.taskId
local cfg_task=cfg_xianbangtaskconfig_get(taskId)

widget:SetChildText(taskcmp.taskname,cfg_task.name)

widget:SetChildActive(taskcmp.taskdesc,false)


widget:SetChildActive(taskcmp.scrollview,false)
local retype,rewards=self:getrewardlsit(cfg_task)
local len=#rewards
if len>0 then
widget:SetChildActive(taskcmp.scrollview,true)
widget:SetChildScrollRectEnable(taskcmp.scrollview,len>4)
widget:SetChildLayoutGroupCreateItems(taskcmp.rewardlist,len)
local grids=widget:GetChildLayoutGroupGridList(taskcmp.rewardlist)
for i=1,len do
local item=grids[i-1]
local reward=rewards[i]
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
end


local rqdata
local taskflag=0
local taskreLists=xianjieModel:findResPointsByXianBangTask(taskId)

if taskreLists and#taskreLists>0 then
rqdata=taskreLists[1]
taskflag=1
else
taskflag=2
local srcArgs={
scrtype=xjResPointSourceType.eXianBangTask,
taskid=taskId,
}
local taskreLists2=xianjieModel:findResPointCacheDatasBySource(srcArgs)
if taskreLists2 and#taskreLists2>0 then
rqdata=taskreLists2[1]
end

end

if rqdata then
self:rpHandleDtat(rqdata,taskflag,widget,cfg_task)

local sceneidx=rqdata.sceneidx
widget:SetChildButtonClick(taskcmp.gotobtn2,function()
self:omjump(taskId,taskflag,sceneidx)
end)
widget:SetChildButtonClick(taskcmp.gotobtn,function()
self:omjump(taskId,taskflag,sceneidx)
end)
end
end


function UIXBTCTaskWin:rpHandleDtat(rpData,taskflag,widget,cfg_task)
if taskflag==1 then
local cfg=rpData:getCfg()
widget:SetChildActive(taskcmp.tszimg,false)
widget:SetChildActive(taskcmp.doimg,false)
if rpData.rpType==XJ_ResPoint_TYPE.eMonster then

local groupid=cfg.monster_id
widget:SetChildActive(taskcmp.zydicon,false)
local color=cfg_task.color or 1
widget:SetChildCSImageSprite(taskcmp.monsterkuang,globalABLookup.global,FMT.fmt("image_gwtouxiangpjk_{0}",color))
comHelper.setChildModelRawImage_monsterGroup(widget,groupid,taskcmp.monstericon,0,eHeadCenterType.eHead)


local march=xianjieModel:getResPointMarch(rpData.rpGuid)
if march then
local teamHandle=march:getTeamHandle()
if teamHandle then
local state,times,lerp=teamHandle:getTeamState()
if lerp and lerp>0 and state==xjMarchTeamStateType.eGoto then
widget:SetChildActive(taskcmp.tszimg,false)
widget:SetChildActive(taskcmp.doimg,true)
end
end
end

elseif rpData.rpType==XJ_ResPoint_TYPE.eCollectible then

local xbzyname=cfg.xbzyname
widget:SetChildActive(taskcmp.zydicon,true)
widget:SetChildActive(taskcmp.monstericon,false)
widget:SetChildCSImageSprite(taskcmp.zydicon,abname,xbzyname)
local color=cfg_task.color or 1
widget:SetChildCSImageSprite(taskcmp.monsterkuang,globalABLookup.global,FMT.fmt("image_gwtouxiangpjk_{0}",color))


local march=xianjieModel:getResPointMarch(rpData.rpGuid)
if march then
local teamHandle=march:getTeamHandle()
if teamHandle then
local state,times,lerp=teamHandle:getTeamState()
if lerp and lerp>0 and state==xjMarchTeamStateType.eBattle then
widget:SetChildActive(taskcmp.tszimg,true)
widget:SetChildActive(taskcmp.doimg,false)
end
if lerp and lerp>0 and state==xjMarchTeamStateType.eGoto then
widget:SetChildActive(taskcmp.tszimg,false)
widget:SetChildActive(taskcmp.doimg,true)
end
end
end

elseif rpData.rpType==XJ_ResPoint_TYPE.eCtCollectible then

widget:SetChildActive(taskcmp.zydicon,false)
widget:SetChildIcon(taskcmp.monstericon,cfg.headimage,false)
local color=cfg_task.color or 1
widget:SetChildCSImageSprite(taskcmp.monsterkuang,globalABLookup.global,FMT.fmt("image_gwtouxiangpjk_{0}",color))

end
end
end
