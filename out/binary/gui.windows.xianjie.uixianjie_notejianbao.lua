







def_class("UIXianJie_notejianbao",UIWindowBase)









function UIXianJie_notejianbao:bindComponents()

self.aapanel=UIObject.get(self,0)
self.allitem=UIObject.get(self,1)
self.allitem1=UIObject.get(self,2)
self.allitem2=UIObject.get(self,3)
self.allitem3=UIObject.get(self,4)
self.allitem4=UIObject.get(self,5)
self.allitem5=UIObject.get(self,6)
self.allitem6=UIObject.get(self,7)
self.allitem7=UIObject.get(self,8)
self.apanel=UIObject.get(self,9)
self.bticon=UIImage.get(self,10)
self.bticonbg=UIImage.get(self,11)
self.closeButton=UIButton.get(self,12)
self.frame=UIButton.get(self,13)
self.hpanel=UIObject.get(self,14)
self.htxt=UIText.get(self,15)
self.ipanel=UIImage.get(self,16)
self.liconItem=UIObject.get(self,17)
self.monsterLvBg=UIImage.get(self,18)
self.monsterLvTx=UIText.get(self,19)
self.moqi=UIObject.get(self,20)
self.riconItem=UIObject.get(self,21)
self.skilDesc=UIObject.get(self,22)
self.strengthenCreator=UIObject.get(self,23)
self.topicon=UIImage.get(self,24)
self.xianqi=UIObject.get(self,25)
self.zdbtn=UIButton.get(self,26)
self.zdjbImg=UIObject.get(self,27)
self.zdjbtxt=UIText.get(self,28)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIXianJie_notejianbao")end)

self.frame:setButtonClick(function()self:onFrame()end)

self.zdbtn:setButtonClick(function()self:onZdbtn()end)



end


function UIXianJie_notejianbao:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.aapanel);self.aapanel=nil;
_UIObject_release(self.allitem);self.allitem=nil;
_UIObject_release(self.allitem1);self.allitem1=nil;
_UIObject_release(self.allitem2);self.allitem2=nil;
_UIObject_release(self.allitem3);self.allitem3=nil;
_UIObject_release(self.allitem4);self.allitem4=nil;
_UIObject_release(self.allitem5);self.allitem5=nil;
_UIObject_release(self.allitem6);self.allitem6=nil;
_UIObject_release(self.allitem7);self.allitem7=nil;
_UIObject_release(self.apanel);self.apanel=nil;
_UIObject_release(self.bticon);self.bticon=nil;
_UIObject_release(self.bticonbg);self.bticonbg=nil;
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.frame);self.frame=nil;
_UIObject_release(self.hpanel);self.hpanel=nil;
_UIObject_release(self.htxt);self.htxt=nil;
_UIObject_release(self.ipanel);self.ipanel=nil;
_UIObject_release(self.liconItem);self.liconItem=nil;
_UIObject_release(self.monsterLvBg);self.monsterLvBg=nil;
_UIObject_release(self.monsterLvTx);self.monsterLvTx=nil;
_UIObject_release(self.moqi);self.moqi=nil;
_UIObject_release(self.riconItem);self.riconItem=nil;
_UIObject_release(self.skilDesc);self.skilDesc=nil;
_UIObject_release(self.strengthenCreator);self.strengthenCreator=nil;
_UIObject_release(self.topicon);self.topicon=nil;
_UIObject_release(self.xianqi);self.xianqi=nil;
_UIObject_release(self.zdbtn);self.zdbtn=nil;
_UIObject_release(self.zdjbImg);self.zdjbImg=nil;
_UIObject_release(self.zdjbtxt);self.zdjbtxt=nil;
end
















local _this
local abname="ui/windows/xianjie/chongjianxianyu_atlas_pak.ab"
local headidx=
{
headicon=0,
headkuang=1,
headclick=2,
zmname=3,
name=4,
zbimg=5,
zb=6,
monfight=7,
monfighttxt=8,

monsterkaung=9,
monstericon=10,

xumodel=11,
xutype=12,
zjtype=13,
}
local allitemidx=
{
allitem=0,
addbtn=1,
lefttxtx=2,
zjtxt=3,
rightxt=4,
zjbtn=5,
descitem=6,
}
local xstype=
{
[1]="筑基",
[2]="结丹",
[3]="元婴",
[4]="化神",
[5]="炼虚",
[6]="合体",
[7]="大乘",
[8]="渡劫",
[9]="天仙",
}
local xsState=
{
jiankang=2,
qingshang=3,
zhongshang=4,
siwang=5
}
local descitemidx={0,1,2,3,4,5,6,7,8}
local singlepidx=
{
selfitem=0,
txt=1,
progress=2,
progressimg=3,
ltxt=4,
rtxt=5,
linr=6,
arrow=7,
}

local _colorKuang={
[xjServerEnityType.eMonster]={
[0]="image_gwtouxiangpjk_2",
[1]="image_gwtouxiangpjk_3",
},
[xjServerEnityType.eBossMonster]={
[0]="image_gwtouxiangpjk_4",
[1]="image_gwtouxiangpjk_3",
},
[xjServerEnityType.eMoJieMoZong_Small]={
[0]="image_gwtouxiangpjk_4",
[1]="image_gwtouxiangpjk_3",
},
[xjServerEnityType.eMoJieMoJunFenShen]={
[0]="image_gwtouxiangpjk_5",
[1]="image_gwtouxiangpjk_5",
},
}

