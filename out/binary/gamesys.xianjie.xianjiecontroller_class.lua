









xjDataConfig={
[xjDataType.eCloud]={2,'xjEntityData_cloud'},
[xjDataType.eCloudPlot]={2,'xjEntityData_cloudPlot'},
[xjDataType.eCloudLock]={2,'xjEntityData_cloudLock'},
[xjDataType.eMonster]={2,'xjEntityData_monster'},
[xjDataType.eResource]={2,'xjEntityData_resource'},
[xjDataType.eStation]={2,'xjEntityData_station'},
[xjDataType.eZongMen]={2,'xjEntityData_zongmen'},
[xjDataType.eXianMeng]={2,'xjEntityData_xianmeng'},
[xjDataType.eXianMengEffect]={2,'xjEntityData_XianMengEffect'},
[xjDataType.eNPC]={2,'xjEntityData_NPC'},
[xjDataType.eMarchTeam]={2,'xjEntityData_marchTeam'},
[xjDataType.eResPoint_Monster]={2,'xjEntityData_RPMonster'},
[xjDataType.eResPoint_Event]={2,'xjEntityData_RPEvent'},
[xjDataType.eResPoint_NPC]={2,'xjEntityData_RPNPC'},
[xjDataType.eResPoint_Collectible]={2,'xjEntityData_RPCollectible'},
[xjDataType.eResPoint_Mystery]={2,'xjEntityData_RPMystery'},
[xjDataType.eResPoint_MarchTeam]={2,'xjEntityData_RPMarchTeam'},
[xjDataType.eCloudQiYu]={2,'xjEntityData_cloudQiYu'},
[xjDataType.eLeyLine]={2,'xjEntityData_LeyLine'},
[xjDataType.eTransfer]={2,'xjEntityData_transfer'},
[xjDataType.eXJFMBoss]={2,'xjEntityData_XJFMBoss'},
[xjDataType.eResPoint_CanvertCollectible]={2,'xjEntityData_RPCtCollectible'},
[xjDataType.eArena]={2,'xjEntityData_arena'},
[xjDataType.eCloudUnLock]={2,'xjEntityData_cloudUnLock'},
[xjDataType.eXJXingYu]={2,'xjEntityData_XJXingYu'},
[xjDataType.eZuoBiao]={2,'xjEntityData_XMBiaoJi'},
[xjDataType.eMoGong]={2,'xjEntityData_MoGong'},
[xjDataType.eNotDataMarchTeam]={2,'xjEntityData_notDataMarchTeam'},
[xjDataType.eMoJiang]={2,'xjEntityData_MoJiang'},
[xjDataType.eMoJiangRange]={2,'xjEntityData_MoJiangRange'},
[xjDataType.eMoJingZhenJi_Origin]={2,'xjEntityData_BenYuanZhenJi'},
[xjDataType.eMoJieGate]={2,'xjEntityData_MoJieGate'},
[xjDataType.eMoJun]={2,'xjEntityData_MoJun'},
[xjDataType.eMoJunRange]={2,'xjEntityData_MoJunRange'},
[xjDataType.eMoJunTiaoZhanRange]={2,'xjEntityData_MoJunTiaoZhanRange'},
[xjDataType.eMoJunEffect]={2,'xjEntityData_MoJunEffect'},
[xjDataType.eMoJunBox]={2,'xjEntityData_MoJunBox'},
[xjDataType.eMoJunFenShen]={2,'xjEntityData_MoJunFenShen'},
[xjDataType.eMoJunBox_MarchTeam]={2,'xjEntityData_MoJunBoxTeam'},
[xjDataType.eCaravanEscortEnter]={2,'xjEntityData_caravanEscortEnter'},
[xjDataType.eCaravanEscortTeam]={2,'xjEntityData_caravanEscortTeam'},
[xjDataType.eMGZD_ZhanHunGe]={2,'xjEntityData_MGZDZhanHunGe'},
[xjDataType.eMGZD_HuLingTa]={2,'xjEntityData_MGZDHuLingTa'},
[xjDataType.eCaravanEscortHub]={2,'xjEntityData_caravanEscortHub'},
[xjDataType.eZhenTai]={2,'xjEntityData_ZhenTai'},
[xjDataType.eMoGongRange]={2,'xjEntityData_MoGongRange'},
[xjDataType.eMoJingZhenJi_Normal]={2,'xjEntityData_PuTongZhenJi'},
[xjDataType.eZhenTaiRange]={2,'xjEntityData_ZhenTaiRange'},
[xjDataType.eLingShou]={2,'xjEntityData_lingshou'},
[xjDataType.eLingshouGroup]={2,'xjEntityData_lingshouGroup'},
}





function xianjieController:createXJClass(dataType,data)
return new_xjClass(dataType,data)
end


function xianjieController:removeXJClass(obj)
release_xjClass(obj)
end


function xianjieController:getXJClass(mID)
return get_xjClass(mID)
end