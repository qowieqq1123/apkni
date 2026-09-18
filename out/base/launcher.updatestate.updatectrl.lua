updateCtrl={};

local _DownloadGroup=CS.ResourceHelper.DownloadGroup

local this=updateCtrl;

this.LoadTaskList={};

function updateCtrl.DownLoadGroupID(GroupID,ProgressCallBack,AllLoadCallBack)

local TempLoadAllGroupRes=function(IsError,VesionID)
AllLoadCallBack(IsError,VesionID);

if#this.LoadTaskList>0 then

local DownLoadReq=this.LoadTaskList[1];
table.remove(1);
updateCtrl.DownLoadGroupID(DownLoadReq.m_GroupID,DownLoadReq.m_ProgressCallBack,DownLoadReq.m_AllLoadCallBack);
else

end
end

local loadSize=_DownloadGroup(GroupID,ProgressCallBack,TempLoadAllGroupRes);
if loadSize<=0 then

table.insert(this.LoadTaskList,{m_GroupID=GroupID,m_ProgressCallBack=ProgressCallBack,m_AllLoadCallBack=AllLoadCallBack});
end
end

