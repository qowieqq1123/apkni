







def_class("UIYYHYWintwo",UIWindowBase)









function UIYYHYWintwo:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.itemList2=UIObject.get(self,1)
self.content=UIText.get(self,2)
self.title=UIText.get(self,3)
self.Image2=UIObject.get(self,4)
self.Button2=UIButton.get(self,5)
self.Image3=UIObject.get(self,6)
self.zhangai1=UIObject.get(self,7)
self.zhangai2=UIObject.get(self,8)
self.fish1=UIObject.get(self,9)
self.fish2=UIObject.get(self,10)
self.yuchis=UIObject.get(self,11)
self.fish3=UIObject.get(self,12)
self.fish4=UIObject.get(self,13)
self.fish5=UIObject.get(self,14)
self.fish6=UIObject.get(self,15)
self.jifentext=UIText.get(self,16)
self.hddaojishi=UIText.get(self,17)
self.baoxiangpoint=UIObject.get(self,18)
self.stormpoint=UIObject.get(self,19)
self.onelayer1_1=UIObject.get(self,20)
self.onelayer1_2=UIObject.get(self,21)
self.onelayer1_3=UIObject.get(self,22)
self.onelayer1_4=UIObject.get(self,23)
self.onelayer2_1=UIObject.get(self,24)
self.onelayer2_2=UIObject.get(self,25)
self.onelayer2_3=UIObject.get(self,26)
self.onelayer2_4=UIObject.get(self,27)
self.twolayer1_1=UIObject.get(self,28)
self.twolayer1_2=UIObject.get(self,29)
self.twolayer1_3=UIObject.get(self,30)
self.twolayer1_4=UIObject.get(self,31)
self.twolayer2_1=UIObject.get(self,32)
self.twolayer2_2=UIObject.get(self,33)
self.twolayer2_3=UIObject.get(self,34)
self.twolayer2_4=UIObject.get(self,35)
self.threelayer1_1=UIObject.get(self,36)
self.threelayer1_2=UIObject.get(self,37)
self.threelayer1_3=UIObject.get(self,38)
self.threelayer1_4=UIObject.get(self,39)
self.threelayer2_1=UIObject.get(self,40)
self.threelayer2_2=UIObject.get(self,41)
self.threelayer2_3=UIObject.get(self,42)
self.threelayer2_4=UIObject.get(self,43)
self.fish7=UIObject.get(self,44)
self.fish8=UIObject.get(self,45)
self.fish9=UIObject.get(self,46)
self.fish10=UIObject.get(self,47)
self.fish11=UIObject.get(self,48)
self.fish12=UIObject.get(self,49)
self.fish13=UIObject.get(self,50)
self.fish14=UIObject.get(self,51)
self.fish15=UIObject.get(self,52)
self.fish16=UIObject.get(self,53)
self.fish17=UIObject.get(self,54)
self.fish18=UIObject.get(self,55)
self.fish19=UIObject.get(self,56)
self.fish20=UIObject.get(self,57)
self.fish21=UIObject.get(self,58)
self.fish22=UIObject.get(self,59)
self.fish23=UIObject.get(self,60)
self.fish24=UIObject.get(self,61)
self.fish25=UIObject.get(self,62)
self.fish26=UIObject.get(self,63)
self.fish27=UIObject.get(self,64)
self.fish28=UIObject.get(self,65)
self.fish29=UIObject.get(self,66)
self.fish30=UIObject.get(self,67)
self.fish31=UIObject.get(self,68)
self.fish32=UIObject.get(self,69)
self.rightbianjie=UIObject.get(self,70)
self.leftbianjie=UIObject.get(self,71)
self.effectWind=UIObject.get(self,72)
self.effectWindpoint=UIObject.get(self,73)
self.underbianjie=UIObject.get(self,74)
self.dingdian=UIObject.get(self,75)
self.dingdianai=UIObject.get(self,76)
self.Image2ai=UIObject.get(self,77)
self.Image3ai=UIObject.get(self,78)
self.Image4ai=UIObject.get(self,79)
self.jifentextai=UIText.get(self,80)
self.Imggouai=UIObject.get(self,81)
self.item_1=UIObject.get(self,82)
self.item_2=UIObject.get(self,83)
self.item_3=UIObject.get(self,84)
self.item_4=UIObject.get(self,85)
self.item_5=UIObject.get(self,86)
self.jianglitext=UIText.get(self,87)
self.hdtimes=UIText.get(self,88)
self.starttips=UIButton.get(self,89)
self.tiaozhantext=UIText.get(self,90)
self.addbtn=UIButton.get(self,91)
self.startbtn=UIButton.get(self,92)
self.tujianbtn=UIButton.get(self,93)
self.tujianred=UIObject.get(self,94)
self.shangdianbtn=UIButton.get(self,95)
self.shangdianred=UIObject.get(self,96)
self.mubiaobtn=UIButton.get(self,97)
self.mubiaored=UIObject.get(self,98)
self.startdizibtn=UIButton.get(self,99)
self.gamewinpanel=UIObject.get(self,100)
self.gamemainpanel=UIObject.get(self,101)
self.startpanel=UIObject.get(self,102)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.Button2:setButtonClick(function()self:onButton2()end)

self.starttips:setButtonClick(function()self:onStarttips()end)

self.addbtn:setButtonClick(function()self:onAddbtn()end)

self.startbtn:setButtonClick(function()self:onStartbtn()end)

self.tujianbtn:setButtonClick(function()self:onTujianbtn()end)

self.shangdianbtn:setButtonClick(function()self:onShangdianbtn()end)

self.mubiaobtn:setButtonClick(function()self:onMubiaobtn()end)

self.startdizibtn:setButtonClick(function()self:onStartdizibtn()end)
self.onelayer1={
self.onelayer1_1,
self.onelayer1_2,
self.onelayer1_3,
self.onelayer1_4,
}
self.onelayer2={
self.onelayer2_1,
self.onelayer2_2,
self.onelayer2_3,
self.onelayer2_4,
}
self.twolayer1={
self.twolayer1_1,
self.twolayer1_2,
self.twolayer1_3,
self.twolayer1_4,
}
self.twolayer2={
self.twolayer2_1,
self.twolayer2_2,
self.twolayer2_3,
self.twolayer2_4,
}
self.threelayer1={
self.threelayer1_1,
self.threelayer1_2,
self.threelayer1_3,
self.threelayer1_4,
}
self.threelayer2={
self.threelayer2_1,
self.threelayer2_2,
self.threelayer2_3,
self.threelayer2_4,
}
self.item={
self.item_1,
self.item_2,
self.item_3,
self.item_4,
self.item_5,
}



end


