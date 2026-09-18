







def_class("UISubAct_yunchengtanbaoWin",UIWindowBase)









function UISubAct_yunchengtanbaoWin:bindComponents()

self.root=UIObject.get(self,0)
self.bgModel=UIObject.get(self,1)
self.teamTwoGrid=UIObject.get(self,2)
self.teamOneGrid=UIObject.get(self,3)
self.desc2Txt=UIText.get(self,4)
self.changeDefBtn=UIButton.get(self,5)
self.chekBtn=UIButton.get(self,6)
self.rightModel=UIObject.get(self,7)
self.headRewardGrid=UIObject.get(self,8)
self.joinTimeTxt=UIText.get(self,9)
self.raceTimeTxt=UIText.get(self,10)
self.descTxt=UIText.get(self,11)
self.joinRewardtBtn=UIButton.get(self,13)
self.joinSign=UIObject.get(self,14)
self.ruleBtn=UIButton.get(self,15)
self.joinBtnTxt=UIText.get(self,16)
self.jiachebtn=UIButton.get(self,17)
self.jianlibtn=UIButton.get(self,18)
self.paihanbtn=UIButton.get(self,19)
self.grid1=UIObject.get(self,21)
self.grid2=UIObject.get(self,22)
self.grid3=UIObject.get(self,23)
self.grid4=UIObject.get(self,24)
self.grid5=UIObject.get(self,25)
self.grid6=UIObject.get(self,26)
self.grid7=UIObject.get(self,27)
self.grid8=UIObject.get(self,28)
self.grid9=UIObject.get(self,29)
self.grid10=UIObject.get(self,30)
self.grid11=UIObject.get(self,31)
self.grid13=UIObject.get(self,32)
self.grid12=UIObject.get(self,33)
self.grid14=UIObject.get(self,34)
self.grid15=UIObject.get(self,35)
self.grid16=UIObject.get(self,36)
self.grid18=UIObject.get(self,37)
self.grid21=UIObject.get(self,38)
self.grid22=UIObject.get(self,39)
self.grid20=UIObject.get(self,40)
self.grid23=UIObject.get(self,41)
self.grid19=UIObject.get(self,42)
self.grid17=UIObject.get(self,43)
self.joinBtn=UIButton.get(self,44)
self.cishumun=UIText.get(self,45)
self.add=UIButton.get(self,46)
self.actytime=UIText.get(self,47)
self.quanshu=UIText.get(self,48)
self.spine_player=UIObject.get(self,49)
self.buildScrollview=UIObject.get(self,50)
self.startPoint=UIObject.get(self,51)
self.endPoint=UIObject.get(self,52)
self.clicktwo=UIButton.get(self,53)
self.jiachengpanel=UIObject.get(self,54)
self.roots=UIObject.get(self,55)
self.yuxianDesc=UIObject.get(self,56)
self.jiachenpanelbtn=UIButton.get(self,57)
self.clickpanel=UIButton.get(self,58)
self.WarringPanel=UIObject.get(self,59)
self.spine_join=UIObject.get(self,60)
self.daojuitems=UIObject.get(self,61)
self.shaizipanel=UIObject.get(self,62)
self.perfab_shaizi=UIObject.get(self,63)
self.djupanel=UIObject.get(self,64)
self.djuicon=UIImage.get(self,65)
self.djunum=UIText.get(self,66)
self.warringText=UIImage.get(self,67)
self.saiziEffect=UIObject.get(self,68)
self.saiziEffect2=UIObject.get(self,69)
self.btnroots=UIObject.get(self,70)
self.skipBtn=UIButton.get(self,71)
self.skipSelectImg=UIObject.get(self,72)
self.autoPanel=UIObject.get(self,73)
self.startAutoButton=UIButton.get(self,74)
self.cancelAutoButton=UIButton.get(self,75)
self.autoImg=UIObject.get(self,76)
self.preffect=UIObject.get(self,77)
self.isShowReddotBtn=UIButton.get(self,78)

self.changeDefBtn:setButtonClick(function()self:onChangeDefBtn()end)

self.chekBtn:setButtonClick(function()self:onChekBtn()end)

self.joinBtn:setButtonClick(function()self:onJoinBtn()end)

self.joinRewardtBtn:setButtonClick(function()self:onJoinRewardtBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.jiachebtn:setButtonClick(function()self:onJiachebtn()end)

self.jianlibtn:setButtonClick(function()self:onJianlibtn()end)

self.paihanbtn:setButtonClick(function()self:onPaihanbtn()end)

self.add:setButtonClick(function()self:onAdd()end)

self.clicktwo:setButtonClick(function()self:onClicktwo()end)

self.jiachenpanelbtn:setButtonClick(function()self:onJiachenpanelbtn()end)

self.clickpanel:setButtonClick(function()self:onClickpanel()end)

self.skipBtn:setButtonClick(function()self:onSkipBtn()end)

self.startAutoButton:setButtonClick(function()self:onStartAutoButton()end)

self.cancelAutoButton:setButtonClick(function()self:onCancelAutoButton()end)

self.isShowReddotBtn:setButtonClick(function()self:onIsShowReddotBtn()end)
self.spine={
["player"]=self.spine_player,
["join"]=self.spine_join,
}
self.perfab={
["shaizi"]=self.perfab_shaizi,
}



end


function UISubAct_yunchengtanbaoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.teamTwoGrid);self.teamTwoGrid=nil;
_UIObject_release(self.teamOneGrid);self.teamOneGrid=nil;
_UIObject_release(self.desc2Txt);self.desc2Txt=nil;
_UIObject_release(self.changeDefBtn);self.changeDefBtn=nil;
_UIObject_release(self.chekBtn);self.chekBtn=nil;
_UIObject_release(self.rightModel);self.rightModel=nil;
_UIObject_release(self.headRewardGrid);self.headRewardGrid=nil;
_UIObject_release(self.joinTimeTxt);self.joinTimeTxt=nil;
_UIObject_release(self.raceTimeTxt);self.raceTimeTxt=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.joinRewardtBtn);self.joinRewardtBtn=nil;
_UIObject_release(self.joinSign);self.joinSign=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.joinBtnTxt);self.joinBtnTxt=nil;
_UIObject_release(self.jiachebtn);self.jiachebtn=nil;
_UIObject_release(self.jianlibtn);self.jianlibtn=nil;
_UIObject_release(self.paihanbtn);self.paihanbtn=nil;
_UIObject_release(self.grid1);self.grid1=nil;
_UIObject_release(self.grid2);self.grid2=nil;
_UIObject_release(self.grid3);self.grid3=nil;
_UIObject_release(self.grid4);self.grid4=nil;
_UIObject_release(self.grid5);self.grid5=nil;
_UIObject_release(self.grid6);self.grid6=nil;
_UIObject_release(self.grid7);self.grid7=nil;
_UIObject_release(self.grid8);self.grid8=nil;
_UIObject_release(self.grid9);self.grid9=nil;
_UIObject_release(self.grid10);self.grid10=nil;
_UIObject_release(self.grid11);self.grid11=nil;
_UIObject_release(self.grid13);self.grid13=nil;
_UIObject_release(self.grid12);self.grid12=nil;
_UIObject_release(self.grid14);self.grid14=nil;
_UIObject_release(self.grid15);self.grid15=nil;
_UIObject_release(self.grid16);self.grid16=nil;
_UIObject_release(self.grid18);self.grid18=nil;
_UIObject_release(self.grid21);self.grid21=nil;
_UIObject_release(self.grid22);self.grid22=nil;
_UIObject_release(self.grid20);self.grid20=nil;
_UIObject_release(self.grid23);self.grid23=nil;
_UIObject_release(self.grid19);self.grid19=nil;
_UIObject_release(self.grid17);self.grid17=nil;
_UIObject_release(self.joinBtn);self.joinBtn=nil;
_UIObject_release(self.cishumun);self.cishumun=nil;
_UIObject_release(self.add);self.add=nil;
_UIObject_release(self.actytime);self.actytime=nil;
_UIObject_release(self.quanshu);self.quanshu=nil;
_UIObject_release(self.spine_player);self.spine_player=nil;
_UIObject_release(self.buildScrollview);self.buildScrollview=nil;
_UIObject_release(self.startPoint);self.startPoint=nil;
_UIObject_release(self.endPoint);self.endPoint=nil;
_UIObject_release(self.clicktwo);self.clicktwo=nil;
_UIObject_release(self.jiachengpanel);self.jiachengpanel=nil;
_UIObject_release(self.roots);self.roots=nil;
_UIObject_release(self.yuxianDesc);self.yuxianDesc=nil;
_UIObject_release(self.jiachenpanelbtn);self.jiachenpanelbtn=nil;
_UIObject_release(self.clickpanel);self.clickpanel=nil;
_UIObject_release(self.WarringPanel);self.WarringPanel=nil;
_UIObject_release(self.spine_join);self.spine_join=nil;
_UIObject_release(self.daojuitems);self.daojuitems=nil;
_UIObject_release(self.shaizipanel);self.shaizipanel=nil;
_UIObject_release(self.perfab_shaizi);self.perfab_shaizi=nil;
_UIObject_release(self.djupanel);self.djupanel=nil;
_UIObject_release(self.djuicon);self.djuicon=nil;
_UIObject_release(self.djunum);self.djunum=nil;
_UIObject_release(self.warringText);self.warringText=nil;
_UIObject_release(self.saiziEffect);self.saiziEffect=nil;
_UIObject_release(self.saiziEffect2);self.saiziEffect2=nil;
_UIObject_release(self.btnroots);self.btnroots=nil;
_UIObject_release(self.skipBtn);self.skipBtn=nil;
_UIObject_release(self.skipSelectImg);self.skipSelectImg=nil;
_UIObject_release(self.autoPanel);self.autoPanel=nil;
_UIObject_release(self.startAutoButton);self.startAutoButton=nil;
_UIObject_release(self.cancelAutoButton);self.cancelAutoButton=nil;
_UIObject_release(self.autoImg);self.autoImg=nil;
_UIObject_release(self.preffect);self.preffect=nil;
_UIObject_release(self.isShowReddotBtn);self.isShowReddotBtn=nil;
self.spine=nil;
self.perfab=nil;
end

















