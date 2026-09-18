







def_class("UIXianJunYanZhenRecordWin",UIWindowBase)









function UIXianJunYanZhenRecordWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.notRecord=UIObject.get(self,1)
self.scrollerView=UIObject.get(self,2)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXianJunYanZhenRecordWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.notRecord);self.notRecord=nil;
_UIObject_release(self.scrollerView);self.scrollerView=nil;
end
















local item_index=
{
desc=0,
buff=1,
buffIcon=2,
smallType=3,
middleType=4,
detailsBtn=5,
new=6,
}

local _this




function UIXianJunYanZhenRecordWin:onLoaded(...)
self:bindComponents()
_this=self
self.scrollerView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIXianJunYanZhenRecordWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianJunYanZhenRecordWin:onShow(argtable,afterOnloaded)
self.gx_id=argtable.gx_id
if not self.gx_id then
self.gx_id=XianJunYanZhenModel:getCurGxId()
end
self:refreshPanel()

XianJunYanZhenModel:clearNewLog()
end


function UIXianJunYanZhenRecordWin:onHide()

end

function UIXianJunYanZhenRecordWin:refreshPanel()
local abname="ui/windows/xianjunyanzhen/xianjunyanzhen_atlas_pak.ab"
self.recordData=XianJunYanZhenModel:getLogList(self.gx_id)
self.fightIdList=XianJunYanZhenModel:getFightIdList()
local recordLen=#self.recordData
self.scrollerView:setActive(recordLen>0)
self.notRecord:setActive(recordLen<=0)
if recordLen>0 then
self.scrollerView:setChildScrollViewCreateGrids(#self.recordData,1)
local grids=self.scrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local index=recordLen-i+1
local record=self.recordData[index]
local fightId=self.fightIdList[index]

local gx_id=record.gx_id
local mon_groub_idx=record.mon_groub_idx
local ret=record.ret
local total_xiushi_cnt=record.total_xiushi_cnt
local qs_xiushi_cnt=record.qs_xiushi_cnt
local damage_rate=record.damage_rate

local mon_groub_list=cfgHelper.get2(cfg_xianjunyanzhengxconfig_get,gx_id,"mon_groub_list")
local monster=mon_groub_list[mon_groub_idx]
local monsterId=monster[1]
local minTeamNum=monster[2]
local dzBuffs=monster[3]
local monsterBuffs=monster[4]
local buffType=monster[6]
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterId)

local multi_battle_mon_id=cfgHelper.get2(cfg_xianjunyanzhengxconfig_get,gx_id,"multi_battle_mon_id")
local isMultiBattle=multi_battle_mon_id~=nil and multi_battle_mon_id[mon_groub_idx]~=nil

local isNew=XianJunYanZhenModel:isNewLog(index)

local smallIcon
local descStr=FMT.fmt("                      <color=#549327>您</color> 派遣弟子挑战<color=#c82c2c>[{0}]</color>",monsterCfg.name)
if ret==0 then
smallIcon="image_tiaozhanchenggong_1"
descStr=FMT.fmt("{0}取得胜利，此间本宗修士轻伤：<color=#549327>{1}</color>",descStr,qs_xiushi_cnt)
elseif ret==1 then
smallIcon="image_tiaozhanshibai_1"
if isMultiBattle then
local rate=math.floor(damage_rate/10)/10
descStr=FMT.fmt("{0}，成功对其造成<color=#ca631d>{1}%</color>生命伤害，此间本宗修士轻伤：<color=#549327>{2}</color>",descStr,rate,qs_xiushi_cnt)
else
descStr=FMT.fmt("{0}不幸落败，只能悻悻而归",descStr)
end
end
item:SetChildText(item_index.desc,descStr)
item:SetChildCSImageSprite(item_index.smallType,abname,smallIcon)
item:SetChildActive(item_index.new,isNew)

local hasDzBuff,hasMonBuff,buffDesc
if ret==0 then
if dzBuffs and next(dzBuffs)then
for k,v in pairs(dzBuffs)do
local buffId=v[1]
local level=v[2]
local cfg=cfgHelper.getSSlawRule(buffId)
descStr=string.format(cfg.attrdesc,unpack(cfg.descparm[level]))
hasDzBuff=true
end
end
if monsterBuffs and next(monsterBuffs)then
for mId,v in pairs(monsterBuffs)do
for k,vv in pairs(v)do
local buffId=vv[1]
local level=vv[2]
local cfg=cfgHelper.getSSlawRule(buffId)
local desc=string.format(cfg.attrdesc,unpack(cfg.descparm[level]))

local monsterName=cfgHelper.get2(cfg_monstergroup_get,mId,"name")
descStr=FMT.fmt(desc,monsterName)
end
hasMonBuff=true
end
end
item:SetChildText(item_index.buff,descStr)
end
local hasBuff=hasDzBuff or hasMonBuff
item:SetChildActive(item_index.buff,ret==0 and hasBuff)
if ret==0 and hasBuff then
local abname="ui/windows/xianjunyanzhen/xianjunyanzhen_atlas_pak.ab"
local iconname
if hasDzBuff then
if buffType==1 then
iconname="image_xianjunyanzhen_jt02"
else
iconname="image_xianjunyanzhen_jt01"
end
else
iconname="image_xianjunyanzhen_boss01"
end
item:SetChildCSImageSprite(item_index.buffIcon,abname,iconname)
end

local is_win=ret==0 and 1 or 0
item:SetChildButtonClick(item_index.detailsBtn,function(...)
local _fun=function(fightLoglist)
local fightLog=fightLoglist[1]
local _fightInfo=fightModel:getJsonReport(fightLog)
local temp=
{
win=is_win,
yunjun=false,
jgxjyz=true,
fightInfo=_fightInfo,
timetxt="",
fightarry={fightId,{nil,fightId,eRePlayerType.xianjunyanzhen,_this.gx_id,is_win,showBattle=true,eReplayType=eRePlayerType.xianjunyanzhen}},
rijbdata={gx_id,mon_groub_idx},
}
_this:showWindow('UIXianJie_notejianbao',temp)
end
local args={nil,fightId,eRePlayerType.xianjunyanzhen,"进攻取得了胜利",is_win,showBattle=true,extraCall=_fun}
fightController:send_log_list({fightId},args)
end)
end
end
end




function UIXianJunYanZhenRecordWin:onCloseBtn()
UIFullXianJunYanZhenControl:closeWindow(self.winlua.name)
end

