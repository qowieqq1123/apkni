







def_class("UIXianJie_ShouMoList",UIWindowBase)









function UIXianJie_ShouMoList:bindComponents()

self.addbtn=UIButton.get(self,0)
self.addbtn1=UIButton.get(self,1)
self.addbtn2=UIButton.get(self,2)
self.addbtn3=UIButton.get(self,3)
self.autoing=UIText.get(self,4)
self.autoToggle=UIToggleButton.get(self,5)
self.beginBtn=UIButton.get(self,6)
self.begintext=UIText.get(self,7)
self.cost=UIObject.get(self,8)
self.dropdownTxt5=UIText.get(self,9)
self.failTip=UIText.get(self,10)
self.listitem1=UIObject.get(self,11)
self.listitem2=UIObject.get(self,12)
self.listitem3=UIObject.get(self,13)
self.listitem4=UIObject.get(self,14)
self.moneyicon=UIImage.get(self,15)
self.notclickdro=UIButton.get(self,16)
self.notclickdro1=UIButton.get(self,17)
self.notclickdro2=UIButton.get(self,18)
self.rule=UIButton.get(self,19)
self.selectToggle=UIToggleButton.get(self,20)
self.sortTypeDropdown1=UIDropdown.get(self,21)
self.sortTypeDropdown2=UIDropdown.get(self,22)
self.sortTypeDropdown3=UIDropdown.get(self,23)
self.sortTypeDropdown4=UIDropdown.get(self,24)
self.sortTypeDropdown5=UIDropdown.get(self,25)
self.titleTxt=UIText.get(self,26)
self.tlnum=UIText.get(self,27)
self.tltext=UIText.get(self,28)

self.addbtn:setButtonClick(function()self:onAddbtn()end)

self.addbtn1:setButtonClick(function()self:onAddbtn1()end)

self.addbtn2:setButtonClick(function()self:onAddbtn2()end)

self.addbtn3:setButtonClick(function()self:onAddbtn3()end)

self.beginBtn:setButtonClick(function()self:onBeginBtn()end)

self.notclickdro:setButtonClick(function()self:onNotclickdro()end)

self.notclickdro1:setButtonClick(function()self:onNotclickdro1()end)

self.notclickdro2:setButtonClick(function()self:onNotclickdro2()end)

self.rule:setButtonClick(function()self:onRule()end)



end


function UIXianJie_ShouMoList:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addbtn);self.addbtn=nil;
_UIObject_release(self.addbtn1);self.addbtn1=nil;
_UIObject_release(self.addbtn2);self.addbtn2=nil;
_UIObject_release(self.addbtn3);self.addbtn3=nil;
_UIObject_release(self.autoing);self.autoing=nil;
_UIObject_release(self.autoToggle);self.autoToggle=nil;
_UIObject_release(self.beginBtn);self.beginBtn=nil;
_UIObject_release(self.begintext);self.begintext=nil;
_UIObject_release(self.cost);self.cost=nil;
_UIObject_release(self.dropdownTxt5);self.dropdownTxt5=nil;
_UIObject_release(self.failTip);self.failTip=nil;
_UIObject_release(self.listitem1);self.listitem1=nil;
_UIObject_release(self.listitem2);self.listitem2=nil;
_UIObject_release(self.listitem3);self.listitem3=nil;
_UIObject_release(self.listitem4);self.listitem4=nil;
_UIObject_release(self.moneyicon);self.moneyicon=nil;
_UIObject_release(self.notclickdro);self.notclickdro=nil;
_UIObject_release(self.notclickdro1);self.notclickdro1=nil;
_UIObject_release(self.notclickdro2);self.notclickdro2=nil;
_UIObject_release(self.rule);self.rule=nil;
_UIObject_release(self.selectToggle);self.selectToggle=nil;
_UIObject_release(self.sortTypeDropdown1);self.sortTypeDropdown1=nil;
_UIObject_release(self.sortTypeDropdown2);self.sortTypeDropdown2=nil;
_UIObject_release(self.sortTypeDropdown3);self.sortTypeDropdown3=nil;
_UIObject_release(self.sortTypeDropdown4);self.sortTypeDropdown4=nil;
_UIObject_release(self.sortTypeDropdown5);self.sortTypeDropdown5=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.tlnum);self.tlnum=nil;
_UIObject_release(self.tltext);self.tltext=nil;
end


