function UIYYHYWintwo:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.itemList2);self.itemList2=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.Image2);self.Image2=nil;
_UIObject_release(self.Button2);self.Button2=nil;
_UIObject_release(self.Image3);self.Image3=nil;
_UIObject_release(self.zhangai1);self.zhangai1=nil;
_UIObject_release(self.zhangai2);self.zhangai2=nil;
_UIObject_release(self.fish1);self.fish1=nil;
_UIObject_release(self.fish2);self.fish2=nil;
_UIObject_release(self.yuchis);self.yuchis=nil;
_UIObject_release(self.fish3);self.fish3=nil;
_UIObject_release(self.fish4);self.fish4=nil;
_UIObject_release(self.fish5);self.fish5=nil;
_UIObject_release(self.fish6);self.fish6=nil;
_UIObject_release(self.jifentext);self.jifentext=nil;
_UIObject_release(self.hddaojishi);self.hddaojishi=nil;
_UIObject_release(self.baoxiangpoint);self.baoxiangpoint=nil;
_UIObject_release(self.stormpoint);self.stormpoint=nil;
_UIObject_release(self.onelayer1_1);self.onelayer1_1=nil;
_UIObject_release(self.onelayer1_2);self.onelayer1_2=nil;
_UIObject_release(self.onelayer1_3);self.onelayer1_3=nil;
_UIObject_release(self.onelayer1_4);self.onelayer1_4=nil;
_UIObject_release(self.onelayer2_1);self.onelayer2_1=nil;
_UIObject_release(self.onelayer2_2);self.onelayer2_2=nil;
_UIObject_release(self.onelayer2_3);self.onelayer2_3=nil;
_UIObject_release(self.onelayer2_4);self.onelayer2_4=nil;
_UIObject_release(self.twolayer1_1);self.twolayer1_1=nil;
_UIObject_release(self.twolayer1_2);self.twolayer1_2=nil;
_UIObject_release(self.twolayer1_3);self.twolayer1_3=nil;
_UIObject_release(self.twolayer1_4);self.twolayer1_4=nil;
_UIObject_release(self.twolayer2_1);self.twolayer2_1=nil;
_UIObject_release(self.twolayer2_2);self.twolayer2_2=nil;
_UIObject_release(self.twolayer2_3);self.twolayer2_3=nil;
_UIObject_release(self.twolayer2_4);self.twolayer2_4=nil;
_UIObject_release(self.threelayer1_1);self.threelayer1_1=nil;
_UIObject_release(self.threelayer1_2);self.threelayer1_2=nil;
_UIObject_release(self.threelayer1_3);self.threelayer1_3=nil;
_UIObject_release(self.threelayer1_4);self.threelayer1_4=nil;
_UIObject_release(self.threelayer2_1);self.threelayer2_1=nil;
_UIObject_release(self.threelayer2_2);self.threelayer2_2=nil;
_UIObject_release(self.threelayer2_3);self.threelayer2_3=nil;
_UIObject_release(self.threelayer2_4);self.threelayer2_4=nil;
_UIObject_release(self.fish7);self.fish7=nil;
_UIObject_release(self.fish8);self.fish8=nil;
_UIObject_release(self.fish9);self.fish9=nil;
_UIObject_release(self.fish10);self.fish10=nil;
_UIObject_release(self.fish11);self.fish11=nil;
_UIObject_release(self.fish12);self.fish12=nil;
_UIObject_release(self.fish13);self.fish13=nil;
_UIObject_release(self.fish14);self.fish14=nil;
_UIObject_release(self.fish15);self.fish15=nil;
_UIObject_release(self.fish16);self.fish16=nil;
_UIObject_release(self.fish17);self.fish17=nil;
_UIObject_release(self.fish18);self.fish18=nil;
_UIObject_release(self.fish19);self.fish19=nil;
_UIObject_release(self.fish20);self.fish20=nil;
_UIObject_release(self.fish21);self.fish21=nil;
_UIObject_release(self.fish22);self.fish22=nil;
_UIObject_release(self.fish23);self.fish23=nil;
_UIObject_release(self.fish24);self.fish24=nil;
_UIObject_release(self.fish25);self.fish25=nil;
_UIObject_release(self.fish26);self.fish26=nil;
_UIObject_release(self.fish27);self.fish27=nil;
_UIObject_release(self.fish28);self.fish28=nil;
_UIObject_release(self.fish29);self.fish29=nil;
_UIObject_release(self.fish30);self.fish30=nil;
_UIObject_release(self.fish31);self.fish31=nil;
_UIObject_release(self.fish32);self.fish32=nil;
_UIObject_release(self.rightbianjie);self.rightbianjie=nil;
_UIObject_release(self.leftbianjie);self.leftbianjie=nil;
_UIObject_release(self.effectWind);self.effectWind=nil;
_UIObject_release(self.effectWindpoint);self.effectWindpoint=nil;
_UIObject_release(self.underbianjie);self.underbianjie=nil;
_UIObject_release(self.dingdian);self.dingdian=nil;
_UIObject_release(self.dingdianai);self.dingdianai=nil;
_UIObject_release(self.Image2ai);self.Image2ai=nil;
_UIObject_release(self.Image3ai);self.Image3ai=nil;
_UIObject_release(self.Image4ai);self.Image4ai=nil;
_UIObject_release(self.jifentextai);self.jifentextai=nil;
_UIObject_release(self.Imggouai);self.Imggouai=nil;
_UIObject_release(self.item_1);self.item_1=nil;
_UIObject_release(self.item_2);self.item_2=nil;
_UIObject_release(self.item_3);self.item_3=nil;
_UIObject_release(self.item_4);self.item_4=nil;
_UIObject_release(self.item_5);self.item_5=nil;
_UIObject_release(self.jianglitext);self.jianglitext=nil;
_UIObject_release(self.hdtimes);self.hdtimes=nil;
_UIObject_release(self.starttips);self.starttips=nil;
_UIObject_release(self.tiaozhantext);self.tiaozhantext=nil;
_UIObject_release(self.addbtn);self.addbtn=nil;
_UIObject_release(self.startbtn);self.startbtn=nil;
_UIObject_release(self.tujianbtn);self.tujianbtn=nil;
_UIObject_release(self.tujianred);self.tujianred=nil;
_UIObject_release(self.shangdianbtn);self.shangdianbtn=nil;
_UIObject_release(self.shangdianred);self.shangdianred=nil;
_UIObject_release(self.mubiaobtn);self.mubiaobtn=nil;
_UIObject_release(self.mubiaored);self.mubiaored=nil;
_UIObject_release(self.startdizibtn);self.startdizibtn=nil;
_UIObject_release(self.gamewinpanel);self.gamewinpanel=nil;
_UIObject_release(self.gamemainpanel);self.gamemainpanel=nil;
_UIObject_release(self.startpanel);self.startpanel=nil;
self.onelayer1=nil;
self.onelayer2=nil;
self.twolayer1=nil;
self.twolayer2=nil;
self.threelayer1=nil;
self.threelayer2=nil;
self.item=nil;
end
















local itemCmp={
owner=-1,
select=0,
name=1,
}
local _this=nil

local state=
{
Rock=1,
Stretch=2,
Shorten=3
}
local _state=state.Rock
local _state_fisher=state.Rock
local dir=Vector3.back
local dir2=0
local ai_dir2=0
local speed=1.5
local ai_speed=2
local game_time=1

local ropelenght=1
local ai_ropelenght=1
local vector3_dir=Vector3.New(0,0,0)
local ropeSpeed_out=5
local ropeSpeed_back=3.8
local ai_ropeSpeed_out=0.1
local ai_ropeSpeed_back=0.1

local ropeSpeed_back_arry={3,3.2,3.8,4}



local fishLayer=
{
layer_one=1,
layer_two=2,
layer_three=3,
}

local changePoints=
{
[1]={{1,2}},
}


local fishstage=
{
bitted=1,
swimming=2,
ice=3,
}

local fishNum=20


local fish_layer_num=
{
2,2,2
}

local fish_layer_genrate_num=
{
3,3,3
}


local jifen=0
local jifens=
{
100,500,600,700,1000
}


local itemsTag=
{
ice=1,
storm=2,
}


local gameitemstage=
{
normal=1,
ice=2,
storm=3,
}


local game_ice_time=0

local game_storm_time=0

local game_time=360
local temp_time=0


local genratelayernum={6,6,6}
local genrateNum=5


local speedarry={0.05,0.06,0.07,0.08,0.09,0.1}


local fishColor={green='#17D924',bule='#0B55F8',purple='#8100FF',orange='#FF6A00',red='#D91736',}

local layer_one_color=
{
{fishColor.green,fishColor.bule},
{fishColor.green,fishColor.bule,fishColor.orange},
{fishColor.red,fishColor.orange},
}


local Fish_PerfabWidth={5,6,7,8}
local Fish_PerfabHeight={25,30,35,40,45,50,55}


local wind_speed=0.1


local IsStormAnimPlay=false


local FisherAI_speed_k=0.1
local dir_x=0
local dir_y=0

local FisherAI_look_fishid=1

local fish_gou_width=30
local fish_gou_hight=20
local fish_width_hight_volume=0.1

local fish_gou_attack_range=0.8

local fishigou_pos_new_test
local fish_go_rightpos
local fish_go_leftpos

local ai_rope_lenght_max=4
local ai_rope_lenght=1

local fish_bite_probability=7
local fish_bite_out_timesArry={2,4,6}
local fish_bite_out_times=0
local fish_bite_IsOut=false

local fishcolors=
{
[1]='普通',
[2]='稀有',
[3]='奇珍',
[4]='异种',
[5]='神品',
}



local _AppConfig_GetBool=CS.AppDataModel.AppConfig_GetBool


function UIYYHYWintwo:onLoaded(...)
self:bindComponents()
self.defaultIdx=1
_this=self
self.yugou=CS.UIHelper.FindRectTransform(self.gameObject,"root/#Image")
self._transform=self.Image2:getTransform()
self._transformgogo=self.Image3:getTransform()
self._transform_ai=self.Image2ai:getTransform()
self._transformgogo_ai=self.Image3ai:getTransform()

self.fish_data_list=UIYYHYWintwo:FishDataList()
self.items_data_list=UIYYHYWintwo:ItemDataList()
self.fish_bitted_data_list={}
self.fish_ai_bitted_data_list={}

self.fish_pfb_list={self.fish5,self.fish6,self.fish4,self.fish3,self.fish1,self.fish2,self.fish7,
self.fish8,self.fish9,self.fish10,self.fish11,self.fish12,self.fish13,self.fish13,
self.fish14,self.fish15,self.fish16,self.fish17,self.fish18,self.fish19,self.fish20,
self.fish21,self.fish22,self.fish23,self.fish24,self.fish25,self.fish26,self.fish27,
self.fish28,self.fish29,self.fish30,self.fish31,self.fish32,}
self.itemslist={self.baoxiangpoint,self.stormpoint}

self.zhangaiperfab={self.zhangai1,self.zhangai2}
self.yutong_pos=_this.yuchis:getChildPosition()


self.genratePoint=
{
{self.onelayer1_2,self.onelayer1_3,self.onelayer1_4,self.onelayer2_2,self.onelayer2_3,self.onelayer2_4},
{self.twolayer1_2,self.twolayer1_3,self.twolayer1_4,self.twolayer2_2,self.twolayer2_3,self.twolayer2_4},
{self.threelayer1_2,self.threelayer1_3,self.threelayer1_4,self.threelayer2_2,self.threelayer2_3,self.threelayer2_4}
}

