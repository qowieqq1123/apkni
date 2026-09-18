







def_class("UIXianJieForceWin",UIWindowBase)









function UIXianJieForceWin:bindComponents()

self.bgmodel=UIObject.get(self,0)
self.bgModelPanel=UIObject.get(self,1)
self.chooseGrid=UIObject.get(self,2)
self.chooseView=UIObject.get(self,3)
self.closebtn=UIButton.get(self,4)
self.closelist=UIButton.get(self,5)
self.content=UIObject.get(self,6)
self.groupItem=UIObject.get(self,7)
self.listbg=UIButton.get(self,8)
self.listroot=UIObject.get(self,9)
self.NPCListPanel=UIObject.get(self,10)
self.root=UIObject.get(self,11)
self.shelter=UIObject.get(self,12)

self.closebtn:setButtonClick(function()self:onClosebtn()end)

self.closelist:setButtonClick(function()self:onCloselist()end)

self.listbg:setButtonClick(function()self:onListbg()end)



end


function UIXianJieForceWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgmodel);self.bgmodel=nil;
_UIObject_release(self.bgModelPanel);self.bgModelPanel=nil;
_UIObject_release(self.chooseGrid);self.chooseGrid=nil;
_UIObject_release(self.chooseView);self.chooseView=nil;
_UIObject_release(self.closebtn);self.closebtn=nil;
_UIObject_release(self.closelist);self.closelist=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.groupItem);self.groupItem=nil;
_UIObject_release(self.listbg);self.listbg=nil;
_UIObject_release(self.listroot);self.listroot=nil;
_UIObject_release(self.NPCListPanel);self.NPCListPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.shelter);self.shelter=nil;
end



















local this=nil
function UIXianJieForceWin:onLoaded(...)
this=self
self:bindComponents()
self:addNotify(notifyConfig.on_mystery_event_new,self.onMysteryEventNew)
end


function UIXianJieForceWin:__delete()
if self.delayid then
self:stopTimerByID(self.delayid)
self.delayid=nil
end
self:unbindComponents()
end
local abname="ui/windows/xianjie/xianjietask_atlas_pak.ab"
local abname2="ui/windows/xiangong/xiangong_atlas_pak.ab"

function UIXianJieForceWin.onMysteryEventNew(sysid,qiyuList)
if sysid==SYSTEM_DEFINE.eXianJieShiLiQiYuEvent then












end
end


function UIXianJieForceWin:onTaskChange(taskid,taskstate,Forceid)
local taskcfg=taskModel:getTaskConfig(taskid)
if taskcfg.tasktype==272 then
if taskstate==taskModel.taskDoingState then
local params=string.split(taskcfg.params[1],'_')
local NPCid=tonumber(params[1])
local treeid=tonumber(params[2])
local npccfg=taskModel:getTaskNPCConfig(NPCid)
local haveforce=npccfg.haveforce
if haveforce==this.Forceid then
this.npcid=NPCid
end
end
this:refresh()

elseif taskcfg.finish_npc or taskcfg.accept_npc then
this:refresh()

if taskcfg.weakGuideByAccept2 and taskstate==taskModel.taskDoingState then
if taskcfg.weakGuideByAccept2[1]==1 then
this:playGuide(taskid)
end
end
elseif Forceid and Forceid==this.Forceid then
this:refresh()
end
end

function UIXianJieForceWin:playGuide(taskid)
local taskweakGuide2=taskModel:GetnewtaskweakGuide2()
if taskweakGuide2 and taskweakGuide2[taskid]then
weakGuideController:beginGuide(taskweakGuide2[taskid])
taskModel:SetnewtaskweakGuide2(taskid,false)
end

end


local listcmp=
{
item=0,
headicon=1,
name=2,
stageicon=3,
button=4,
buttontext=5,
sign=6,
qipao=7,
qipaosign=8,
}
local singenpcCmp=
{
click=0,
headicon=1,
name=2,
qipao=3,
fuhao=4,
}



function UIXianJieForceWin:onShow(argtable,afterOnloaded)
self.listroot:setActive(false)
self.listbg:setActive(false)
self.closelist:setActive(false)
self.Forceid=argtable.Forceid
self.npcid=argtable.npcid or 0
self.shownewbie=argtable.shownewbie
self.cav=self:getChildCanvas(-1)
self.closebtn:setActive(false)

self.ForceCfg=xianjieModel:GetForceCfg(self.Forceid)
self:refresh()

end
function UIXianJieForceWin:getGuideWidget(guid)
return self:getChildExpandUI(-1,guid)
end
function UIXianJieForceWin:refresh()

local npclist=taskModel:GetHighTaskbyForceid(self.Forceid)

