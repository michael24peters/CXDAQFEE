
object: FEE is_of_class TOP_DAQ_Domain_v2_CLASS

class: FwChildrenMode_CLASS
!panel: FwChildrenMode.pnl
    state: Complete
    !color: _3DFace
        when ( any_in FWDEVMODE_FWSETSTATES in_state DISABLED )  move_to IncompleteDev
    state: Incomplete
    !color: FwStateAttention2
    state: IncompleteDev
    !color: FwStateAttention1
        when (  ( all_in FWDEVMODE_FWSETSTATES not_in_state DISABLED )  ) move_to Complete
    state: IncompleteDead
    !color: FwStateAttention3

object: FEE_FWCNM is_of_class FwChildrenMode_CLASS

class: FwMode_CLASS
!panel: FwMode.pnl
    state: Excluded
    !color: FwStateOKNotPhysics
        action: Take(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            move_to InLocal
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            move_to Included
        action: Manual	!visible: 0
            move_to Manual
        action: Ignore	!visible: 0
            move_to Ignored
    state: Included
    !color: FwStateOKPhysics
        action: Exclude(string OWNER = "")	!visible: 0
            move_to Excluded
        action: Manual(string OWNER = "")	!visible: 0
            move_to Manual
        action: Ignore(string OWNER = "")	!visible: 0
            move_to Ignored
        action: ExcludeAll(string OWNER = "")	!visible: 0
            move_to Excluded
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            move_to Included
        action: Free(string OWNER = "")	!visible: 0
            move_to Included
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
    state: InLocal
    !color: FwStateOKNotPhysics
        action: Release(string OWNER = "")	!visible: 1
            move_to Excluded
        action: ReleaseAll(string OWNER = "")	!visible: 1
            move_to Excluded
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
        action: Take(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 1
            move_to InLocal
    state: Manual
    !color: FwStateOKNotPhysics
        action: Include(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
            move_to Included
        action: Take(string OWNER = "")	!visible: 1
            move_to InManual
        action: Exclude(string OWNER = "")	!visible: 0
            move_to Excluded
        action: Ignore	!visible: 0
            move_to Ignored
        action: Free(string OWNER = "")	!visible: 0
            move_to Excluded
        action: ExcludeAll(string OWNER = "")	!visible: 0
            move_to Excluded
    state: InManual
    !color: FwStateOKNotPhysics
        action: Release(string OWNER = "")	!visible: 1
            move_to Manual
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
        action: ReleaseAll(string OWNER = "")	!visible: 0
            move_to Excluded
        action: SetInLocal	!visible: 0
            move_to InLocal
    state: Ignored
    !color: FwStateOKNotPhysics
        action: Include	!visible: 0
            move_to Included
        action: Exclude(string OWNER = "")	!visible: 0
            move_to Excluded
        action: Manual	!visible: 0
            move_to Manual
        action: SetMode(string OWNER = "", string EXCLUSIVE = "YES")	!visible: 0
        action: Free(string OWNER = "")	!visible: 0
            move_to Included
        action: ExcludeAll(string OWNER = "")	!visible: 0
            move_to Excluded

object: FEE_FWM is_of_class FwMode_CLASS

class: FwDevMode_FwDevMode_CLASS
    state: READY
        action: Disable(Device)
            remove &VAL_OF_Device from FWDEVMODE_FWSETSTATES
            remove &VAL_OF_Device from FWDEVMODE_FWSETACTIONS
            move_to READY
        action: Enable(Device)
            insert &VAL_OF_Device in FWDEVMODE_FWSETSTATES
            insert &VAL_OF_Device in FWDEVMODE_FWSETACTIONS
            move_to READY

object: FwDevMode_FWDM is_of_class FwDevMode_FwDevMode_CLASS


class: FwDevMode_CLASS/associated
!panel: FwDevMode.pnl
    state: ENABLED
    !color: FwStateOKPhysics
    state: DISABLED
    !color: FwStateAttention1

object: FEE_FWDM is_of_class FwDevMode_CLASS

objectset: FWDEVMODE_FWSETSTATES is_of_class VOID {FEE_FWDM }
objectset: FWDEVMODE_FWSETACTIONS is_of_class VOID {FEE_FWDM }

class: HwTypeGENERICTOPFrontEnd_DU_FwDevMode_CLASS
    state: READY
        action: Disable(Device)
            remove &VAL_OF_Device from HWTYPEGENERICTOPFRONTEND_DU_FWSETSTATES
            remove &VAL_OF_Device from HWTYPEGENERICTOPFRONTEND_DU_FWSETACTIONS
            move_to READY
        action: Enable(Device)
            insert &VAL_OF_Device in HWTYPEGENERICTOPFRONTEND_DU_FWSETSTATES
            insert &VAL_OF_Device in HWTYPEGENERICTOPFRONTEND_DU_FWSETACTIONS
            move_to READY

object: HwTypeGENERICTOPFrontEnd_DU_FWDM is_of_class HwTypeGENERICTOPFrontEnd_DU_FwDevMode_CLASS


class: HwTypeGENERICTOPFrontEnd_DU_CLASS/associated
!panel: HwTypeGENERICTOPFrontEnd|HwTypeGENERICTOPFrontEnd_DU.pnl
    state: RUNNING
    !color: FwStateOKPhysics
        action: STOP	!visible: 1
        action: RESET	!visible: 1
    state: READY
    !color: FwStateOKNotPhysics
        action: START	!visible: 1
        action: RESET	!visible: 1
    state: NOT_READY
    !color: FwStateAttention1
        action: CONFIGURE	!visible: 1
        action: RESET	!visible: 1
    state: ERROR
    !color: FwStateAttention3
        action: RECOVER	!visible: 1

object: top_cxsol01:Top:TOPFrontEnd is_of_class HwTypeGENERICTOPFrontEnd_DU_CLASS

objectset: HWTYPEGENERICTOPFRONTEND_DU_FWSETSTATES is_of_class VOID {top_cxsol01:Top:TOPFrontEnd }
objectset: HWTYPEGENERICTOPFRONTEND_DU_FWSETACTIONS is_of_class VOID {top_cxsol01:Top:TOPFrontEnd }


objectset: FWCHILDREN_FWSETACTIONS union {HWTYPEGENERICTOPFRONTEND_DU_FWSETACTIONS } is_of_class VOID
objectset: FWCHILDREN_FWSETSTATES union {HWTYPEGENERICTOPFRONTEND_DU_FWSETSTATES } is_of_class VOID