local _showModel={
[xjServerEnityType.eMonster]=false,
[xjServerEnityType.eBossMonster]=false,
[xjServerEnityType.eMonsterHouse]=true,
[xjServerEnityType.eMoJieMoZong_Small]=false,
[xjServerEnityType.eMoJieMoZong_Big]=true,
}
local _showType={
[xjServerEnityType.eBossMonster]={"ui/windows/xianjie/xianjiemain_atlas_pak.ab","image_hujianguiwu_03"},
[xjServerEnityType.eMonsterHouse]={"ui/windows/xianjie/xianjiemain_atlas_pak.ab","image_hujianguiwu_04"},
[xjServerEnityType.eMoJieMoZong_Small]={"ui/windows/xianjie/xianjiemain_atlas_pak.ab","image_hujianguiwu_03"},
[xjServerEnityType.eMoJieMoZong_Big]={"ui/windows/xianjie/xianjiemain_atlas_pak.ab","image_hujianguiwu_04"},
}
local _showXJType={
[4]=true,
[5]=true,
[6]=true,
[7]=true,
}
local XSLvl={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,[9]=true,}




function UIXianJie_notejianbao:onLoaded(...)
self:bindComponents()
_this=self
self.onekey={false,false,false,false,false}
end


function UIXianJie_notejianbao:__delete()
self:unbindComponents()
_this=nil
end




function UIXianJie_notejianbao:onShow(argtable,afterOnloaded)
self.skilDesc:setChildCanvasGroupAlpha(0)
self.skilDesc:setChildCanvasGroupDOFade(1,0.6,nil)

self.win=argtable.win
self.yunjun=argtable.yunjun
self.cfgid=argtable.cfgid
self.jgxjyz=argtable.jgxjyz
if self.jgxjyz then
self.rzcfg={
fightLogType=1,
}
self.zdjbImg:setActive(false)
else
self.rzcfg=cfgHelper.get1(cfg_fairylandlogconfig_get,self.cfgid)
end

self.jgxx=self.rzcfg.jgxx
self.jingong=self.rzcfg.jgorfs
self.fightInfo=argtable.fightInfo

self.timetxt=argtable.timetxt
self.fightarry=argtable.fightarry
self.rijbdata=argtable.rijbdata
self.datatb_guid=argtable.datatb_guid
self.rewlist=argtable.rewlist
self.isyuanjun=argtable.isyuanjun
if self.yunjun then
local result=fightModel:getBattleResult(self.fightInfo)
self.win=result==1 and 1 or 0

self.apanel:setActive(false)
self.aapanel:setActive(true)
end

self:freshinfo()
end


function UIXianJie_notejianbao:onHide()

end
function UIXianJie_notejianbao:onFrame()
self:closeSelf()
end
function UIXianJie_notejianbao:onRuleBtn(item,idx)
local ruleLangIdList=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'RTruleLangIdList')
local langId=ruleLangIdList[idx]


local screenPos=item:GetChildUIScreenPos(allitemidx.zjbtn,false)
screenPos.x=screenPos.x-35
screenPos.y=screenPos.y-5
local winParams={
parentWin=self,
lang=langId,
num=nil,
screenPos=screenPos,
}
self:showWindow("UIXianJie_XJRZRuleWin",winParams)
end

function UIXianJie_notejianbao:onZdbtn()
local temp=
{
win=_this.win,
yunjun=_this.yunjun,
cfgid=_this.cfgid,
fightInfo=_this.fightInfo,
timetxt=_this.timetxt,
fightarry=_this.fightarry,
rijbdata=_this.rijbdata,
datatb_guid=_this.datatb_guid,
rewlist=_this.rewlist,
isyuanjun=_this.isyuanjun,
jgxjyz=_this.jgxjyz,
}
xianjieController:setjbTozb(temp)

local fightLogType=self.rzcfg.fightLogType
local args=self.fightarry[2]
if args and args[5]then
args[5]=_this.win
end
if fightLogType==1 then
fightController:send_log_list({self.fightarry[1]},args)
elseif fightLogType==2 then
fightController:send_log_list({self.fightarry[1]},args,true)
elseif fightLogType==3 then
fightController:send_log_list({self.fightarry[1]},args,nil,true)
end
end

function UIXianJie_notejianbao:onSkillClickItem(xswidget,index,_xstype)
_this.onekey[index]=not _this.onekey[index]
if _this.onekey[index]then
xswidget:SetChildActive(allitemidx.descitem,true)
else
xswidget:SetChildActive(allitemidx.descitem,false)
end
end


function UIXianJie_notejianbao:freshinfo()


self.bticonbg:setActive(false)
if self.win==1 then
self.winlua:SetChildCSImageSprite(self.topicon:getID(),abname,"image_xji_sheng")
self.bticonbg:setActive(true)
self.winlua:SetChildCSImageSprite(self.bticonbg:getID(),abname,"image_xji_jindi")
if self.yunjun then
if self.jingong==1 then
self.winlua:SetChildCSImageSprite(self.bticon:getID(),abname,"image_xji_jgcg")
elseif self.jingong==2 then
self.winlua:SetChildCSImageSprite(self.bticon:getID(),abname,"image_xji_jgcg")
end
else
local jianbaotxt=self.rzcfg.jianbaotxt
if jianbaotxt then
self.winlua:SetChildCSImageSprite(self.bticon:getID(),abname,jianbaotxt)
else
self.winlua:SetChildCSImageSprite(self.bticon:getID(),abname,"image_xji_ztcg")
end
end
elseif self.win==0 then
self.winlua:SetChildCSImageSprite(self.topicon:getID(),abname,"image_xji_bai")
self.bticonbg:setActive(true)
self.winlua:SetChildCSImageSprite(self.bticonbg:getID(),abname,"image_xji_huidi")
if self.yunjun then
if self.jingong==1 then
self.winlua:SetChildCSImageSprite(self.bticon:getID(),abname,"image_xji_jgsb")
elseif self.jingong==2 then
self.winlua:SetChildCSImageSprite(self.bticon:getID(),abname,"image_xji_jgsb")
end
else
local jianbaotxt=self.rzcfg.jianbaotxt
if jianbaotxt then
self.winlua:SetChildCSImageSprite(self.bticon:getID(),abname,jianbaotxt)
else
self.winlua:SetChildCSImageSprite(self.bticon:getID(),abname,"image_xji_ztsb")
end
end
end