local _this
local gridinex=
{
grid=0,
big=1,
first=2,
reward=3,
namal=4,
big_plypos=5,
spinebg=6,
bigimg=7,
donetag=8,

fir_plypos=9,
firstimg=10,
firsttag=11,

rew_plypos=12,
rewadimg=13,
imgreward=14,

nal_plypos=15,
nal_effect=16,
nalimg=17,
nal_done=18,

daojuicon=19,
daojunump=20,
daojunum=21,

daojubtn=22,
reward_effect=23,

reward_tag=24,
}


local gridinex_pos=
{
[2]=5,
[4]=5,
[5]=5,
[6]=5,
[1]=9,
[3]=12,
[0]=15,
}

local specialgriseum=
{
normal=0,
start=1,
daoju=2,
baoxiang=3,
cat=4,
shijian=5,
game=6,
}

local gameid=
{
[1]=1,
[2]=2,
[3]=3,
[4]=4,
}
local abnameyc='ui/windows/activities/sub_yunchengtanbao/yunchengtanbao_atlas_pak.ab'
local abnamegame='ui/sharedtextures/uiglobalspriteatlas_1.ab'
local abnamesj='ui/windows/main/main_sprite_atlas_pak.ab'

local jcitemidx={1,2,3,4,5}
local jctextidx={6,7,8,9,10}
local jciconidx={11,12,13,14,15}

local gamenametype=
{
[5]=1,
[1]=2,
[4]=3,
[2]=4,
}


local bx_images=
{
[1]="image_yunctb_08",
[2]="image_yunctb_09",
[3]="image_yunctb_10",
}

local abname_yctb='ui/windows/activities/sub_yunchengtanbao/yunchengtanbao_atlas_pak.ab'
local jump_speed=0.2



function UISubAct_yunchengtanbaoWin:onLoaded(...)
_this=self
self:bindComponents()

self.grids={self.grid1,self.grid2,self.grid3,self.grid4,self.grid5,self.grid6,self.grid7,self.grid8,self.grid9,self.grid10,
self.grid11,self.grid12,self.grid13,self.grid14,self.grid15,self.grid16,self.grid17,self.grid18,}
self.gridstate={}
self.buildScrollview:setChildScrollViewInit(1,true,nil,nil)
self.playrightindex={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[9]=1,[16]=1,[17]=1,}
self.startpos=self.startPoint:getChildPosition()
self.endpos=self.endPoint:getChildPosition()
self.specialitemid=10591
self.allneeditemdi=10594
self.doubleitemdi=10593
self.resetitemdi=10592
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
self:addNotify(notifyConfig.onSubActivityOverBeforeEndTime24Hour,self.onSubActivityOverBeforeEndTime24Hour)
self.isAnima=true
self.isgetbtn=false
self.iszidong=false
end


function UISubAct_yunchengtanbaoWin:__delete()
self:setAutoMode(false)
self:clearTimer()
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
self:unbindComponents()

end
function UISubAct_yunchengtanbaoWin:onChangeDefBtn()
end
function UISubAct_yunchengtanbaoWin:onChekBtn()
end
function UISubAct_yunchengtanbaoWin:onJoinRewardtBtn()
end
function UISubAct_yunchengtanbaoWin:onRuleBtn()
end

function UISubAct_yunchengtanbaoWin:onClickpanel()

end

function UISubAct_yunchengtanbaoWin:onAdd()
self:showWindow('UIDialougeYCTBbuy',{actID=_this.actID,subType=_this.subType,subid=_this.subid,parentwin=_this})
end

function UISubAct_yunchengtanbaoWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil})
end




function UISubAct_yunchengtanbaoWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)

self.startday=self.sub_actInfo.start_day_idx
self.start_time=self.sub_actInfo.start_time
self.end_time=self.sub_actInfo.end_time


local now_dizi_guid=nil
local disciplesList=discipleLookup:getSortDiscipleList()
for k,v in ipairs(disciplesList)do
local netdata=v.netData
local guid=netdata.net.discipleguid
local dizinam=UIDiscipleModel:getDiscipleName(guid)
if dizinam then
now_dizi_guid=guid
break
end
end
local info=UIDiscipleModel:getDiscipleImageInfo(now_dizi_guid)
self.modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info)

self.select_index=-1
self.select_itemid=-1

self.now_grid_index=1
self.move_num=0
self.now_grid=1
self.isgetbtn=false
self.iszidong=false
self.gameisjump=false
self.isjumpbtn=false
self.isonhide=false
self._cfg_free_times=cfg_cloudcitytreasureactconfig_get(self.subid).free_times
self._costid=cfg_cloudcitytreasureactconfig_get(self.subid).costs[1]

self:refreshSkipBtn()
self.winlua:SetChildActive(self.perfab_shaizi:getID(),false)
self:showWindow('UIYCTBRightWin',{actID=self.actID,subType=self.subType,subid=self.subid,parentwin=self})

self.buildScrollview:setActive(true)
self:SetGridState()
self:refreshQuanNun()
self:refreshShaiZiNum()
self:refreshActivityTime()
self:refreshDaojuList(true)
self:refreshIsShowReddotBtn()

local check=self.sub_actInfo:isSaiZiNum()
if check then
self.spine_join:setChildShowEffect(10348,true)
end

self:refreshbuttonLayer()
self:refreshMapInfo()

if argtable.extraParams and argtable.extraParams.monterautojump then
self.sub_actInfo:setAutofright(false)
self:setAutoMode(true)
end


if argtable.extraParams and argtable.extraParams.autojump then
self.sub_actInfo:setAutofright(false)
local iscan=true
if _this.isgetbtn then
iscan=false
end
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local free_times=mydata.free_times
local num=bagControl.invokeFuncByItemId(_this._costid,'getItemCountByItemID',_this._costid)
if(self._cfg_free_times<=free_times)and(num<=0)then
UIManager.error('云城宝骰不足')
self:showWindow('UIDialougeYCTBbuy',{actID=_this.actID,subType=_this.subType,subid=_this.subid,parentwin=_this})
iscan=false
end
if iscan then
local is_run=mydata.is_run
if is_run>0 then
UIManager.error('当前处于跳跃状态中，无法操作')
else
self.autoImg:setChildCanvasGroupDOFade(1,0.5,nil)
self.sub_actInfo:setAutoMode(true)
end
end
end

local autoMode=self.sub_actInfo:isInAuto()
if autoMode then
self.sub_actInfo:setAutoStart(true)
self.startAutoButton:setActive(false)
self.cancelAutoButton:setActive(true)
self:startAutoTimer()
else
self.startAutoButton:setActive(true)
self.cancelAutoButton:setActive(false)
end
end


function UISubAct_yunchengtanbaoWin:qiyujumprefresh(argtable)

if self.actID==argtable.act_id and self.subid==argtable.sub_act_id then
if _this.sub_actInfo and _this.sub_actInfo:isInAuto()then
_this.sub_actInfo:setAutoStart(true)
end
_this.isgetbtn=false
_this.iszidong=false
_this:continueRun(nil)
end
end


function UISubAct_yunchengtanbaoWin:onHide()
if _this then
_this.winlua:SetChildShowEffect(_this.saiziEffect:getID(),0,false)
_this.winlua:SetChildShowEffect(_this.saiziEffect2:getID(),0,false)
_this.buildScrollview:setActive(false)



if _this.shaiziTimer then
_this:stopTimerByID(_this.shaiziTimer)
_this.shaiziTimer=nil
end
if _this.shaiziTimer2 then
_this:stopTimerByID(_this.shaiziTimer2)
_this.shaiziTimer2=nil
end
if _this.shaiziTimer3 then
_this:stopTimerByID(_this.shaiziTimer3)
_this.shaiziTimer3=nil
end
_this:stopAutoTimer()
end
self:setAutoMode(false)
_this.isonhide=true

end

function UISubAct_yunchengtanbaoWin:onShowArgRecv(argtable)
_this.buildScrollview:setActive(true)
end


function UISubAct_yunchengtanbaoWin:initStage()

local disciplesList=discipleLookup:getSortDiscipleList()
local discipleguid=disciplesList[1].netData.net.discipleguid
self.fightStage:addEntity(100,fightEntityType.diZi,discipleguid,fightModel.getWorldCenter(),true)
self.modelEntity=self.fightStage:getEntity(100)
end


