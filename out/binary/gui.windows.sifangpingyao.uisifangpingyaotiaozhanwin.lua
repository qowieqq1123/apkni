







def_class("UISiFangPingYaotiaozhanWin",UIWindowBase)









function UISiFangPingYaotiaozhanWin:bindComponents()

self.choosepanel=UIObject.get(self,0)
self.guaiwubg=UIObject.get(self,1)
self.qiyubg=UIObject.get(self,2)
self.fazebg=UIObject.get(self,3)
self.yaowangbg=UIObject.get(self,4)
self.huifubg=UIObject.get(self,5)
self.dzfhbg=UIObject.get(self,6)
self.dzhfbg=UIObject.get(self,7)
self.gwtxt=UIText.get(self,8)
self.gwGrid=UIObject.get(self,9)
self.gwzrbtn=UIButton.get(self,10)
self.gwftbtn=UIButton.get(self,11)
self.qiyutxt=UIText.get(self,12)
self.qutxt=UIText.get(self,13)
self.qiyubtn=UIButton.get(self,14)
self.fazetxt=UIText.get(self,15)
self.fztxt=UIText.get(self,16)
self.fznobtn=UIButton.get(self,17)
self.fzchgbtn=UIButton.get(self,18)
self.ywtxt=UIText.get(self,19)
self.ywftbtn=UIButton.get(self,20)
self.huifutxt=UIText.get(self,21)
self.hftxt=UIText.get(self,22)
self.fhbtn=UIButton.get(self,23)
self.hfbtn=UIButton.get(self,24)
self.dzfhtxt=UIText.get(self,25)
self.dzfhbtn=UIButton.get(self,26)
self.dzhftxt=UIText.get(self,27)
self.dzhmsftxt=UIText.get(self,28)
self.dzhfbtn=UIButton.get(self,29)
self.teamOneGrid=UIObject.get(self,30)
self.ywGrid=UIObject.get(self,31)
self.imgbtn=UIObject.get(self,32)
self.newpanel=UIObject.get(self,33)
self.maioshu=UIText.get(self,34)
self.newpanel2=UIObject.get(self,35)
self.maioshu2=UIText.get(self,36)
self.ywtanhao=UIObject.get(self,37)

self.gwzrbtn:setButtonClick(function()self:onGwzrbtn()end)

self.gwftbtn:setButtonClick(function()self:onGwftbtn()end)

self.qiyubtn:setButtonClick(function()self:onQiyubtn()end)

self.fznobtn:setButtonClick(function()self:onFznobtn()end)

self.fzchgbtn:setButtonClick(function()self:onFzchgbtn()end)

self.ywftbtn:setButtonClick(function()self:onYwftbtn()end)

self.fhbtn:setButtonClick(function()self:onFhbtn()end)

self.hfbtn:setButtonClick(function()self:onHfbtn()end)

self.dzfhbtn:setButtonClick(function()self:onDzfhbtn()end)

self.dzhfbtn:setButtonClick(function()self:onDzhfbtn()end)



end


function UISiFangPingYaotiaozhanWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.choosepanel);self.choosepanel=nil;
_UIObject_release(self.guaiwubg);self.guaiwubg=nil;
_UIObject_release(self.qiyubg);self.qiyubg=nil;
_UIObject_release(self.fazebg);self.fazebg=nil;
_UIObject_release(self.yaowangbg);self.yaowangbg=nil;
_UIObject_release(self.huifubg);self.huifubg=nil;
_UIObject_release(self.dzfhbg);self.dzfhbg=nil;
_UIObject_release(self.dzhfbg);self.dzhfbg=nil;
_UIObject_release(self.gwtxt);self.gwtxt=nil;
_UIObject_release(self.gwGrid);self.gwGrid=nil;
_UIObject_release(self.gwzrbtn);self.gwzrbtn=nil;
_UIObject_release(self.gwftbtn);self.gwftbtn=nil;
_UIObject_release(self.qiyutxt);self.qiyutxt=nil;
_UIObject_release(self.qutxt);self.qutxt=nil;
_UIObject_release(self.qiyubtn);self.qiyubtn=nil;
_UIObject_release(self.fazetxt);self.fazetxt=nil;
_UIObject_release(self.fztxt);self.fztxt=nil;
_UIObject_release(self.fznobtn);self.fznobtn=nil;
_UIObject_release(self.fzchgbtn);self.fzchgbtn=nil;
_UIObject_release(self.ywtxt);self.ywtxt=nil;
_UIObject_release(self.ywftbtn);self.ywftbtn=nil;
_UIObject_release(self.huifutxt);self.huifutxt=nil;
_UIObject_release(self.hftxt);self.hftxt=nil;
_UIObject_release(self.fhbtn);self.fhbtn=nil;
_UIObject_release(self.hfbtn);self.hfbtn=nil;
_UIObject_release(self.dzfhtxt);self.dzfhtxt=nil;
_UIObject_release(self.dzfhbtn);self.dzfhbtn=nil;
_UIObject_release(self.dzhftxt);self.dzhftxt=nil;
_UIObject_release(self.dzhmsftxt);self.dzhmsftxt=nil;
_UIObject_release(self.dzhfbtn);self.dzhfbtn=nil;
_UIObject_release(self.teamOneGrid);self.teamOneGrid=nil;
_UIObject_release(self.ywGrid);self.ywGrid=nil;
_UIObject_release(self.imgbtn);self.imgbtn=nil;
_UIObject_release(self.newpanel);self.newpanel=nil;
_UIObject_release(self.maioshu);self.maioshu=nil;
_UIObject_release(self.newpanel2);self.newpanel2=nil;
_UIObject_release(self.maioshu2);self.maioshu2=nil;
_UIObject_release(self.ywtanhao);self.ywtanhao=nil;
end

