local _this=nil

local iswzsy=
{
[1]=true,
}

local MonsterMoney=
{
[1]=20,
[2]=20,
[3]=25,
[16]=30,
}

local boatCmp=
{
yetSet=0,
name=1,
Close=2,
head=3,
headbg=4,
addimage=5,
lock=6,
bossroot=7,
notbossroot=8,
model=9,
peoplebg=10,
jian=11,
}

local sortTypeNamesList={"普通","历练","首领",}

local monstertypeCmp={[1]=2,[2]=1,[3]=3}
local mjBossType={"所有","仙","魔"}

local _sceneDropView={
[eXianJieLogicSceneType.eXianJie]={
getSortTypeNameList=function()
if seasonController:checkSeasonStageBegined(0,5)then
sortTypeNamesList={"历练","普通","首领",}
else
sortTypeNamesList={"历练","普通"}
end
return sortTypeNamesList
end,
getMonsterTypeIndexList=function()
return{[1]=2,[2]=1,[3]=3}
end,
useMoneyId=140,
},
[eXianJieLogicSceneType.eMoJie]={
getSortTypeNameList=function()
return{"历练","首领"}
end,
getMonsterTypeIndexList=function()
return{[1]=2,[2]=16}
end,
useMoneyId=153,
}
}


function UIXianJie_ShouMoList:onLoaded(...)
self:bindComponents()
_this=self
self.sortTypeDropdown1:setChangeAction(function(...)self:onDropdownChange1(...)end)
self.sortTypeDropdown2:setChangeAction(function(...)self:onDropdownChange2(...)end)
self.sortTypeDropdown3:setChangeAction(function(...)self:onDropdownChange3(...)end)
self.sortTypeDropdown5:setChangeAction(function(...)self:onDropdownChange5(...)end)

end


function UIXianJie_ShouMoList:__delete()
xianjieModel:recordlastSelectType(_this.selectmonstertype,_this.select_min,_this.select_max,_this.priSelect,_sceneDropView[_this.curScene].useMoneyId,_this.select_xm,_this.curScene)
self:unbindComponents()
end
































function UIXianJie_ShouMoList:initDropData()
local curSceneIdx=xianjieModel:getSceneIndex()
self.curScene=xianjieController:transSceneIdxToLogicSceneType(curSceneIdx)
sortTypeNamesList=_sceneDropView[self.curScene].getSortTypeNameList()
monstertypeCmp=_sceneDropView[self.curScene].getMonsterTypeIndexList()
end




function UIXianJie_ShouMoList:onShow(argtable,afterOnloaded)

self.MJJD_flag=0
local sceneIdx=xianjieModel:getSceneIndex()
if sceneIdx and xianjienSceneIndexType:isMoJie(sceneIdx)then
local zmPos=xianjieModel:getZongMenOutPos_mojie()
local sceneidx=zmPos[1]
local gridX=zmPos[2]
local gridZ=zmPos[3]
local areaID_zm=xianjieModel:checkMapGridDataAreaID(sceneidx,gridX,gridZ)
if areaID_zm~=0 then
self.MJJD_flag=1
else
self.MJJD_flag=2
end
end

self:initDropData()

self.sceneDropView=_sceneDropView[_this.curScene]

self:showWindow('UITopMoneyWin',{{self.sceneDropView.useMoneyId}})
self.moneynum=0
local min,max=xianjieController:getMonsterMaxlevel(3)
if not argtable then
argtable={}
end