function UISubAct_yunchengtanbaoWin:SetGridState()
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local mapid=mydata.map_id
local yctbGrids=cfg_cloudcitytreasureactmapconfig_get(mapid).grids
local gridstates={}
for k,v in ipairs(_this.grids)do
gridstates[#gridstates+1]={id=k,state=0,data={}}
end
gridstates[1]={id=1,state=1,data={}}
if yctbGrids and next(yctbGrids)then
for k,v in pairs(yctbGrids)do
local gwid
if v[3]and v[3]>0 then
gwid=v[3]
end
gridstates[k+1]={id=k+1,state=v[1],data={param1=gwid,param2=1,param3=v[2]}}
end
end
_this.gridstate=gridstates

end


function UISubAct_yunchengtanbaoWin:refreshMapInfo()
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local recv_bit=mydata.finish_bit
_this.now_grid=mydata.current_grid+1


for k,v in ipairs(_this.gridstate)do
local item=_this.grids[v.id]:getChildWidgetBase()
if v.id==1 then
item:SetChildActive(gridinex.first,true)
else
if v.state==specialgriseum.normal then
item:SetChildActive(gridinex.namal,true)
item:SetChildActive(gridinex.daojubtn,false)
item:SetChildActive(gridinex.nal_done,true)
local flag=mathHelper.getBitValue(recv_bit,k-1)
if flag==true then
item:SetChildCSImageSprite(gridinex.nal_done,abnameyc,'image_yunctb_21')
item:SetChildSizeDelta(gridinex.nal_done,61,58)
item:SetChildActive(gridinex.nal_effect,false)
else
item:SetChildActive(gridinex.nal_effect,true)
item:SetChildShowEffect(gridinex.nal_effect,10347,true)
item:SetChildCSImageSprite(gridinex.nal_done,abnameyc,'image_yunctb_22')
item:SetChildSizeDelta(gridinex.nal_done,39,36)
end

elseif v.state==specialgriseum.daoju then

item:SetChildActive(gridinex.big,true)
item:SetChildActive(gridinex.daojuicon,false)
item:SetChildActive(gridinex.spinebg,true)
item:SetChildActive(gridinex.daojubtn,true)
local flag=mathHelper.getBitValue(recv_bit,k-1)
if flag==true then
item:SetChildActive(gridinex.donetag,true)
item:SetChildCSImageSprite(gridinex.donetag,abnamegame,'image_dyyilingqu_2')
item:SetChildSizeDelta(gridinex.donetag,72,28)
else
item:SetChildActive(gridinex.donetag,false)
end
item:SetChildActive(gridinex.daojunump,false)
item:SetChildUIModelShowTarget(gridinex.spinebg,5328,1,{},eAnimationID.stand,false,false,0.5)
item:SetChildUIModelShowTargetOffset(gridinex.spinebg,0,22)

elseif v.state==specialgriseum.baoxiang then
item:SetChildActive(gridinex.reward,true)
item:SetChildActive(gridinex.donetag,false)
item:SetChildActive(gridinex.daojubtn,false)

local flag=mathHelper.getBitValue(recv_bit,k-1)
if flag==true then

item:SetChildActive(gridinex.reward_tag,true)
else
item:SetChildActive(gridinex.reward_tag,false)
end
item:SetChildActive(gridinex.reward_effect,true)
item:SetChildShowEffect(gridinex.reward_effect,10346,true)
item:SetChildCSImageSprite(gridinex.imgreward,abnameyc,bx_images[v.data.param3])

elseif v.state==specialgriseum.cat then
item:SetChildActive(gridinex.big,true)
item:SetChildActive(gridinex.daojuicon,false)
item:SetChildActive(gridinex.spinebg,true)
item:SetChildActive(gridinex.daojubtn,true)
local flag=mathHelper.getBitValue(recv_bit,k-1)
if flag==true then
local monster_bits=mydata.monster_bits
local msflag=mathHelper.getBitValue(monster_bits,k-1)
if msflag then
item:SetChildCSImageSprite(gridinex.donetag,abnameyc,'image_yunctb_yjb')
else
item:SetChildCSImageSprite(gridinex.donetag,abnameyc,'image_yunctb_ytp')
end
item:SetChildActive(gridinex.donetag,true)
item:SetChildSizeDelta(gridinex.donetag,84,38)
else
item:SetChildActive(gridinex.donetag,false)
end
item:SetChildActive(gridinex.daojunump,false)

local mosterGroupcfg=cfgHelper.get(cfg_monstergroup_get,v.data.param1)
local mosterId=mosterGroupcfg.monList[1]
local mcfg=cfgHelper.get1(cfg_monsterconfig_get,mosterId)
item:SetChildUIModelShowTarget(gridinex.spinebg,mcfg.modelid[1],1,mcfg.modelid[2],eAnimationID.stand,false,false,0.5)

elseif v.state==specialgriseum.shijian then
item:SetChildActive(gridinex.big,true)
item:SetChildActive(gridinex.daojuicon,false)
item:SetChildActive(gridinex.spinebg,true)
item:SetChildActive(gridinex.daojubtn,true)
local flag=mathHelper.getBitValue(recv_bit,k-1)
if flag==true then
item:SetChildActive(gridinex.donetag,true)
item:SetChildCSImageSprite(gridinex.donetag,abnameyc,'image_dyyilingqu_1A')
item:SetChildSizeDelta(gridinex.donetag,84,38)
else
item:SetChildActive(gridinex.donetag,false)
end
item:SetChildActive(gridinex.daojunump,false)

item:SetChildUIModelShowTarget(gridinex.spinebg,530002,0.4,{},eAnimationID.stand,false,false,0.5)
item:SetChildUIModelShowTargetOffset(gridinex.spinebg,0,22)

elseif v.state==specialgriseum.game then
item:SetChildActive(gridinex.big,true)
item:SetChildActive(gridinex.daojuicon,false)
item:SetChildActive(gridinex.spinebg,true)
item:SetChildActive(gridinex.daojubtn,true)
local flag=mathHelper.getBitValue(recv_bit,k-1)
if flag==true then
item:SetChildActive(gridinex.donetag,true)
item:SetChildCSImageSprite(gridinex.donetag,abnameyc,'image_dyyilingqu_1A')
item:SetChildSizeDelta(gridinex.donetag,84,38)
else
item:SetChildActive(gridinex.donetag,false)
end
item:SetChildActive(gridinex.donetag,false)
item:SetChildActive(gridinex.daojunump,false)
item:SetChildUIModelShowTarget(gridinex.spinebg,5328,1,{},eAnimationID.stand,false,false,0.5)
item:SetChildUIModelShowTargetOffset(gridinex.spinebg,0,22)
end
end
end
_this:refreshGameState()

_this.spine_player:setChildUIModelShowTarget(_this.modelParams.body,0.75,_this.modelParams.componets,eAnimationID.stand,false,false,0.5)
local grid=_this.grids[_this.now_grid]:getChildWidgetBase()
local griddata=_this.gridstate[_this.now_grid]
local nowpos=grid:GetChildPosition(gridinex_pos[griddata.state])
local Transform=_this.spine_player:getTransform()
if _this.now_grid==12 then
Transform:SetSiblingIndex(17)
elseif _this.now_grid==15 then
Transform:SetSiblingIndex(19)
elseif _this.now_grid==14 then
Transform:SetSiblingIndex(17)
else
Transform:SetSiblingIndex(_this.now_grid)
end
_this.spine_player:setChildPosition(Vector3.New(nowpos.x,nowpos.y,nowpos.z))

if _this.playrightindex[_this.now_grid]then
_this.spine_player:setChildUIModelShowFlipX(true)
else
_this.spine_player:setChildUIModelShowFlipX(false)
end
_this:HideGridImg(_this.now_grid)
_this:CheckIsComplish(mydata,_this.now_grid,recv_bit)
end

function UISubAct_yunchengtanbaoWin:refreshbuttonLayer()
local item=_this.btnroots:getChildWidgetBase()
for k,v in ipairs(_this.gridstate)do
if v.id==1 then
else
if v.state==specialgriseum.daoju then
item:SetChildButtonClick(k-2,function()
if _this==nil then return end
local pos=item:GetChildLocalPosition(k-2)
_this:onBigClickBtn(specialgriseum.daoju,item,{v.data.param1,pos})
end)
elseif v.state==specialgriseum.baoxiang then
item:SetChildButtonClick(k-2,function()
if _this==nil then return end
local pos=item:GetChildLocalPosition(k-2)
_this:onBigClickBtn(specialgriseum.baoxiang,item,{v.data.param3,pos})
end)
elseif v.state==specialgriseum.cat then
item:SetChildButtonClick(k-2,function()
if _this==nil then return end
_this:onBigClickBtn(specialgriseum.cat,item,{v.data.param1,v.data.param3,_this.subid,v.data.param2})
end)
elseif v.state==specialgriseum.shijian then
item:SetChildButtonClick(k-2,function()
if _this==nil then return end
_this:onBigClickBtn(specialgriseum.shijian,item)
end)
elseif v.state==specialgriseum.game then
item:SetChildButtonClick(k-2,function()
if _this==nil then return end
_this:onBigClickBtn(specialgriseum.game,item)
end)
end
end
end
end

function UISubAct_yunchengtanbaoWin:OnStartrefreshMapInfo()
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local recv_bit=mydata.finish_bit



for k,v in ipairs(_this.gridstate)do
local item=_this.grids[v.id]:getChildWidgetBase()
if v.id==1 then
item:SetChildActive(gridinex.first,true)
else
if v.state==specialgriseum.normal then
item:SetChildActive(gridinex.namal,true)
item:SetChildActive(gridinex.big,false)
item:SetChildActive(gridinex.reward,false)
item:SetChildActive(gridinex.daojubtn,false)
item:SetChildActive(gridinex.nal_done,true)
local flag=mathHelper.getBitValue(recv_bit,k-1)
if flag==true then
item:SetChildCSImageSprite(gridinex.nal_done,abnameyc,'image_yunctb_21')
item:SetChildSizeDelta(gridinex.nal_done,61,58)
item:SetChildActive(gridinex.nal_effect,false)
else

item:SetChildActive(gridinex.nal_effect,true)
item:SetChildShowEffect(gridinex.nal_effect,10347,true)
item:SetChildCSImageSprite(gridinex.nal_done,abnameyc,'image_yunctb_22')
item:SetChildSizeDelta(gridinex.nal_done,39,36)
end

elseif v.state==specialgriseum.daoju then

item:SetChildActive(gridinex.namal,false)
item:SetChildActive(gridinex.big,true)
item:SetChildActive(gridinex.reward,false)
item:SetChildActive(gridinex.daojuicon,false)
item:SetChildActive(gridinex.spinebg,true)
item:SetChildActive(gridinex.daojubtn,true)
item:SetChildActive(gridinex.donetag,true)
local flag=mathHelper.getBitValue(recv_bit,k-1)
if flag==true then
item:SetChildActive(gridinex.donetag,true)
item:SetChildCSImageSprite(gridinex.donetag,abnamegame,'image_dyyilingqu_2')
item:SetChildSizeDelta(gridinex.donetag,72,28)
else
item:SetChildActive(gridinex.donetag,false)
end
item:SetChildActive(gridinex.daojunump,false)

item:SetChildUIModelShowTarget(gridinex.spinebg,5328,1,{},eAnimationID.stand,false,false,0.5)
item:SetChildUIModelShowTargetOffset(gridinex.spinebg,0,22)

elseif v.state==specialgriseum.baoxiang then
item:SetChildActive(gridinex.namal,false)
item:SetChildActive(gridinex.big,false)
item:SetChildActive(gridinex.reward,true)
item:SetChildActive(gridinex.donetag,false)
item:SetChildActive(gridinex.daojubtn,false)
local flag=mathHelper.getBitValue(recv_bit,k-1)
if flag==true then
item:SetChildActive(gridinex.reward_tag,true)
else
item:SetChildActive(gridinex.reward_tag,false)
end
item:SetChildActive(gridinex.reward_effect,true)
item:SetChildShowEffect(gridinex.reward_effect,10346,true)
item:SetChildCSImageSprite(gridinex.imgreward,abnameyc,bx_images[v.data.param3])

elseif v.state==specialgriseum.cat then
item:SetChildActive(gridinex.namal,false)
item:SetChildActive(gridinex.big,true)
item:SetChildActive(gridinex.reward,false)
item:SetChildActive(gridinex.daojuicon,false)
item:SetChildActive(gridinex.spinebg,true)
item:SetChildActive(gridinex.daojubtn,true)
local flag=mathHelper.getBitValue(recv_bit,k-1)
if flag==true then
local monster_bits=mydata.monster_bits
local msflag=mathHelper.getBitValue(monster_bits,k-1)
if msflag then
item:SetChildCSImageSprite(gridinex.donetag,abnameyc,'image_yunctb_yjb')
else
item:SetChildCSImageSprite(gridinex.donetag,abnameyc,'image_yunctb_ytp')
end
item:SetChildActive(gridinex.donetag,true)
item:SetChildSizeDelta(gridinex.donetag,84,38)
else
item:SetChildActive(gridinex.donetag,false)
end
item:SetChildActive(gridinex.daojunump,false)

local mosterGroupcfg=cfgHelper.get(cfg_monstergroup_get,v.data.param1)
local mosterId=mosterGroupcfg.monList[1]
local mcfg=cfgHelper.get1(cfg_monsterconfig_get,mosterId)
item:SetChildUIModelShowTarget(gridinex.spinebg,mcfg.modelid[1],1,mcfg.modelid[2],eAnimationID.stand,false,false,0.5)

elseif v.state==specialgriseum.shijian then
item:SetChildActive(gridinex.namal,false)
item:SetChildActive(gridinex.big,true)
item:SetChildActive(gridinex.reward,false)
item:SetChildActive(gridinex.daojuicon,false)
item:SetChildActive(gridinex.spinebg,true)
item:SetChildActive(gridinex.daojubtn,true)
local flag=mathHelper.getBitValue(recv_bit,k-1)
if flag==true then
item:SetChildActive(gridinex.donetag,true)
item:SetChildCSImageSprite(gridinex.donetag,abnameyc,'image_dyyilingqu_1A')
item:SetChildSizeDelta(gridinex.donetag,84,38)
else
item:SetChildActive(gridinex.donetag,false)
end
item:SetChildActive(gridinex.daojunump,false)

item:SetChildUIModelShowTarget(gridinex.spinebg,530002,0.4,{},eAnimationID.stand,false,false,0.5)
item:SetChildUIModelShowTargetOffset(gridinex.spinebg,0,22)

elseif v.state==specialgriseum.game then
item:SetChildActive(gridinex.namal,false)
item:SetChildActive(gridinex.big,true)
item:SetChildActive(gridinex.reward,false)
item:SetChildActive(gridinex.daojuicon,false)
item:SetChildActive(gridinex.spinebg,true)
item:SetChildActive(gridinex.daojubtn,true)
local flag=mathHelper.getBitValue(recv_bit,k-1)
if flag==true then
item:SetChildActive(gridinex.donetag,true)
item:SetChildCSImageSprite(gridinex.donetag,abnameyc,'image_dyyilingqu_1A')
item:SetChildSizeDelta(gridinex.donetag,84,38)
else
item:SetChildActive(gridinex.donetag,false)
end
item:SetChildActive(gridinex.donetag,false)
item:SetChildActive(gridinex.daojunump,false)

item:SetChildUIModelShowTarget(gridinex.spinebg,5328,1,{},eAnimationID.stand,false,false,0.5)
item:SetChildUIModelShowTargetOffset(gridinex.spinebg,0,22)
end
end
end
_this:refreshbuttonLayer()
_this:refreshGameState()
end

function UISubAct_yunchengtanbaoWin:refreshQuanNun()
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local circle_num=mydata.circle_num
_this.winlua:SetChildText(_this.quanshu:getID(),FMT.fmt("第{0}圈",(circle_num)))
end

function UISubAct_yunchengtanbaoWin:refreshShaiZiNum()
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local free_times=mydata.free_times
local cfg_free_times=cfg_cloudcitytreasureactconfig_get(_this.subid).free_times
if cfg_free_times>free_times then
_this.cishumun:setActive(true)
_this.djupanel:setActive(false)
_this.winlua:SetChildText(_this.cishumun:getID(),FMT.fmt("免费次数:{0}",(cfg_free_times-free_times)))
else
_this.cishumun:setActive(false)
_this.djupanel:setActive(true)
local costid=cfg_cloudcitytreasureactconfig_get(_this.subid).costs[1]
local num=bagControl.invokeFuncByItemId(costid,'getItemCountByItemID',costid)
local iconName=iconHelper.getIconName(costid)
_this.winlua:SetChildIcon(_this.djuicon:getID(),iconName,false)
if num and num>0 then
_this.winlua:SetChildText(_this.djunum:getID(),num)
else
_this.winlua:SetChildText(_this.djunum:getID(),0)
_this.spine_join:setChildShowEffect(0,false)
end
end
end

function UISubAct_yunchengtanbaoWin:refreshActivityTime()
self:clearTimer()
local func
func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.end_time and self.end_time-nowTime or 0
if lerp>0 then

self.actytime:setText(FMT.fmt("<color=#f1ce78>云城探宝结束倒计时：</color>{0}",timeHelper.format_time_stamp3(lerp,true)))
else
self.actytime:setText("活动已结束")
UIManager.error("活动已结束")
self.isOver=true
self:clearTimer()
end
end
self.timer=self:setTimer(1,0,func)
func()
end

function UISubAct_yunchengtanbaoWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UISubAct_yunchengtanbaoWin:refreshDaojuList(init)

local datas=cfg_cloudcitytreasureactconfig_get(_this.subid).itemlist

table.sort(datas,function(a,b)
local num1=bagControl.invokeFuncByItemId(a[1],'getItemCountByItemID',a[1])
local num2=bagControl.invokeFuncByItemId(b[1],'getItemCountByItemID',b[1])
local state1=num1>0 and-1 or 0
local state2=num2>0 and-1 or 0
local weight1=state1*100+a[2]
local weight2=state2*100+b[2]
return weight1<weight2
end)

_this.buildScrollview:setChildScrollViewCreateGrids(#datas,0)
local grids=_this.buildScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local itemId=datas[i][1]
local itemcfg=itemsConfig.getConfig(itemId)
local num=bagControl.invokeFuncByItemId(itemId,'getItemCountByItemID',itemId)
_this:setRoadItem(item,itemId,itemcfg,i,num)
if init then
_this:refreshSelect(i,false)
_this:speiclitem(i,false)
end
end
end


function UISubAct_yunchengtanbaoWin:setRoadItem(item,itemid,itemcfg,i,num)
item:SetChildActive(35,false)
item:SetChildIcon(1,iconHelper.getItemIconName(itemcfg.icon),false)
local item_type=cfg_cloudcitytreasureactdaojuconfig_get(itemid).typeid
local desc=cfg_cloudcitytreasureactdaojuconfig_get(itemid).effect_desc
item:SetChildText(21,num)
item:SetChildActive(20,false)
item:SetChildText(34,num)
item:SetChildActive(33,true)
if num<=0 then
item:SetChildText(19,FMT.fmt('<color=#161A14>{0}</color>',desc))
else
item:SetChildText(19,desc)
end
item:SetChildButtonClick(9,function()
_this:onRoadItemClick(item,i,num,itemid)
end,true)
item:SetChildButtonClick(35,function()
_this:onUseItemClick(item_type,itemid,i,num,item,desc,itemid)
end,true)
if itemid==_this.specialitemid then
item:SetChildButtonClick(26,function()
_this:onZhidingItemClick(item_type,itemid,item,i,1,desc)
end,true)
item:SetChildButtonClick(27,function()
_this:onZhidingItemClick(item_type,itemid,item,i,2,desc)
end,true)
item:SetChildButtonClick(28,function()
_this:onZhidingItemClick(item_type,itemid,item,i,3,desc)
end,true)
item:SetChildButtonClick(29,function()
_this:onZhidingItemClick(item_type,itemid,item,i,4,desc)
end,true)
item:SetChildButtonClick(30,function()
_this:onZhidingItemClick(item_type,itemid,item,i,5,desc)
end,true)
item:SetChildButtonClick(31,function()
_this:onZhidingItemClick(item_type,itemid,item,i,6,desc)
end,true)
end

item:SetChildImageExGray(1,num<=0)
end


function UISubAct_yunchengtanbaoWin:CheckIsComplish(mydata,now_grid,recv_bit)
local gridstate=_this.gridstate[now_grid]
if gridstate.id==1 then
else
if gridstate.state==specialgriseum.normal then
local flag=mathHelper.getBitValue(recv_bit,now_grid-1)
if flag==true then
end
elseif gridstate.state==specialgriseum.daoju then
local flag=mathHelper.getBitValue(recv_bit,now_grid-1)
if flag==true then
end
elseif gridstate.state==specialgriseum.baoxiang then
local flag=mathHelper.getBitValue(recv_bit,now_grid-1)
if flag==true then
end
elseif gridstate.state==specialgriseum.cat then
local flag=mathHelper.getBitValue(recv_bit,now_grid-1)
if flag==true then
else
if _this.allget_state==false and mydata.is_run<=0 then
_this:MosterFrighting(gridstate.data.param1)
elseif _this.allget_state==true then
_this:MosterFrighting(gridstate.data.param1)
else
_this:continueRun()
end
return
end
elseif gridstate.state==specialgriseum.shijian then
local flag=mathHelper.getBitValue(recv_bit,now_grid-1)
if flag==true then
else
if _this.allget_state==false and mydata.is_run<=0 then
_this:MysteryEvent(gridstate.data.param1)
elseif _this.allget_state==true then
_this:MysteryEvent(gridstate.data.param1)
else
_this:continueRun()
end
return
end
elseif gridstate.state==specialgriseum.game then
local flag=mathHelper.getBitValue(recv_bit,now_grid-1)
if flag==true then
else
if _this.allget_state==false and mydata.is_run<=0 then
_this:GamePlaying(2)
elseif _this.allget_state==true then
_this:GamePlaying(2)
else
_this:continueRun()
end
return
end
end
end

if mydata.is_run>0 then
_this:continueRun(mydata.is_run)
end
end


function UISubAct_yunchengtanbaoWin:onJoinBtn()
local autoMode=_this.sub_actInfo:isInAuto()
if autoMode then
UIManager.info("请先取消自动探宝")
return
end
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local free_times=mydata.free_times
local cfg_free_times=cfg_cloudcitytreasureactconfig_get(_this.subid).free_times
local costid=cfg_cloudcitytreasureactconfig_get(_this.subid).costs[1]
local num=bagControl.invokeFuncByItemId(costid,'getItemCountByItemID',costid)
if(cfg_free_times<=free_times)and(num<=0)then
UIManager.error('云城宝骰不足')
self:showWindow('UIDialougeYCTBbuy',{actID=_this.actID,subType=_this.subType,subid=_this.subid,parentwin=_this})
return
end

local is_run=mydata.is_run
if is_run>0 then
UIManager.error('当前处于跳跃状态中，无法操作')
return
end
if _this.isgetbtn then
return
end

if not _this.isgetbtn then
_this.isgetbtn=true
if cfg_free_times>free_times then
mydata.isTouzi=true
activitiesModel:setSubActInfoData(_this.actID,_this.subType,_this.subid,mydata)


_this:checkIsJump()
else
if num and num>0 then
mydata.isTouzi=true
activitiesModel:setSubActInfoData(_this.actID,_this.subType,_this.subid,mydata)


_this:checkIsJump()
else
self:showWindow('UIDialougeYCTBbuy',{actID=_this.actID,subType=_this.subType,subid=_this.subid,parentwin=_this})
end
end
end
end


function UISubAct_yunchengtanbaoWin:onBigClickBtn(type,item,argument)

if type==specialgriseum.daoju then
local pos=argument[2]
local flag=2
local idx=1
self:showWindow('UIYCTBBigtis',{actID=_this.actID,subType=_this.subType,subid=_this.subid,parentwin=self,contentstr="概率获得以上奖励其中一项",posx=0,posy=0,itempos=pos,flag=flag,idx=idx})
elseif type==specialgriseum.cat then
self:MosterInfo(argument)
elseif type==specialgriseum.shijian then
UIManager.info('行走至此处可触发云城探宝事件')
elseif type==specialgriseum.baoxiang then
local pos=argument[2]
local flag=1
local idx=argument[1]
self:showWindow('UIYCTBBigtis',{actID=_this.actID,subType=_this.subType,subid=_this.subid,parentwin=self,contentstr="概率获得以上奖励其中一项",posx=0,posy=0,itempos=pos,flag=flag,idx=idx})
end
end

function UISubAct_yunchengtanbaoWin:onZhidingItemClick(itemtype,itemid,item,index,i,desc)

if itemid==_this.specialitemid then
local istg=_this:checkIsDJJump()
local callback=function()
local old=_this.select_index
_this.select_index=-1
_this.select_itemid=-1
local pos=item:GetChildPosition(9)
local isstatechange=false
_this:speiclitem(old,false)
UIManager:showWindow('UIYCTBTEffectWin',{_this.actID,_this.subType,_this.subid,pos,desc,itemid,isstatechange,{3,itemtype,1,i,istg},_this})
item:SetChildShowEffect(32,0,false)
item:SetChildCanvasGroupDOFade(9,0,0.4)
_this:delayDo(0.8,function()
item:SetChildCanvasGroupDOFade(9,1,0.6)
end)
end
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eYunChenTanBaoItem)
if not flag then
local _desc=FMT.fmt('是否行走<color=#EB8139>{0}个</color>格子？',i)
local show_data=
{
title='云城探宝',
Str=_desc or'',
oktext="确认",
canceltext="取消",
eDay=REPEAT_TIME_TYPE.eDay,
REPEAT_TYPE=REPEAT_TYPE.eYunChenTanBaoItem,
okcallback=function()
if _this==nil then return end
callback()
end
}
UIManager:showWindow('UIDialougeYCTBtips',show_data)
else
callback()
end
end
end

function UISubAct_yunchengtanbaoWin:onRoadItemClick(item,index,num,itemid)
local now_pos=item:GetChildPosition(-1)

if now_pos.x<=_this.startpos.x or now_pos.x>=_this.endpos.x then
return
end
local autoMode=_this.sub_actInfo:isInAuto()
if autoMode then
UIManager.info("请先取消自动探宝")
return
end
if _this.gameisjump==true or _this.isjumpbtn then
UIManager.error('当前处于跳跃状态中，无法操作')
return
end
if num<=0 then
gainControl:showGainWin(itemid)
return
end
local old=_this.select_index
_this.select_index=index
local olditemid=_this.select_itemid
_this.select_itemid=itemid
if itemid==_this.specialitemid then
if old==index then
_this.select_index=-1
_this.select_itemid=-1
self:speiclitem(index,false)
else
self:speiclitem(index,true,now_pos)
self:refreshSelect(old,false)
end
else
if old==index then
_this.select_index=-1
_this.select_itemid=-1
self:refreshSelect(index,false)
else
if olditemid==_this.specialitemid then
self:speiclitem(old,false)
self:refreshSelect(index,true)
else
self:refreshSelect(old,false)
self:refreshSelect(index,true)
end
end
end
end

function UISubAct_yunchengtanbaoWin:onUseItemClick(itemtype,itemid,index,num,item,desc,itemid)
local autoMode=_this.sub_actInfo:isInAuto()
if autoMode then
UIManager.info("请先取消自动探宝")
return
end
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local is_run=mydata.is_run
if is_run>0 or _this.isjumpbtn then
UIManager.error('当前处于跳跃状态中，无法操作')
return
end

local old=_this.select_index
_this.select_index=-1
_this.select_itemid=-1
local pos=item:GetChildPosition(9)
local iscanuse=true

local effect_list=mydata.effect_list or{}


if itemid==_this.specialitemid then
else
if itemid==_this.allneeditemdi then
for k,v in ipairs(effect_list)do
if v==3 then
UIManager.error('加成效果生效中，无法重复使用')
iscanuse=false

end
end
end
if itemid==_this.doubleitemdi then
for k,v in ipairs(effect_list)do
if v==2 then
UIManager.error('加成效果生效中，无法重复使用')
iscanuse=false

end
end
end
if iscanuse then
local _index=1
local dice_effectcfg=cfg_cloudcitytreasureactconfig_get(_this.subid).dice_effect
if itemtype then
for k,v in ipairs(dice_effectcfg[itemtype])do
if itemid==v[1]then
_index=k
break
end
end
end

local isstatechange=false
if itemid==_this.allneeditemdi or itemid==_this.doubleitemdi then
isstatechange=true
end
local istg=_this:checkIsDJJump()
UIManager:showWindow('UIYCTBTEffectWin',{_this.actID,_this.subType,_this.subid,pos,desc,itemid,isstatechange,{3,itemtype,_index,0,istg},_this})
item:SetChildCanvasGroupDOFade(9,0,0.4)
item:SetChildCanvasGroupDOFade(35,0,0.4)
item:SetChildShowEffect(32,0,false)
self:delayDo(0.8,function()
self:refreshSelect(old,false)
item:SetChildCanvasGroupDOFade(9,1,0.6)
item:SetChildCanvasGroupDOFade(35,1,0.6)
end)
else
self:refreshSelect(old,false)
end
end
end

function UISubAct_yunchengtanbaoWin:refreshSelect(index,flag)
if index<0 then
return
end
local item=_this.buildScrollview:getChildScrollViewItemWidget(index-1)
if flag==true then
_this.buildScrollview:setChildScrollRectEnable(false)
item:SetChildAnchoredPos(9,0,60)
item:SetChildShowEffect(32,10352,true)
item:SetChildActive(35,true)
item:SetChildActive(20,true)
else
_this.buildScrollview:setChildScrollRectEnable(true)
item:SetChildAnchoredPos(9,0,-3)
item:SetChildShowEffect(32,0,false)
item:SetChildActive(35,false)
item:SetChildActive(20,false)
end
end

function UISubAct_yunchengtanbaoWin:speiclitem(index,flag,now_pos)
if index<0 then
return
end
local item=_this.buildScrollview:getChildScrollViewItemWidget(index-1)
if flag==true then
_this.buildScrollview:setChildScrollRectEnable(false)

item:SetChildScale(36,Vector3.New(0,1,1))
if now_pos then
if math.abs(now_pos.x-_this.startpos.x)<1.1 then
item:SetChildAnchoredPos(25,118,147)
end
if math.abs(now_pos.x-_this.endpos.x)<1.3 then
item:SetChildAnchoredPos(25,-120,147)
end
end
item:SetChildActive(24,true)
item:SetChildActive(25,true)

item:SetChildDOScaleX(36,1,0.3,nil)
item:SetChildShowEffect(32,10352,true)
item:SetChildActive(20,true)
else
item:SetChildActive(24,false)
item:SetChildActive(25,false)
_this.buildScrollview:setChildScrollRectEnable(true)



item:SetChildScale(36,Vector3.New(0,1,1))
item:SetChildShowEffect(32,0,false)
item:SetChildActive(20,false)
end
end


function UISubAct_yunchengtanbaoWin:onJiachebtn()
if _this.gameisjump==true then
UIManager.error('当前处于跳跃状态中，无法操作')
return
end
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local effect_list=mydata.effect_list
if effect_list and#effect_list>0 then
local win=UIManager:findActiveWindow('UIYCTBTipsWin')
if win then
win:closeSelf()
else
_this:showWindow('UIYCTBTipsWin',{effect_list,_this.actID,_this.subType,_this.subid})
end
else
UIManager.error('当前没有加成效果')
end
end

function UISubAct_yunchengtanbaoWin:onJianlibtn()
if _this.gameisjump==true then
UIManager.error('当前处于跳跃状态中，无法操作')
return
end
UIManager:showWindow('UISubAct_yunchengtanbao_reward_win')
end

function UISubAct_yunchengtanbaoWin:onPaihanbtn()
if _this.gameisjump==true then
UIManager.error('当前处于跳跃状态中，无法操作')
return
end
local json_str=jsonHelper.encode({4})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
end


function UISubAct_yunchengtanbaoWin:refreshGameState()
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
_this.allget_state=false
local effect_list=mydata.effect_list
if effect_list and#effect_list>0 then
for k,v in ipairs(effect_list)do
if v==3 then
_this.allget_state=true
break
end
end
end
end

function UISubAct_yunchengtanbaoWin:handelRun()
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local is_skip=mydata.is_skip
if is_skip and is_skip==1 then
_this:jumphandelRun()
else
local next_grid=mydata.current_grid+1
_this.gameisjump=true
_this.move_num=mydata.run_step
_this:ShowGridImg(_this.now_grid)
_this:PlayerMoveTo(next_grid)
end
end

function UISubAct_yunchengtanbaoWin:continueRun(isrun)

if _this then
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local is_run=mydata.is_run

if is_run>0 then


_this:checkIsJump()
end
end
end

function UISubAct_yunchengtanbaoWin:handelGridRefresh(grid_index)

local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local recv_bit=mydata.finish_bit
local current_grid=grid_index
local gridstate=_this.gridstate[current_grid]
local item=_this.grids[gridstate.id]:getChildWidgetBase()

if gridstate.id==1 then
return
else
if gridstate.state==specialgriseum.normal then

elseif gridstate.state==specialgriseum.daoju then
local flag=mathHelper.getBitValue(recv_bit,current_grid-1)
if flag==true then
item:SetChildActive(gridinex.donetag,true)
item:SetChildCSImageSprite(gridinex.donetag,abnamegame,'image_dyyilingqu_2')
item:SetChildSizeDelta(gridinex.donetag,72,28)

self:OpeanPrizeWin()
else
item:SetChildActive(gridinex.donetag,false)

self:continueRun()
end

elseif gridstate.state==specialgriseum.baoxiang then
local flag=mathHelper.getBitValue(recv_bit,current_grid-1)
if flag==true then


item:SetChildActive(gridinex.reward_tag,true)
self:OpeanPrizeWin()
else

item:SetChildActive(gridinex.reward_tag,false)
self:continueRun()
end

elseif gridstate.state==specialgriseum.cat then
local flag=mathHelper.getBitValue(recv_bit,current_grid-1)
if flag==true then
local monster_bits=mydata.monster_bits
local msflag=mathHelper.getBitValue(monster_bits,current_grid-1)
if msflag then
item:SetChildCSImageSprite(gridinex.donetag,abnameyc,'image_yunctb_yjb')
else
item:SetChildCSImageSprite(gridinex.donetag,abnameyc,'image_yunctb_ytp')
end
item:SetChildActive(gridinex.donetag,true)
item:SetChildSizeDelta(gridinex.donetag,84,38)
else
item:SetChildActive(gridinex.donetag,false)
if _this.allget_state==false and mydata.is_run<=0 then
self:MosterFrighting(gridstate.data.param1)
elseif _this.allget_state==true then
self:MosterFrighting(gridstate.data.param1)
else
self:continueRun()
end
end

elseif gridstate.state==specialgriseum.shijian then
local flag=mathHelper.getBitValue(recv_bit,current_grid-1)
if flag==true then
item:SetChildActive(gridinex.donetag,true)
item:SetChildCSImageSprite(gridinex.donetag,abnameyc,'image_dyyilingqu_1A')
item:SetChildSizeDelta(gridinex.donetag,84,38)
else
item:SetChildActive(gridinex.donetag,false)
if _this.allget_state==false and mydata.is_run<=0 then
self:MysteryEvent(gridstate.data.param1)
elseif _this.allget_state==true then
self:MysteryEvent(gridstate.data.param1)
else
self:continueRun()
end
end

elseif gridstate.state==specialgriseum.game then
local flag=mathHelper.getBitValue(recv_bit,current_grid-1)
if flag==true then

else

if _this.allget_state==false and mydata.is_run<=0 then
self:GamePlaying(2)
elseif _this.allget_state==true then
self:GamePlaying(2)
else
self:continueRun()
end
end
end
end
end

function UISubAct_yunchengtanbaoWin:PlayerMoveTo(next_current_grid)

if next_current_grid>23 then
next_current_grid=1
end
_this.spine_player:setChildModelAnimationState(eAnimationID.jump1)
if _this.playrightindex[next_current_grid]then
_this.spine_player:setChildUIModelShowFlipX(true)
else
_this.spine_player:setChildUIModelShowFlipX(false)
end
local Transform=_this.spine_player:getTransform()
if next_current_grid==12 or next_current_grid==13 or next_current_grid==14 then
Transform:SetSiblingIndex(18)
elseif next_current_grid==15 then
Transform:SetSiblingIndex(19)
else
Transform:SetSiblingIndex(next_current_grid)
end

local grid=_this.grids[next_current_grid]:getChildWidgetBase()
local griddata=_this.gridstate[next_current_grid]
local nowpos=grid:GetChildPosition(gridinex_pos[griddata.state])
_this.spine_player:setChildModelAnimationState(eAnimationID.jump2)
local tweener=_this.winlua:SetChildDOMove(_this.spine_player:getID(),nowpos,jump_speed,function()
_this.spine_player:setChildModelAnimationState(eAnimationID.jump3)
if _this then



_this.iszidong=false
self:reachNormalGridindex(next_current_grid)
self:reachTargetGridindex(next_current_grid)
_this.now_grid=next_current_grid
self:HideGridImg(_this.now_grid)
self:isJumping()
_this.isgetbtnTimer=nil
_this.isgetbtn=true
_this.isgetbtnTimer=_this:delayDo(2,function()
if _this==nil then return end
_this.isgetbtnTimer=nil
_this.isgetbtn=false
end)
end
end)
tweener:SetEase(_Ease.Linear)
end

function UISubAct_yunchengtanbaoWin:reachTargetGridindex(grid_index)
_this:handelGridRefresh(grid_index)
end

function UISubAct_yunchengtanbaoWin:reachNormalGridindex(grid_index)
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local recv_bit=mydata.finish_bit
local current_grid=grid_index
local gridstate=_this.gridstate[current_grid]
local item=_this.grids[gridstate.id]:getChildWidgetBase()


if gridstate.id==1 then

if _this.sub_actInfo and _this.sub_actInfo:isInAuto()then
_this.sub_actInfo:setAutoStart(false)
end
local startCallback=function()
if _this==nil then return end
self:SetGridState()
self:OnStartrefreshMapInfo()
self:refreshQuanNun()
self:refreshShaiZiNum()
self:continueRun()
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
local endCallback=function()
if _this==nil then return end
if _this.sub_actInfo and _this.sub_actInfo:isInAuto()then
_this.sub_actInfo:setAutoStart(true)
end
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback,endCallback=endCallback})

