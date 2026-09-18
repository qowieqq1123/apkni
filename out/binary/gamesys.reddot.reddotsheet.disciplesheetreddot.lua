








discipleBaseSheetReddot=reddotSheetBase.new({classname='discipleBaseSheetReddot'})

discipleBaseSheetReddot.reddot_type=REDDIT_TYPE.eDiscipleBase

discipleBaseSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sDiscipleBase]=
{
catch={
CATCH_TYPE.eDisciple,
CATCH_TYPE.eDiscipleJJ,
CATCH_TYPE.eZongMenLevel,
CATCH_TYPE.eDiziChuiWei,
CATCH_TYPE.eMoney,
CATCH_TYPE.eItem,
CATCH_TYPE.eDiscipleLT,
CATCH_TYPE.eDiscipleFightChanged,
CATCH_TYPE.eEquipJingLianFilterChanged,
CATCH_TYPE.eFabaoJiLianFilterChanged,
CATCH_TYPE.eDiscipleTianMing,
CATCH_TYPE.eBenMingFaBaoReddotChange,
CATCH_TYPE.eDiscipleGongFaChange,
CATCH_TYPE.eDiscipleDaoYan,
CATCH_TYPE.eDiscipleSpriteRoot,
},
func=function(asynch,asynchData)
return UIDiscipleModel:checkAllDiscipleJJReddot(asynch,asynchData)
end,

asynch=true,
},


[REDDIT_SUB_TYPE.sDiscipleWenXin]=
{
catch={
CATCH_TYPE.eDiscipleJJ,
},
func=function(asynch,asynchData)
return UIDiscipleModel:checkAllDiscipleWXGReddot(asynch,asynchData)
end,

asynch=true,
},

[REDDIT_SUB_TYPE.sDiscipleXianMo]=
{
catch={
CATCH_TYPE.eMoney,
CATCH_TYPE.eItem,
CATCH_TYPE.eDiscipleJJ,
},
func=function(asynch,asynchData)
return UIDiscipleModel:checkAllDiscipleXianMoReddot(asynch,asynchData)
end,

asynch=true,
},
}



discipleInfoSheetReddot=reddotSheetBase.new({classname='discipleInfoSheetReddot'})

discipleInfoSheetReddot.reddot_type=REDDIT_TYPE.eDiscipleInfo