self.selectmonstertype=argtable[1]or 2
if table.findValue(monstertypeCmp,self.selectmonstertype)==nil then
self.selectmonstertype=monstertypeCmp[1]
argtable={}
end


local texttable={}
local xm=1

self.selectToggle:setActive(self.selectmonstertype==1)
if self.selectmonstertype==3 then

min,max=xianjieController:getMonsterMaxlevel(4)
elseif self.selectmonstertype==2 then
min,max=1,1
elseif self.selectmonstertype==16 then
min,max=xianjieController:getMoJieMonsterMaxlevel(16,self.MJJD_flag)
xm=1
end

for i=min,max do
texttable[#texttable+1]=i..'阶'
end

self.select_min=argtable[2]or min
self.select_max=argtable[3]or max
self.select_xm=argtable[6]or xm
self.priSelect=argtable[4]or false

xianjieModel:recordlastSelectType(_this.selectmonstertype,_this.select_min,_this.select_max,_this.priSelect,_sceneDropView[_this.curScene].useMoneyId,_this.select_xm,_this.curScene)


self.sortTypeDropdown1:setOption(sortTypeNamesList)
if self.selectmonstertype==3 then
self.sortTypeDropdown1:setValue(2)
elseif self.selectmonstertype==2 then
self.sortTypeDropdown1:setValue(0)
else
self.sortTypeDropdown1:setValue(1)
end
self.yzBoatDataList=XianYunGangModel:getBoatList()

self.sortTypeDropdown2:setOption(texttable)

self.sortTypeDropdown2:setValue(self.select_min-1)

self.sortTypeDropdown3:setOption(texttable)
self.sortTypeDropdown3:setValue(self.select_max-1)

self.sortTypeDropdown5:setOption(mjBossType)
self.sortTypeDropdown5:setValue(self.select_xm-1)

self.autoflag=xianjieModel:GetOpenAuto()

self.autoToggle:setToggle(self.autoflag)
self.autoToggle:setToggleChange(function(name,isOn)
self.autoflag=isOn
xianjieModel:SetOpenAuto(self.autoflag)
end)


self.selectToggle:setToggle(self.priSelect)
self.selectToggle:setToggleChange(function(name,isOn)
self.priSelect=isOn
self:refresh()
end)
self:refresh()

end


function UIXianJie_ShouMoList:onHide()

end
function UIXianJie_ShouMoList:refreshmoney()

end

function UIXianJie_ShouMoList:refresh()

if not xianjieModel:GetAutoStage()then
xianjieModel:SetSortTeam()
xianjieModel:SetSortTeamBoss()
end
self.notclickdro:setActive(xianjieModel:GetAutoStage())
self.notclickdro1:setActive(xianjieModel:GetAutoStage())
self.notclickdro2:setActive(xianjieModel:GetAutoStage())

local cmp=
{
self.listitem1,
self.listitem2,
self.listitem3,
self.listitem4,
}
local teamnum=0



local allTeamCount=xianjieModel:getWaiPaiTeamMaxNum()

local teamHandleList=xianjieModel:getAllWaiPaiTeamHandle()
local doingTeamCount=#teamHandleList
local freeTeamCount=allTeamCount-doingTeamCount
local yunzhouNum=xianjieModel:getXJFreeYzNum()
for k,v in ipairs(cmp)do
local widget=v:getWidgetBase()
local havediziflag=xianjieModel:CheckHavedizi(k,self.selectmonstertype)
local isboss=self.selectmonstertype==3 or self.selectmonstertype==16
local islock=false

local yunzhouNum=xianjieModel:getXJFreeYzNum()
widget:SetChildActive(boatCmp.addimage,not(havediziflag~=0))
widget:SetChildActive(boatCmp.yetSet,havediziflag~=0)
widget:SetChildActive(boatCmp.notbossroot,not isboss)
widget:SetChildActive(boatCmp.bossroot,isboss)
if not isboss then
widget:SetChildActive(boatCmp.peoplebg,not(havediziflag~=0))
widget:SetChildActive(boatCmp.jian,havediziflag~=0)
widget:SetChildActive(boatCmp.head,false)
widget:SetChildActive(boatCmp.headbg,false)
widget:SetChildActive(boatCmp.lock,freeTeamCount<k and havediziflag==0)
islock=freeTeamCount<k and havediziflag==0
widget:SetChildActive(boatCmp.model,false)
else
widget:SetChildActive(boatCmp.addimage,yunzhouNum>=k and not(havediziflag~=0))
widget:SetChildActive(boatCmp.lock,(yunzhouNum<k or freeTeamCount<k)and havediziflag==0)
islock=(yunzhouNum<k or freeTeamCount<k)and havediziflag==0
widget:SetChildActive(boatCmp.head,false)
widget:SetChildActive(boatCmp.headbg,false)
end
if havediziflag==1 then
teamnum=teamnum+1
end
if havediziflag~=0 then


local diziid=xianjieModel:FindFirstDZ(k,self.selectmonstertype)
if not diziid or mathHelper.compareInt64(diziid,Int64_0)then
widget:SetChildActive(boatCmp.head,false)
widget:SetChildActive(boatCmp.headbg,false)
elseif isboss then
widget:SetChildActive(boatCmp.head,true)
widget:SetChildActive(boatCmp.headbg,true)
self:SetDiZiHead(diziid,widget)
elseif not isboss then

local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(diziid,true,1,{changeBody=1})
widget:SetChildActive(boatCmp.model,true)

widget:SetChildUIModelShowTarget(boatCmp.model,modelParams.body,0.8,nil,-1,false,false)
end
end
widget:SetChildActive(boatCmp.Close,havediziflag~=0)
widget:SetChildButtonClick(boatCmp.Close,function()
if not isboss then
xianjieModel:saveShouMolist(k,{})
else
local beforedata=xianjieModel:getShouMolist_boss(k)
local botid=beforedata[2]
xianjieModel:saveShouMo_boss(k,{},0,{})

xianjieModel:ClearYunzhouShouMo_bossByIndex(botid)
end
self:refresh()
end)
if xianjieModel:GetAutoStage()and havediziflag==0 then
widget:SetChildActive(boatCmp.lock,true)
islock=true
end

if havediziflag==1 and isboss then
local bossdata=xianjieModel:getShouMolist_boss(k)
local yzId=bossdata[2]
if yzId then
local name=nil
if not name or name==''then

local cfg=cfgHelper.get1(cfg_fairylandboatconfig_get,yzId)
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,cfg.build_id)
if bdData and bdData.name then
name=bdData.name
end
end
widget:SetChildText(boatCmp.name,name)
end
elseif havediziflag==0 then
if not islock then
widget:SetChildText(boatCmp.name,"编辑队伍")
else
widget:SetChildText(boatCmp.name,"")
end
elseif havediziflag==-1 then
widget:SetChildText(boatCmp.name,string.format("<color=#f36666>%s</color>","弟子出征中"))
else
widget:SetChildText(boatCmp.name,"")
end