else
if gridstate.state==specialgriseum.normal then
local flag=mathHelper.getBitValue(recv_bit,current_grid-1)
item:SetChildActive(gridinex.nal_done,true)
if flag==true then
item:SetChildActive(gridinex.nal_effect,false)
item:SetChildCSImageSprite(gridinex.nal_done,abnameyc,'image_yunctb_21')
item:SetChildSizeDelta(gridinex.nal_done,61,58)

self:OpeanPrizePiaoZi()
self:continueRun()
else
self:continueRun()
end
end
end
end

function UISubAct_yunchengtanbaoWin:ShowGridImg(dangqian_index)

local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local recv_bit=mydata.finish_bit
local current_grid=dangqian_index
local gridstate=_this.gridstate[current_grid]
local item=_this.grids[gridstate.id]:getChildWidgetBase()

if gridstate.id==1 then
return
else
if gridstate.state==specialgriseum.normal then
local flag=mathHelper.getBitValue(recv_bit,current_grid-1)
item:SetChildActive(gridinex.nal_done,true)
if flag==true then
item:SetChildActive(gridinex.nal_effect,false)
item:SetChildCSImageSprite(gridinex.nal_done,abnameyc,'image_yunctb_21')
item:SetChildSizeDelta(gridinex.nal_done,61,58)
else
item:SetChildActive(gridinex.nal_effect,true)
item:SetChildCSImageSprite(gridinex.nal_done,abnameyc,'image_yunctb_22')
item:SetChildSizeDelta(gridinex.nal_done,39,36)
end
elseif gridstate.state==specialgriseum.daoju then
local flag=mathHelper.getBitValue(recv_bit,current_grid-1)
if flag==true then
item:SetChildActive(gridinex.donetag,true)

