






local _MODULENAME="YiYuHuiYouModel"


def_table(_MODULENAME)
YiYuHuiYouModel.name=_MODULENAME
YiYuHuiYouModel.data={}

function YiYuHuiYouModel:onAppStart()

end


function YiYuHuiYouModel:onEnterState(isReconnect)
YiYuHuiYouModel:initData()
end


function YiYuHuiYouModel:onLeaveState(isReconnect)

self.data={}
end



function YiYuHuiYouModel:initData()
self.data.yyhySever={}
self.data.yyhySever.rewardList={}
self.data.yyhySever.waterObj_Data={}

self.data.yyhySever.idxs={}
end



function YiYuHuiYouModel:initSeverData(enter_cnt,buy_enter_cnt,week_reward_val,week_reward_weight,week_reward_flag,yg_lvl,yw_lvl,yx_lvl,beat_score,npc_len,npc_arry,fish_len,fishlist,ver_str,fish_cs)
self.data.yyhySever={}
self.data.yyhySever.enter_cnt=enter_cnt
self.data.yyhySever.buy_enter_cnt=buy_enter_cnt
self.data.yyhySever.week_reward_val=week_reward_val
self.data.yyhySever.guid_reward_flag=week_reward_weight
self.data.yyhySever.week_reward_flag=week_reward_flag
self.data.yyhySever.yg_lvl=yg_lvl
self.data.yyhySever.yw_lvl=yw_lvl
self.data.yyhySever.yx_lvl=yx_lvl
self.data.yyhySever.week_best_score=beat_score
self.data.yyhySever.fish_cs=fish_cs
if npc_len>0 then
local list={}
for k,v in ipairs(npc_arry)do
local temp=
{
world=v.param_1,
block=v.param_2,
npcid=v.param_3,
posIdx=v.param_4,
}
list[#list+1]=temp
end

YiYuHuiYouModel:SetYYHYNpcDatas(list,ver_str)
else
if not self.data.yyhySever.npc_guid_list then
self.data.yyhySever.npc_guid_list={}
end
end
if fish_len>0 then
self.data.yyhySever.fishlist=fishlist
else
if not self.data.yyhySever.fishlist then
self.data.yyhySever.fishlist={}
end
end

end


function YiYuHuiYouModel:setXianLuId(xian_lu_id)
self.data.yyhySever.xian_lu_id=xian_lu_id
end

function YiYuHuiYouModel:setDiZiId(dz_guid)
self.data.yyhySever.dz_guid=dz_guid
end

function YiYuHuiYouModel:setNPCId(npc_id)
self.data.yyhySever.npc_id=npc_id
end

function YiYuHuiYouModel:getNPCId()
return self.data.yyhySever.npc_id
end



function YiYuHuiYouModel:getNPCIdlist()
return self.data.yyhySever.npc_guid_list
end


function YiYuHuiYouModel:getNPCIdlistbyGuid(guid)
if self.data.yyhySever.npc_guid_list and#self.data.yyhySever.npc_guid_list>0 then
for k,v in ipairs(self.data.yyhySever.npc_guid_list)do
if v.guid==guid then
return v
end
end
end
end


function YiYuHuiYouModel:initWaterObjectData(npc_id,len,waterObj_Data)
self.data.yyhySever.npc_id=npc_id

if len>0 then
self.data.yyhySever.waterObj_Data={}
local _tword={1,-1}
for i=1,len do
local config=cfg_yiyuhuiyouitemconfig_get(waterObj_Data[i])
local _speed=config.speed
local _bit_stage
if config.type2==YYHYWaterObjectBaseType.item then
_bit_stage=YYHYWaterObjectState.still
elseif config.type2==YYHYWaterObjectBaseType.fish then
_bit_stage=YYHYWaterObjectState.swimming
end

self.data.yyhySever.waterObj_Data[i]=
{
id=waterObj_Data[i],
weight=config.weight,

waterObj_type=config.type3,
waterObj_basetype=config.type2,
fish_pfb_id=i,
name=config.name,
pos={},
tword=_tword[math.random(1,2)],
speed=_speed[math.random(1,#_speed)],
bit_stage=_bit_stage,
fish_layerNum=config.layer_id,
color=config.color,
yuxian_line=config.line_len,
cfg=config
}
end

end
end



function YiYuHuiYouModel:getYgLevel()
return self.data.yyhySever.yg_lvl
end

function YiYuHuiYouModel:getYwLevel()
return self.data.yyhySever.yw_lvl
end

function YiYuHuiYouModel:getYxLevel()
return self.data.yyhySever.yx_lvl
end


function YiYuHuiYouModel:getEnter_cnt()
return self.data.yyhySever.enter_cnt
end

function YiYuHuiYouModel:getBuy_enter_cnt()
return self.data.yyhySever.buy_enter_cnt
end

function YiYuHuiYouModel:setWeek_reward_val(score)
self.data.yyhySever.week_reward_val=score
end

function YiYuHuiYouModel:getWeek_reward_val()
return self.data.yyhySever.week_reward_val
end

function YiYuHuiYouModel:getGuid_reward_flag()
return self.data.yyhySever.guid_reward_flag or 1
end

function YiYuHuiYouModel:getWeek_reward_flag()
return self.data.yyhySever.week_reward_flag
end


function YiYuHuiYouModel:getXianLuId()
return self.data.yyhySever.xian_lu_id or 0
end

function YiYuHuiYouModel:getDiZiId()
return self.data.yyhySever.dz_guid
end

function YiYuHuiYouModel:getDiZiId_index()
return self.data.yyhySever.dz_indexid
end


function YiYuHuiYouModel:getfishcs()
return self.data.yyhySever.fish_cs or 0
end

function YiYuHuiYouModel:setfishcs(fish_cs)
self.data.yyhySever.fish_cs=fish_cs
end

function YiYuHuiYouModel:addfishcs()
if self.data.yyhySever.fish_cs then
self.data.yyhySever.fish_cs=self.data.yyhySever.fish_cs+1
end
end


function YiYuHuiYouModel:gettWaterObjectData()
return self.data.yyhySever.waterObj_Data
end


function YiYuHuiYouModel:setRewardDataNil()
self.data.yyhySever.rewardList={}
end

function YiYuHuiYouModel:getRewardData()
return self.data.yyhySever.rewardList or{}
end


function YiYuHuiYouModel:setYujuLevel(type)
if type==1 then
self.data.yyhySever.yg_lvl=self.data.yyhySever.yg_lvl+1
end
if type==2 then
self.data.yyhySever.yw_lvl=self.data.yyhySever.yw_lvl+1
end
if type==3 then
self.data.yyhySever.yx_lvl=self.data.yyhySever.yx_lvl+1
end
end


function YiYuHuiYouModel:setBuy_enter_cnt(cnt)
self.data.yyhySever.buy_enter_cnt=self.data.yyhySever.buy_enter_cnt+cnt
end

function YiYuHuiYouModel:addEnter_cnt(cnt)
self.data.yyhySever.enter_cnt=self.data.yyhySever.enter_cnt+cnt
end

function YiYuHuiYouModel:sethebingCnt(cnt)
self.data.yyhySever.hbingCnt=cnt
end

function YiYuHuiYouModel:gethebingCnt()
return self.data.yyhySever.hbingCnt or 0
end


function YiYuHuiYouModel:setCatchWaterObjectSuccse(reward_len,reward_arry,list_len,list,npc_id,ex_reward_len,ex_reward_arry)

local player_score_temp=0
local ai_score_temp=0


if list_len>0 and(list[1]==5 or list[1]==6)then
local waterobj_list=YiYuHuiYouModel:gettWaterObjectData()
local newfishlist={}
for k,v in ipairs(waterobj_list)do




















if list_len>0 and list[1]==5 then
if v.bit_stage==YYHYWaterObjectState.player_disapper then
player_score_temp=player_score_temp+v.cfg.score

else
table.insert(newfishlist,v)
end

elseif list_len>0 and list[1]==6 then
if v.bit_stage==YYHYWaterObjectState.ai_disapper then
ai_score_temp=ai_score_temp+v.cfg.score
else
table.insert(newfishlist,v)
end
end
end


if npc_id==0 then
if player_score_temp>0 then
YiYuHuiYouModel:setWaterObjScore(player_score_temp)
local str=FMT.fmt('+{0}',player_score_temp)
YiYuHuiYouController:addThrowOutAndSliderTipsEx({4,str})
end
UIManager:invokeUIMethod('UIYYHYWin','FishsScore')
else
if ai_score_temp>0 then
YiYuHuiYouModel:setWaterObjScore_ai(ai_score_temp)
local str=FMT.fmt('+{0}',ai_score_temp)
YiYuHuiYouController:addThrowOutAndSliderTipsEx_ai({1,str})
end
UIManager:invokeUIMethod('UIYYHYWin','FisherAIFishsScore')
end

if#newfishlist>0 then
YiYuHuiYouModel:refreshWaterObjectDataAll(newfishlist)
end
end


if reward_len>0 then
if ex_reward_len>0 and ex_reward_arry then
for k,v in ipairs(ex_reward_arry)do
reward_arry[#reward_arry+1]=v
end
end

if not self.data.yyhySever.rewardList then
self.data.yyhySever.rewardList={}
end
if self.data.yyhySever.rewardList then
for k,v in ipairs(reward_arry)do
self.data.yyhySever.rewardList[#self.data.yyhySever.rewardList+1]=v
end
end


for k,v in ipairs(reward_arry)do
if v.param_1>=60000 and v.param_1<=69999 then

UIAquariumControl:setHandleBookFlagByWeight(v.param_1,v.param_3)
if not self.data.yyhySever.dafengshoulist then
self.data.yyhySever.dafengshoulist={}
end
local itemCfg=itemsConfig.getConfig(v.param_1)
local cfg=cfgHelper.get1(cfg_yuelongchibookconfig_get,itemCfg.bookid)
if v.param_3<=cfg.min then

if not self.data.yyhySever.dafengshoulist[itemCfg.bookid]then
self.data.yyhySever.dafengshoulist[itemCfg.bookid]={}
end
if self.data.yyhySever.dafengshoulist[itemCfg.bookid][1]then
self.data.yyhySever.dafengshoulist[itemCfg.bookid][1]=2
else
self.data.yyhySever.dafengshoulist[itemCfg.bookid][1]=1
end
elseif v.param_3>=cfg.max then

if not self.data.yyhySever.dafengshoulist[itemCfg.bookid]then
self.data.yyhySever.dafengshoulist[itemCfg.bookid]={}
end
if self.data.yyhySever.dafengshoulist[itemCfg.bookid][2]then
self.data.yyhySever.dafengshoulist[itemCfg.bookid][2]=2
else
self.data.yyhySever.dafengshoulist[itemCfg.bookid][2]=1
end
end
end
end


for k,v in ipairs(reward_arry)do
if v.param_1<60000 or v.param_1>69999 then
local itemConfig=itemsConfig.getConfig(v.param_1)
local color=itemConfig.color
local name=FMT.cfmt(color,itemConfig.name)
local num=v.param_2
UIManager.info(FMT.fmt('{0}x{1}',name,num))
end
end
end
end

function YiYuHuiYouModel:getdafengshoudata()
return self.data.yyhySever.dafengshoulist or{}
end


function YiYuHuiYouModel:refreshWaterObject(wobj_len,wobj_arry)

if wobj_len>0 then
local newWaterObj_Data={}
for k,v in ipairs(wobj_arry)do
newWaterObj_Data[#newWaterObj_Data+1]=v
end

UIManager:callWindowFunc('UIYYHYWin','RefreshWaterObjGenrate',newWaterObj_Data)
end
end


function YiYuHuiYouModel:refreshWaterObjectData(waterObj_Data)
self.data.yyhySever.waterObj_Data[#self.data.yyhySever.waterObj_Data+1]=waterObj_Data
end


function YiYuHuiYouModel:refreshWaterObjectDataAll(waterObj_Data)
self.data.yyhySever.waterObj_Data=waterObj_Data
end


function YiYuHuiYouModel:setWaterObjTword(index,tword)
self.data.yyhySever.waterObj_Data[index].tword=tword
end

function YiYuHuiYouModel:setWaterObjSpeed(index,speed)
self.data.yyhySever.waterObj_Data[index].speed=speed
end

function YiYuHuiYouModel:setWaterObjPos(index,pos_x,pos_y)
self.data.yyhySever.waterObj_Data[index].pos={pos_x,pos_y}
end

function YiYuHuiYouModel:setWaterObjBit_Stage(index,bit_stage)
self.data.yyhySever.waterObj_Data[index].bit_stage=bit_stage
end

function YiYuHuiYouModel:setWaterObjfish_layerNum(index,fish_layerNum)
self.data.yyhySever.waterObj_Data[index].fish_layerNum=fish_layerNum
end

function YiYuHuiYouModel:setWaterObjfish_pfb_id(index,fish_pfb_id)
self.data.yyhySever.waterObj_Data[index].fish_pfb_id=fish_pfb_id
end


function YiYuHuiYouModel:setYuerItemid(id)
self.data.yyhySever.yuerItemID=id
end

function YiYuHuiYouModel:getYuerItemid()
return self.data.yyhySever.yuerItemID
end


function YiYuHuiYouModel:getShopGoodsList()
local datas={}
local config=cfg_xianzhanshopconfig()
for k,cfg in pairs(config)do
local t=datas[cfg.pageTab]
if t==nil then
t={}
datas[cfg.pageTab]=t
end
local sellout=YiYuHuiYouModel:checkGoodSellOut(cfg.id)
local sortWeight=sellout and 0 or 10000
sortWeight=sortWeight+(1000-cfg.sortid)
table.insert(t,{cfg,sortWeight})
end
for k,v in pairs(datas)do
table.sort(v,function(a,b)return a[2]>b[2]end)
end
return datas
end


function YiYuHuiYouModel:init_shopdata(itemListLen,itemList)
self.data.shopDatas={}
if itemListLen>0 then
for i,v in ipairs(itemList)do
self.data.shopDatas[v.itemId]=v
end
end
end

function YiYuHuiYouModel:update_shopdata(shopItem)
local itemId=shopItem.itemId
self.data.shopDatas[itemId]=shopItem
end
function YiYuHuiYouModel:getShopDataByItemid(itemId)
return self.data.shopDatas[itemId]
end

function YiYuHuiYouModel:checkGoodSellOut(shopId,_data)

local data=funcShopModel:get_data(shopId,_data.cfg.id)
if data then


local totalNum=data.buyNum
local totalMax=_data.cfg.buyLimit[1][2]
local weekNum=data.buyNum
local weekMax=_data.cfg.buyLimit[1][2]
if weekMax then
if weekNum>=weekMax then
return true
end
elseif totalMax then
if totalNum>=totalMax then
return true
end
else
return false
end
end
return false
end

function YiYuHuiYouModel:checkGoodSellNumMax(shopId,_data)


local totalMax=_data.cfg.buyLimit[1][2]
local weekMax=_data.cfg.buyLimit[1][2]
local totalNum
local weekNum

local data=funcShopModel:get_data(shopId,_data.cfg.id)
if data then
totalNum=data.buyNum
weekNum=data.buyNum
else
totalNum=0
weekNum=0
end
if weekMax then
if weekNum>=weekMax then
return 0
else
return weekMax-weekNum
end
elseif totalMax then
if totalNum>=totalMax then
return 0
else
return totalMax-totalNum
end
else
return 99
end
end


function YiYuHuiYouModel:getTuJianReddot()
return true
end

function YiYuHuiYouModel:getMuBiaoRewardReddot()
return false
end


function YiYuHuiYouModel:setmemberRankList_YYHY(list)
self.data.yyhySever.rank_Data=list
end

function YiYuHuiYouModel:getmemberRankList_YYHY()
return self.data.yyhySever.rank_Data
end

function YiYuHuiYouModel:setself_idx(self_idx)
self.data.yyhySever.self_idx=self_idx
end

function YiYuHuiYouModel:getself_idx()
return self.data.yyhySever.self_idx or 0
end


function YiYuHuiYouModel:setRankList_YYHY_idxs(idx)
self.data.yyhySever.jfidxs=idx
end
function YiYuHuiYouModel:getRankList_YYHY_idxs()
return self.data.yyhySever.jfidxs or 0
end


function YiYuHuiYouModel:setYuHuoList(id)
if not self.data.yyhySever.yuhuolist then
self.data.yyhySever.yuhuolist={}
end
if#self.data.yyhySever.yuhuolist>0 then
for k,v in ipairs(self.data.yyhySever.yuhuolist)do
if v.ID==id then
self.data.yyhySever.yuhuolist[k].Num=self.data.yyhySever.yuhuolist[k].Num+1
break
end
end
self.data.yyhySever.yuhuolist[#self.data.yyhySever.yuhuolist+1]={ID=id,Num=1}
else
self.data.yyhySever.yuhuolist[#self.data.yyhySever.yuhuolist+1]={ID=id,Num=1}
end


end

function YiYuHuiYouModel:getYuHuoList()
return self.data.yyhySever.yuhuolist or{}
end


function YiYuHuiYouModel:setWaterObjScore(score)
if not self.data.yyhySever.yuhuoscore then
self.data.yyhySever.yuhuoscore=0
end
if score then
self.data.yyhySever.yuhuoscore=self.data.yyhySever.yuhuoscore+score
end
end

function YiYuHuiYouModel:getWaterObjScore()
return self.data.yyhySever.yuhuoscore or 0
end
function YiYuHuiYouModel:clearWaterObjScore()
self.data.yyhySever.yuhuoscore=0
end


function YiYuHuiYouModel:setWaterObjScore_ai(score)
if not self.data.yyhySever.yuhuoscore_ai then
self.data.yyhySever.yuhuoscore_ai=0
end
if score then
self.data.yyhySever.yuhuoscore_ai=self.data.yyhySever.yuhuoscore_ai+score
end
end

function YiYuHuiYouModel:getWaterObjScore_ai()
return self.data.yyhySever.yuhuoscore_ai or 0
end
function YiYuHuiYouModel:clearWaterObjScore_ai()
self.data.yyhySever.yuhuoscore_ai=0
end


function YiYuHuiYouModel:setPinZhiFishlist(color,num)
if#self.data.yyhySever.fishlist>0 then
self.data.yyhySever.fishlist[color]=self.data.yyhySever.fishlist[color]+num
end
end


function YiYuHuiYouModel:getPinZhiFishlist()
local fishlist={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0}
if self.data.yyhySever.fishlist and#self.data.yyhySever.fishlist>0 then
for k,v in pairs(self.data.yyhySever.fishlist)do
fishlist[k]=v
end
end
return fishlist
end










function YiYuHuiYouModel:getUnitDataList()
local list={}
local npcdata=YiYuHuiYouModel:getNPCIdlist()or{}

if npcdata and#npcdata>0 then
for i,v in ipairs(npcdata)do
if worldBlockModel:checkBlockState(v.world,v.block,eWorldBlockState.OPEN)then
local cfg=cfgHelper.get1(cfg_yiyuhuiyounpcconfig_get,v.npcid)
local guankaname=cfg_worldblockconfig_get(v.world)[v.block].name
local blockname=FMT.fmt("{0}\n<color=#686868>{1}</color>",cfg.name,guankaname)
local nandu=cfg_yiyuhuiyounpcconfig_get(v.npcid).nanduImg
local yujulevel=cfg_yiyuhuiyounpcconfig_get(v.npcid).yuju_level
local now_yujulevel=YiYuHuiYouController:getYuJuAllLevel()
local isopen=now_yujulevel>=yujulevel
if not isopen then
local chavalue=yujulevel-now_yujulevel
blockname=FMT.fmt("{0}\n<color=#FF0000>升级任意渔具{1}次\n({2}/3)</color>",cfg.name,chavalue,3-chavalue)
end
local yudata={isopen,yujulevel}

local data={
name=blockname,
icon=cfg.icon,
ing=false,
guid=v,
naduindex=nandu,
yujudata=yudata,
}
table.insert(list,data)
end
end
end
return list
end


function YiYuHuiYouModel:refreshUnitData(data)



end



function YiYuHuiYouModel:checkArenaPosition()

local guids={}
local havePos={}
local noPos={}
local npcdata=YiYuHuiYouModel:getNPCIdlist()

if npcdata and#npcdata>0 then
for i,v in pairs(npcdata)do
table.insert(guids,v.guid)
local posData=worldPositionLibrary:getData(v.guid)
if posData then

local position,block=worldPositionConfig:getPosition(v.world,{posData.x,posData.z})

if position~=Vector3.zero then
v.flip=posData.flip
v.position=position
v.block=block
havePos[block]=(havePos[block]or 0)+1
else

worldPositionLibrary:eraseData(v.guid)
table.insert(noPos,v.guid)
end
else
table.insert(noPos,v.guid)
end
end
end


worldPositionLibrary:checkData(eWorldUnitTpye.YIYUHUIYOU,guids)


local new_pos={}


for k,v in ipairs(noPos)do

if#noPos<=0 then

end
local guid=noPos[k]



local npcdata_single=YiYuHuiYouModel:getNPCIdlistbyGuid(guid)



local check,temp=worldPositionLibrary:extract({npcdata_single.posIdx})


if check then
local posData=temp[1]
local x=posData.x
local z=posData.z
local flip=posData.flip

local position,block=worldPositionConfig:getPosition(npcdata_single.world,{posData.x,posData.z})
if position~=Vector3.zero then
npcdata_single.position=position
npcdata_single.flip=flip
npcdata_single.block=block

worldPositionLibrary:markData(npcdata_single.world,x,z,flip,eWorldUnitTpye.YIYUHUIYOU,guid)
else
new_pos[#new_pos+1]=noPos[k]

npcdata_single.position=Vector3.zero
npcdata_single.flip=false
npcdata_single.block=0
end
else
new_pos[#new_pos+1]=noPos[k]

npcdata_single.position=Vector3.zero
npcdata_single.flip=false
npcdata_single.block=0
end

end


for i,v in ipairs(new_pos)do


local npcdata_single=YiYuHuiYouModel:getNPCIdlistbyGuid(v)
npcdata_single.position=Vector3.zero
npcdata_single.flip=false
npcdata_single.block=0
end



end



function YiYuHuiYouModel:getnpcdatas()
local npcdata={}
local npclist=YiYuHuiYouModel:getNPCIdlist()
local world=1
local block=1
if npcdata and#npcdata>0 then
for k,v in ipairs(npclist)do
local data=worldResPointDataModel:getPointData(v)


npcdata[#npcdata+1]={guid=v}

end
end
return npcdata
end

local lists={}
function YiYuHuiYouModel:setnpcdatas(world,npc_arry)
lists[world]=npc_arry
end

local type={int64.new('-1'),int64.new('-2'),int64.new('-3'),int64.new('-4'),int64.new('-5'),}





function YiYuHuiYouModel:SetYYHYNpcDatas(list,ver_str)




self.data.yyhySever.npc_guid_list=list


for k,v in ipairs(self.data.yyhySever.npc_guid_list)do
local npcguid=type[k]
v.guid=npcguid

end

YiYuHuiYouModel:checkArenaPosition()
end


function YiYuHuiYouModel:convertUnitKey(series)
return worldModel:convertUnitKey({eWorldUnitTpye.YIYUHUIYOU,tostring(series)})
end



function YiYuHuiYouModel:setSpecialEffect(type_list)
if not self.data.yyhySever.SpecialEffect then
self.data.yyhySever.SpecialEffect={}
end
self.data.yyhySever.SpecialEffect[type_list[1][1]]=type_list

end
function YiYuHuiYouModel:getSpecialEffect(index)

return self.data.yyhySever.SpecialEffect[index][1]or{}
end



function YiYuHuiYouModel:sethailongjuanFishlist(list)
if not self.data.yyhySever.hlj_fishlist then
self.data.yyhySever.hlj_fishlist={}
end
if list then
for k,v in ipairs(list)do
self.data.yyhySever.hlj_fishlist[#self.data.yyhySever.hlj_fishlist+1]=v
end
end
local temp=self.data.yyhySever.hlj_fishlist or{}
platformSDK.printSDK('UIYYHYWin_248_60_Fishlist',serializeHelper.serialize(temp))
end
function YiYuHuiYouModel:clearhailongjuanFishlist()
self.data.yyhySever.hlj_fishlist={}
end
function YiYuHuiYouModel:gethailongjuanFishlist()
return self.data.yyhySever.hlj_fishlist or{}
end



function YiYuHuiYouModel:isDaFengShouData()
local list={}
local js_data_alltwo=YiYuHuiYouModel:getRewardData()
local js_data_all=YiYuHuiYouModel:getlYYHYDiaoLuo()

local js_data={}
for k,v in ipairs(js_data_all)do
if v.itemid>=60000 and v.itemid<=69999 then
js_data[#js_data+1]=v
end
end


local templist={}
for k,v in ipairs(js_data_alltwo)do
if v.param_1>=60000 and v.param_1<=69999 then
templist[#templist+1]=v
end
end
local new_templist={}
for k,v in ipairs(js_data_alltwo)do
if v.param_1>=60000 and v.param_1<=69999 then
new_templist[v.param_1]=v
end
end


for k,v in ipairs(js_data)do
if new_templist[v.itemid]then
v.weight=new_templist[v.itemid].param_3 or-2
else
v.weight=-1
end
local itemCfg=itemsConfig.getConfig(v.itemid)
v.bookid=itemCfg.bookid
end



local new_bookslist={}
for k,v in ipairs(js_data)do


if new_bookslist[v.bookid]then



new_bookslist[v.bookid][#new_bookslist[v.bookid]+1]=v
else
new_bookslist[v.bookid]={}
new_bookslist[v.bookid]={v}
end

end


for k,v in pairs(new_bookslist)do
for i,j in ipairs(v)do

if not j.bookid then
loggerUtil.logErrFMT("渔获表没有该对应的bookid,{0}",j.itemid)
end

local cfg=cfgHelper.get1(cfg_yuelongchibookconfig_get,j.bookid)
local data=UIAquariumControl:getHandleBookData(j.bookid)
local itemCfg=itemsConfig.getConfig(j.itemid)

if data then
if data.star<0 and data.times==j.num then

local check_min=UIAquariumControl:checkHandleBookFlag(j.bookid,0)
local check_max=UIAquariumControl:checkHandleBookFlag(j.bookid,2)

local dafengshoulist=YiYuHuiYouModel:getdafengshoudata()
local ismin=-1
local ismax=-1
if dafengshoulist[j.bookid]then
if dafengshoulist[j.bookid][1]then
ismin=dafengshoulist[j.bookid][1]
end
if dafengshoulist[j.bookid][2]then
ismax=dafengshoulist[j.bookid][2]
end
end

if not check_min and ismin==1 then
if j.weight<=cfg.min then

list[j.bookid]={[1]=j}
break
end
end
if not check_max and ismax==1 then
if j.weight>=cfg.max then

list[j.bookid]={[2]=j}
break
end
end
list[j.bookid]={[0]=j}

else

local check_min=UIAquariumControl:checkHandleBookFlag(j.bookid,0)
local check_max=UIAquariumControl:checkHandleBookFlag(j.bookid,2)

local dafengshoulist=YiYuHuiYouModel:getdafengshoudata()
local ismin=-1
local ismax=-1
if dafengshoulist[j.bookid]then
if dafengshoulist[j.bookid][1]then
ismin=dafengshoulist[j.bookid][1]
end
if dafengshoulist[j.bookid][2]then
ismax=dafengshoulist[j.bookid][2]
end
end

if not check_min and ismin==1 then
if j.weight<=cfg.min then

list[j.bookid]={[1]=j}
end
end
if not check_max and ismax==1 then
if j.weight>=cfg.max then

list[j.bookid]={[2]=j}
end
end
end
end
end
end


local new_list_sort={}
for k,v in pairs(list)do
for i,j in pairs(v)do
new_list_sort[#new_list_sort+1]={j,i}
end
end

return new_list_sort
end



function YiYuHuiYouModel:ClearYYHYData()
YiYuHuiYouModel:setXianLuId(nil)


YiYuHuiYouModel:clearWaterObjScore()
YiYuHuiYouModel:clearWaterObjScore_ai()
YiYuHuiYouModel:setRewardDataNil()
YiYuHuiYouModel:ClearlYYHYDiaoLuo()
end
function YiYuHuiYouModel:ClearYYHYDatadizinpc()
YiYuHuiYouModel:setDiZiId(nil)
YiYuHuiYouModel:setNPCId(nil)
end


function YiYuHuiYouModel:handelYYHYScoreAdd(score)
if not self.data.yyhySever.week_reward_val then
self.data.yyhySever.week_reward_val=0
end
local hbnum=self:gethebingCnt()
if hbnum>0 then
self.data.yyhySever.week_reward_val=self.data.yyhySever.week_reward_val+score*hbnum
else
self.data.yyhySever.week_reward_val=self.data.yyhySever.week_reward_val+score
end
end


function YiYuHuiYouModel:setlYYHYRankMaxScore(score)
if not self.data.yyhySever.recordgame_score then
self.data.yyhySever.recordgame_score=0
end
if self.data.yyhySever.recordgame_score<score then
self.data.yyhySever.recordgame_score=score
end
end


function YiYuHuiYouModel:getlYYHYRankMaxScore()
return self.data.yyhySever.recordgame_score or 0
end

function YiYuHuiYouModel:getlYYHYRankBsetScore()
return self.data.yyhySever.week_best_score or 0
end


function YiYuHuiYouModel:setlYYHYDiaoLuo(data)
if not self.data.yyhySever.diaoluolist then
self.data.yyhySever.diaoluolist={}
end
self.data.yyhySever.diaoluolist[#self.data.yyhySever.diaoluolist+1]=data
end
function YiYuHuiYouModel:getlYYHYDiaoLuo()

return self.data.yyhySever.diaoluolist or{}
end
function YiYuHuiYouModel:ClearlYYHYDiaoLuo()
self.data.yyhySever.diaoluolist={}
end


function YiYuHuiYouModel:setnpczhiyinid(zhiyinid)
self.data.yyhySever.zhinyinid=zhiyinid or 1
end
function YiYuHuiYouModel:getnpczhiyinid()

return self.data.yyhySever.zhinyinid or 1
end



function YiYuHuiYouModel:getTiaoZhanResidueCount()
local battlenum=YiYuHuiYouModel:getEnter_cnt()
local tiaozhanmax=cfg_yiyuhuiyoubaseconfig_get(1).enter_cnt
local buy_enter_cost=cfg_yiyuhuiyoubaseconfig_get(1).buy_enter_cnt
local buy_enter_cnt=#buy_enter_cost

local battlemax=tiaozhanmax+buy_enter_cnt
return battlemax-battlenum
end