end


local useMoneyId=_sceneDropView[self.curScene].useMoneyId
if self.priSelect and self.selectmonstertype==1 then
local cfg=cfgHelper.get(cfg_fairylandinfoconfig003_get,10001)
local consume=cfg and cfg.consume
MonsterMoney[1]=consume and consume[1][2]or 20
self.moneynum=teamnum*MonsterMoney[1]
else
if self.selectmonstertype==1 then
local cfg=cfgHelper.get(cfg_fairylandinfoconfig003_get,1)
local consume=cfg and cfg.consume
MonsterMoney[1]=consume and consume[1][2]or 20
elseif self.selectmonstertype==2 then
local cfg=cfgHelper.get(cfg_fairylandmonsterresourceconfig_get,1)
local consume=cfg and cfg.costs
MonsterMoney[2]=consume and consume[2]or 20

elseif self.selectmonstertype==3 then
local cfg=cfgHelper.get(cfg_fairylandinfoconfig004_get,1)
local consume=cfg and cfg.consume
MonsterMoney[3]=consume and consume[1][2]or 25
elseif self.selectmonstertype==16 then
local cfg=cfgHelper.get(cfg_fairylandinfoconfig016_get,101)
local consume=cfg and cfg.consume
MonsterMoney[16]=consume and consume[1][2]or 25
end
self.moneynum=teamnum*MonsterMoney[self.selectmonstertype]
end
self.moneyicon:setImageIcon(iconHelper.getIconName(useMoneyId),false)
self.tlnum:setText(self.moneynum)