_this.winlua:SetChildText(self.jifentext:getID(),0)
_this.winlua:SetChildText(self.jifentextai:getID(),0)
self.gameItemStage=1
self.itemsGenratePoint={}

self.fish_all_pfbNum={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32}
self.fish_temp_pfbNum={}
self.fishs_yuchi_pfbNu={1,2,3,4,5,6}

self.layerByOneNum=0
self.layerByTwoNum=0
self.layerByThreeNum=0

self.rightbianjie_pos=_this.rightbianjie:getChildPosition()
self.leftbianjie_pos=_this.leftbianjie:getChildPosition()
self.underbianjie_pos=_this.underbianjie:getChildPosition()

self.stormPoint_pos=_this.effectWindpoint:getChildPosition()

end


function UIYYHYWintwo:__delete()
self:unbindComponents()
self:stopCheckTimer()
end




function UIYYHYWintwo:onShow(argtable,afterOnloaded)
self.isFull=argtable.isFull
_this.YYHYGameStage=YYHYGameState.preparation

_this.startpanel:setActive(true)
_this.gamewinpanel:setActive(false)
_this.gamemainpanel:setActive(false)
_this.Button2:setActive(false)
UIYYHYWintwo:refreshcenterPanel()
UIYYHYWintwo:refreshleftPanel()
UIYYHYWintwo:refreshrightPanel()

self.yugan_player_level=1
self.yugou_player_level=1
self.yuxian_player_level=1
self.player_power=1
self.player_line=1
self.player_yugou_range=0.5
self.can_player_jisuiWp_num=1
self.can_player_qiangYu_num=1

self.yugan_ai_level=1
self.yugou_ai_level=1
self.yuxian_ai_level=1
self.ai_power=1
self.ai_line=1
self.ai_yugou_range=0.5
self.can_ai_jisuiWp_num=1
self.can_ai_qiangYu_num=1

UIYYHYWintwo:UpdateView()
UIYYHYWintwo:UpdateView_two()
end


function UIYYHYWintwo:onHide()

end




function UIYYHYWintwo:onCloseBtn()

if self.isFull then
UIFullCommonControl:closeUI()
else
self:closeSelf()
end
end

function UIYYHYWintwo:onfresh(isSuccess,info)
if not isSuccess then return end
self:freshLeftList()
self:onSelect(self.defaultIdx)
end

function UIYYHYWintwo:freshInfo()
self:freshLeftList()
self:freshRight()
end

function UIYYHYWintwo:freshLeftList()
local dataList=gonggaoModel.getData()
self.itemList:setChildLayoutGroupCreateItems(#dataList,function(idx)
local index=idx
local info=dataList[index]
local item=self.itemList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(itemCmp.select,self.selectIdx==index)
item:SetChildText(itemCmp.name,info.title)
item:SetChildButtonClickWithID(itemCmp.owner,function(...)
self:onSelect(...)
end,index)
end)
end

function UIYYHYWintwo:onSelect(index)
if index==self.selectIdx then return end

local lastIdx=self.selectIdx
self.selectIdx=index


if lastIdx then
local item=self.itemList:getChildLayoutGroupGridItem(lastIdx-1)
item:SetChildActive(itemCmp.select,false)
end
local item=self.itemList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(itemCmp.select,true)

self:freshRight()
end

function UIYYHYWintwo:freshRight()
if self.selectIdx==nil then return end
local data=gonggaoModel.getDataByIndex(self.selectIdx)
self.content:setText(data.content)
self.title:setText(data.title)
end


function UIYYHYWintwo:stopCheckTimer()
if self.checkTime then
self:stopTimerByID(self.checkTime)
end
self.checkTime=nil
if self.refreshTimeId then
self:stopTimerByID(self.refreshTimeId)
self.refreshTimeId=nil
end
if self.refreshTimeTwoId then
self:stopTimerByID(self.refreshTimeTwoId)
self.refreshTimeTwoId=nil
end
end






function UIYYHYWintwo:Rock()

if _state==state.Rock then















if dir2>=60 then
speed=-speed
elseif dir2<=-60 then
speed=-speed
end
dir2=dir2+speed
_this.Image2:setRotation(0,0,dir2)


end
end


function UIYYHYWintwo:Stretch()
if ropelenght>=5 then
_state=state.Shorten
return
end

ropelenght=ropelenght+Time.deltaTime*ropeSpeed_out

_this._transform.localScale=Vector3.New(_this._transform.localScale.x,ropelenght,_this._transform.localScale.z)
_this._transformgogo.localScale=Vector3.New(_this._transformgogo.localScale.x,1/ropelenght,_this._transformgogo.localScale.z)

end


function UIYYHYWintwo:Shorten()
if ropelenght<=1 then
ropelenght=1
_state=state.Rock
return
end
ropelenght=ropelenght-Time.deltaTime*ropeSpeed_back

_this._transform.localScale=Vector3.New(_this._transform.localScale.x,ropelenght,_this._transform.localScale.z)
_this._transformgogo.localScale=Vector3.New(_this._transformgogo.localScale.x,1/ropelenght,_this._transformgogo.localScale.z)

end







function UIYYHYWintwo:FishsGenrateByGameStart()




_this.fishs_yuchi_pfbNu=_this.fish_all_pfbNum
for k,v in ipairs(_this.fishs_yuchi_pfbNu)do
_this.fishs_yuchi_pfbNu[k]=0
end
for k,v in ipairs(_this.fish_data_list)do
if v.fishid then
_this.fishs_yuchi_pfbNu[v.fishid]=v.fishid
end















end


fishigou_pos_new_test=_this.dingdianai:getChildPosition()
local num=(ai_rope_lenght_max-ai_rope_lenght)/ai_ropeSpeed_out
local fishgou_dingdian_pos=fishigou_pos_new_test
local fishgou_ai_center_pos=_this.Imggouai:getChildPosition()
local dir_xy=math.abs(fishgou_dingdian_pos.y-fishgou_ai_center_pos.y)*FisherAI_speed_k

local new_x=fishgou_ai_center_pos.x+dir_xy*num
local new_y=fishgou_ai_center_pos.y-dir_xy*num
fish_go_rightpos=Vector3.New(new_x,fishgou_ai_center_pos.y,fishgou_ai_center_pos.z)
fish_go_leftpos=Vector3.New(fishgou_ai_center_pos.x,new_y,fishgou_ai_center_pos.z)