local _this
local gwitem=
{
iconbg=1,
image=2,
btn=3
}
local _iconAb="ui/sharedtextures/uiglobalspriteatlas_1.ab"
local _iconBg={
[monType.LittleMonster]="image_gwtouxiangpjk_2",
[monType.EliteMonster]="image_gwtouxiangpjk_3",
[monType.Boss]="image_gwtouxiangpjk_5",
[monType.GodAnimal]="image_gwtouxiangpjk_7",
}



function UISiFangPingYaotiaozhanWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISiFangPingYaotiaozhanWin:__delete()
self:unbindComponents()
_this=nil
end




function UISiFangPingYaotiaozhanWin:onShow(argtable,afterOnloaded)

local demons_id=SiFangPingYaoModel:getMapIdex()
local chapter_id=SiFangPingYaoModel:getZhangjieIdex()
if demons_id and demons_id~=0 then
self.ygcfg=cfg_foursideskilldemonsconfig_get(demons_id)
end

if argtable and argtable.tag then
self.parentwin=argtable.parentwin



if argtable.tag==1 then

self:fazechange()

elseif argtable.tag==2 then
local this_point_id=0
this_point_id=argtable.this_pointid

local point_data=SiFangPingYaoController:getPointJiaoHuData(this_point_id)
self.point_data=point_data
if not point_data then
logErr(FMT.fmt("传入的节点 {0} 没有返回或配置表没有数据 请前端检查{1}妖国{2}章节后端数据",this_point_id,demons_id,chapter_id))
return
end

self:handlePointFun(point_data)
end
end
end


function UISiFangPingYaotiaozhanWin:onHide()

end


function UISiFangPingYaotiaozhanWin:handlePointFun(point_data)
local point_type=point_data.point_type
if point_type==sfpyPointType.xiaoguai then
self:xiaoguaifun(point_data,sfpyPointType.xiaoguai)

elseif point_type==sfpyPointType.jingyin then
self:xiaoguaifun(point_data,sfpyPointType.jingyin)

elseif point_type==sfpyPointType.shijian then
self:shijianpanel(point_data,sfpyPointType.shijian)

elseif point_type==sfpyPointType.juqing then
self:shijianpanel(point_data,sfpyPointType.juqing)

elseif point_type==sfpyPointType.huifu then
self:huifupanel(point_data,sfpyPointType.huifu)

elseif point_type==sfpyPointType.yaowang then
self:yaowangtiaozhan(point_data,sfpyPointType.yaowang)
end
end


function UISiFangPingYaotiaozhanWin:xiaoguaifun(point_data,_sfpyPointType)
self.guaiwubg:setActive(true)
if _sfpyPointType==sfpyPointType.xiaoguai then
self.gwtxt:setText("妖兽挑战")
_this.winlua:SetChildLocalPosY(_this.gwGrid:getID(),22)
self.newpanel:setActive(true)
self.maioshu:setText("击败可获得<color=#3375c0>蓝色</color>或者<color=#6833c0>紫色</color>法则")
elseif _sfpyPointType==sfpyPointType.jingyin then
self.gwtxt:setText("精英挑战")
_this.winlua:SetChildLocalPosY(_this.gwGrid:getID(),22)
self.newpanel:setActive(true)
self.maioshu:setText("击败可获得<color=#6833c0>紫色</color>或者<color=#ca631d>橙色</color>法则")
end
if point_data.point_value==0 then
logErr(FMT.fmt("生成的节点{0},后端下发怪物id为0，需检查生成的随机点",point_data.point_id))
end
self:refreshgwlist(point_data)
end