else
item:SetChildActive(gridinex.donetag,false)
end
elseif gridstate.state==specialgriseum.baoxiang then
item:SetChildActive(gridinex.imgreward,true)
item:SetChildActive(gridinex.reward_effect,true)
local flag=mathHelper.getBitValue(recv_bit,current_grid-1)
if flag==true then
item:SetChildActive(gridinex.reward_tag,true)
else
item:SetChildActive(gridinex.reward_tag,false)
end
elseif gridstate.state==specialgriseum.cat then
local flag=mathHelper.getBitValue(recv_bit,current_grid-1)
if flag==true then
item:SetChildActive(gridinex.donetag,true)
item:SetChildActive(gridinex.spinebg,true)
else
item:SetChildActive(gridinex.donetag,false)
end
elseif gridstate.state==specialgriseum.shijian then
local flag=mathHelper.getBitValue(recv_bit,current_grid-1)
item:SetChildActive(gridinex.spinebg,true)
if flag==true then
item:SetChildActive(gridinex.donetag,true)
item:SetChildCSImageSprite(gridinex.donetag,abnameyc,'image_dyyilingqu_1A')
item:SetChildSizeDelta(gridinex.donetag,84,38)
else
item:SetChildActive(gridinex.donetag,false)
end
elseif gridstate.state==specialgriseum.game then
local flag=mathHelper.getBitValue(recv_bit,current_grid-1)
item:SetChildActive(gridinex.spinebg,true)
if flag==true then
item:SetChildActive(gridinex.donetag,true)
item:SetChildCSImageSprite(gridinex.donetag,abnameyc,'image_dyyilingqu_1A')
item:SetChildSizeDelta(gridinex.donetag,84,38)
else
item:SetChildActive(gridinex.donetag,false)
end
end
end
end