self:refreshStrengthenGrids()

self.zdjbtxt:setText(self.timetxt)


self:showxmqiPanel()

local leftfight,rightfight=self:handleJunZhenFight()

self:lheaddata(leftfight)

self:rheaddata(rightfight)


local allarry=self:handleJunZhenData()
local allxswidget=self.allitem:getWidgetBase()
allxswidget:SetChildButtonClick(allitemidx.zjbtn,function(...)
if _this==nil then return end
self:onRuleBtn(allxswidget,1)
end)
self:inithandleitem(allxswidget,1,allarry,0)

local ylxswidget=self.allitem1:getWidgetBase()
ylxswidget:SetChildButtonClick(allitemidx.zjbtn,function(...)
if _this==nil then return end
self:onRuleBtn(ylxswidget,2)
end)
self:inithandleitem(ylxswidget,2,allarry,xsState.siwang)

local zsxswidget=self.allitem2:getWidgetBase()
zsxswidget:SetChildButtonClick(allitemidx.zjbtn,function(...)
if _this==nil then return end
self:onRuleBtn(zsxswidget,3)
end)
self:inithandleitem(zsxswidget,3,allarry,xsState.zhongshang)

local qsxswidget=self.allitem3:getWidgetBase()
qsxswidget:SetChildButtonClick(allitemidx.zjbtn,function(...)
if _this==nil then return end
self:onRuleBtn(qsxswidget,4)
end)
self:inithandleitem(qsxswidget,4,allarry,xsState.qingshang)

local shxswidget=self.allitem4:getWidgetBase()
shxswidget:SetChildButtonClick(allitemidx.zjbtn,function(...)
if _this==nil then return end
self:onRuleBtn(shxswidget,5)
end)
self:inithandleitem(shxswidget,5,allarry,xsState.jiankang)


local leftarry,rightarry=self:handleJunZhenShuXing()
local gjjzwidget=self.allitem5:getWidgetBase()
gjjzwidget:SetChildButtonClick(allitemidx.zjbtn,function(...)
if _this==nil then return end
self:onRuleBtn(gjjzwidget,6)
end)

local fyjzwidget=self.allitem6:getWidgetBase()
fyjzwidget:SetChildButtonClick(allitemidx.zjbtn,function(...)
if _this==nil then return end
self:onRuleBtn(fyjzwidget,7)
end)

local smjzwidget=self.allitem7:getWidgetBase()
smjzwidget:SetChildButtonClick(allitemidx.zjbtn,function(...)
if _this==nil then return end
self:onRuleBtn(smjzwidget,8)
end)


if leftarry then
if leftarry[351]then
gjjzwidget:SetChildText(allitemidx.lefttxtx,FMT.fmt("{0}%",leftarry[351]*100))
end
if leftarry[352]then
fyjzwidget:SetChildText(allitemidx.lefttxtx,FMT.fmt("{0}%",leftarry[352]*100))
end
if leftarry[353]then
smjzwidget:SetChildText(allitemidx.lefttxtx,FMT.fmt("{0}%",leftarry[353]*100))
end
end

if rightarry then
if rightarry[351]then
gjjzwidget:SetChildText(allitemidx.rightxt,FMT.fmt("{0}%",rightarry[351]*100))
end
if rightarry[352]then
fyjzwidget:SetChildText(allitemidx.rightxt,FMT.fmt("{0}%",rightarry[352]*100))
end
if rightarry[353]then
smjzwidget:SetChildText(allitemidx.rightxt,FMT.fmt("{0}%",rightarry[353]*100))
end
end
end

function UIXianJie_notejianbao:refreshStrengthenGrids()
self.jumpData=strengthenController:getStrengthenJumpList(strengthenFunctionType.eFightLose,true)
local jumpCnt=#self.jumpData
self.strengthenCreator:setChildLayoutGroupCreateItems(jumpCnt)
local strengthenGrid=self.strengthenCreator:getChildLayoutGroupGridList()
for i=1,jumpCnt do
local item=strengthenGrid[i-1]
local cfg=self.jumpData[i]
item:SetChildIcon(0,FMT.fmt('icon_sjtp_{0}',cfg.icon),true)
item:SetChildText(1,cfg.name)
item:SetChildButtonClickWithID(2,self.onClickStrengthenItem,i,true)

end
end
function UIXianJie_notejianbao.onClickStrengthenItem(index)
local cfg=_this.jumpData[index]
local jumpParams={}
local jumpType=cfg.jumpType
local params={disciples=jumpParams.disciples}
local temp=
{
win=_this.win,
yunjun=_this.yunjun,
cfgid=_this.cfgid,
fightInfo=_this.fightInfo,
timetxt=_this.timetxt,
fightarry=_this.fightarry,
rijbdata=_this.rijbdata,
datatb_guid=_this.datatb_guid,
rewlist=_this.rewlist,
isyuanjun=_this.isyuanjun,
jgxjyz=_this.jgxjyz,
}
strengthenController:doJump(jumpType,params)


local closeCallback=function()
xianjieController:OpenZhengZhanShanHaiMonsterLog()
if temp then
UIManager:showWindow('UIXianJie_notejianbao',temp)
end
return false
end
if closeCallback then
fullScreenUI.setNextActiveUICallback(closeCallback)
end
end