self.autoing:setActive(xianjieModel:GetAutoStage())
self.cost:setActive(not xianjieModel:GetAutoStage())
self.begintext:setText(xianjieModel:GetAutoStage()and"中止狩魔"or"出  发")

local moneyName=itemsConfig.getItemName(useMoneyId)
self.failTip:setText(FMT.fmt("（挑战失败将返还{0}）",moneyName))
self.tltext:setText(FMT.fmt("消耗{0}",moneyName))

local isShowDropDowm5=self.selectmonstertype==3


self.sortTypeDropdown5:setActive(isShowDropDowm5)
self.dropdownTxt5:setActive(isShowDropDowm5)
end


function UIXianJie_ShouMoList:onDropdownChange1(idx)


self.selectmonstertype=monstertypeCmp[idx+1]
local min,max=xianjieController:getMonsterMaxlevel(3)
if self.selectmonstertype==3 then
min,max=xianjieController:getMonsterMaxlevel(4)
elseif self.selectmonstertype==16 then
min,max=xianjieController:getMoJieMonsterMaxlevel(16,self.MJJD_flag)
elseif self.selectmonstertype==2 then
min,max=1,1
end
self.selectToggle:setActive(self.selectmonstertype==1)
local texttable={}
for i=min,max do
texttable[#texttable+1]=i..'阶'
end

self.sortTypeDropdown2:setOption(texttable)

self.sortTypeDropdown3:setOption(texttable)
self:refresh()
end
function UIXianJie_ShouMoList:onDropdownChange2(idx)

self.select_min=idx+1

if self.select_min>self.select_max then
self.sortTypeDropdown3:setValue(self.select_min-1)
end
end
function UIXianJie_ShouMoList:onDropdownChange3(idx)

self.select_max=idx+1

if self.select_min>self.select_max then
self.sortTypeDropdown2:setValue(self.select_max-1)
end
end
function UIXianJie_ShouMoList:onDropdownChange5(idx)

self.select_xm=idx+1

self.sortTypeDropdown5:setValue(self.select_xm-1)
end

function UIXianJie_ShouMoList:SetTeam(listid)
if self.selectmonstertype==1 or self.selectmonstertype==2 then
self:changeList(listid)
elseif self.selectmonstertype==3 or self.selectmonstertype==16 then
self:changeList_boss(listid)
end
end

function UIXianJie_ShouMoList:ShowDialouge()

local show_data={
type='UIDialouge',
title='提示',
content='云舟未解锁是否前往云港解锁？',
oktext='是',
canceltext='否',
okcallback=function()
jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=SLG_SYSTEM_TYPE.eXianYunGang}},nil,JUMP_BACK.eNoBack)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end

function UIXianJie_ShouMoList:onAddbtn1()
if xianjieModel:GetAutoStage()then
UIManager.info("自动狩魔中")
return
end
local listid=1
local allTeamCount=xianjieModel:getWaiPaiTeamMaxNum()

