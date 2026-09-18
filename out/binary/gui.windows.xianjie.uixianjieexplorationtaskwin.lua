







def_class("UIXianJieExplorationTaskWin",UIWindowBase)









function UIXianJieExplorationTaskWin:bindComponents()

self.cjbtn=UIButton.get(self,0)
self.cjnum=UIText.get(self,1)
self.Content=UIObject.get(self,2)
self.itemScroller=UILoopListView.new(self,3)
self.maskBlock=UIButton.get(self,4)
self.reddot=UIObject.get(self,5)
self.root=UIObject.get(self,6)
self.rule=UIButton.get(self,7)
self.uiPanel=UIObject.get(self,8)

self.cjbtn:setButtonClick(function()self:onCjbtn()end)

self.itemScroller:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.maskBlock:setButtonClick(function()self:onMaskBlock()end)

self.rule:setButtonClick(function()self:onRule()end)



end


function UIXianJieExplorationTaskWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cjbtn);self.cjbtn=nil;
_UIObject_release(self.cjnum);self.cjnum=nil;
_UIObject_release(self.Content);self.Content=nil;
self.itemScroller:deleteSelf();self.itemScroller=nil;
_UIObject_release(self.maskBlock);self.maskBlock=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.rule);self.rule=nil;
_UIObject_release(self.uiPanel);self.uiPanel=nil;
end


















local abname="ui/windows/xianjie/xianjietask_atlas_pak.ab"
local taskcmp=
{
rewardlist=0,
taskname=1,
taskdesc=2,
gotobtn=3,
scrollview=4,
headroot=5,
}

local iconname=
{
[1]='image_xianjie_tb3',
[2]='image_xianjie_tb2',
[3]='image_xianjie_tb1',
}

local iconname_color=
{
[1]='image_xianjie_pzd1',
[2]='image_xianjie_pzd2',
[3]='image_xianjie_pzd3',
[4]='image_xianjie_pzd4',
}

function UIXianJieExplorationTaskWin:onLoaded(...)
self:bindComponents()
self.loopListView=self.winlua:GetChildUILoopListView(self.itemScroller:getID())
self.loopListViewCmp=self.winlua:GetChildLoopListView2(self.itemScroller:getID())
end


function UIXianJieExplorationTaskWin:__delete()
UIManager:invokeUIMethod("UIXianJieMainWin","refreshTanChaBtn")
self:unbindComponents()
end




function UIXianJieExplorationTaskWin:onShow(argtable,afterOnloaded)
self.Explor_datatable=table.weakCopy(taskModel:Initloaddatatable())
self:refreshView()

if afterOnloaded and argtable.isInit then
self:playEnterAnim()
end


taskModel:ClearExplor_newtask()
end


function UIXianJieExplorationTaskWin:playEnterAnim()
if not newbieControl.isInNewbie()then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
self.uiPanel:setChildAnchoredPosition(Vector2(-508,1))
self.uiPanel:setChildDOAnchorPosX(0,0.2,nil)
end
UIManager:invokeUIMethod('UIXianJieExplorationWin','playEnterAnim')
end

function UIXianJieExplorationTaskWin:playLeaveAnim()

self.uiPanel:setChildDOAnchorPosX(-508,0.2,nil)
self.closeLock=true
self:delayDo(0.2,function()
self.closeLock=nil
self:closeSelf()
end)
end

function UIXianJieExplorationTaskWin:onHide()

end

function UIXianJieExplorationTaskWin:refreshcj()
self.reddot:setActive(taskModel:GetChengjiuReddot())

local maxnum,nownum=taskModel:GetChengjiuNum()
self.cjnum:setText(string.format("%d/%d",nownum,maxnum))

end
function UIXianJieExplorationTaskWin:refreshView()
self:getDataList()
local createCount=#self.datalist
local createList={}
for i=1,createCount do
createList[#createList+1]=i
end
self.itemScroller:initData('XJtaskItem',createList)
self:refreshcj()
end

function UIXianJieExplorationTaskWin:onFreshAction(i,widget,data)


local taskdata=self.datalist[i].cfg
widget:SetChildText(taskcmp.taskname,taskdata.name)
widget:SetChildActive(taskcmp.taskdesc,false)
if taskdata['xianjietaskdesc']then
widget:SetChildText(taskcmp.taskdesc,taskdata.xianjietaskdesc)
widget:SetChildActive(taskcmp.taskdesc,true)
end
widget:SetChildActive(taskcmp.scrollview,false)
local headitem=widget:GetChildWidgetBase(taskcmp.headroot)
local headindex=taskModel:GetXianJieType(taskdata.id)
local taskColor=taskModel:GetXianJietaskColor(taskdata.id)
if not taskColor then
taskColor=1
logErr(string.format("仙界任务id%d没有配任务品质",taskdata.id))
end
local stringid=tostring(taskdata.id)


local isShow,type=taskModel:isRareTask(taskdata.id)
if isShow and not self.Explor_datatable[stringid]then
headitem:SetChildActive(1,true)
if type==1 then
headitem:SetChildCSImageSprite(1,globalABLookup.global,"image_xi_1")
else
local abname="ui/windows/xiangong/xiangong_atlas_pak.ab"
headitem:SetChildCSImageSprite(1,abname,FMT.fmt("image_xiangongrenwu_bs{0}",type-1))
end
else
headitem:SetChildActive(1,false)
end
headitem:SetChildActive(3,self.Explor_datatable[stringid]and self.Explor_datatable[stringid]or false)

if api_Available_SetChildCSImage()then
headitem:SetChildCSImage(0,abname,iconname[headindex],true)
headitem:SetChildCSImage(2,abname,iconname_color[taskColor],true)
else
headitem:SetChildCSImageSprite(0,abname,iconname[headindex])
headitem:SetChildCSImage(2,abname,iconname_color[taskColor],true)
end
if taskdata.xianjieRewardShow then
widget:SetChildActive(taskcmp.scrollview,true)
local num=#taskdata.xianjieRewardShow
widget:SetChildScrollRectEnable(taskcmp.scrollview,num>4)

widget:SetChildLayoutGroupCreateItems(taskcmp.rewardlist,num)
local grids=widget:GetChildLayoutGroupGridList(taskcmp.rewardlist)
for i=1,num do
local widget=grids[i-1]
local reward=taskdata.xianjieRewardShow[i]
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


widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)

end
end




widget:SetChildButtonClick(taskcmp.gotobtn,function()
xianjieModel:visitNPC(taskdata.accept_npc)
end)
end

function UIXianJieExplorationTaskWin:onStartAction()

end

function UIXianJieExplorationTaskWin:getDataList()

self.datalist=taskModel:GetAllCanAccept()
self:SortDataList()
end

function UIXianJieExplorationTaskWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})

end

function UIXianJieExplorationTaskWin:SortDataList()
table.sort(self.datalist,function(a,b)
local a_xi=a.cfg.xianjietype
local b_xi=b.cfg.xianjietype
if a_xi and not b_xi then
return true
elseif not a_xi and b_xi then
return false
else
return a.taskline>b.taskline
end
end)

end





function UIXianJieExplorationTaskWin:onMaskBlock()
end


function UIXianJieExplorationTaskWin:onCjbtn()
UIManager:showWindow("UIXianJieChengJiu")
end

function UIXianJieExplorationTaskWin:onRule()
local d={}
d.title='规则'
d.mode=3
d.name='ExplorationTaskWin_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end