function UIXianJie_notejianbao:getXJZmData(actorId)
local zmData
local isSelf=playerModel:checkActorId(actorId)
if isSelf then
zmData=xianjieModel:getMyZongMenData()
else
zmData=xianjieModel:getZongMenData(actorId)
end
return zmData
end

function UIXianJie_notejianbao:lheaddata(leftfight)
local widget=self.liconItem:getWidgetBase()

if self.jgxjyz then
local zmName=UISettingModel:getZMName()
local nameStr=playerModel:getActorName()
widget:SetChildActive(headidx.headicon,true)
widget:SetChildActive(headidx.monsterkaung,false)
playerController:setHeadIcon(widget,headidx.headicon,{})
widget:SetChildText(headidx.zmname,FMT.fmt("[{0}]",zmName))
widget:SetChildText(headidx.name,nameStr)
widget:SetChildActive(headidx.zbimg,false)
else
local actorId=fightModel:getLeftActorId(self.fightInfo)
local actoridstr=actorId
if type(actorId)=="string"then
actorId=tonumber(actorId)
end

if actorId>0 then
actorId=actoridstr
local zmdata=self:getXJZmData(actorId)
if zmdata then
widget:SetChildActive(headidx.headicon,true)
widget:SetChildActive(headidx.monsterkaung,false)

local headParams={iconInfo=zmdata.iconInfo,scale=0.8}
playerController:setHeadIcon(widget,headidx.headicon,headParams)

local zmName=zmdata.sectname
widget:SetChildText(headidx.zmname,FMT.fmt("[{0}]",zmName))
widget:SetChildActive(headidx.zmname,true)

local nameStr=zmdata.actorname
widget:SetChildText(headidx.name,nameStr)

local _sceneIndex=zmdata.sceneidx
local sceneType=xianjieModel:sceneIndex2SceneType(_sceneIndex)
local xjname=sceneType and cfgHelper.get2(cfg_xianjiesceneconfig_get,sceneType,'name')or""
local gridX=zmdata.gridX or 1
local gridZ=zmdata.gridZ or 1
local _txt=FMT.fmt("{0}({1}，{2})",xjname,gridX,gridZ)
local link=FMT.fmt("<a;{0};4;1;21,{1},{2},{3};/>",_txt,gridX,gridZ,zmdata.sceneidx or 0)
widget:SetChildText(headidx.zb,link)
local fightvalue=fightModel:getZhanLiInfo(self.fightInfo)
if fightvalue[1]then
widget:SetChildActive(headidx.monfight,true)
widget:SetChildText(headidx.monfighttxt,mathHelper.formatNumber5(fightvalue[1]+leftfight,2))
else
widget:SetChildActive(headidx.monfight,false)
end
end
else
actorId=math.abs(actorId)
local rzdata=self.rijbdata

if rzdata then
local xj_entitytype=rzdata[2]
local isMZ=xj_entitytype==xjServerEnityType.eMoJieMoZong_Small or xj_entitytype==xjServerEnityType.eMoJieMoZong_Big

if rzdata[1]==1 or rzdata[1]==18 then
local xj_cfg=xianjieController:xjrzgetCfg_hj(rzdata[2],rzdata[3])
local groupid=isMZ and xj_cfg.monster[2]or xj_cfg.monster[1]
widget:SetChildActive(headidx.headicon,false)
widget:SetChildActive(headidx.monsterkaung,true)
if isMZ then
widget:SetChildCSImageSprite(headidx.monsterkaung,globalABLookup.global,FMT.fmt("image_gwtouxiangpjk_{0}",xj_cfg.type))
else
widget:SetChildCSImageSprite(headidx.monsterkaung,globalABLookup.global,_colorKuang[xjServerEnityType.eMoJieMoJunFenShen][0])
end

comHelper.setChildModelRawImage_monsterGroup(widget,groupid,headidx.monstericon,0,eHeadCenterType.eHead)

local groupcfg=cfgHelper.get1(cfg_monstergroup_get,groupid)
local stage=xj_cfg.stage or 1
local nameStr=isMZ and groupcfg.name or FMT.fmt("{0}阶 {1}",stage,groupcfg.name)
widget:SetChildText(headidx.name,nameStr)
widget:SetChildText(headidx.zmname,"")
else
logErr("战斗简报 进攻为怪物 类型未处理")
end

local _sceneIndex=rzdata[4]
local sceneType=xianjieModel:sceneIndex2SceneType(_sceneIndex)
local xjname=sceneType and cfgHelper.get2(cfg_xianjiesceneconfig_get,sceneType,'name')or""
local gridX=rzdata[5]or 1
local gridZ=rzdata[6]or 1
local _txt=FMT.fmt("{0}({1}，{2})",xjname,gridX,gridZ)
local link=FMT.fmt("<a;{0};4;1;21,{1},{2},{3};/>",_txt,gridX,gridZ,rzdata[4]or 0)
widget:SetChildText(headidx.zb,link)
widget:SetChildActive(headidx.monfight,false)
end
end
end
end


function UIXianJie_notejianbao:rheaddata(rightfight)
local widget=self.riconItem:getWidgetBase()
if self.jgxjyz then
local rzdata=self.rijbdata
local mon_groub_list=cfgHelper.get2(cfg_xianjunyanzhengxconfig_get,rzdata[1],"mon_groub_list")
local monster=mon_groub_list[rzdata[2]]
local groupid=monster[1]
local groupcfg=cfgHelper.get1(cfg_monstergroup_get,groupid)
widget:SetChildActive(headidx.headicon,false)
widget:SetChildActive(headidx.monsterkaung,true)
widget:SetChildCSImageSprite(headidx.monsterkaung,globalABLookup.global,monTypeBg[groupcfg.monType])
comHelper.setChildModelRawImage_monsterGroup(widget,groupid,headidx.monstericon,0,eHeadCenterType.eHead)