discipleInfoSheetReddot.reddot_config=
{

[REDDIT_SUB_TYPE.sDiscipleInfo]=
{
catch={
CATCH_TYPE.eMoney,
CATCH_TYPE.eItem,
CATCH_TYPE.eDisciple,
CATCH_TYPE.eDiscipleJJ,
CATCH_TYPE.eDiscipleLT,
CATCH_TYPE.eDiziChuiWei,
CATCH_TYPE.eZongMenLevel,
CATCH_TYPE.eDiscipleChangeTab,
CATCH_TYPE.eDiscipleQiZhen,
CATCH_TYPE.eDiscipleCuiTi,
CATCH_TYPE.eDZQiZhenSystemOpen,
CATCH_TYPE.eDiscipleFightChanged,
},
func=function(catchType,...)
if fullScreenUI.isActiveFullEx(FULL_TYPE.eDiscipleMain)then
local attach={}
UIFullDiscipleMainControl:copyAttach2(attach)
local dis_guid=attach.dis_guid
if dis_guid then
return UIDiscipleModel:checkDiscipleInofReddot2(dis_guid)or UIDiscipleModel:checkDiscipleXianMoTransferReddot(dis_guid)
end
end
return false
end,
},


[REDDIT_SUB_TYPE.sDiscipleInfo_Equip]={
catch={
CATCH_TYPE.eMoney,
CATCH_TYPE.eItem,
CATCH_TYPE.eEquipJingLianFilterChanged,
CATCH_TYPE.eFabaoJiLianFilterChanged,
CATCH_TYPE.eDiscipleChangeTab,
CATCH_TYPE.eBenMingFaBaoReddotChange,
CATCH_TYPE.eDiscipleFightChanged,
CATCH_TYPE.eZMLevel,
CATCH_TYPE.eDiscipleLingShouChange,
},
func=function(catchType,...)
if fullScreenUI.isActiveFullEx(FULL_TYPE.eDiscipleMain)then
local attach={}
UIFullDiscipleMainControl:copyAttach2(attach)
local dis_guid=attach.dis_guid
if dis_guid then
if not UIDiscipleModel:checkDiscipleIsTop5(dis_guid)then
return false
end
return UIDiscipleModel:checkDiscipleEquipReddot(dis_guid)
end
end
return false
end,
},



[REDDIT_SUB_TYPE.sDiscipleInfo_Skill]={
catch={
CATCH_TYPE.eMoney,
CATCH_TYPE.eItem,
CATCH_TYPE.eFabaoJiLianFilterChanged,
CATCH_TYPE.eDiscipleChangeTab,
CATCH_TYPE.eBenMingFaBaoReddotChange,
CATCH_TYPE.eDiscipleFightChanged,
CATCH_TYPE.eDiscipleGongFaChange,
},
func=function(catchType,...)
if fullScreenUI.isActiveFullEx(FULL_TYPE.eDiscipleMain)then
local attach={}
UIFullDiscipleMainControl:copyAttach2(attach)
local dis_guid=attach.dis_guid
if dis_guid then
if not UIDiscipleModel:checkDiscipleIsTop5(dis_guid)then
return false
end

return UIDiscipleModel:checkDiscipleSkillReddot(dis_guid)
end
end
return false
end,
},



[REDDIT_SUB_TYPE.sDiscipleTianMing]=
{
catch={
CATCH_TYPE.eMoney,
CATCH_TYPE.eItem,
CATCH_TYPE.eDiscipleTianMing,
CATCH_TYPE.eDiscipleChangeTab,
CATCH_TYPE.eDiscipleTianMingCiFuChange,
CATCH_TYPE.eDiscipleDaoYan,
},
func=function(catchType,...)
if fullScreenUI.isActiveFullEx(FULL_TYPE.eDiscipleMain)then
local attach={}
UIFullDiscipleMainControl:copyAttach2(attach)
local dis_guid=attach.dis_guid
if dis_guid then
return UIDiscipleModel:getDiscipleTianMingReddot(dis_guid)or UIDiscipleModel:getDiscipleTianMingCiFuReddot(dis_guid)or UIDiscipleModel:getDiscipleDaoYanReddot(dis_guid)
end
end
return false
end,
},


[REDDIT_SUB_TYPE.sDiscipleLingGen]=
{
catch={
CATCH_TYPE.eMoney,
CATCH_TYPE.eItem,
CATCH_TYPE.eDiscipleSpriteRoot,
CATCH_TYPE.eDiscipleChangeTab,
},
func=function(catchType,...)
if fullScreenUI.isActiveFullEx(FULL_TYPE.eDiscipleMain)then
local attach={}
UIFullDiscipleMainControl:copyAttach2(attach)
local dis_guid=attach.dis_guid
if dis_guid then
return UIDiscipleModel:checkDiscipleStrengthenLingGenReddot(dis_guid)or
UIDiscipleModel:checkDiscipleVaryLingGenReddot(dis_guid)or
UIDiscipleModel:checkDiscipleCanEquipHoardReddot(dis_guid)or
mzbkModel:getOneTimeReddot()
end
end
return false
end,
},
}




































discipleEquipSheetReddot=reddotSheetBase.new({classname='discipleEquipSheetReddot',subType_=REDDIT_SUB_TYPE.sDiscipleEquip})

discipleEquipSheetReddot.reddot_type=REDDIT_TYPE.eDiscipleEquip

discipleEquipSheetReddot.isDynamic=true

discipleEquipSheetReddot.sub_type={
eJingLian=1,
eChongZhu=2,
eNingLian=3,
eRonghe=4,
}