local teamHandleList=xianjieModel:getAllWaiPaiTeamHandle()
local doingTeamCount=#teamHandleList
local freeTeamCount=allTeamCount-doingTeamCount
local canmaxteam=xianjieModel:getWaiPaiTeamCanMaxNum()
local havediziflag=xianjieModel:CheckHavedizi(listid,self.selectmonstertype)
if havediziflag==-1 then
UIManager.info("弟子出征中")
return
end
if freeTeamCount<listid and allTeamCount<canmaxteam then

local args={}
args.titleName='队伍拓展'
args.showClose=false
args.pos=2
args.extraWin='UIXianJie_extraTeamGainWin'


local extraParams={}
args.extraParams=extraParams

UIManager:showWindow('UICommonPageWin',args)
return
end


if freeTeamCount<listid then
UIManager.info("队列已满")
return
end


if self.selectmonstertype==3 then

local yunzhouNum=xianjieModel:getXJFreeYzNum()
if yunzhouNum<1 then

local flag=self:YZnumEnough()
if flag then
self:ShowDialouge()
return
end
UIManager.info("没有空闲云舟")
return
end
end


self:SetTeam(listid)
end

function UIXianJie_ShouMoList:onAddbtn2()
if xianjieModel:GetAutoStage()then

UIManager.info("自动狩魔中")
return
end
local listid=2
local allTeamCount=xianjieModel:getWaiPaiTeamMaxNum()

local teamHandleList=xianjieModel:getAllWaiPaiTeamHandle()
local doingTeamCount=#teamHandleList
local freeTeamCount=allTeamCount-doingTeamCount
local canmaxteam=xianjieModel:getWaiPaiTeamCanMaxNum()
local havediziflag=xianjieModel:CheckHavedizi(listid,self.selectmonstertype)
if havediziflag==-1 then
UIManager.info("弟子出征中")
return
end
if freeTeamCount<listid and allTeamCount<canmaxteam then

local args={}
args.titleName='队伍拓展'
args.showClose=false
args.pos=2
args.extraWin='UIXianJie_extraTeamGainWin'


local extraParams={}
args.extraParams=extraParams

UIManager:showWindow('UICommonPageWin',args)
return
end

if freeTeamCount<listid then
UIManager.info("队列已满")
return
end

if self.selectmonstertype==3 then

local yunzhouNum=xianjieModel:getXJFreeYzNum()
if yunzhouNum<2 then
local flag=self:YZnumEnough()
if flag then
self:ShowDialouge()
return
end
UIManager.info("没有空闲云舟")
return
end
end


self:SetTeam(2)
end

function UIXianJie_ShouMoList:onAddbtn3()
if xianjieModel:GetAutoStage()then

UIManager.info("自动狩魔中")
return
end
local listid=3
local allTeamCount=xianjieModel:getWaiPaiTeamMaxNum()

local teamHandleList=xianjieModel:getAllWaiPaiTeamHandle()
local doingTeamCount=#teamHandleList
local freeTeamCount=allTeamCount-doingTeamCount

local canmaxteam=xianjieModel:getWaiPaiTeamCanMaxNum()
local havediziflag=xianjieModel:CheckHavedizi(listid,self.selectmonstertype)
if havediziflag==-1 then
UIManager.info("弟子出征中")
return
end
if freeTeamCount<listid and allTeamCount<canmaxteam then

local args={}
args.titleName='队伍拓展'
args.showClose=false
args.pos=2
args.extraWin='UIXianJie_extraTeamGainWin'


local extraParams={}
args.extraParams=extraParams

UIManager:showWindow('UICommonPageWin',args)
return
end

if freeTeamCount<listid then
UIManager.info("队列已满")
return
end

if self.selectmonstertype==3 then

local yunzhouNum=xianjieModel:getXJFreeYzNum()
if yunzhouNum<3 then
local flag=self:YZnumEnough()
if flag then
self:ShowDialouge()
return
end
UIManager.info("没有空闲云舟")
return
end
end


self:SetTeam(3)
end