widget:SetChildText(headidx.name,groupcfg.name)
widget:SetChildActive(headidx.monfight,false)
widget:SetChildActive(headidx.zbimg,false)
return
end
local actorId=fightModel:getRightActorId(self.fightInfo)
local actoridstr=actorId
if type(actorId)=="string"then
actorId=tonumber(actorId)
end
if actorId>0 then

self.xsSex=1
actorId=actoridstr
local zmdata=self:getXJZmData(actorId)
if zmdata then
widget:SetChildActive(headidx.headicon,true)
widget:SetChildActive(headidx.monsterkaung,false)
local headParams={iconInfo=zmdata.iconInfo,scale=0.8}
playerController:setHeadIcon(widget,headidx.headicon,headParams)

local zmName=zmdata.sectname
widget:SetChildText(headidx.zmname,FMT.fmt("[{0}]",zmName))

local nameStr=zmdata.actorname
widget:SetChildText(headidx.name,nameStr)

local _sceneIndex=zmdata.sceneidx
local sceneType=xianjieModel:sceneIndex2SceneType(_sceneIndex)
local xjname=sceneType and cfgHelper.get2(cfg_xianjiesceneconfig_get,sceneType,'name')or""
local gridX=zmdata.gridX or 1
local gridZ=zmdata.gridZ or 1
local _txt=FMT.fmt("{0}({1}，{2})",xjname,gridX,gridZ)
local link=FMT.fmt("<a;{0};4;1;21,{1},{2},{3};/>",_txt,gridX,gridZ,zmdata.sceneidx or 0)
widget:SetChildText(headidx.zb,link)


local fightvalue=fightModel:getZhanLiInfo(self.fightInfo)
if fightvalue[2]then
widget:SetChildActive(headidx.monfight,true)
widget:SetChildText(headidx.monfighttxt,mathHelper.formatNumber5(fightvalue[2]+rightfight,2))
else
widget:SetChildActive(headidx.monfight,false)
end
end
else
actorId=math.abs(actorId)
self.xsSex=2
if self.jgxx==1 then

local rzdata=self.rijbdata

if rzdata then
local cfg=xianjieController:xjrzgetCfg_hj(rzdata[2],rzdata[3])
local groupid=cfg.monster[1]
local groupcfg=cfgHelper.get1(cfg_monstergroup_get,groupid)
local stage=cfg.stage or 1
local nameStr=FMT.fmt("{0}阶 {1}",stage,groupcfg.name)
widget:SetChildText(headidx.name,nameStr)

if false then

widget:SetChildActive(6,true)
widget:SetChildUIModelRemoveTarget(0)
widget:SetChildCSImageSprite(6,globalABLookup.global,_colorKuang[7][cfg.flag or 0])
comHelper.setChildModelRawImage_monsterGroup(monsterInfoWidget,groupid,7,0,eHeadCenterType.eHead)
else
widget:SetChildActive(headidx.headicon,false)









widget:SetChildActive(headidx.headicon,false)
widget:SetChildActive(headidx.monsterkaung,true)
widget:SetChildCSImageSprite(headidx.monsterkaung,globalABLookup.global,FMT.fmt("image_gwtouxiangpjk_{0}",cfg.type))
comHelper.setChildModelRawImage_monsterGroup(widget,groupid,headidx.monstericon,0,eHeadCenterType.eHead)
end







local _sceneIndex=rzdata[4]
local sceneType=xianjieModel:sceneIndex2SceneType(_sceneIndex)
local xjname=sceneType and cfgHelper.get2(cfg_xianjiesceneconfig_get,sceneType,'name')or""
local gridX=rzdata[5]or 1
local gridZ=rzdata[6]or 1
local _txt=FMT.fmt("{0}({1}，{2})",xjname,gridX,gridZ)
local link=FMT.fmt("<a;{0};4;1;21,{1},{2},{3};/>",_txt,gridX,gridZ,rzdata[4]or 0)
widget:SetChildText(headidx.zb,link)







widget:SetChildActive(headidx.monfight,false)
end
else

local rzdata=self.rijbdata

if rzdata then
local xj_entitytype=rzdata[2]
local hideStage=xj_entitytype==xjServerEnityType.eMoJieMoZong_Small or xj_entitytype==xjServerEnityType.eMoJieMoZong_Big or xj_entitytype==xjServerEnityType.eMoJieMoJunYaoMo
or xj_entitytype==xjServerEnityType.eMoJieShangGuMoster
if rzdata[1]==1 or rzdata[1]==24 then
local xj_cfg=xianjieController:xjrzgetCfg_hj(rzdata[2],rzdata[3])
local groupid=xj_cfg.monster[1]
widget:SetChildActive(headidx.headicon,false)
widget:SetChildActive(headidx.monsterkaung,true)
if xj_entitytype==xjServerEnityType.eMoJingZhenJi_Normal then
widget:SetChildCSImageSprite(headidx.monsterkaung,"ui/windows/mojingzhenji/mojingzhenji_atlas_pak.ab","image_xjjianzhuui_7")
widget:SetChildCSImageSprite(headidx.zjtype,globalABLookup.global,FMT.fmt("icon_yuansu_{0}",xj_cfg.wxType or 1))

