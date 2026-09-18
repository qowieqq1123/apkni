
local _MODULENAME="MysteryEventRecv"


def_table(_MODULENAME)
MysteryEventRecv.name=_MODULENAME

local recvStruct={
[MysteryEventSendType.eMystery]=function(args)
return{args.fzId}
end,
[MysteryEventSendType.eLiLian]=function(args)
return{args.dynamicType,args.lilianid}
end,
[MysteryEventSendType.eResPoint]=function(args)
return{args.dynamicType,args.world_id,args.guid,args.op_idx,args.id}
end,
[MysteryEventSendType.eYSLK]=function(args)
return{args.dynamicType,args.event_id,args.idx}
end,
[MysteryEventSendType.eActivies]=function(args)
return{args.dynamicType,args.act_id,args.act2_id,args.idx,args.event_idx}
end,
[MysteryEventSendType.eSFPY]=function(args)
return{args.dynamicType,args.point}
end,
[MysteryEventSendType.eXianJie]=function(args)
return{args.dynamicType,args.eventtype,args.cloudid,args.idx}
end,
[MysteryEventSendType.eXianJieResPoint]=function(args)
return{args.dynamicType,args.guid}
end,
[MysteryEventSendType.eXianJieForce]=function(args)
return{args.dynamicType,args.taskId}
end,
[MysteryEventSendType.eZongMenScene]=function(args)
return{args.dynamicType,args.sf_id,args.un_build_id,args.areaId}
end,
}

function MysteryEventRecv.getHandle(eType)
return recvStruct[eType]
end