function UISubAct_yunchengtanbaoWin:HideGridImg(dangqian_index)

local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local recv_bit=mydata.finish_bit
local current_grid=dangqian_index
local gridstate=_this.gridstate[current_grid]
local item=_this.grids[gridstate.id]:getChildWidgetBase()

if gridstate.id==1 then
return
else
if gridstate.state==specialgriseum.normal then
item:SetChildActive(gridinex.nal_effect,false)
if mydata.is_run<=0 then
item:SetChildActive(gridinex.nal_done,false)

end
elseif gridstate.state==specialgriseum.daoju then
local flag=mathHelper.getBitValue(recv_bit,current_grid-1)
if mydata.is_run<=0 then
item:SetChildActive(gridinex.daojuicon,false)
item:SetChildActive(gridinex.daojunump,false)
item:SetChildActive(gridinex.donetag,false)
end
if _this.allget_state==true then
item:SetChildActive(gridinex.daojuicon,false)
item:SetChildActive(gridinex.daojunump,false)
item:SetChildActive(gridinex.donetag,false)
end
elseif gridstate.state==specialgriseum.baoxiang then
item:SetChildActive(gridinex.reward_effect,false)
if mydata.is_run<=0 then
item:SetChildActive(gridinex.imgreward,false)
item:SetChildActive(gridinex.reward_tag,false)
end
if _this.allget_state==true then
item:SetChildActive(gridinex.imgreward,false)
item:SetChildActive(gridinex.reward_tag,false)
end
elseif gridstate.state==specialgriseum.cat then
if mydata.is_run<=0 then
item:SetChildActive(gridinex.donetag,false)
item:SetChildActive(gridinex.spinebg,false)
end
if _this.allget_state==true then
item:SetChildActive(gridinex.donetag,false)
item:SetChildActive(gridinex.spinebg,false)
end
elseif gridstate.state==specialgriseum.shijian then
if mydata.is_run<=0 then
item:SetChildActive(gridinex.donetag,false)
item:SetChildActive(gridinex.spinebg,false)
end
if _this.allget_state==true then
item:SetChildActive(gridinex.donetag,false)
item:SetChildActive(gridinex.spinebg,false)
end
elseif gridstate.state==specialgriseum.game then
if mydata.is_run<=0 then
item:SetChildActive(gridinex.donetag,false)
item:SetChildActive(gridinex.spinebg,false)
end
if _this.allget_state==true then
item:SetChildActive(gridinex.donetag,false)
item:SetChildActive(gridinex.spinebg,false)
end
end
end
end