widget:SetChildText(headidx.name,xj_cfg.name)
else
local groupcfg=cfgHelper.get1(cfg_monstergroup_get,groupid)
if _showXJType[xj_cfg.type]then
widget:SetChildCSImageSprite(headidx.monsterkaung,globalABLookup.global,FMT.fmt("image_gwtouxiangpjk_{0}",xj_cfg.type))
else
widget:SetChildCSImageSprite(headidx.monsterkaung,globalABLookup.global,monTypeBg[groupcfg.monType])
end
comHelper.setChildModelRawImage_monsterGroup(widget,groupid,headidx.monstericon,0,eHeadCenterType.eHead)

local stage=xj_cfg.stage or 1
local nameStr=hideStage and groupcfg.name or FMT.fmt("{0}阶 {1}",stage,groupcfg.name)
widget:SetChildText(headidx.name,nameStr)
end
elseif rzdata[1]==3 then
local xj_cfg=xianjieController:xjrzgetCfg_zyd(rzdata[2],rzdata[3])
local groupid=xj_cfg.monster_id
widget:SetChildActive(headidx.headicon,false)
widget:SetChildActive(headidx.monsterkaung,true)
local groupcfg=cfgHelper.get1(cfg_monstergroup_get,groupid)
if _showXJType[xj_cfg.type]then
widget:SetChildCSImageSprite(headidx.monsterkaung,globalABLookup.global,FMT.fmt("image_gwtouxiangpjk_{0}",xj_cfg.type))
else
widget:SetChildCSImageSprite(headidx.monsterkaung,globalABLookup.global,monTypeBg[groupcfg.monType])
end
comHelper.setChildModelRawImage_monsterGroup(widget,groupid,headidx.monstericon,0,eHeadCenterType.eHead)

local stage=xj_cfg.stage or 1
local nameStr=hideStage and groupcfg.name or FMT.fmt("{0}阶 {1}",stage,groupcfg.name)
widget:SetChildText(headidx.name,nameStr)
elseif rzdata[1]==11 then
widget:SetChildActive(headidx.headicon,false)
widget:SetChildActive(headidx.monsterkaung,true)
if xj_entitytype and xj_entitytype==xjServerEnityType.eClientBuild then
local buildId=rzdata[3]
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,buildId)
local buildName=buildCfg.name

if buildCfg and buildCfg.clientParam then
local gateId=buildCfg.clientParam.gateId
if gateId then

local gateCfg=cfgHelper.get1(cfg_devildomscenegateconfig_get,gateId)
local gateName=gateCfg.name
local gateXYSceneIndex=gateCfg.area
local xyName=xianjieController:getCrossServerNamebySCidx(gateXYSceneIndex)
buildName=FMT.fmt("{0}-{1}",xyName,gateName)
widget:SetChildText(headidx.name,buildName)

local groupcfg=cfgHelper.get1(cfg_monstergroup_get,rzdata.monster)
widget:SetChildCSImageSprite(headidx.monsterkaung,globalABLookup.global,monTypeBg[groupcfg.monType])
comHelper.setChildModelRawImage_monsterGroup(widget,rzdata.monster,headidx.monstericon,0,eHeadCenterType.eHead)
end
end
end
elseif rzdata[1]==12 then
widget:SetChildActive(headidx.headicon,false)
widget:SetChildActive(headidx.monsterkaung,true)
if xj_entitytype and xj_entitytype==xjServerEnityType.eClientBuild then
local buildId=rzdata[3]
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,buildId)
local buildName=buildCfg.name
if xianjieModel:checkClientBdIsBenYuanZhenJiByBuildId(buildId)then
widget:SetChildText(headidx.name,buildName)

widget:SetChildCSImageSprite(headidx.monsterkaung,"ui/windows/mojingzhenji/mojingzhenji_atlas_pak.ab","image_mojingzhenji_10")
end
end
elseif rzdata[1]==13 then
local xj_cfg=xianjieController:xjrzgetCfg_hj(rzdata[2],rzdata[3])
widget:SetChildActive(headidx.headicon,false)
widget:SetChildActive(headidx.monsterkaung,true)

widget:SetChildCSImageSprite(headidx.monsterkaung,"ui/windows/mojingzhenji/mojingzhenji_atlas_pak.ab","image_xjjianzhuui_7")
widget:SetChildCSImageSprite(headidx.zjtype,globalABLookup.global,FMT.fmt("icon_yuansu_{0}",xj_cfg.wxType or 1))

widget:SetChildText(headidx.name,xj_cfg.name)
elseif rzdata[1]==14 then
widget:SetChildActive(headidx.headicon,false)
widget:SetChildActive(headidx.monsterkaung,true)
local groupcfg=cfgHelper.get1(cfg_monstergroup_get,rzdata.monster)
widget:SetChildCSImageSprite(headidx.monsterkaung,globalABLookup.global,monTypeBg[groupcfg.monType])
comHelper.setChildModelRawImage_monsterGroup(widget,rzdata.monster,headidx.monstericon,0,eHeadCenterType.eHead)

local nameStr=cfgHelper.get2(cfg_fairylandclientbuildconfig_get,rzdata[3],"name")
widget:SetChildText(headidx.name,nameStr)

elseif rzdata[1]==16 or rzdata[1]==10 and rzdata.monster then
widget:SetChildActive(headidx.headicon,false)
widget:SetChildActive(headidx.monsterkaung,true)
local groupcfg=cfgHelper.get1(cfg_monstergroup_get,rzdata.monster)
widget:SetChildCSImageSprite(headidx.monsterkaung,globalABLookup.global,monTypeBg[groupcfg.monType])
comHelper.setChildModelRawImage_monsterGroup(widget,rzdata.monster,headidx.monstericon,0,eHeadCenterType.eHead)

