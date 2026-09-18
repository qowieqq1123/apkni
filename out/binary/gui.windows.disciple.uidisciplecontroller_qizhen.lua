







function UIDiscipleController:onAppStart_qizhen()
socketManager:register_receiver(2,86,UIDiscipleController.do_protocol_2_86)
socketManager:register_receiver(2,87,UIDiscipleController.do_protocol_2_87)
end

function UIDiscipleController:onEnterState_qizhen()
UIDiscipleModel:initQiZhenGroup()
end

function UIDiscipleController:onLeaveState_qizhen()
UIDiscipleModel:clearQiZhenGroup()
end




function UIDiscipleController:reqUseQiZhen(discipleguid,itemid,usednum)



socketManager:send_2_86(discipleguid,itemid,usednum)
end






function UIDiscipleController.do_protocol_2_86(discipleguid,itemid,usednum,ctexp)





local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end

netData.qzctexp=ctexp
local qzList=netData.qzList
local oldnum=-1
local f=nil
if qzList then
for i,v in ipairs(qzList)do
if v.param_1==itemid then
f=v
break
end
end
else
qzList={}
netData.qzList=qzList
end
if f==nil then
f={param_1=itemid,param_2=usednum}
table.insert(qzList,f)
netData.qzItemlookup[itemid]=f
else
oldnum=f.param_2
f.param_2=usednum
end
netData.qzlistlen=#qzList

if oldnum~=usednum then
local usenum
if oldnum<0 then
usenum=usednum
else
usenum=usednum-oldnum
end
if usenum>0 then
local qzcfg=cfgHelper.get1(cfg_discipleqizhenconfig_get,itemid)
if qzcfg.attr then
for i,v in ipairs(qzcfg.attr)do
local attrID=v[1]
local attrValue=v[2]*usenum
local str=FMT.fmt('{0}+{1}',helper.getAttributeName(attrID),attrValue)
commonTipsHelper.addThrowOutAndSliderTipsEx({1,str})
end
end
if qzcfg.percent and qzcfg.percent>0 then
local str=FMT.fmt('炼体属性+{0}%',qzcfg.percent*usenum)
commonTipsHelper.addThrowOutAndSliderTipsEx({1,str})
end
if qzcfg.exp and qzcfg.exp>0 then
local str=FMT.fmt('气血值+{0}',qzcfg.exp*usenum)
commonTipsHelper.addThrowOutAndSliderTipsEx({1,str})
end
end

UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eQiZhen,true)
notifySystem:postNotify(notifyConfig.onDiscipleQiZhenChange,discipleguid)
reddotControl.onDiscipleQiZhenChange(discipleguid)
end
end


function UIDiscipleController.do_protocol_2_87(discipleguid)


local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end

netData.qzlistlen=0
netData.qzList=nil
netData.qzItemlookup={}
netData.qzctlv=1
netData.qzctexp=0

UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eQiZhen,true)
local isclear=true
notifySystem:postNotify(notifyConfig.onDiscipleQiZhenChange,discipleguid,isclear)
notifySystem:postNotify(notifyConfig.onDiscipleCuiTiChange,discipleguid,nil)
reddotControl.onDiscipleQiZhenChange(discipleguid,isclear)
reddotControl.onDiscipleCuiTiChange(discipleguid,isclear)
end