local npclist=self:findSamePos(npclist)
if self.delayid then
self:stopTimerByID(self.delayid)
self.delayid=nil
end

self.NPCListPanel:setChildLayoutGroupClearAllItems()
self.NPCListPanel:setChildLayoutGroupCreateItems(#npclist,function(index)
local item=self.NPCListPanel:getChildLayoutGroupGridItem(index-1)
local npcdata=npclist[index][2]
local npcid=npcdata.id
local npcpos=npcdata.pos_force

if#npclist[index][3]==1 then
if npcid==self.npcid then
if self.shownewbie then
item:SetChildNewBieComponentId(singenpcCmp.click,'UIXianJieForceWin.NPCItem'..npcid)
self.shownewbie=false
else

self:SetWeak(item)
end


self.npcid=0
end

item:SetChildWeakGuideComponentId(-1,'UIXianJieForceWin.NPCItem'..npcid)

item:SetChildLocalPosition(-1,Vector3(npcpos[1],npcpos[2],0))

item:SetChildButtonClick(singenpcCmp.click,function()
self:onTalkBtn(npcdata,item)
end)
item:SetChildIcon(singenpcCmp.headicon,npcdata.headimage,false)
item:SetChildText(singenpcCmp.name,npcdata.name)
local stageimage,type,needgray=taskModel:GetNPCStage(npcid)
if type==4 then

local cfg=taskModel:getTaskNPCConfig(npcid)
local talkday_treeid=cfg.talkday_treeid
if not talkday_treeid then
stageimage=nil
end
end
item:SetChildActive(singenpcCmp.fuhao,false)
item:SetChildActive(singenpcCmp.qipao,false)
if stageimage then
item:SetChildActive(singenpcCmp.fuhao,true)
item:SetChildActive(singenpcCmp.qipao,true)

if api_Available_SetChildCSImage()then

item:SetChildCSImage(singenpcCmp.qipao,abname,NPCstageimage[type].qipao,true)
item:SetChildCSImage(singenpcCmp.fuhao,abname,stageimage,true)
item:SetChildGray(singenpcCmp.qipao,needgray)
item:SetChildGray(singenpcCmp.fuhao,needgray)
else
item:SetChildCSImageSprite(singenpcCmp.qipao,abname,NPCstageimage[type].qipao)
item:SetChildCSImageSprite(singenpcCmp.fuhao,abname,stageimage)
item:SetChildGray(singenpcCmp.qipao,needgray)
item:SetChildGray(singenpcCmp.fuhao,needgray)
end
end
else
if next(npclist[index][3])then
for k,v in ipairs(npclist[index][3])do
local npcdata=v[2]
local npcid=npcdata.id
if npcid==self.npcid then

self:SetWeak(item)
self.npcid=0
break
end
end
end


item:SetChildText(singenpcCmp.name,"一众仙家")
item:SetChildGray(singenpcCmp.qipao,false)
item:SetChildGray(singenpcCmp.fuhao,false)

if api_Available_SetChildCSImage()then
item:SetChildCSImage(singenpcCmp.headicon,abname2,'icon_xiangongdizi_1',true)
item:SetChildCSImage(singenpcCmp.qipao,abname,'image_rwzt_qp1',true)
item:SetChildCSImage(singenpcCmp.fuhao,abname,'image_rwzt_dh1',true)
else
item:SetChildCSImageSprite(singenpcCmp.headicon,abname2,'icon_xiangongdizi_1')
item:SetChildCSImageSprite(singenpcCmp.qipao,abname,"image_rwzt_qp1")
item:SetChildCSImageSprite(singenpcCmp.fuhao,abname,'image_rwzt_dh1')
end

item:SetChildLocalPosition(-1,Vector3(npcpos[1],npcpos[2],0))
item:SetChildButtonClick(singenpcCmp.click,function()
self:ShowNPClist(npclist[index][3],item)
end)
end

end)

end


function UIXianJieForceWin:onHide()

end