function UIXianJie_ShouMoList:onAddbtn()
if xianjieModel:GetAutoStage()then
UIManager.info("自动狩魔中")
return
end
local listid=4
local allTeamCount=xianjieModel:getWaiPaiTeamMaxNum()

local teamHandleList=xianjieModel:getAllWaiPaiTeamHandle()
local doingTeamCount=#teamHandleList
local freeTeamCount=allTeamCount-doingTeamCount

local canmaxteam=xianjieModel:getWaiPaiTeamCanMaxNum()
local havediziflag=xianjieModel:CheckHavedizi(listid,self.selectmonstertype)
if havediziflag==-1 then
UIManager.info("弟子出征中")
return
end
if freeTeamCount<listid and allTeamCount<canmaxteam then

local args={}
args.titleName='队伍拓展'
args.showClose=false
args.pos=2
args.extraWin='UIXianJie_extraTeamGainWin'


local extraParams={}
args.extraParams=extraParams

UIManager:showWindow('UICommonPageWin',args)
return
end

if freeTeamCount<listid then
UIManager.info("队列已满")
return
end

if self.selectmonstertype==3 then

local yunzhouNum=xianjieModel:getXJFreeYzNum()
if yunzhouNum<4 then
local flag=self:YZnumEnough()
if flag then
self:ShowDialouge()
return
end
UIManager.info("没有空闲云舟")
return
end
end


self:SetTeam(4)
end


function UIXianJie_ShouMoList:YZnumEnough()
local list=XianYunGangModel:getBoatList()
local canmax=XianYunGangModel:getCanBuildBoatList()

local num=0
if list then
num=#list
end

return num<#canmax
end




function UIXianJie_ShouMoList:changeList(listid)

local teamList=xianjieModel:getShouMoteamData(listid)

local allData=UIDiscipleModel:getAllDiscipleData()
local dzlist={}
for k,v in pairs(allData)do
local dzguid=v.netData.net.discipleguid
local flag=xianjieModel:GetYetDizi_notboss(dzguid)
if flag==0 or flag==listid then
table.insert(dzlist,dzguid)
end
end

local winArgs=
{
lockSelect=dzlist,
teamList=teamList,

enterCallBack=function(selectList,zfId,mapId)
fightController:closeSelectStage()
UIFullFightPrepareControl:closeActiveUI()
xianjieModel:saveShouMolist(listid,selectList)
xianjieController:openWin('UIXianJieExplorationWin',{page=1})
local arg=xianjieModel:GetrecordlastSelectType()
UIManager:showWindow('UIXianJie_ShouMoList',arg)

end,
enterTxt="仙界",
cancelCallBack=function()
fightController:closeSelectStage()
xianjieController:openWin('UIXianJieExplorationWin',{page=1})
local arg=xianjieModel:GetrecordlastSelectType()
UIManager:showWindow('UIXianJie_ShouMoList',arg)

end,
isCheckXJOccupyType=true,
dzCountLeast=0,
statePriorityCheck=false,
skipDiscipleStateCheck=true,
skipDiscipleInjuryCheck=true,
showZhenFa=false,
}
local dzInfoFuncList={}
local dzlist=UIDiscipleModel:getSortList()
for i,netData in ipairs(dzlist)do
local d={guid=netData.discipleguid}
xianjieModel:initBattleDZ(d)
dzInfoFuncList[netData.discipleguidStr]=d
end
winArgs.dzInfoFuncList=dzInfoFuncList
winArgs.checkDZSortFunc=xianjieModel.checkDZSortFunc
UIManager:invokeUIMethod('UIXianJieExplorationWin',"onCloseBtn")
xianjieModel:recordlastSelectType(_this.selectmonstertype,_this.select_min,_this.select_max,_this.priSelect,_sceneDropView[_this.curScene].useMoneyId,_this.select_xm,_this.curScene)
fightController.showPrepareWin(fightPreSelectModel.fightType.xianjieResPointMonster,winArgs)
end