local nameStr=cfgHelper.get2(cfg_fairylandclientbuildconfig_get,rzdata[3],"name")
widget:SetChildText(headidx.name,nameStr)
elseif rzdata[1]==19 then
local xj_cfg=xianjieController:xjrzgetCfg_hj(rzdata[2],rzdata[3])
local groupid=xj_cfg.monster[1]
widget:SetChildActive(headidx.headicon,false)
widget:SetChildActive(headidx.monsterkaung,true)
local groupcfg=cfgHelper.get1(cfg_monstergroup_get,groupid)
if _showXJType[xj_cfg.type]then
widget:SetChildCSImageSprite(headidx.monsterkaung,globalABLookup.global,FMT.fmt("image_gwtouxiangpjk_{0}",xj_cfg.type))
else
widget:SetChildCSImageSprite(headidx.monsterkaung,globalABLookup.global,monTypeBg[groupcfg.monType])
end
comHelper.setChildModelRawImage_monsterGroup(widget,groupid,headidx.monstericon,0,eHeadCenterType.eHead)

local stage=xj_cfg.stage or 1
local nameStr=hideStage and groupcfg.name or FMT.fmt("{0}阶 {1}",stage,groupcfg.name)
widget:SetChildText(headidx.name,nameStr)
end

local _sceneIndex=rzdata[4]
local sceneType=xianjieModel:sceneIndex2SceneType(_sceneIndex)
local xjname=sceneType and cfgHelper.get2(cfg_xianjiesceneconfig_get,sceneType,'name')or""
local gridX=rzdata[5]or 1
local gridZ=rzdata[6]or 1
local _txt=FMT.fmt("{0}({1}，{2})",xjname,gridX,gridZ)
local link=FMT.fmt("<a;{0};4;1;21,{1},{2},{3};/>",_txt,gridX,gridZ,rzdata[4]or 0)
widget:SetChildText(headidx.zb,link)







widget:SetChildActive(headidx.monfight,false)
end
end
end
end


function UIXianJie_notejianbao:handleJunZhenData()
local allcenter={}
local junzhendata=fightModel:getJunZhenInfo(self.fightInfo)

if junzhendata then