function UIXianJieForceWin:ShowNPClist(npclist,item)
if self.delayid then
self:stopTimerByID(self.delayid)
item:SetChildRemoveExpandUI(-1,this.weakguid)
self.delayid=nil
end
self.listroot:setActive(true)
self.listbg:setActive(true)
self.closelist:setActive(true)
self.chooseView:setChildScrollViewCreateGrids(#npclist,1)
local grid=self.chooseView:getChildScrollViewItemWidgets()
for i=1,#npclist do
local npcdata=npclist[i][2]
local npcid=npcdata.id
local item=grid[i-1]
local hightask=npclist[i][1]
local npccfg=taskModel:getTaskNPCConfig(npcid)

item:SetChildText(listcmp.buttontext,npccfg.listbtn_text)
item:SetChildIcon(listcmp.headicon,npcdata.headimage,false)

item:SetChildButtonClick(listcmp.button,function()
self:onTalkBtn(npcdata)
end)

item:SetChildText(listcmp.name,npcdata.name)

local stageimage,type,needgray=taskModel:GetNPCStage(npcid)
if type==4 then

local cfg=taskModel:getTaskNPCConfig(npcid)
local talkday_treeid=cfg.talkday_treeid
if not talkday_treeid then
stageimage=nil
end
end
item:SetChildActive(listcmp.qipaosign,false)
item:SetChildActive(listcmp.qipao,false)
if stageimage then
item:SetChildActive(listcmp.qipaosign,true)
item:SetChildActive(listcmp.qipao,true)

if api_Available_SetChildCSImage()then
item:SetChildCSImage(listcmp.qipao,abname,NPCstageimage[type].qipao,true)
item:SetChildCSImage(listcmp.qipaosign,abname,stageimage,true)
item:SetChildGray(listcmp.qipao,needgray)
item:SetChildGray(listcmp.qipaosign,needgray)
else
item:SetChildCSImageSprite(listcmp.qipao,abname,NPCstageimage[type].qipao)
item:SetChildCSImageSprite(listcmp.qipaosign,abname,stageimage)
item:SetChildGray(listcmp.qipao,needgray)
item:SetChildGray(listcmp.qipaosign,needgray)
end
end


local cfg=hightask.cfg
item:SetChildActive(listcmp.sign,false)
if cfg then
local tasklineid=cfg.tasklineid
local iszhuizong=taskModel:isZhuiZongTask(tasklineid)
local type=0

if iszhuizong then
type=5
elseif tasklineid==1 then
type=1
elseif cfg.xianjietype and cfg.xianjietype==1 then
type=2
end

local signimage,abname_type=taskModel:GettaskTypeSign(type)
if signimage then
item:SetChildActive(listcmp.sign,true)
item:SetChildCSImageSprite(listcmp.sign,abname_type,signimage)
end

end
end
end


function UIXianJieForceWin:findSamePos(npclist)
local newnpclist={}
local needremove={}
local newlist=table.weakCopy(npclist)
for k,v in ipairs(newlist)do
local npcdata=v[2]
local npcid=npcdata.id
local npccfg=taskModel:getTaskNPCConfig(npcid)
local pos_force=npccfg.pos_force
if not newnpclist[pos_force[1]]then
newnpclist[pos_force[1]]={}
end
if not newnpclist[pos_force[1]][pos_force[2]]then
newnpclist[pos_force[1]][pos_force[2]]={}
end

table.insert(newnpclist[pos_force[1]][pos_force[2]],v)
if#newnpclist[pos_force[1]][pos_force[2]]>1 then
table.insert(needremove,k)
end
newlist[k][3]=newnpclist[pos_force[1]][pos_force[2]]
end

if#needremove>0 then
table.sort(needremove,function(a,b)
return a>b
end)
for k,v in ipairs(needremove)do
table.remove(newlist,v)
end
end



return newlist,newnpclist
end




function UIXianJieForceWin:onClosebtn()
self:closeSelf()

end


function UIXianJieForceWin:onTalkBtn(npcdata,item)
if self.delayid then
self:stopTimerByID(self.delayid)
item:SetChildRemoveExpandUI(-1,this.weakguid)
self.delayid=nil
end

taskModel:SetSelectlist(npcdata)
end




function UIXianJieForceWin:onCloselist()
self.listroot:setActive(false)
self.listbg:setActive(false)
self.closelist:setActive(false)

end
function UIXianJieForceWin:onListbg()
self:onCloselist()

end

function UIXianJieForceWin:SetWeak(item)
local pos=item:GetChildLocalPosition(-1)
local style={1,{10045,{-65,-5}}}
local func1=function(id)
if this==nil then return end

local widget=self:getGuideWidget(id)
if widget then


widget:SetChildLocalPosX(-1,60)
widget:SetChildLocalPosY(-1,45)
local data={sortLayer=self.cav[1],sortOrder=1000,sortOrderOffset=500}
weakGuideController:createStyle(widget,style,data)
end
end
local instanceID=weakGuideController:getStyleInstance(1)


self.weakguid=item:SetChildGreateExpandUI(-1,-1,instanceID,func1)
local func2=function()




item:SetChildRemoveExpandUI(-1,this.weakguid)
self.delayid=nil
end
self.delayid=self:delayDo(3,func2)

end


function UIXianJieForceWin:ChangeScrowview(X)

self.bgModelPanel:setLocalPosX(X)

end