function UIXianJie_ShouMoList:changeList_boss(listid)

local orderType=xjOrderType.eAttackBoss
local isChuZheng,isCanChuZheng=xianjieModel:checkXJIsChuZheng(orderType,true)
if isChuZheng then
if not isCanChuZheng then
return
end

local func=function(selectDzList,selectMoneyList,boatId)


local ordertype=orderType
local params=''
if not boatId then
return
end
xianjieModel:saveShouMo_boss(listid,selectDzList,boatId,selectMoneyList)
xianjieController:openWin('UIXianJieExplorationWin',{page=1})
local arg=xianjieModel:GetrecordlastSelectType()
UIManager:showWindow('UIXianJie_ShouMoList',arg)
end

local teamList=xianjieModel:getShouMolist_boss(listid)
local defaultSoldierList={}

if teamList and teamList[3]then
for k,v in ipairs(teamList[3])do

local bzid=yunjiayingModel:getSoldierLevelByMoneyType(v[1])
defaultSoldierList[bzid]=v[2]
end
end

local win=
{
defaultDzList=teamList and teamList[1],
selectYzIndex=teamList and teamList[2],
defaultSoldierList=next(defaultSoldierList)and defaultSoldierList or nil,
callback=func,
cancelCallBack=function()
xianjieController:openWin('UIXianJieExplorationWin',{page=1})
local arg=xianjieModel:GetrecordlastSelectType()
UIManager:showWindow('UIXianJie_ShouMoList',arg)
end,


orderType=orderType,
isCheckSMDData=true,
smdId=listid,
}

UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx(win)

end
end





function UIXianJie_ShouMoList:onBeginBtn()
local zmData=xianjieModel:getMyZongMenData()
local sceneType_=zmData.sceneidx
local sceneidx=xianjieModel:getSceneIndex()
if sceneType_~=sceneidx then
local msg=""
if sceneType_~=0 then
msg="堡垒不在仙界中，无法自动狩猎，请先将堡垒搬迁至仙界中"
else
msg="堡垒不在仙域中，无法自动狩猎，请先将堡垒搬迁至仙域中"
end
UIManager.info(msg)
return
end


local AutoStage=xianjieModel:GetAutoStage()
if not AutoStage then
if xianjieModel:GetOpenAuto()then
xianjieModel:SetAutoStage(true)
end
xianjieModel:recordlastSelectType(_this.selectmonstertype,_this.select_min,_this.select_max,_this.priSelect,_sceneDropView[_this.curScene].useMoneyId,_this.select_xm,_this.curScene)
local goflag=xianjieModel:BeginBtn()

if goflag then
self:closeSelf()
end
else
xianjieModel:SetAutoStage(false)
self:refresh()
end

end







function UIXianJie_ShouMoList:SetDiZiHead(guid,widget)
local netData=UIDiscipleModel:getDiscipleData(guid)
local image=UIDiscipleModel.calculationDiscipleImageBase(netData)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(boatCmp.head,widget,modelParams,eHeadCenterType.eHalf,nil,false)

local dzInfo=netData.imageInfo
local color=dzInfo.color
comHelper.setChildModelHeadIconBGByColor(widget,boatCmp.headbg,color)
end


function UIXianJie_ShouMoList:onRule()
local d={}
d.title='规则'
d.mode=3
d.name='XianjieShouMo_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end



function UIXianJie_ShouMoList:onNotclickdro()
if xianjieModel:GetAutoStage()then
UIManager.info("自动狩魔中")
return
end
end

function UIXianJie_ShouMoList:onNotclickdro1()
if xianjieModel:GetAutoStage()then
UIManager.info("自动狩魔中")
return
end
end
function UIXianJie_ShouMoList:onNotclickdro2()
if xianjieModel:GetAutoStage()then
UIManager.info("自动狩魔中")
return
end
end