discipleEquipSheetReddot.sub_type_config=
{
[discipleEquipSheetReddot.sub_type.eJingLian]=
function(itemguid)
return{
catch={
CATCH_TYPE.eMoney,
CATCH_TYPE.eItem,
CATCH_TYPE.eEquipJingLianFilterChanged,
CATCH_TYPE.eChongZhu,
},
func=function(catchType,...)
return equipsHelper.checkEquipIsCanJingLian(itemguid)and(not equipsModel:isEquipChongzhu(itemguid))
end,
}
end,
[discipleEquipSheetReddot.sub_type.eChongZhu]=
function(itemguid)
return{
catch={
CATCH_TYPE.eChongZhu,
},
func=function(catchType,...)
return equipsModel:isEquipChongzhu(itemguid)
end,
}
end,
[discipleEquipSheetReddot.sub_type.eNingLian]=
function(itemguid)
return{
catch={
CATCH_TYPE.eNingLian,
},
func=function(catchType,...)
return equipsModel.isReddotEquipNingLian(itemguid)
end,
}
end,
[discipleEquipSheetReddot.sub_type.eRonghe]=
function(itemguid)
return{
catch={
CATCH_TYPE.eRonghe,
},
func=function(catchType,...)
return false
end,
}
end,
}


function discipleEquipSheetReddot:onAppStart()

end
function discipleEquipSheetReddot:onEnterState()
self:resetConfig()
self:initConfig()
end
function discipleEquipSheetReddot:onLeaveState()
self:resetConfig()
end


function discipleEquipSheetReddot:initConfig()

if self.reddot_config==nil then
self.reddot_config={}
self.subTypeList=nil

reddotClassManager.init_class(self)

self:init_data()
self.init=true
end
end

function discipleEquipSheetReddot:resetConfig()

reddotClassManager.reset_class(self)
self:reset_data()
self.reddot_config=nil
self.itemguid=nil
self.initSubType={}
self.init=nil
self.subTypeList={}
end

function discipleEquipSheetReddot:getSubTypeReddotId(sub_type,itemguid)
local isNew=true
if self.itemguid then
if mathHelper.compareInt64(self.itemguid,itemguid)then
isNew=self.initSubType[sub_type]~=true
else
self:resetConfig()
self.itemguid=itemguid
end
else
self.itemguid=itemguid
end

if not self.init then
self:initConfig()
end
local key=self:getSubReddotKey(sub_type)
if isNew then
local subConfig=discipleEquipSheetReddot.sub_type_config[sub_type](itemguid)
self.reddot_config[key]=subConfig
reddotClassManager.add_class_config(self,key,subConfig)
self.initSubType[sub_type]=true
end
return key
end




discipleFabaoSheetReddot=reddotSheetBase.new({classname='discipleFabaoSheetReddot',subType_=REDDIT_SUB_TYPE.sDiscipleFabao})

discipleFabaoSheetReddot.reddot_type=REDDIT_TYPE.eDiscipleFabao

discipleFabaoSheetReddot.isDynamic=true

discipleFabaoSheetReddot.sub_type={
eJiLian=1,
eLianHua=2,
}

function discipleFabaoSheetReddot:onAppStart()

end
function discipleFabaoSheetReddot:onEnterState()
self:resetConfig()
self:initConfig()
end
function discipleFabaoSheetReddot:onLeaveState()
self:resetConfig()
end


function discipleFabaoSheetReddot:initConfig()

if self.reddot_config==nil then
self.reddot_config={}
self.subTypeList=nil

reddotClassManager.init_class(self)

self:init_data()
self.init=true
end
end

function discipleFabaoSheetReddot:resetConfig()

reddotClassManager.reset_class(self)
self:reset_data()
self.reddot_config=nil
self.itemguid=nil
self.initSubType={}
self.init=nil
self.subTypeList={}
end

function discipleFabaoSheetReddot:getSubTypeReddotId(sub_type,itemguid)
local isNew=true
if self.itemguid then
if mathHelper.compareInt64(self.itemguid,itemguid)then
isNew=self.initSubType[sub_type]~=true
else
self:resetConfig()
self.itemguid=itemguid
end
else
self.itemguid=itemguid
end

if not self.init then
self:initConfig()
end
local key=self:getSubReddotKey(sub_type)
if isNew then
local subConfig={
catch={
CATCH_TYPE.eMoney,
CATCH_TYPE.eItem,
CATCH_TYPE.eFabaoJiLianFilterChanged,
},
func=function(catchType,...)
return fabaoHelper.checkFabaoIsCanJiLian(itemguid)
end,
}
self.reddot_config[key]=subConfig
reddotClassManager.add_class_config(self,key,subConfig)
self.initSubType[sub_type]=true
end
return key
end