function UISubAct_yunchengtanbaoWin:MosterFrighting(mosterGroupId)
local actID=_this.actID
local subType=_this.subType
local subid=_this.subid
local cyc_num=cfg_cloudcitytreasureactconfig_get(subid).cyc_num
local singleFightDescStr=FMT.fmt('{0}回合内取得胜利',cyc_num)
local mcfg=cfgHelper.get(cfg_monstergroup_get,mosterGroupId)
if _this.sub_actInfo and _this.sub_actInfo:isInAuto()then
_this.sub_actInfo:setAutoStart(false)
_this.sub_actInfo:setAutofright(true)
end
local autojump=_this.sub_actInfo:isfrightAuto()

local fightType=fightPreSelectModel.fightType.yunchengtanbao
local teamList=fightPreSelectModel:getTeamData(fightType)or{}
local temp={}
for k,v in pairs(teamList)do
table.insert(temp,{fightPreSelectModel.teamEntityType.dizi,v})
end
if temp and next(temp)and _this.sub_actInfo:isInAuto()then
fightLaunchController:sendFight(eBattleLaunch.yunchengtanbao,temp,mcfg.mapId or 0,nil,{actID,subType,subid})
else
fightController.showPrepareWin(fightPreSelectModel.fightType.yunchengtanbao,
{

skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
isHomeBattle=false,
dzCountLimit=5,
yunchentanbao=autojump,
showZhenFa=false,
editorTeam=false,
monsterList=mcfg.monList,
needSaveTeam=true,
groupId=mosterGroupId,
enterCallBack=function(guidList,zfId)
UIManager:closeWindow('UIYunChenFightExtraWin')
fightLaunchController:sendFight(eBattleLaunch.yunchengtanbao,guidList,mcfg.mapId or 0,zfId,{actID,subType,subid})
end,
cancelCallBack=function()
UIManager:closeWindow('UIYunChenFightExtraWin')


jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=subType,subid=subid,extraParams={monterautojump=autojump}}},function()
jumpManager:clearJump()
end)
end,

},function(...)
UIManager:showWindow('UIYunChenFightExtraWin',{txt=singleFightDescStr})
end)
end
end

function UISubAct_yunchengtanbaoWin:MysteryEvent(eventGroupId)
local actID=_this.actID
local subType=_this.subType
local subid=_this.subid
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
if _this.sub_actInfo and _this.sub_actInfo:isInAuto()then
_this.sub_actInfo:setAutoStart(false)
_this.sub_actInfo:setAutofright(true)
end
local autojump=_this.sub_actInfo:isfrightAuto()

local func=function()
if actID then

jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=subType,subid=subid,extraParams={autojump=autojump}}},function()
jumpManager:clearJump()
end)
end
end
if not data.event_guid_id then
loggerUtil.logErrFMT("请检查249——100协议,活动actID：{0},subid：{1}，奇遇事件数据没有及时下发",actID,subid)
end

MysteryEventSystem:showEventByGuid(SYSTEM_DEFINE.eCloudCityTreasure,data.event_guid_id,{},true,func)
end

function UISubAct_yunchengtanbaoWin:GamePlaying(game_id)




local gamecb=function(resultLV)
local iswin=resultLV>0 and 1 or 2
local json_str=jsonHelper.encode({2,iswin})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
end

self:showWarringPanel(game_id)
_this:delayDo(2,function()
UILittleGameController:openLittleGame(game_id,{mapId=1,isyctb_flag=true},gamecb,nil)
end)
end
function UISubAct_yunchengtanbaoWin:showWarringPanel(game_id)
_this.WarringPanel:setLocalPosY(600)
_this.warringText:setCSImageSprite(abname_yctb,FMT.fmt('title_yunchengtb_0{0}',gamenametype[game_id]or 1))
_this.WarringPanel:setChildCanvasGroupAlpha(1)
_this.WarringPanel:setChildDOLocalMoveY(200,0.5,nil)
local fadetweener=_this.WarringPanel:setChildCanvasGroupDOFade(0,0.5)
fadetweener:SetDelay(1.25)
end

function UISubAct_yunchengtanbaoWin:MosterInfo(argument)
local moster_color=1
local mosterGroupId=nil
local subid=argument[3]
mosterGroupId=argument[1]
moster_color=argument[2]
if mosterGroupId then
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local cfg_dioaluo=cfg_cloudcitytreasureactconfig_get(subid).grids_reward
local rwId1=cfg_dioaluo[4][moster_color][1]
local rwId2=cfg_dioaluo[4][moster_color][2]

local mCfg=cfgHelper.get(cfg_monstergroup_get,mosterGroupId)
local lv=mydata.mon_lv
local rwcfg1=cfgHelper.get1(cfg_awardconfig_get,rwId1)
local items=rwcfg1.showItems or{}
local rwcfg2=cfgHelper.get1(cfg_awardconfig_get,rwId2)
local itemss=rwcfg2.showItems or{}
local winParam={
groupId=mCfg.id,
name=mCfg.name,
icon=mCfg.model,
level=lv,
skills=mCfg.showSkills,
desc=mCfg.desc,
items=items,
itemss=itemss,
detail=nil,
actRewards={},
title="妖怪信息",
gotReward=false,
highestType=mCfg.monType,
close=function()
UIManager:closeWindow('UIYYTBBossWin')
end,
challenge=function()
UIManager:closeWindow('UIYYTBBossWin')
end,
}
self:showWindow("UIYYTBBossWin",winParam)
end
end

function UISubAct_yunchengtanbaoWin:OpeanPrizeWin()
local data=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
if data==nil then return end
if _this.sub_actInfo:isInAuto()then
_this.sub_actInfo:setAutoStart(false)
end
local list=data.specialPrize or{}
local conf={}
for i,v in ipairs(list)do
table.insert(conf,{itemid=v.itemid,num=v.num})
end
local _fun=function()
if data==nil then return end
if _this.sub_actInfo and _this.sub_actInfo:isInAuto()then
_this.sub_actInfo:setAutoStart(true)
end
self:continueRun(nil)
end
local flag=_this.sub_actInfo:isInAuto()
showPrizeControl.showWindow(conf,_fun,{yc_data=flag})
end

function UISubAct_yunchengtanbaoWin:OpeanPrizePiaoZi()
local data=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
if data==nil then return end
local list=data.normalPrize or{}
for i,v in ipairs(list)do
UIManager.rewardInfo(iconHelper.getIconName(v.itemid),FMT.fmt('X{0}',v.num))
end
end

function UISubAct_yunchengtanbaoWin:OpeanGamePrizeWin(list)

if _this.sub_actInfo:isInAuto()then
_this.sub_actInfo:setAutoStart(false)
end
local conf={}
for i,v in ipairs(list)do
table.insert(conf,{itemid=v.itemid,num=v.num})
end
showPrizeControl.showWindow(conf,function()
if _this.sub_actInfo and _this.sub_actInfo:isInAuto()then
_this.sub_actInfo:setAutoStart(true)
end
_this:continueRun(nil)
end)
end


function UISubAct_yunchengtanbaoWin:isJumping()
if _this then
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local is_run=mydata.is_run
if is_run<=0 then
_this.gameisjump=false
end
end
end

function UISubAct_yunchengtanbaoWin:shaizirotation(num)
_this.isjumpbtn=true
if _this.sub_actInfo:isInAuto()then
_this.autoImg:setChildCanvasGroupAlpha(0)
end
if not _this.skipFlag then
_this.winlua:SetChildShowEffect(_this.saiziEffect:getID(),10561,true)
_this.shaiziTimer=_this:delayDo(0.2,function()
if not _this then return end
if num==1 then
_this.winlua:SetChildShowEffect(_this.saiziEffect2:getID(),10565,true)
elseif num==2 then
_this.winlua:SetChildShowEffect(_this.saiziEffect2:getID(),10566,true)
elseif num==3 then
_this.winlua:SetChildShowEffect(_this.saiziEffect2:getID(),10567,true)
elseif num==4 then
_this.winlua:SetChildShowEffect(_this.saiziEffect2:getID(),10568,true)
elseif num==5 then
_this.winlua:SetChildShowEffect(_this.saiziEffect2:getID(),10569,true)
elseif num==6 then
_this.winlua:SetChildShowEffect(_this.saiziEffect2:getID(),10570,true)
end
end)
_this.shaiziTimer2=_this:delayDo(3.3,function()
self:shaizirotationRefreshMove()
end)
_this:delayDo(4,function()
if _this.sub_actInfo:isInAuto()then
_this.autoImg:setChildCanvasGroupDOFade(1,0.5,nil)
else
_this.autoImg:setChildCanvasGroupAlpha(0)
end
_this.isjumpbtn=false
end)
else
if not _this then return end
if num==1 then
_this.winlua:SetChildShowEffect(_this.saiziEffect2:getID(),10600,true)
elseif num==2 then
_this.winlua:SetChildShowEffect(_this.saiziEffect2:getID(),10601,true)
elseif num==3 then
_this.winlua:SetChildShowEffect(_this.saiziEffect2:getID(),10602,true)
elseif num==4 then
_this.winlua:SetChildShowEffect(_this.saiziEffect2:getID(),10603,true)
elseif num==5 then
_this.winlua:SetChildShowEffect(_this.saiziEffect2:getID(),10604,true)
elseif num==6 then
_this.winlua:SetChildShowEffect(_this.saiziEffect2:getID(),10605,true)
end
_this.shaiziTimer3=_this:delayDo(0.6,function()
if not _this then return end
if _this.sub_actInfo:isInAuto()then
_this.autoImg:setChildCanvasGroupDOFade(1,0.5,nil)
else
_this.autoImg:setChildCanvasGroupAlpha(0)
end
_this.winlua:SetChildShowEffect(_this.saiziEffect2:getID(),-1,false)
_this:shaizirotationRefreshMove()
_this.isjumpbtn=false
end)
end
end