if fish_bite_out_times==0 then
local time_index=math.random(1,#fish_bite_out_timesArry)
fish_bite_out_times=fish_bite_out_timesArry[time_index]
end

end



function UIYYHYWintwo:WaterObjGenrate()



local waterobj_list=YiYuHuiYouModel:gettWaterObjectData()
local waterobj_fish_genrates={{1,2},{3,4},{5,6}}
local waterobj_item_genrates={{1,2},{3,4},{5,6}}
local waterobj_item_baoxiang_genrates={1,2}


local fish_layer1=0
local fish_layer2=0
local fish_layer3=0
local fish_pfbid_layer1={}
local fish_pfbid_layer2={}
local fish_pfbid_layer3={}

local item_layer1
local item_layer2
local item_layer3
local item_pfbid_layer1={}
local item_pfbid_layer2={}
local item_pfbid_layer3={}


for k,v in ipairs(waterobj_list)do

if v.waterObj_type==YYHYWaterObjectType.normal_fish then
if v.fish_layerNum==YYHYLayoutType.first then
fish_layer1=fish_layer1+1
fish_pfbid_layer1[#fish_pfbid_layer1+1]=v.fish_pfb_id
elseif v.fish_layerNum==YYHYLayoutType.second then
fish_layer2=fish_layer2+1
fish_pfbid_layer2[#fish_pfbid_layer2+1]=v.fish_pfb_id
elseif v.fish_layerNum==YYHYLayoutType.third then
fish_layer3=fish_layer3+1
fish_pfbid_layer3[#fish_pfbid_layer3+1]=v.fish_pfb_id
end
end


if v.waterObj_type==YYHYWaterObjectType.ice_item or v.waterObj_type==YYHYWaterObjectType.storm_item or v.waterObj_type==YYHYWaterObjectType.normal_item then

if v.fish_layerNum==YYHYLayoutType.first then
item_layer1=item_layer1+1
item_pfbid_layer1[#item_pfbid_layer1+1]=v.fish_pfb_id
elseif v.fish_layerNum==YYHYLayoutType.second then
item_layer2=item_layer2+1
item_pfbid_layer2[#item_pfbid_layer2+1]=v.fish_pfb_id
elseif v.fish_layerNum==YYHYLayoutType.third then
item_layer3=item_layer3+1
item_pfbid_layer3[#item_pfbid_layer3+1]=v.fish_pfb_id
end
end


if v.waterObj_type==YYHYWaterObjectType.baoxiang_item then
local genrateEntity=waterobj_item_baoxiang_genrates
local fishpos=genrateEntity:getChildPosition()
_this.fish_pfb_list[v.fish_pfb_id]:setChildPosition(Vector3.New(fishpos.x,fishpos.y,fishpos.z))
end
end


local list_1={}
local list_1_temp={}
if fish_layer1>0 then
local num=#waterobj_fish_genrates[YYHYLayoutType.first]
for i=1,fish_layer1 do
local r=math.random(1,num)
local a=r
if list_1_temp[r]then
a=list_1_temp[r]
end
table.insert(list_1,a)
list_1_temp[r]=list_1_temp[i]or i
end
end


local list_2={}
local list_2_temp={}
if fish_layer2>0 then
local num=#waterobj_fish_genrates[YYHYLayoutType.second]
for i=1,fish_layer2 do
local r=math.random(1,num)
local a=r
if list_2_temp[r]then
a=list_2_temp[r]
end
table.insert(list_2,a)
list_2_temp[r]=list_2_temp[i]or i
end
end


local list_3={}
local list_3_temp={}
if fish_layer3>0 then
local num=#waterobj_fish_genrates[YYHYLayoutType.third]
for i=1,fish_layer3 do
local r=math.random(1,num)
local a=r
if list_3_temp[r]then
a=list_3_temp[r]
end
table.insert(list_3,a)
list_3_temp[r]=list_3_temp[i]or i
end
end


if#list_1>0 then
for k,v in ipairs(list_1)do
local genrateEntity=waterobj_fish_genrates[YYHYLayoutType.first][v]
local fishpos=genrateEntity:getChildPosition()
_this.fish_pfb_list[fish_pfbid_layer1[k]]:setChildPosition(Vector3.New(fishpos.x,fishpos.y,fishpos.z))
end
end


if#list_2>0 then
for k,v in ipairs(list_2)do
local genrateEntity=waterobj_fish_genrates[YYHYLayoutType.second][v]
local fishpos=genrateEntity:getChildPosition()
_this.fish_pfb_list[fish_pfbid_layer2[k]]:setChildPosition(Vector3.New(fishpos.x,fishpos.y,fishpos.z))
end
end


if#list_3>0 then
for k,v in ipairs(list_3)do
local genrateEntity=waterobj_fish_genrates[YYHYLayoutType.third][v]
local fishpos=genrateEntity:getChildPosition()
_this.fish_pfb_list[fish_pfbid_layer3[k]]:setChildPosition(Vector3.New(fishpos.x,fishpos.y,fishpos.z))
end
end


local list_item_1={}
local list_item_1_temp={}
if item_layer1>0 then
local num=#waterobj_item_genrates[YYHYLayoutType.first]
for i=1,item_layer1 do
local r=math.random(1,num)
local a=r
if list_item_1_temp[r]then
a=list_item_1_temp[r]
end
table.insert(list_item_1,a)
list_item_1_temp[r]=list_item_1_temp[i]or i
end
end

local list_item_2={}
local list_item_2_temp={}
if item_layer2>0 then
local num=#waterobj_item_genrates[YYHYLayoutType.second]
for i=1,item_layer2 do
local r=math.random(1,num)
local a=r
if list_item_2_temp[r]then
a=list_item_2_temp[r]
end
table.insert(list_item_2,a)
list_item_2_temp[r]=list_item_2_temp[i]or i
end
end

local list_item_3={}
local list_item_3_temp={}
if item_layer3>0 then
local num=#waterobj_item_genrates[YYHYLayoutType.third]
for i=1,item_layer3 do
local r=math.random(1,num)
local a=r
if list_item_3_temp[r]then
a=list_item_3_temp[r]
end
table.insert(list_item_3,a)
list_item_3_temp[r]=list_item_3_temp[i]or i
end
end


if#list_item_1>0 then
for k,v in ipairs(list_item_1)do
local genrateEntity=waterobj_item_genrates[YYHYLayoutType.first][v]
local fishpos=genrateEntity:getChildPosition()
_this.fish_pfb_list[item_pfbid_layer1[k]]:setChildPosition(Vector3.New(fishpos.x,fishpos.y,fishpos.z))
end
end

if#list_item_2>0 then
for k,v in ipairs(list_item_2)do
local genrateEntity=waterobj_item_genrates[YYHYLayoutType.second][v]
local fishpos=genrateEntity:getChildPosition()
_this.fish_pfb_list[item_pfbid_layer2[k]]:setChildPosition(Vector3.New(fishpos.x,fishpos.y,fishpos.z))
end
end

if#list_item_3>0 then
for k,v in ipairs(list_item_3)do
local genrateEntity=waterobj_item_genrates[YYHYLayoutType.third][v]
local fishpos=genrateEntity:getChildPosition()
_this.fish_pfb_list[item_pfbid_layer3[k]]:setChildPosition(Vector3.New(fishpos.x,fishpos.y,fishpos.z))
end
end


end


function UIYYHYWintwo:RefreshWaterObjGenrate(newWaterObj_Data)

local layerlist_1={}
local layerlist_2={}
local layerlist_3={}
for k,v in ipairs(newWaterObj_Data)do
local config=cfgHelper.get1(cfg_yiyuhuiyouitemconfig_get,v)
if config.layer_id==YYHYLayoutType.first then
layerlist_1[#layerlist_1+1]=v
elseif config.layer_id==YYHYLayoutType.second then
layerlist_2[#layerlist_2+1]=v
elseif config.layer_id==YYHYLayoutType.third then
layerlist_3[#layerlist_3+1]=v
end
end
if#layerlist_1>0 then
UIYYHYWintwo:WaterObjGenrating(YYHYLayoutType.first,layerlist_1)
end
if#layerlist_2>0 then
UIYYHYWintwo:WaterObjGenrating(YYHYLayoutType.second,layerlist_2)
end
if#layerlist_3>0 then
UIYYHYWintwo:WaterObjGenrating(YYHYLayoutType.third,layerlist_3)
end

end


function UIYYHYWintwo:WaterObjGenrating(layerid,layerlist_1)
local fish_perfab_canues={}

local all_pfbNum={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32}
for k,v in ipairs(all_pfbNum)do
if _this.fishs_yuchi_pfbNu[k]==0 then
fish_perfab_canues[#fish_perfab_canues+1]=v
end
end

local random_index={}
local random_index_temp={}
for i=1,#layerlist_1 do

local r=math.random(i,genratelayernum[layerid])
local a=r
if random_index_temp[r]then
a=random_index_temp[r]
end
table.insert(random_index,a)
random_index_temp[r]=random_index_temp[i]or i
end

for i=1,#layerlist_1 do
local config=cfgHelper.get1(cfg_yiyuhuiyouitemconfig_get,waterObj_Data[i].param_1)
local _speeds=config.speed
local point=_this.genratePoint[layerid]
local index=random_index[i]
local genrateEntity=point[index]
local fishpos=genrateEntity:getChildPosition()

local _tword=random_index[i]<=3 and 1 or-1
local _speed=_speeds[math.random(1,#_speeds)]

local fish_pfb_id=fish_perfab_canues[i]
_this.fish_pfb_list[fish_pfb_id]:setChildPosition(Vector3.New(fishpos.x,fishpos.y,fishpos.z))



local _widthindex=math.random(1,#Fish_PerfabWidth)
local _heightindex=math.random(1,#Fish_PerfabHeight)
local width=Fish_PerfabWidth[_widthindex]+Fish_PerfabHeight[_heightindex]
local height=Fish_PerfabHeight[_heightindex]
_this.fish_pfb_list[fish_pfb_id]:setChildSizeDelta(width,height)

local new_waterObj_Data=
{
id=layerlist_1[i],


waterObj_type=config.type3,
waterObj_basetype=config.type2,
fish_pfb_id=fish_pfb_id,
name=config.name,
pos={},
tword=_tword,
speed=_speed,
bit_stage=YYHYWaterObjectState.swimming,
fish_layerNum=config.layer_id,
}

YiYuHuiYouModel:refreshWaterObjectData(new_waterObj_Data)
_this.fishs_yuchi_pfbNu[fish_pfb_id]=fish_pfb_id
end
end



function UIYYHYWintwo:FishPerfabList()

end


function UIYYHYWintwo:FishDataList()
local fish_data_test=
{
[1]=
{
name="123",
fishid=1,
pos={},
tword=1,
speed=0.06,
bite_stage=fishstage.swimming,
fish_layerNum=fishLayer.layer_one,
fish_color=fishColor.green
},
[2]=
{
name="456",
fishid=2,
pos={},
tword=-1,
speed=0.08,
bite_stage=fishstage.swimming,
fish_layerNum=fishLayer.layer_one,
fish_color=fishColor.bule
},

[3]=
{
name="789",
fishid=3,
pos={},
tword=1,
speed=0.05,
bite_stage=fishstage.swimming,
fish_layerNum=fishLayer.layer_two,
fish_color=fishColor.orange
},
[4]=
{
name="987",
fishid=4,
pos={},
tword=-1,
speed=0.07,
bite_stage=fishstage.swimming,
fish_layerNum=fishLayer.layer_two,
fish_color=fishColor.bule
},
[5]=
{
name="654",
fishid=5,
pos={},
tword=1,
speed=0.09,
bite_stage=fishstage.swimming,
fish_layerNum=fishLayer.layer_three,
fish_color=fishColor.orange
},
[6]=
{
name="321",
fishid=6,
pos={},
tword=-1,
speed=0.06,
bite_stage=fishstage.swimming,
fish_layerNum=fishLayer.layer_three,
fish_color=fishColor.red
},

}
return fish_data_test
end


function UIYYHYWintwo:FishRandomPosition(x,y,toward,speed,isReverse)
x=x+speed*toward
return x,y
end


function UIYYHYWintwo:FishsMoveAI(index,fish_perfab_id)

local waterobj_list=YiYuHuiYouModel:gettWaterObjectData()
local fish_pos=_this.fish_pfb_list[fish_perfab_id]:getChildPosition()




local fish_tword=waterobj_list[index].tword
local fish_speed=waterobj_list[index].speed


local zhangaiperfab_pos1=_this.zhangaiperfab[1]:getChildPosition()
local zhangaiperfab_pos2=_this.zhangaiperfab[2]:getChildPosition()


if fish_pos.x>=zhangaiperfab_pos1.x then
fish_tword=-fish_tword

YiYuHuiYouModel:setWaterObjTword(index,fish_tword)
elseif fish_pos.x<=zhangaiperfab_pos2.x then
fish_tword=-fish_tword

YiYuHuiYouModel:setWaterObjTword(index,fish_tword)
end


local new_x,new_y=UIYYHYWintwo:FishRandomPosition(fish_pos.x,fish_pos.y,fish_tword,fish_speed)


if _this.gameItemStage~=gameitemstage.ice and waterobj_list[index].waterObj_basetype==YYHYWaterObjectBaseType.fish then



if waterobj_list[index].bit_stage==YYHYWaterObjectState.swimming then
_this.fish_pfb_list[fish_perfab_id]:setChildPosition(Vector3.New(new_x,new_y,fish_pos.z))
end
end










































































































































end


function UIYYHYWintwo:FishsCollisionAI(index,fish_perfab_id)

local waterobj_list=YiYuHuiYouModel:gettWaterObjectData()
local fish_pos=_this.fish_pfb_list[fish_perfab_id]:getChildPosition()
local waterobj_id_palyer_bites={}
local waterobj_listId_palyer_bites={}


if _state==state.Stretch and waterobj_list[index].bit_stage~=YYHYWaterObjectState.bitted and waterobj_list[index].bit_stage~=YYHYWaterObjectState.disapper then
local fishgou_pos=_this.Image3:getChildPosition()
local ydis=math.abs(fishgou_pos.y-fish_pos.y)
local xdis=math.abs(fishgou_pos.x-fish_pos.x)

if ydis<=0.5 and xdis<=0.5 then

if _this.player_yugou_range>0 then
for k,v in ipairs(waterobj_list)do
local fish_two_pos=_this.fish_pfb_list[v.fish_pfb_id]:getChildPosition()
local two_ydis=math.abs(fishgou_pos.y-fish_two_pos.y)
local two_xdis=math.abs(fishgou_pos.x-fish_two_pos.x)
if two_ydis<=_this.player_yugou_range and two_xdis<=_this.player_yugou_range then






if v.waterObj_type==YYHYWaterObjectType.normal_fish then
YiYuHuiYouModel:setWaterObjBit_Stage(k,YYHYWaterObjectState.bitted)
YiYuHuiYouModel:setWaterObjPos(k,xdis,ydis)
waterobj_id_palyer_bites[#waterobj_id_palyer_bites+1]=v.id
waterobj_listId_palyer_bites[#waterobj_listId_palyer_bites+1]=k

elseif v.waterObj_type==YYHYWaterObjectType.ice_item then
_this.gameItemStage=gameitemstage.ice
_this.fish_pfb_list[v.fish_perfab_id]:setChildPosition(Vector3.New(_this.yutong_pos.x,_this.yutong_pos.y,_this.yutong_pos.z))
YiYuHuiYouModel:setWaterObjBit_Stage(k,YYHYWaterObjectState.disapper)
waterobj_id_palyer_bites[#waterobj_id_palyer_bites+1]=v.id
waterobj_listId_palyer_bites[#waterobj_listId_palyer_bites+1]=k

elseif v.waterObj_type==YYHYWaterObjectType.storm_item then
_this.gameItemStage=gameitemstage.storm
_this.fish_pfb_list[v.fish_perfab_id]:setChildPosition(Vector3.New(_this.yutong_pos.x,_this.yutong_pos.y,_this.yutong_pos.z))
YiYuHuiYouModel:setWaterObjBit_Stage(k,YYHYWaterObjectState.disapper)
waterobj_id_palyer_bites[#waterobj_id_palyer_bites+1]=v.id
waterobj_listId_palyer_bites[#waterobj_listId_palyer_bites+1]=k

elseif v.waterObj_type==YYHYWaterObjectType.normal_item then

if true then
_this.fish_pfb_list[v.fish_perfab_id]:setChildPosition(Vector3.New(_this.yutong_pos.x,_this.yutong_pos.y,_this.yutong_pos.z))
YiYuHuiYouModel:setWaterObjBit_Stage(k,YYHYWaterObjectState.disapper)
waterobj_id_palyer_bites[#waterobj_id_palyer_bites+1]=v.id
waterobj_listId_palyer_bites[#waterobj_listId_palyer_bites+1]=k
else
YiYuHuiYouModel:setWaterObjBit_Stage(k,YYHYWaterObjectState.bitted)
YiYuHuiYouModel:setWaterObjPos(k,xdis,ydis)
waterobj_id_palyer_bites[#waterobj_id_palyer_bites+1]=v.id
waterobj_listId_palyer_bites[#waterobj_listId_palyer_bites+1]=k
end
end
end
end

_state=state.Shorten
else




if waterobj_list[index].waterObj_type==YYHYWaterObjectType.normal_fish then
YiYuHuiYouModel:setWaterObjBit_Stage(index,YYHYWaterObjectState.bitted)
YiYuHuiYouModel:setWaterObjPos(index,xdis,ydis)
waterobj_id_palyer_bites[#waterobj_id_palyer_bites+1]=waterobj_list[index].id
waterobj_listId_palyer_bites[#waterobj_listId_palyer_bites+1]=index
_state=state.Shorten

elseif waterobj_list[index].waterObj_type==YYHYWaterObjectType.ice_item then
_this.gameItemStage=gameitemstage.ice
_this.fish_pfb_list[fish_perfab_id]:setChildPosition(Vector3.New(_this.yutong_pos.x,_this.yutong_pos.y,_this.yutong_pos.z))
YiYuHuiYouModel:setWaterObjBit_Stage(index,YYHYWaterObjectState.disapper)
waterobj_id_palyer_bites[#waterobj_id_palyer_bites+1]=waterobj_list[index].id
waterobj_listId_palyer_bites[#waterobj_listId_palyer_bites+1]=index
_state=state.Shorten

elseif waterobj_list[index].waterObj_type==YYHYWaterObjectType.storm_item then
_this.gameItemStage=gameitemstage.storm
_this.fish_pfb_list[fish_perfab_id]:setChildPosition(Vector3.New(_this.yutong_pos.x,_this.yutong_pos.y,_this.yutong_pos.z))
YiYuHuiYouModel:setWaterObjBit_Stage(index,YYHYWaterObjectState.disapper)
waterobj_id_palyer_bites[#waterobj_id_palyer_bites+1]=waterobj_list[index].id
waterobj_listId_palyer_bites[#waterobj_listId_palyer_bites+1]=index
_state=state.Shorten

elseif waterobj_list[index].waterObj_type==YYHYWaterObjectType.normal_item then


if _this.can_player_jisuiWp_num>0 then
_this.fish_pfb_list[fish_perfab_id]:setChildPosition(Vector3.New(_this.yutong_pos.x,_this.yutong_pos.y,_this.yutong_pos.z))
YiYuHuiYouModel:setWaterObjBit_Stage(index,YYHYWaterObjectState.disapper)
waterobj_id_palyer_bites[#waterobj_id_palyer_bites+1]=waterobj_list[index].id
waterobj_listId_palyer_bites[#waterobj_listId_palyer_bites+1]=index

_this.can_player_jisuiWp_num=_this.can_player_jisuiWp_num-1
else
YiYuHuiYouModel:setWaterObjBit_Stage(index,YYHYWaterObjectState.bitted)
YiYuHuiYouModel:setWaterObjPos(index,xdis,ydis)
waterobj_id_palyer_bites[#waterobj_id_palyer_bites+1]=waterobj_list[index].id
waterobj_listId_palyer_bites[#waterobj_listId_palyer_bites+1]=index
_state=state.Shorten
end
end
end


local newfishlist={}
local newfishbitlist={}
local waterobj_list2=YiYuHuiYouModel:gettWaterObjectData()
for k,v in ipairs(waterobj_list2)do
if v.bite_stage~=YYHYWaterObjectState.bitted then


elseif v.bite_stage==YYHYWaterObjectState.bitted then

table.insert(newfishbitlist,v)
end
end



_this.fish_bitted_data_list=newfishbitlist




if#waterobj_id_palyer_bites>0 and#waterobj_listId_palyer_bites>0 then
YiYuHuiYouController.send_248_57(#waterobj_id_palyer_bites,waterobj_id_palyer_bites,0,#waterobj_listId_palyer_bites,waterobj_listId_palyer_bites)
end


local ropeSpeed_back_index=math.random(1,#ropeSpeed_back_arry)
ropeSpeed_back=ropeSpeed_back_arry[ropeSpeed_back_index]
end


if fishgou_pos.x>=_this.rightbianjie_pos.x or fishgou_pos.y<=_this.underbianjie_pos.y then
_state=state.Shorten
end
end


local waterobj_list_ai=YiYuHuiYouModel:gettWaterObjectData()
if _state_fisher==state.Stretch and waterobj_list[index].bit_stage~=YYHYWaterObjectState.bitted then
local fishgou_ai_pos=_this.Image3ai:getChildPosition()
local waterobj_list=YiYuHuiYouModel:gettWaterObjectData()
local ydis_ai=math.abs(fishgou_ai_pos.y-fish_pos.y)
local xdis_ai=math.abs(fishgou_ai_pos.x-fish_pos.x)

if ydis_ai<=0.5 and xdis_ai<=0.5 then
if true then
for k,v in ipairs(waterobj_list)do
local fish_two_pos=_this.fish_pfb_list[v.fish_pfb_id]:getChildPosition()
local two_ydis_ai=math.abs(fishgou_ai_pos.y-fish_two_pos.y)
local two_xdis_ai=math.abs(fishgou_ai_pos.x-fish_two_pos.x)
if two_ydis_ai<=0.8 and two_xdis_ai<=0.8 then



YiYuHuiYouModel:setWaterObjBit_Stage(k,YYHYWaterObjectState.bitted)
YiYuHuiYouModel:setWaterObjPos(k,two_xdis_ai,two_ydis_ai)
end
end
else



YiYuHuiYouModel:setWaterObjBit_Stage(index,YYHYWaterObjectState.bitted)
YiYuHuiYouModel:setWaterObjPos(index,xdis_ai,ydis_ai)
end


local newfishlist_ai={}
local newfishbitlist_ai={}
for k,v in ipairs(_this.fish_data_list)do
if v.bite_stage~=YYHYWaterObjectState.bitted then

elseif v.bite_stage==YYHYWaterObjectState.bitted then
table.insert(newfishbitlist_ai,v)
end
end



_this.fish_ai_bitted_data_list=newfishbitlist_ai
_state_fisher=state.Shorten











end


if fishgou_ai_pos.x<=_this.leftbianjie_pos.x or fishgou_ai_pos.y<=_this.underbianjie_pos.y then
_state_fisher=state.Shorten
end
end
end



function UIYYHYWintwo:FishsGenrateMain()


if _this.layerByOneNum<fish_layer_num[1]then
UIYYHYWintwo:FishsGenrate(1,_this.layerByOneNum)
end
if _this.layerByTwoNum<fish_layer_num[2]then
UIYYHYWintwo:FishsGenrate(2,_this.layerByTwoNum)
end
if _this.layerByThreeNum<fish_layer_num[3]then
UIYYHYWintwo:FishsGenrate(3,_this.layerByThreeNum)
end
end


function UIYYHYWintwo:FishsGenrate(layerid,fishnum)





local fish_perfab_canues={}

local random_index={}
local random_index_temp={}




local all_pfbNum={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32}
for k,v in ipairs(all_pfbNum)do
if _this.fishs_yuchi_pfbNu[k]==0 then
fish_perfab_canues[#fish_perfab_canues+1]=v
end
end


for i=1,fish_layer_genrate_num[layerid]do

local r=math.random(i,genratelayernum[layerid])
local a=r
if random_index_temp[r]then
a=random_index_temp[r]
end
table.insert(random_index,a)
random_index_temp[r]=random_index_temp[i]or i











end


for i=1,fish_layer_genrate_num[layerid]do


local point=_this.genratePoint[layerid]
local index=random_index[i]
local genrateEntity=point[index]
local fishpos=genrateEntity:getChildPosition()
local _tword=random_index[i]<=3 and 1 or-1

local speed_index=math.random(1,#speedarry)
local _speed=speedarry[speed_index]



local fish_pfb_id=fish_perfab_canues[i]
_this.fish_pfb_list[fish_pfb_id]:setChildPosition(Vector3.New(fishpos.x,fishpos.y,fishpos.z))


local _color=math.random(1,#layer_one_color[layerid])


local _widthindex=math.random(1,#Fish_PerfabWidth)
local _heightindex=math.random(1,#Fish_PerfabHeight)
local width=Fish_PerfabWidth[_widthindex]+Fish_PerfabHeight[_heightindex]
local height=Fish_PerfabHeight[_heightindex]
_this.fish_pfb_list[fish_pfb_id]:setChildSizeDelta(width,height)

_this.fish_data_list[#_this.fish_data_list+1]=
{
name=fish_pfb_id+100,
fishid=fish_pfb_id,
pos={},
tword=_tword,
speed=_speed,
bite_stage=fishstage.swimming,
fish_layerNum=layerid,
fish_color=layer_one_color[layerid][_color]
}

_this.fishs_yuchi_pfbNu[fish_pfb_id]=fish_pfb_id


if fishLayer.layer_one==layerid then
_this.layerByOneNum=_this.layerByOneNum+1
elseif fishLayer.layer_two==layerid then
_this.layerByTwoNum=_this.layerByTwoNum+1
elseif fishLayer.layer_three==layerid then
_this.layerByThreeNum=_this.layerByThreeNum+1
end

end
end


function UIYYHYWintwo:FishsGotMove()
if#_this.fish_bitted_data_list>0 then
local fishgou_pos=_this.Image3:getChildPosition()
for k,v in ipairs(_this.fish_bitted_data_list)do




local fishpos=_this.fish_pfb_list[v.fish_pfb_id]:getChildPosition()
local _x=v.pos[1]
local _y=v.pos[2]
if fishgou_pos.x<=fishpos.x then
_this.fish_pfb_list[v.fish_pfb_id]:setChildPosition(Vector3.New(fishgou_pos.x+_x,fishgou_pos.y-_y,fishpos.z))
elseif fishgou_pos.x>fishpos.x then
_this.fish_pfb_list[v.fish_pfb_id]:setChildPosition(Vector3.New(fishgou_pos.x-_x,fishgou_pos.y-_y,fishpos.z))
end

end
end
end


function UIYYHYWintwo:FishsGotDelet()
if#_this.fish_bitted_data_list>0 then
for k,v in ipairs(_this.fish_bitted_data_list)do

_this.fish_pfb_list[v.fish_pfb_id]:setChildPosition(Vector3.New(_this.yutong_pos.x,_this.yutong_pos.y,_this.yutong_pos.z))
UIYYHYWintwo:FishsRefeshLayerNum(v)
_this.fishs_yuchi_pfbNu[v.fish_pfb_id]=0
end

_this.fish_bitted_data_list={}
UIYYHYWintwo:FishsScore()
end
end


function UIYYHYWintwo:FishsScore()
local _index=math.random(1,#jifens)
local jifen_index=jifens[_index]
jifen=jifen+jifen_index
_this.winlua:SetChildText(_this.jifentext:getID(),jifen..'斤')
end


function UIYYHYWintwo:FishsRefeshLayerNum(fish_perfab)
if fish_perfab.fish_layerNum==fishLayer.layer_one then
_this.layerByOneNum=_this.layerByOneNum-1
elseif fish_perfab.fish_layerNum==fishLayer.layer_two then
_this.layerByTwoNum=_this.layerByTwoNum-1
elseif fish_perfab.fish_layerNum==fishLayer.layer_three then
_this.layerByThreeNum=_this.layerByThreeNum-1
end
end







function UIYYHYWintwo:ItemDataList()
local items_data_test=
{
[1]=
{
name="111",
itemperfabid=1,
tag=itemsTag.ice,
},
[2]=
{
name="222",
itemperfabid=2,
tag=itemsTag.storm,
},
}
return items_data_test
end


function UIYYHYWintwo:ItemsGenrate()

end


function UIYYHYWintwo:ItemsTirgger()

local fishgou_pos=_this.Image3:getChildPosition()


for i=1,2 do
if _this.items_data_list[i]then
local item_perfabID=_this.items_data_list[i].itemperfabid
local tag=_this.items_data_list[i].tag
local items_pos=_this.itemslist[item_perfabID]:getChildPosition()

local ydis=math.abs(fishgou_pos.y-items_pos.y)
local xdis=math.abs(fishgou_pos.x-items_pos.x)


if ydis<=0.5 and xdis<=0.5 then
if tag==itemsTag.ice then

_this.gameItemStage=gameitemstage.ice
_state=state.Shorten

_this.itemslist[_this.items_data_list[i].itemperfabid]:setChildPosition(Vector3.New(_this.yutong_pos.x,_this.yutong_pos.y,_this.yutong_pos.z))

elseif tag==itemsTag.storm then

_this.gameItemStage=gameitemstage.storm
_state=state.Shorten
_this.itemslist[_this.items_data_list[i].itemperfabid]:setChildPosition(Vector3.New(_this.yutong_pos.x,_this.yutong_pos.y,_this.yutong_pos.z))
IsStormAnimPlay=true
else

_this.gameItemStage=gameitemstage.normal
end
end
end
end
end


function UIYYHYWintwo:ItemsClearFishsPerfab()




local storm_pos=_this.effectWind:getChildPosition()
if storm_pos.x>_this.stormPoint_pos.x then
local new_x=storm_pos.x-wind_speed
_this.effectWind:setChildPosition(Vector3.New(new_x,storm_pos.y,storm_pos.z))


for i=1,32 do
local waterobj_list=YiYuHuiYouModel:gettWaterObjectData()
if waterobj_list[i]then
local fish_pos=_this.fish_pfb_list[waterobj_list[i].fish_pfb_id]:getChildPosition()

local ydis=math.abs(storm_pos.y-fish_pos.y)
local xdis=math.abs(storm_pos.x-fish_pos.x)


if waterobj_list[i].waterObj_type==YYHYWaterObjectType.normal_fish then
if waterobj_list[i].color==fishColor.green or waterobj_list[i].color==fishColor.bule then
if ydis<=0.5 and xdis<=0.5 then

YiYuHuiYouModel:setWaterObjBit_Stage(index,YYHYWaterObjectState.bitted)

_this.fish_pfb_list[waterobj_list[i].fish_pfb_id]:setChildPosition(Vector3.New(_this.yutong_pos.x,_this.yutong_pos.y,_this.yutong_pos.z))
UIYYHYWintwo:FishsRefeshLayerNum(waterobj_list[i])
_this.fishs_yuchi_pfbNu[waterobj_list[i].fish_pfb_id]=0















end
end
end
end
end
else
_this.gameItemStage=gameitemstage.normal
end
end







function UIYYHYWintwo:FisherAIRock()

if _state_fisher==state.Rock then

if ai_dir2>=60 then
ai_speed=-ai_speed
elseif ai_dir2<=-60 then
ai_speed=-ai_speed
end
ai_dir2=ai_dir2+ai_speed
_this.Image2ai:setRotation(0,0,ai_dir2)

dir_x=0
dir_y=0
FisherAI_speed_k=0.1
ai_ropeSpeed_out=0.1
ai_ropeSpeed_back=0.1

local fishgou_center_pos=_this.Image4ai:getChildPosition()
_this.Image3ai:setChildPosition(Vector3.New(fishgou_center_pos.x,fishgou_center_pos.y,fishgou_center_pos.z))
_this.Image3ai:setRotation(0,0,ai_dir2)


end
end


function UIYYHYWintwo:FisherAIStretch()
if ai_ropelenght>=ai_rope_lenght_max then
_state_fisher=state.Shorten
return
end
ai_ropelenght=ai_ropelenght+ai_ropeSpeed_out



local fishgou_dingdian_pos=_this.dingdianai:getChildPosition()
local fishgou_ai_pos=_this.Image3ai:getChildPosition()
if dir_x==0 then
dir_x=math.abs(fishgou_dingdian_pos.x-fishgou_ai_pos.x)*FisherAI_speed_k
dir_y=math.abs(fishgou_dingdian_pos.y-fishgou_ai_pos.y)*FisherAI_speed_k
end




if fishgou_dingdian_pos.x<=fishgou_ai_pos.x then
_this.Image3ai:setChildPosition(Vector3.New(fishgou_ai_pos.x+dir_x,fishgou_ai_pos.y-dir_y,fishgou_ai_pos.z))
elseif fishgou_dingdian_pos.x>fishgou_ai_pos.x then
_this.Image3ai:setChildPosition(Vector3.New(fishgou_ai_pos.x-dir_x,fishgou_ai_pos.y-dir_y,fishgou_ai_pos.z))
end



_this._transform_ai.localScale=Vector3.New(_this._transform_ai.localScale.x,ai_ropelenght,_this._transform_ai.localScale.z)

end


function UIYYHYWintwo:FisherAIShorten()
if ai_ropelenght<=ai_rope_lenght then
ai_ropelenght=ai_rope_lenght
_state_fisher=state.Rock
return
end


ai_ropelenght=ai_ropelenght-ai_ropeSpeed_back


local fishgou_dingdian_pos=_this.dingdianai:getChildPosition()
local fishgou_ai_pos=_this.Image3ai:getChildPosition()
if fishgou_dingdian_pos.x<=fishgou_ai_pos.x then
_this.Image3ai:setChildPosition(Vector3.New(fishgou_ai_pos.x-dir_x,fishgou_ai_pos.y+dir_y,fishgou_ai_pos.z))
elseif fishgou_dingdian_pos.x>fishgou_ai_pos.x then
_this.Image3ai:setChildPosition(Vector3.New(fishgou_ai_pos.x+dir_x,fishgou_ai_pos.y+dir_y,fishgou_ai_pos.z))
end



_this._transform_ai.localScale=Vector3.New(_this._transform_ai.localScale.x,ai_ropelenght,_this._transform_ai.localScale.z)

end



function UIYYHYWintwo:FisherAIGetIntersectionPos(fishgou_dingdian_pos,fishgou_pos,fish_pos,tword)










local k=(fishgou_pos.y-fishgou_dingdian_pos.y)/(fishgou_pos.x-fishgou_dingdian_pos.x)
local new_y=fish_pos.y
local new_x=(fishgou_dingdian_pos.y-fish_pos.y)*(-k)+fishgou_dingdian_pos.x
return Vector3.New(new_x,new_y,fish_pos.z)



end


function UIYYHYWintwo:FisherAIChuGouBtn()


if _this.gameItemStage==gameitemstage.storm then
return
end

if _state_fisher==state.Rock then
_state_fisher=state.Stretch
end

end


function UIYYHYWintwo:FisherAIFishsScore()
local _index=math.random(1,#jifens)
local jifen_index=jifens[_index]
jifen=jifen+jifen_index
_this.winlua:SetChildText(_this.jifentextai:getID(),jifen..'斤')
end


function UIYYHYWintwo:FisherAIHandle(fish_data,fishPos,isDeflection)













local fishgou_dingdian_pos=fishigou_pos_new_test
local fishgou_ai_pos=_this.Image3ai:getChildPosition()
local fish_pos=fishPos
local tword=fish_data.tword
local fish_speed=fish_data.speed




































































































if tword==-1 and ai_dir2>=2 then
if fish_pos.x>fishgou_ai_pos.x then
local num=3/ai_ropeSpeed_out
local _x=1
local _y=1
if dir_x==0 then
_x=math.abs(fishgou_dingdian_pos.x-fishgou_ai_pos.x)*FisherAI_speed_k
_y=math.abs(fishgou_dingdian_pos.y-fishgou_ai_pos.y)*FisherAI_speed_k
end

local new_y=fishgou_ai_pos.y-_y*num


if new_y<=fish_pos.y then

local dis_y=math.abs(fishgou_ai_pos.y-fish_pos.y)
local num2=math.modf(dis_y/_y)

local fishgou_moveposx=fishgou_ai_pos.x+_x*num2
local fish_moveposx=fish_pos.x+(tword*fish_speed*num2)

if math.abs(fishgou_moveposx-fish_moveposx)<0.5 then
return true
end
end
end
elseif tword==1 and ai_dir2>=2 then
if fish_pos.x<fishgou_ai_pos.x then
local num=3/ai_ropeSpeed_out
local _x=1
local _y=1
if dir_x==0 then
_x=math.abs(fishgou_dingdian_pos.x-fishgou_ai_pos.x)*FisherAI_speed_k
_y=math.abs(fishgou_dingdian_pos.y-fishgou_ai_pos.y)*FisherAI_speed_k
end

local new_y=fishgou_ai_pos.y-_y*num

if new_y<=fish_pos.y then

local dis_y=math.abs(fishgou_ai_pos.y-fish_pos.y)
local num2=math.modf(dis_y/_y)
local fishgou_moveposx=fishgou_ai_pos.x+_x*num2
local fish_moveposx=fish_pos.x+(tword*fish_speed*num2)
if math.abs(fishgou_moveposx-fish_moveposx)<0.5 then
return true
end
end
end
end


return false
end



function UIYYHYWintwo:FisherAI()









if _state_fisher==state.Rock and fish_bite_IsOut==true then

for i=1,32 do
if _this.fish_data_list[i]then
local fish_pos=_this.fish_pfb_list[_this.fish_data_list[i].fishid]:getChildPosition()

if fish_pos.x>fish_go_leftpos.x and fish_pos.x<fish_go_rightpos.x then
if fish_pos.y>fish_go_leftpos.y and fish_pos.y<fish_go_rightpos.y then

if _this.fish_data_list[i].fish_layerNum==fishLayer.layer_one or _this.fish_data_list[i].fish_layerNum==fishLayer.layer_two then

local probability_index=math.random(1,10)
local isnotDeflection=probability_index<=fish_bite_probability

local isChuGou=UIYYHYWintwo:FisherAIHandle(_this.fish_data_list[i],fish_pos,isnotDeflection)
if isChuGou and#_this.fish_ai_bitted_data_list<=0 then
UIYYHYWintwo:FisherAIChuGouBtn()
end
end
end
end
end
end
end
end


function UIYYHYWintwo:FisherAIFishsGotMove()
if#_this.fish_ai_bitted_data_list>0 then
local fishgou_ai_pos=_this.Image3ai:getChildPosition()
for k,v in ipairs(_this.fish_ai_bitted_data_list)do







local fishpos=_this.fish_pfb_list[v.fishid]:getChildPosition()
local _x=v.pos[1]
local _y=v.pos[2]
if fishgou_ai_pos.x<=fishpos.x then
_this.fish_pfb_list[v.fishid]:setChildPosition(Vector3.New(fishgou_ai_pos.x+_x,fishgou_ai_pos.y-_y,fishpos.z))
elseif fishgou_ai_pos.x>fishpos.x then
_this.fish_pfb_list[v.fishid]:setChildPosition(Vector3.New(fishgou_ai_pos.x-_x,fishgou_ai_pos.y-_y,fishpos.z))
end

end
end
end


function UIYYHYWintwo:FisherAIFishsGotDelet()
if#_this.fish_ai_bitted_data_list>0 then
for k,v in ipairs(_this.fish_ai_bitted_data_list)do

_this.fish_pfb_list[v.fishid]:setChildPosition(Vector3.New(_this.yutong_pos.x,_this.yutong_pos.y,_this.yutong_pos.z))

UIYYHYWintwo:FishsRefeshLayerNum(v)

_this.fishs_yuchi_pfbNu[v.fishid]=0
end

_this.fish_ai_bitted_data_list={}
UIYYHYWintwo:FisherAIFishsScore()


if fish_bite_out_times==0 then
local chugou_time_index=math.random(1,#fish_bite_out_timesArry)
fish_bite_out_times=fish_bite_out_timesArry[chugou_time_index]
fish_bite_IsOut=false
end
end
end





function UIYYHYWintwo:UpdateView()



self.refreshTimeFunc=function()

if _this.YYHYGameStage==YYHYGameState.execute then
if game_time>0 then

if _state==state.Rock then
UIYYHYWintwo:Rock()
UIYYHYWintwo:FishsGotDelet()

if#_this.fish_data_list<fishNum and _this.gameItemStage~=gameitemstage.storm then
UIYYHYWintwo:FishsGenrateMain()
end
elseif _state==state.Stretch then
UIYYHYWintwo:Stretch()
elseif _state==state.Shorten then
UIYYHYWintwo:Shorten()
UIYYHYWintwo:FishsGotMove()
end

if _state_fisher==state.Rock then
UIYYHYWintwo:FisherAIRock()
UIYYHYWintwo:FisherAIFishsGotDelet()

elseif _state_fisher==state.Stretch then
UIYYHYWintwo:FisherAIStretch()

elseif _state_fisher==state.Shorten then
UIYYHYWintwo:FisherAIShorten()
UIYYHYWintwo:FisherAIFishsGotMove()
end
end



if _this.gameItemStage==gameitemstage.storm then
UIYYHYWintwo:ItemsClearFishsPerfab()
game_storm_time=game_storm_time+0.02
if game_storm_time>=10 then
IsStormAnimPlay=false
game_storm_time=0
end
end


UIYYHYWintwo:ItemsTirgger()


UIYYHYWintwo:FisherAI()


for i=1,#_this.fish_pfb_list do
local waterobj_list=YiYuHuiYouModel:gettWaterObjectData()
if waterobj_list[i]then


UIYYHYWintwo:FishsMoveAI(i,waterobj_list[i].fish_pfb_id)
UIYYHYWintwo:FishsCollisionAI(i,waterobj_list[i].fish_pfb_id)
end
end

elseif _this.YYHYGameStage==YYHYGameState.preparation then

end
end
self.refreshTimeFunc()
_this.refreshTimeId=_this:setTimer(0.02,0,_this.refreshTimeFunc)
end


function UIYYHYWintwo:UpdateView_two()


self.refreshTimeTwoFunc=function()

if _this.YYHYGameStage==YYHYGameState.execute then

if fish_bite_out_times>0 then
fish_bite_out_times=fish_bite_out_times-1
if fish_bite_out_times<=0 then
fish_bite_out_times=0
fish_bite_IsOut=true
end
end


if _this.gameItemStage==gameitemstage.ice then
game_ice_time=game_ice_time+1
if game_ice_time>=5 then
_this.gameItemStage=gameitemstage.normal
game_ice_time=0
end
end

elseif _this.YYHYGameStage==YYHYGameState.preparation then

end
end
self.refreshTimeTwoFunc()
_this.refreshTimeTwoId=_this:setTimer(1,0,_this.refreshTimeTwoFunc)

end



function UIYYHYWintwo:onButton2()
if _this.gameItemStage==gameitemstage.storm then
return
end
if _state==state.Rock then
_state=state.Stretch
end









end





function UIYYHYWintwo:refreshleftPanel()

local widget
local rewardList=cfg_yiyuhuiyounpcconfig_get(1).guanka_rewards
for i,item in ipairs(_this.item)do
if rewardList[i]then
item:setActive(true)
widget=item:getWidgetBase()
local data=rewardList[i]
widgetHelper.setNormalRewardItem(widget,-1,data)
widget:SetChildButtonClick(3,function()
self:onRewardItemClick(data[1],i)
end)
else
item:setActive(false)
end
end


local guankaname=cfg_yiyuhuiyounpcconfig_get(1).guanka_name
_this.jianglitext:setText(guankaname)
end
function UIYYHYWintwo:onRewardItemClick(itemId,itemIndex)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=nil,showModel=true})
end


function UIYYHYWintwo:refreshtopPanel()
local startgametime=120
local str=FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp11(startgametime,true))
self.hdtimes:setText(str)
end

function UIYYHYWintwo:onStarttips()

end


function UIYYHYWintwo:refreshcenterPanel()
local battlenum=3
local battlemax=4
local battle_str=FMT.fmt("挑战次数：{0}/{1}",battlenum,battlemax)
_this.tiaozhantext:setText(battle_str)

local dizi_guid=YiYuHuiYouModel:getDiZiId()
if not dizi_guid or dizi_guid==0 then
_this.startdizibtn:setActive(true)
_this.startbtn:setActive(false)
else
_this.startdizibtn:setActive(false)
_this.startbtn:setActive(true)
end
end
function UIYYHYWintwo:onAddbtn()

local cfg=cfg_yiyuhuiyoubaseconfig_get(1).buy_enter_cnt
local tz_num=YiYuHuiYouModel:getEnter_cnt()
local tz_buynum=YiYuHuiYouModel:getBuy_enter_cnt()or 0
local tz_peizi_num=#cfg
if(tz_peizi_num-tz_buynum)>0 then
UIManager:showWindow('YYHYBuyDialogWin')
else
UIManager.error("今日购买次数已耗尽")
end

end
function UIYYHYWintwo:onStartbtn()

local battlenum=3
if battlenum>0 then
_this.npc_guid=1
YiYuHuiYouController.send_248_54(_this.npc_guid)
end
end
function UIYYHYWintwo:onStartdizibtn()

UIManager:showWindow('YYHYSelectWin')
end



function UIYYHYWintwo:refreshrightPanel()
local tujianreddot=YiYuHuiYouModel:getTuJianReddot()
_this.tujianred:setActive(tujianreddot)
local mubiaoreddot=YiYuHuiYouModel:getMuBiaoRewardReddot()
_this.mubiaored:setActive(mubiaoreddot)
end

function UIYYHYWintwo:onTujianbtn()

end
function UIYYHYWintwo:onShangdianbtn()
UIManager:showWindow('YYHYShopWin',{shopId=5})
end
function UIYYHYWintwo:onMubiaobtn()

YiYuHuiYouController.send_248_58()
end







function UIYYHYWintwo:YYHYStartGame()

_this.startpanel:setActive(false)

_this.gamewinpanel:setActive(true)
_this.gamemainpanel:setActive(true)
_this.Button2:setActive(true)

UIYYHYWintwo:FishsGenrateByGameStart()
_this.YYHYGameStage=YYHYGameState.execute

_this.yuganlevel=1
_this.yugoulevel=1
_this.yuxianlevel=1
end


function UIYYHYWintwo:YYHYEndGame()
_this.startpanel:setActive(true)
_this.gamewinpanel:setActive(false)
_this.gamemainpanel:setActive(false)
_this.Button2:setActive(false)

_this.YYHYGameStage=YYHYGameState.preparation
end