function UISiFangPingYaotiaozhanWin:refreshgwlist(point_data)

local monsterGroupId=point_data.point_value
local mCfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroupId)
local gwlist=mCfg.monList
local newgwlist={}
for k,v in ipairs(gwlist)do
if v~=0 then
newgwlist[#newgwlist+1]=v
end
end
local len=#newgwlist
if len>0 then
_this.winlua:SetChildLayoutGroupCreateItems(_this.gwGrid:getID(),len)
local grids=_this.winlua:GetChildLayoutGroupGridList(_this.gwGrid:getID())
for i=1,len do
local gwwidget=grids[i-1]
local monsterId=newgwlist[i]
local cfg=cfgHelper.get1(cfg_monsterconfig_get,monsterId)
local monsterType=cfg.monType

self:setgwicon(gwwidget,monsterId,monsterType)
end
end
end

function UISiFangPingYaotiaozhanWin:setgwicon(item,monsterId,monsterType)
comHelper.setChildModelRawImage_monster(item,monsterId,gwitem.image,0,eHeadCenterType.eHead)
if _iconBg[monsterType]then
item:SetChildCSImageSprite(gwitem.iconbg,_iconAb,_iconBg[monsterType])
else
item:SetChildCSImageIcon(gwitem.iconbg,nil,true)
end
end

function UISiFangPingYaotiaozhanWin:onGwzrbtn()


local doing_point_id=SiFangPingYaoModel:getdoingpointid()
if doing_point_id and doing_point_id==self.point_data.point_id then
local point_data=self.point_data
local mosterGroupId=point_data.point_value
local mCfg=cfgHelper.get1(cfg_monstergroup_get,mosterGroupId)


local guidList=SiFangPingYaoController:getlivedzteamList()

local dzcountLeast=0
if guidList then
for i,v in pairs(guidList)do
local guidnum=tonumber(tostring(v))
if guidnum>0 then
dzcountLeast=dzcountLeast+1
end
end
end
local mapname=_this.ygcfg.name
local selectDiscipleCallBack=function(guidList,zhenfaId)
local tlist={}


local newdz=table.weakCopy(guidList)
local deaddz=SiFangPingYaoController:getdeaddzteamList()
if#deaddz>0 then
local idx=1
for k,v in ipairs(newdz)do
if v[1]==0 and deaddz[idx]then
v[2]=deaddz[idx]
idx=idx+1
end
end
end

for i,v in ipairs(newdz)do
table.insert(tlist,v[2])
end

SiFangPingYaoModel:setTeamChangeRecord(nil)
SiFangPingYaoModel:setTeamChangeRecord({2,point_data})
SiFangPingYaoController.send_34_52(#tlist,tlist)




local temp={}
for k,v in pairs(tlist)do
table.insert(temp,{fightPreSelectModel.teamEntityType.dizi,v})
end
local isahngzhen=SiFangPingYaoController:checkshangzhendz()
local mapId=mCfg.mapId
if isahngzhen and mCfg.secomdmapId then
mapId=mCfg.secomdmapId
end
fightLaunchController:sendFight(eBattleLaunch.sifangpingyao,temp,mapId or 0,nil,{point_data.point_id})
end
local CancelCallBack=function()
local point_id=point_data.point_id
UIFullSiFangPingYaoControl:showSiFangPingYaoMainWinNoCloud({perfightback={this_point_id=point_id}})
end

local winArgs=
{
enterTxt=mapname,
closeByCloud=true,
lockSelect=guidList,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
isHomeBattle=false,
showZhenFa=false,
editorTeam=false,
dzCountLeast=dzcountLeast,
monsterList=mCfg.monList,
groupId=mosterGroupId,
cancelCallBack=CancelCallBack,
enterCallBack=selectDiscipleCallBack,
}
fightController.showPrepareWin(fightPreSelectModel.fightType.sifangpingyao,winArgs,function(...)
end)
self:closeSelf()
else

local point_id=self.point_data.point_id


SiFangPingYaoModel:settwofight(1)
SiFangPingYaoController.send_34_65(point_id)
self:closeSelf()
end
end

function UISiFangPingYaotiaozhanWin:onGwftbtn()
local point_id=self.point_data.point_id


local doing_point_id=SiFangPingYaoModel:getdoingpointid()
if doing_point_id and doing_point_id==point_id then
local gwid=self.point_data.point_value
local func=function()

local mosterGroupId=gwid
local mcfg=cfgHelper.get(cfg_monstergroup_get,mosterGroupId)

local teamList=SiFangPingYaoController:getFSZteamList()
local temp={}
for k,v in pairs(teamList)do
table.insert(temp,{fightPreSelectModel.teamEntityType.dizi,v})
end
local isahngzhen=SiFangPingYaoController:checkshangzhendz()
local mapId=mcfg.mapId
if isahngzhen and mcfg.secomdmapId then
mapId=mcfg.secomdmapId
end
fightLaunchController:sendFight(eBattleLaunch.sifangpingyao,temp,mapId or 0,nil,{point_id})
end
loadingControl.openCloud(func,1.5)


SiFangPingYaoModel:settwofight(nil)
self:closeSelf()
else



SiFangPingYaoModel:settwofight(2)
SiFangPingYaoController.send_34_65(point_id)
self:closeSelf()
end
end


function UISiFangPingYaotiaozhanWin:shijianpanel(point_data,_sfpyPointType)
self.qiyubg:setActive(true)
if _sfpyPointType==sfpyPointType.shijian then
self.qiyutxt:setText("奇遇事件")
local str="此地似乎存在某种奇遇，然其凶吉未卜，是祸是福难以捉摸，不知会发生何种变故，必须谨慎决断"
self.qutxt:setText(str)

elseif _sfpyPointType==sfpyPointType.juqing then
self.qiyutxt:setText("主线剧情")
local str="此地似乎可察觉到一阵本地妖王的气息，或许此地就处在妖王的神识范围内，弟子们一举一动须更为小心谨慎"
self.qutxt:setText(str)
end
end

function UISiFangPingYaotiaozhanWin:onQiyubtn()
local point_id=self.point_data.point_id
local doing_point_id=SiFangPingYaoModel:getdoingpointid()
if doing_point_id and doing_point_id==point_id then
local eventData=MysteryEventListModel:get_event_by_signData(SYSTEM_DEFINE.eJiuChongTianJie1,{7,point_id})
if eventData then

UIManager:invokeUIMethod("UISiFangPingYaoMainWin","HandlePointFun",point_id)
else

SiFangPingYaoModel:setpointid(point_id)
SiFangPingYaoController.send_34_60(point_id)
end
else

SiFangPingYaoModel:setQiyuRecord(true)
SiFangPingYaoController.send_34_65(point_id)
end
self:closeSelf()
end


function UISiFangPingYaotiaozhanWin:huifupanel(point_data,_sfpyPointType)

local doing_point_id=SiFangPingYaoModel:getdoingpointid()
if doing_point_id and doing_point_id==self.point_data.point_id then
local Huifutype=SiFangPingYaoModel:gettwohuifu()
if Huifutype then

if Huifutype==1 then
self:openfuhuowin(point_data)
elseif Huifutype==2 then
self:openhuifuwin(point_data)
end
else


local deadlist=SiFangPingYaoController:getDeadteamList()

if#deadlist<=0 then
self.fhbtn:setActive(false)
self.hfbtn:setLocalPosX(0)
end
self.huifubg:setActive(true)
self.huifutxt:setText("天虚灵泉")


local point_value=point_data.point_value
local num=point_value/100
local str=FMT.fmt("天地灵力聚涌而成的灵泉，有活死人生白骨之效，可<color=#ca631d>复活</color>一名阵亡弟子，或全体弟子回复<color=#ca631d>{0}%</color>生命值",num)
self.hftxt:setText(str)
end
else
local deadlist=SiFangPingYaoController:getDeadteamList()
if#deadlist<=0 then
self.fhbtn:setActive(false)
self.hfbtn:setLocalPosX(0)
end
self.huifubg:setActive(true)
self.huifutxt:setText("天虚灵泉")
local point_value=point_data.point_value
local num=point_value/100
local str=FMT.fmt("天地灵力聚涌而成的灵泉，有活死人生白骨之效，可<color=#ca631d>复活</color>一名阵亡弟子，或全体弟子回复<color=#ca631d>{0}%</color>生命值",num)
self.hftxt:setText(str)
end
end

function UISiFangPingYaotiaozhanWin:onFhbtn()


local doing_point_id=SiFangPingYaoModel:getdoingpointid()
if doing_point_id and doing_point_id==self.point_data.point_id then
self:openfuhuowin(self.point_data)
else
SiFangPingYaoModel:settwohuifu(1)
local point_id=self.point_data.point_id
SiFangPingYaoController.send_34_65(point_id)
self:closeSelf()
end
end

function UISiFangPingYaotiaozhanWin:openfuhuowin()
self.huifubg:setActive(false)
self.dzfhbg:setActive(true)
local deadlist=SiFangPingYaoController:getDeadteamList()
self.selectidx=1
self.selectguid=deadlist[1].param_1
local len=#deadlist
if len>0 then
self.teamOneGrid:setChildLayoutGroupCreateItems(len)
local grids=self.teamOneGrid:getChildLayoutGroupGridList()
for i=1,len do
local item=grids[i-1]
local dis_guid=deadlist[i].param_1
item:SetChildActive(0,self.selectidx==i)
item:SetChildActive(1,true)
local dis_name=UIDiscipleModel:getDiscipleName(dis_guid)
item:SetChildText(4,dis_name or"")
item:SetChildButtonClick(-1,function()
if _this==nil then return end
_this:onChangeDefBtn(i,dis_guid)
end)

comHelper.setChildModelHeadIconBG(item,1,dis_guid)

comHelper.setChildModelRawImage(item,dis_guid,2,0,eHeadCenterType.eHead,nil,true)
end
end
end

function UISiFangPingYaotiaozhanWin:onChangeDefBtn(idx,dis_guid)

if self.selectidx==idx then
return
end

local grids=self.teamOneGrid:getChildLayoutGroupGridList()
if grids[idx-1]then
grids[idx-1]:SetChildActive(0,true)
end
if self.selectidx and grids[self.selectidx-1]then
grids[self.selectidx-1]:SetChildActive(0,false)
end

self.selectidx=idx
self.selectguid=dis_guid
end

function UISiFangPingYaotiaozhanWin:onDzfhbtn()
if self.selectguid then
SiFangPingYaoController.send_34_55(1,self.selectguid)
self:closeSelf()
end
end

function UISiFangPingYaotiaozhanWin:onHfbtn()


local doing_point_id=SiFangPingYaoModel:getdoingpointid()
if doing_point_id and doing_point_id==self.point_data.point_id then
self:openhuifuwin(self.point_data)
else
SiFangPingYaoModel:settwohuifu(2)
local point_id=self.point_data.point_id
SiFangPingYaoController.send_34_65(point_id)
self:closeSelf()
end
end

function UISiFangPingYaotiaozhanWin:openhuifuwin(point_data)
self.huifubg:setActive(false)
self.dzhfbg:setActive(true)
self.dzhftxt:setText("天虚灵泉")
local point_value=point_data.point_value
local num=point_value/100
local str=FMT.fmt("全体弟子回复<color=#ca631d>{0}%</color>生命值",num)
self.dzhmsftxt:setText(str)
end

function UISiFangPingYaotiaozhanWin:onDzhfbtn()
SiFangPingYaoController.send_34_55(2,int64.new('0'))
self:closeSelf()
end


function UISiFangPingYaotiaozhanWin:yaowangtiaozhan(point_data,_sfpyPointType)
self.yaowangbg:setActive(true)
local chapter_id=SiFangPingYaoModel:getZhangjieIdex()
if chapter_id==3 then
self.ywtxt:setText("妖王挑战")
else
self.ywtxt:setText("首领挑战")
_this.winlua:SetChildLocalPosY(_this.ywGrid:getID(),22)
_this.winlua:SetChildLocalPosX(_this.ywtanhao:getID(),-132)
self.newpanel2:setActive(true)
self.maioshu2:setText("击败可获得<color=#ca631d>橙色</color>法则")
end
self:refreshywlist(point_data)
end

function UISiFangPingYaotiaozhanWin:refreshywlist(point_data)
local monsterGroupId=point_data.point_value
local mCfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroupId)
local gwlist=mCfg.monList
local newgwlist={}
for k,v in ipairs(gwlist)do
if v~=0 then
newgwlist[#newgwlist+1]=v
end
end
local len=#newgwlist
if len>0 then
_this.winlua:SetChildLayoutGroupCreateItems(_this.ywGrid:getID(),len)
local grids=_this.winlua:GetChildLayoutGroupGridList(_this.ywGrid:getID())
for i=1,len do
local gwwidget=grids[i-1]
local monsterId=newgwlist[i]


local monsterType=monType.Boss
self:setgwicon(gwwidget,monsterId,monsterType)
end
end
end

function UISiFangPingYaotiaozhanWin:onYwftbtn()


local doing_point_id=SiFangPingYaoModel:getdoingpointid()
if doing_point_id and doing_point_id==self.point_data.point_id then
local chapter_id=SiFangPingYaoModel:getZhangjieIdex()
local point_data=self.point_data
local mosterGroupId=point_data.point_value
local mCfg=cfgHelper.get1(cfg_monstergroup_get,mosterGroupId)
local guidList=SiFangPingYaoController:getlivedzteamList()
local dzcountLeast=0
if guidList then
for i,v in pairs(guidList)do
local guidnum=tonumber(tostring(v))
if guidnum>0 then
dzcountLeast=dzcountLeast+1
end
end
end

local mapname=_this.ygcfg.name
local selectDiscipleCallBack=function(guidList,zhenfaId)
UIManager:closeWindow('UISFPYYWExtraWin')
local tlist={}

local newdz=table.weakCopy(guidList)
local deaddz=SiFangPingYaoController:getdeaddzteamList()
if#deaddz>0 then
local idx=1
for k,v in ipairs(newdz)do
if v[1]==0 and deaddz[idx]then
v[2]=deaddz[idx]
idx=idx+1
end
end
end

for i,v in ipairs(newdz)do
table.insert(tlist,v[2])
end

SiFangPingYaoModel:setTeamChangeRecord(nil)
SiFangPingYaoModel:setTeamChangeRecord({2,point_data})
SiFangPingYaoController.send_34_52(#tlist,tlist)

local temp={}
for k,v in pairs(tlist)do
table.insert(temp,{fightPreSelectModel.teamEntityType.dizi,v})
end
local isahngzhen=SiFangPingYaoController:checkshangzhendz()
local mapId=mCfg.mapId
if isahngzhen and mCfg.secomdmapId then
mapId=mCfg.secomdmapId
end
fightLaunchController:sendFight(eBattleLaunch.sifangpingyao,temp,mapId or 0,nil,{point_data.point_id})
SiFangPingYaoModel:settwofight(nil)
end
local CancelCallBack=function()
UIManager:closeWindow('UISFPYYWExtraWin')
local point_id=point_data.point_id
UIFullSiFangPingYaoControl:showSiFangPingYaoMainWinNoCloud({perfightback={this_point_id=point_id}})
end
local winArgs=
{
enterTxt=mapname,
closeByCloud=true,
lockSelect=guidList,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
isHomeBattle=false,
showZhenFa=false,
editorTeam=false,
dzCountLeast=dzcountLeast,
monsterList=mCfg.monList,
groupId=mosterGroupId,
cancelCallBack=CancelCallBack,
enterCallBack=selectDiscipleCallBack,
}
fightController.showPrepareWin(fightPreSelectModel.fightType.sifangpingyao,winArgs,function(...)
if chapter_id==3 and point_data.point_id==1000 then
UIFullFightPrepareControl:showWindow("UISFPYYWExtraWin")
end
end)
else

local point_id=self.point_data.point_id


SiFangPingYaoModel:settwofight(1)
SiFangPingYaoController.send_34_65(point_id)
self:closeSelf()
end
end


function UISiFangPingYaotiaozhanWin:fazechange()
self.fazebg:setActive(true)
self.fazetxt:setText("法则更换")
local str="成功击败首领，可选择任意法则<color=#ca631d>随机更换</color>为同品质的其他法则，负面法则随机更换<color=#ca631d>不受品质限制</color>"
self.fztxt:setText(str)
end

function UISiFangPingYaotiaozhanWin:onFznobtn()





local startCallback=function()
SiFangPingYaoController.send_34_54(0,0)
self:closeSelf()
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
local endCallback=function()
UIManager:invokeUIMethod("UISiFangPingYaoMainWin","showfuhuotxt")
UIManager:invokeUIMethod("UISiFangPingYaoMainWin","openNewZhangjiewin")
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback,endCallback=endCallback})
end

function UISiFangPingYaotiaozhanWin:onFzchgbtn()
if self.parentwin then
self.parentwin:showWindow("UISFPYRuleBagWin",{parentwin=self.parentwin,changefa=true})
end
end