function UISubAct_yunchengtanbaoWin:shaizirotationRefreshMove()
_this:delayDo(0.2,function()

_this:handelRun()
_this:refreshQuanNun()
_this:refreshShaiZiNum()
local data=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
if data.effect_list and#data.effect_list>0 then
local win=UIManager:findActiveWindow('UIYCTBTipsWin')
if win then
win:refreshinfo()
end
else
local win=UIManager:findActiveWindow('UIYCTBTipsWin')
if win then
win:closeSelf()
end
end
end)
end

function UISubAct_yunchengtanbaoWin.on_item_changed(changeType,itemguid,itemid,oldVal,newVal)
if itemid==10584 or itemid==10585 or itemid==10586 or itemid==10587 or itemid==10591 or itemid==10593 or itemid==10594 then

if _this and not _this.isonhide then
_this:refreshDaojuList()
_this:refreshShaiZiNum()
end
end
if itemid==10584 then
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,_this.subType)
end
end


function UISubAct_yunchengtanbaoWin:refreshSkipBtn()
if _this.skipFlag==nil then
local flag=userActorSetting.get('yunchengtanbaoWin_Setup',false)
_this.skipFlag=flag
end
_this.skipSelectImg:setActive(self.skipFlag)
end
function UISubAct_yunchengtanbaoWin:onSkipBtn()
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local is_run=mydata.is_run
if is_run>0 or _this.isjumpbtn then
return
end
local autoMode=_this.sub_actInfo:isInAuto()
if autoMode then
UIManager.info("请先取消自动探宝")
return
end
local flag=userActorSetting.get('yunchengtanbaoWin_Setup',false)
flag=not flag
_this.skipFlag=flag
userActorSetting.set('yunchengtanbaoWin_Setup',flag)
userActorSetting.flush()
self:refreshSkipBtn()
end


function UISubAct_yunchengtanbaoWin:onStartAutoButton()
if _this.isgetbtn then
return
end
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local free_times=mydata.free_times
local num=bagControl.invokeFuncByItemId(_this._costid,'getItemCountByItemID',_this._costid)
if(_this._cfg_free_times<=free_times)and(num<=0)then
UIManager.error('云城宝骰不足')
self:showWindow('UIDialougeYCTBbuy',{actID=_this.actID,subType=_this.subType,subid=_this.subid,parentwin=_this})
return
end
local is_run=mydata.is_run
if is_run>0 then
UIManager.error('当前处于跳跃状态中，无法操作')
return
else
self:setAutoMode(true)
UIManager.info("开始自动探宝")
end
end
function UISubAct_yunchengtanbaoWin:onCancelAutoButton()
self:setAutoMode(false)
self.autoImg:setChildCanvasGroupAlpha(0)
UIManager.info("取消自动探宝")
end

function UISubAct_yunchengtanbaoWin:autoUpData()

local autoMode=_this.sub_actInfo:isInAuto()
if not autoMode then
return
end
local autoFlag=_this.sub_actInfo:isAutoStart()
if not autoFlag then
return
end
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)


local is_run=mydata.is_run
if is_run>0 or _this.isjumpbtn then
return
end
if _this.isgetbtn then
return
end
if _this.iszidong then
return
end
local free_times=mydata.free_times
local num=bagControl.invokeFuncByItemId(_this._costid,'getItemCountByItemID',_this._costid)
if(_this._cfg_free_times<=free_times)and(num<=0)then
_this:setAutoMode(false)
UIManager.error('云城宝骰不足')
self:showWindow('UIDialougeYCTBbuy',{actID=_this.actID,subType=_this.subType,subid=_this.subid,parentwin=_this})
return
end

if not _this.isgetbtn then
_this.isgetbtn=true
_this.iszidong=true
if _this._cfg_free_times>free_times then
mydata.isTouzi=true
activitiesModel:setSubActInfoData(_this.actID,_this.subType,_this.subid,mydata)


_this:checkIsJump()
else
if num and num>0 then
mydata.isTouzi=true
activitiesModel:setSubActInfoData(_this.actID,_this.subType,_this.subid,mydata)


_this:checkIsJump()
end
end
end
end

function UISubAct_yunchengtanbaoWin:setAutoMode(flag)
if self then
if self.sub_actInfo then
self.sub_actInfo:setAutoMode(flag)
self.sub_actInfo:setAutoStart(flag)
end
if flag then
self:startAutoTimer()
else
self:stopAutoTimer()
self.autoImg:setChildCanvasGroupAlpha(0)
end



self.startAutoButton:setActive(not flag)
self.cancelAutoButton:setActive(flag)
end
end
function UISubAct_yunchengtanbaoWin:stopAutoTimer()
if _this.autoTimer then
_this:stopTimerByID(_this.autoTimer)
_this.autoTimer=nil
end
end
function UISubAct_yunchengtanbaoWin:startAutoTimer()
_this:stopAutoTimer()
_this:autoUpData()
local tempTimer=_this:setTimer(1.5,0,function()
_this:autoUpData()
end)
_this.autoTimer=tempTimer
end



function UISubAct_yunchengtanbaoWin:checkIsDJJump()
if _this.skipFlag then
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local allget_state=false
local effect_list=mydata.effect_list or{}
if#effect_list>0 then
for k,v in ipairs(effect_list)do
if v==3 then
allget_state=true
break
end
end
end
if allget_state then
return 0
else
return 1
end
else
return 0
end
end

function UISubAct_yunchengtanbaoWin:checkIsJump()
if _this.skipFlag then
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local allget_state=false
local effect_list=mydata.effect_list or{}
if#effect_list>0 then
for k,v in ipairs(effect_list)do
if v==3 then
allget_state=true
break
end
end
end
if allget_state then
local json_str=jsonHelper.encode({1,0})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
else
local json_str=jsonHelper.encode({1,1})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
end
else
local json_str=jsonHelper.encode({1,0})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
end
end

function UISubAct_yunchengtanbaoWin:jumphandelRun(oldcircle_num)
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)

local next_current_grid=mydata.current_grid+1
_this.gameisjump=true
_this:ShowGridImg(_this.now_grid)
_this.iszidong=false
_this.isgetbtnTimer=nil
_this.isgetbtn=true
local actID=_this.actID
local subType=_this.subType
local subid=_this.subid

local oldquan=mydata.oldcircle_num or mydata.circle_num
local nowquan=mydata.circle_num

if nowquan>oldquan then
if _this.sub_actInfo and _this.sub_actInfo:isInAuto()then
_this.sub_actInfo:setAutoStart(false)
end
local startCallback=function()
if _this==nil then return end
self:SetGridState()
self:OnStartrefreshMapInfo()
self:refreshQuanNun()
self:refreshShaiZiNum()
self:continueRun()
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
local endCallback=function()
if _this==nil then return end
local sub_actInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if sub_actInfo and sub_actInfo:isInAuto()then
sub_actInfo:setAutoStart(true)
end
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback,endCallback=endCallback})
end


_this.spine_player:setChildCanvasGroupDOFade(0,0.4,function()
local Transform=_this.spine_player:getTransform()
if next_current_grid==12 or next_current_grid==13 or next_current_grid==14 then
Transform:SetSiblingIndex(18)
elseif next_current_grid==15 then
Transform:SetSiblingIndex(19)
else
Transform:SetSiblingIndex(next_current_grid)
end
local grid=_this.grids[next_current_grid]:getChildWidgetBase()
local griddata=_this.gridstate[next_current_grid]
local nowpos=grid:GetChildPosition(gridinex_pos[griddata.state])
_this.spine_player:setChildPosition(Vector3.New(nowpos.x,nowpos.y,nowpos.z))

if _this.playrightindex[next_current_grid]then
_this.spine_player:setChildUIModelShowFlipX(true)
else
_this.spine_player:setChildUIModelShowFlipX(false)
end
_this.winlua:SetChildShowEffect(_this.preffect:getID(),3,true)
end)


_this:delayDo(0.8,function()
_this.spine_player:setChildCanvasGroupDOFade(1,0.4,function()
self:reachNormalGridindex(next_current_grid)
self:reachTargetGridindex(next_current_grid)
_this.now_grid=next_current_grid
self:HideGridImg(_this.now_grid)
self:isJumping()
end)
end)

_this.isgetbtnTimer=_this:delayDo(2,function()
if _this==nil then return end
_this.isgetbtnTimer=nil
_this.isgetbtn=false
end)
end



function UISubAct_yunchengtanbaoWin:testttt(idx)
local Transform=_this.spine_player:getTransform()
Transform:SetSiblingIndex(idx)
end

function UISubAct_yunchengtanbaoWin:testtttt2(yw)
_this.winlua:SetChildShowEffect(_this.preffect:getID(),yw,true)
_this:delayDo(1,function()
if not _this then return end
_this.winlua:SetChildShowEffect(_this.preffect:getID(),-1,false)
end)
end



function UISubAct_yunchengtanbaoWin:refreshIsShowReddotBtn()
local actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
local isForbiddenShowReddot=actInfo:checkIsForbiddenShowReddot()
self.isShowReddotBtn:setActive(not isForbiddenShowReddot)
if isForbiddenShowReddot then
return
end

local isShowReddot=actInfo:checkIsShowReddot()
local btnWidget=self.isShowReddotBtn:getWidgetBase()
btnWidget:SetChildActive(0,not isShowReddot)
btnWidget:SetChildActive(1,isShowReddot)
end

function UISubAct_yunchengtanbaoWin:onIsShowReddotBtn()
local actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
local isShowReddot=actInfo:checkIsShowReddot()
isShowReddot=not isShowReddot

actInfo:setIsShowReddot(isShowReddot)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
self:refreshIsShowReddotBtn()
end

function UISubAct_yunchengtanbaoWin.onSubActivityOverBeforeEndTime24Hour(actId,subType,subId)
if _this==nil then return end
if _this.actID==actId and _this.subType==subType and _this.subid==subId then
_this:refreshIsShowReddotBtn()
end
end

