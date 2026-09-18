







def_class("UIXM_ZZSH_noteTips",UIWindowBase)









function UIXM_ZZSH_noteTips:bindComponents()

self.closeButton=UIButton.get(self,0)
self.title=UIText.get(self,1)
self.rewardPanel=UIObject.get(self,2)
self.jumpBtn=UIButton.get(self,3)
self.frame=UIButton.get(self,4)
self.discipleModelRoot=UIObject.get(self,5)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIXM_ZZSH_noteTips")end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.frame:setButtonClick(function()self:onFrame()end)



end


function UIXM_ZZSH_noteTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.frame);self.frame=nil;
_UIObject_release(self.discipleModelRoot);self.discipleModelRoot=nil;
end



















function UIXM_ZZSH_noteTips:onLoaded(...)
self:bindComponents()
end


function UIXM_ZZSH_noteTips:__delete()
self:unbindComponents()
end




function UIXM_ZZSH_noteTips:onShow(argtable,afterOnloaded)
if newbieControl.isInNewbie()then
self:onFrame()
return
end
local tipstable=zhengzhanshanhaiModel:Get_logtips()
self.rewardPanel:setChildLayoutGroupCreateItems(#tipstable)
local grids=self.rewardPanel:getChildLayoutGroupGridList()
self.jumptoMonster=false
for i=1,#tipstable do
local rwItem=grids[i-1]

local datatb=tipstable[i]
local cfgid=datatb.logtype
local str_cfg=zhengzhanshanhaiController:getZZSHCfg_log(cfgid,"tips_str")
local type=zhengzhanshanhaiController:getZZSHCfg_log(cfgid,"type")
if type==1 or type==2 then
if type==1 then
self.jumptoMonster=true
end

local logtxt=self:SetStr(str_cfg,datatb.params,cfgid)
rwItem:SetChildText(1,logtxt)


self:Set_BigType(rwItem,datatb)
end
end

local dis_list=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eZhangMen)or{}
local discipleguid=0
if not next(dis_list)then
local plot1=UIDiscipleModel:findSrcTypeDisciple(discipleSrcType.ePlot1)
discipleguid=plot1.discipleguid
else
discipleguid=dis_list[1].discipleguid
end
local args={bgFisrt=true}
comHelper.setChildInSideModel(self.discipleModelRoot,discipleguid,0.85,nil,0,0,false,false,nil,args)
zhengzhanshanhaiModel:saveRecord_Monster()
zhengzhanshanhaiModel:saveRecord_Resource()
end


function UIXM_ZZSH_noteTips:onHide()

end


function UIXM_ZZSH_noteTips:Set_BigType(item,datatb)
local abname=globalABLookup.zzshicons


item:SetChildCSImageSprite(0,abname,zhengzhanshanhaiController:getZZSHCfg_log(datatb.logtype,"small_type"))
end

function UIXM_ZZSH_noteTips:SetStr(str_cfg,json_str,cfgid)

local str_1=str_cfg


local tbstr=self:splitStr(json_str)


local str_2=nil

if cfgid==5 then
local name=self:GetName(cfgid,tonumber(tostring(tbstr[2])))
str_2=FMT.fmt(str_1,tbstr[1],name and name or tbstr[2])
else
local name=self:GetName(cfgid,tonumber(tostring(tbstr[1])))
str_2=FMT.fmt(str_1,name and name or tbstr[1],tbstr[2],tbstr[3])
end



return str_2
end
local cjson=require'cjson'

function UIXM_ZZSH_noteTips:splitStr(str)
return cjson.decode(str)
end


function UIXM_ZZSH_noteTips:GetName(id,cfg_id)

if not cfg_id or type(cfg_id)=="userdata"then
return"未知"
end
local type=zhengzhanshanhaiController:getZZSHCfg_log(id).type
if type==1 then

local ZZSHmonstercfg=zhengzhanshanhaiController:getZZSHCfg_yishou(cfg_id)
local monstertb=ZZSHmonstercfg.monster
local stage=ZZSHmonstercfg.stage

if monstertb and monstertb[1]then
local monstername=cfgHelper.get2(cfg_monstergroup_get,monstertb[1],'name')
local namestr=FMT.fmt("<color={0}>【{1}阶{2}】</color>",FONT_COLOR_VAL[stage],stage,monstername)
return namestr
end
elseif type==2 then
local baoditb=zhengzhanshanhaiController:getZZSHCfg_baodi(cfg_id)
local stage=baoditb.stage

local moneytype=baoditb.moneytype
local moneyname=moneyModel.getMoneyName(moneytype)

local namestr=FMT.fmt("<color={0}>【{1}阶{2}】</color>",FONT_COLOR_VAL[stage],stage,moneyname)
return namestr
end
end




function UIXM_ZZSH_noteTips:onJumpBtn()
if self.jumptoMonster then
zhengzhanshanhaiController:OpenZhengZhanShanHaiMonsterLog()
else
zhengzhanshanhaiController:OpenZhengZhanShanHaiResourceLog()
end

UIManager:closeWindow("UIXM_ZZSH_noteTips")
end



function UIXM_ZZSH_noteTips:onFrame()
UIManager:closeWindow("UIXM_ZZSH_noteTips")
end