local jzdata=junzhendata[#junzhendata-2]or{}
local left=jzdata[1]or{}
local right=jzdata[2]or{}


local allleft={}
for k,v in ipairs(left)do
allleft[v[1]]=v
end

local allright={}
for k,v in ipairs(right)do
allright[v[1]]=v
end

for k=1,#xstype do
allcenter[k]={}
if allleft[k]then
allcenter[k][1]=allleft[k]
else
allcenter[k][1]={}
end
if allright[k]then
allcenter[k][2]=allright[k]
else
allcenter[k][2]={}
end
end
end

return allcenter
end

function UIXianJie_notejianbao:handleJunZhenFight()
local leftfight=0
local rightfight=0
local junzhendata=fightModel:getJunZhenInfo(self.fightInfo)
if junzhendata then
local jzdata=junzhendata[2]or{}

local jzsxarry=junzhendata[1]or{}

local leftarry=jzdata[1]
if leftarry then
local soldierList={}
for k,v in pairs(leftarry)do
if v then
soldierList[v[1]]=v[2]
end
end
local ljzAttrList=jzsxarry[3]or{}
local jzAttrList={}
for k,v in pairs(ljzAttrList)do
if v then
jzAttrList[v[1]]=v[2]
end
end

leftfight=xianjieModel:getXJYZTeamFightValue({},soldierList,jzAttrList)
end

local rightarry=jzdata[2]
if rightarry then
local soldierList={}
for k,v in pairs(rightarry)do
if v then
soldierList[v[1]]=v[2]
end
end
local rjzAttrList=jzsxarry[4]or{}
local jzAttrList={}
for k,v in pairs(rjzAttrList)do
if v then
jzAttrList[v[1]]=v[2]
end
end

local ismonster=false
local actorId=fightModel:getRightActorId(self.fightInfo)
if type(actorId)=="string"then
actorId=tonumber(actorId)
end
if actorId>0 then
ismonster=false
else
ismonster=true
end
rightfight=xianjieModel:getXJYZTeamFightValue({},soldierList,jzAttrList,ismonster)
end
end


return leftfight,rightfight
end


function UIXianJie_notejianbao:handleJunZhenShuXing()
local leftAttr={}
local rightAttr={}
local junzhendata=fightModel:getJunZhenInfo(self.fightInfo)

if junzhendata then
local jzdata=junzhendata[1]or{}
if jzdata[3]and#jzdata[3]>0 then
for k,v in ipairs(jzdata[3])do
local arrid=v[1]
local value=v[2]
leftAttr[arrid]=value
end
end
if jzdata[4]and#jzdata[4]>0 then
for k,v in ipairs(jzdata[4])do
local arrid=v[1]
local value=v[2]
rightAttr[arrid]=value
end
end
end
return leftAttr,rightAttr
end


function UIXianJie_notejianbao:inithandleitem(xswidget,index,allarry,_xstype)
if index==1 then
self.onekey[index]=false
xswidget:SetChildActive(allitemidx.addbtn,false)
xswidget:SetChildActive(allitemidx.descitem,false)

local allnumleft=0
local allnumright=0
for k,v in ipairs(allarry)do
local havelvl=false
local sinumleft=0
local sinumright=0
local left=v[1]
if left and#left>0 then
havelvl=true
sinumleft=(left[2]or 0)+(left[3]or 0)+(left[4]or 0)+(left[5]or 0)
allnumleft=allnumleft+sinumleft
end
local right=v[2]
if right and#right>0 then
havelvl=true
sinumright=(right[2]or 0)+(right[3]or 0)+(right[4]or 0)+(right[5]or 0)
allnumright=allnumright+sinumright
end


if havelvl then
if descitemidx[k]then
local descwidget=xswidget:GetChildWidgetBase(allitemidx.descitem)
descwidget:SetChildActive(descitemidx[k],true)
local singlewidget=descwidget:GetChildWidgetBase(descitemidx[k])
singlewidget:SetChildActive(singlepidx.arrow,false)
singlewidget:SetChildText(singlepidx.txt,xstype[k])
singlewidget:SetChildText(singlepidx.ltxt,sinumleft)
singlewidget:SetChildText(singlepidx.rtxt,sinumright)


local max=sinumleft+sinumright
local dtime=sinumleft
if dtime>0 and dtime/max<0.01 then
dtime=max*0.01
end

if dtime==0 and max==0 then
singlewidget:SetChildUIProgressbar(singlepidx.progress,50,100,false)
else
singlewidget:SetChildUIProgressbar(singlepidx.progress,dtime,max,false)
end
end
end
end
if allnumleft>0 or allnumright>0 then
xswidget:SetChildActive(allitemidx.addbtn,true)
xswidget:SetChildButtonClick(allitemidx.addbtn,function(...)
if _this==nil then return end
self:onSkillClickItem(xswidget,index,_xstype)
end)
end
xswidget:SetChildText(allitemidx.lefttxtx,allnumleft)
xswidget:SetChildText(allitemidx.rightxt,allnumright)
else
self.onekey[index]=false
xswidget:SetChildActive(allitemidx.addbtn,false)
xswidget:SetChildActive(allitemidx.descitem,false)
local allnumleft=0
local allnumright=0
for k,v in ipairs(allarry)do
local havelvl=false
local sinumleft=0
local sinumright=0
local left=v[1]

if left and#left>0 then
havelvl=true
sinumleft=left[_xstype]or 0
allnumleft=allnumleft+sinumleft
end
local right=v[2]
if right and#right>0 then
havelvl=true
sinumright=right[_xstype]or 0
allnumright=allnumright+sinumright
end
if havelvl then
if descitemidx[k]then
local descwidget=xswidget:GetChildWidgetBase(allitemidx.descitem)
descwidget:SetChildActive(descitemidx[k],true)
local singlewidget=descwidget:GetChildWidgetBase(descitemidx[k])
singlewidget:SetChildActive(singlepidx.arrow,false)
singlewidget:SetChildText(singlepidx.txt,xstype[k])
singlewidget:SetChildText(singlepidx.ltxt,sinumleft)
singlewidget:SetChildText(singlepidx.rtxt,sinumright)

local max=sinumleft+sinumright
local dtime=sinumleft
if dtime>0 and dtime/max<0.01 then
dtime=max*0.01
end
if dtime==0 and max==0 then
singlewidget:SetChildUIProgressbar(singlepidx.progress,50,100,false)
else
singlewidget:SetChildUIProgressbar(singlepidx.progress,dtime,max,false)
end
end
end
end
if allnumleft>0 or allnumright>0 then
xswidget:SetChildActive(allitemidx.addbtn,true)
xswidget:SetChildButtonClick(allitemidx.addbtn,function(...)
if _this==nil then return end
self:onSkillClickItem(xswidget,index,_xstype)
end)
end
xswidget:SetChildText(allitemidx.lefttxtx,allnumleft)
xswidget:SetChildText(allitemidx.rightxt,allnumright)
end
end


function UIXianJie_notejianbao:showxmqiPanel()
self.hpanel:setActive(false)
self.ipanel:setActive(false)

if not self.jgxjyz and self.rzcfg and self.rzcfg.gethb then
if self.rewlist then
local havexq=0
local havemq=0
for k,v in ipairs(self.rewlist)do
local itemid=v.param_1
local itemnum=v.param_2
if itemid==eMoneyType.mtXianQi then
havexq=itemnum
elseif itemid==eMoneyType.mtMoQi then
havemq=itemnum
end
end

if havexq>0 or havemq>0 then
self.hpanel:setActive(true)
self.ipanel:setActive(true)
local widget1=self.xianqi:getChildWidgetBase()
local widget2=self.moqi:getChildWidgetBase()
if havexq==0 then
widget1:SetChildActive(2,false)
widget2:SetChildLocalPosX(2,-75)
end
if havemq==0 then
widget2:SetChildActive(2,false)
widget1:SetChildLocalPosX(2,-75)
end
if self.rzcfg.gethb==1 then
self.htxt:setText("战斗获得")
self.winlua:SetChildCSImageSprite(self.ipanel:getID(),abname,"image_zhandoujianbaoui_1")
widget1:SetChildText(1,FMT.fmt("<color=#549327>仙气+{0}</color>",havexq))
widget1:SetChildButtonClick(0,function()
self:onClickItem(eMoneyType.mtXianQi)
end)
widget2:SetChildText(1,FMT.fmt("<color=#549327>魔气+{0}</color>",havemq))
widget2:SetChildButtonClick(0,function()
self:onClickItem(eMoneyType.mtMoQi)
end)

elseif self.rzcfg.gethb==2 then
self.htxt:setText("战斗损失")
self.winlua:SetChildCSImageSprite(self.ipanel:getID(),abname,"image_zhandoujianbaoui_2")
widget1:SetChildText(1,FMT.fmt("<color=#c82c2c>仙气-{0}</color>",havexq))
widget1:SetChildButtonClick(0,function()
self:onClickItem(eMoneyType.mtXianQi)
end)
widget2:SetChildText(1,FMT.fmt("<color=#c82c2c>魔气-{0}</color>",havemq))
widget2:SetChildButtonClick(0,function()
self:onClickItem(eMoneyType.mtMoQi)
end)
end
end
end
end
end

function UIXianJie_notejianbao:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil})
end